Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD4490CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiAQQrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiAQQrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:47:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1190C061574;
        Mon, 17 Jan 2022 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3kkNLTmhK35xzkBXz1aImqDg3lnVlGgMXIfZT5Y36U=; b=tnoOapNJu+dGw5Se/8wRgkoLr4
        FC/MCGdzWh4NDKbC4Eq3eW3Pn7sVP/oGvywH7RLHRWsWlSjwWbvUdEBN9hEIBzFyP+ZOQMQcl+XGl
        yO0szP5JFyM7yMci0/f4PCZr0x9Fc28Ve3Qdz3rvAFpgBHSm02hR3RaAxXV/zr4VP6varEIMuTucU
        s5+uYsznM2Q2O3hlO4xbeLIEBtChuJXj9wUbhW+7c5iZ2YgYD1JuVF6vMiao5ldEzFI/BisO3+zQg
        bdAzg3wLAOKvZN1tvq4OafvfW8XPXgGusZPLcOxx4yQY1csr2QevalAKTwN5LdqMc81PXk4XM4s8T
        10lXBZhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9VA5-008OE0-4I; Mon, 17 Jan 2022 16:47:17 +0000
Date:   Mon, 17 Jan 2022 16:47:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
Message-ID: <YeWdlR7nsBG8fYO2@casper.infradead.org>
References: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
 <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:26:36PM +0000, David Howells wrote:
> +	folio = read_mapping_folio(inode->i_mapping, 0, file);
> +	if (IS_ERR(folio))
> +		goto out;

... you need to set 'err' here, right?

> +	if (folio_test_uptodate(folio))
> +		goto out_put_folio;

Er ... if (!folio_test_uptodate(folio)), perhaps?  And is it even
worth testing if read_mapping_folio() returned success?  I feel like
we should take ->readpage()'s word for it that success means the
folio is now uptodate.

> +	err = folio_lock_killable(folio);
> +	if (err < 0)
> +		goto out_put_folio;
> +
> +	if (inline_version == 1 || /* initial version, no data */
> +	    inline_version == CEPH_INLINE_NONE)
> +		goto out_unlock;
> +
> +	len = i_size_read(inode);
> +	if (len >  folio_size(folio))

extra space.  Plus, you're hardcoding 4096 below, but using folio_size()
here which is a bit weird to me.
