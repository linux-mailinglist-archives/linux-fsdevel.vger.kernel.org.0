Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0C36AFCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhDZIhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 04:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232112AbhDZIhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619426229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbtBcauxw6iV4drutPztIO4FXXpYTboxDuo9XaZQAvw=;
        b=MovGjUyw3HvI+8G9WXTfJVzDlqO1ZBkgKjxonYevMLrYtt/k2J6knQApYoukDtxUnNYsEv
        fBSOmx26h6A4D5VqtJqaf6YOdo9CXI47qxmMMKo+qiQkX6C43fj6YFZGri+leiZnAIoQnZ
        Vp9RapQilk0NcFNgtOZKCWX6sljuSnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-8ox4iTGwPk-t4-JCDAEilA-1; Mon, 26 Apr 2021 04:37:06 -0400
X-MC-Unique: 8ox4iTGwPk-t4-JCDAEilA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0358343A8;
        Mon, 26 Apr 2021 08:37:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA04660BE5;
        Mon, 26 Apr 2021 08:37:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com>
References: <CAOg9mSTwNKPdRMwr_F87YCeUyxT775pBd5WcewGpcwSZFVz5=w@mail.gmail.com> <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com> <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org> <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com> <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com> <1268214.1618326494@warthog.procyon.org.uk
 > <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com> <1612829.1618587694@warthog.procyon.org.uk>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3591075.1619426224.1@warthog.procyon.org.uk>
Date:   Mon, 26 Apr 2021 09:37:04 +0100
Message-ID: <3591076.1619426224@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> Anywho... I see that you've force pushed a new netfs... I think you
> have it applied to a linus-tree-of-the-day on top of 5.12-rc4?
> I have taken these patches from
> git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git (netfs-lib)
> 
> 0001-iov_iter-Add-ITER_XARRAY.patch
> 0002-mm-Add-set-end-wait-functions-for-PG_private_2.patch
> 0003-mm-filemap-Pass-the-file_ra_state-in-the-ractl.patch
> 0004-fs-Document-file_ra_state.patch
> 0005-mm-readahead-Handle-ractl-nr_pages-being-modified.patch
> 0006-mm-Implement-readahead_control-pageset-expansion.patch
> 0007-netfs-Make-a-netfs-helper-module.patch
> 0008-netfs-Documentation-for-helper-library.patch
> 0009-netfs-mm-Move-PG_fscache-helper-funcs-to-linux-netfs.patch
> 0010-netfs-mm-Add-set-end-wait_on_page_fscache-aliases.patch
> 0011-netfs-Provide-readahead-and-readpage-netfs-helpers.patch
> 0012-netfs-Add-tracepoints.patch
> 0013-netfs-Gather-stats.patch
> 0014-netfs-Add-write_begin-helper.patch
> 0015-netfs-Define-an-interface-to-talk-to-a-cache.patch
> 0016-netfs-Add-a-tracepoint-to-log-failures-that-would-be.patch
> 0017-fscache-cachefiles-Add-alternate-API-to-use-kiocb-fo.patch

Can you add this patch also:

https://lore.kernel.org/r/3545034.1619392490@warthog.procyon.org.uk/
[PATCH] iov_iter: Four fixes for ITER_XARRAY

David

