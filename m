Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911BF490FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiAQRue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 12:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbiAQRua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:50:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB6C061748;
        Mon, 17 Jan 2022 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v0Xa43H8A1Rsh86dipLwXthm6PJqoyYAFPfN8Q2Td0A=; b=PzGBDSCeRbtJ6ejZxXWXPErsqC
        pFbBXRzCCnWfdt2+svz/oTt2/vOeUNl3E9CmKwQD1U9+hRI2L0UDYXTKYI4yqxmxli9VIkPOeFxBf
        mWbuSG6fltqdVNA32p8kf+HVU7pAzhnpywyUltr3m9oBQDIDMamY4emVyZtHDJOcfPj+EWljWhBvm
        wVX+2qQhU41B7V5nfMugNiwVmv8rgPPNvAlhvkqD+k39vCoBYSo3nDuhwR3RgvotiYU86ggvAJnXl
        FHuhDnQQCoC6tcNQ8KuZ64EojemuPaPRxIhOayaUSMxukbI5eok1F0smxZuFWagEdpO/jFP4NbfQQ
        TTqbW1dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9W9E-008Rch-4u; Mon, 17 Jan 2022 17:50:28 +0000
Date:   Mon, 17 Jan 2022 17:50:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
Message-ID: <YeWsZDO8U3PU4sdx@casper.infradead.org>
References: <YeWdlR7nsBG8fYO2@casper.infradead.org>
 <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
 <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
 <2883819.1642438775@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2883819.1642438775@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:59:35PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > +	if (folio_test_uptodate(folio))
> > > +		goto out_put_folio;
> > 
> > Er ... if (!folio_test_uptodate(folio)), perhaps?  And is it even
> > worth testing if read_mapping_folio() returned success?  I feel like
> > we should take ->readpage()'s word for it that success means the
> > folio is now uptodate.
> 
> Actually, no, I shouldn't need to do this since it comes out with the page
> lock still held.

No.  The page is unlocked upon IO completion.  After calling ->readpage,
                folio_wait_locked(folio);

