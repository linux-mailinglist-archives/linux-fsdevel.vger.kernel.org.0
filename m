Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB9F2E8EA3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhACWGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 17:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbhACWGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:06:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3842FC061573;
        Sun,  3 Jan 2021 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IPkgGX+SKWseAA881v8oRHr85WnU1YqvzzzJRMs/71c=; b=BdIKsHNTHDDRsSDH1FUIo5CixW
        fHX/00nq5Thq2nVnXzL0YbgDHkdY/qDUQrsPMorvAXhHt5f1BNttlCATeR6jkTV0FQt9Ad0tTyx81
        iaVc1Rav9ITLT5mVkawRsEsFACWkTUbVDvimQn3bx9NuKS9lGDdN2ZBIx7H0CMQaEigliabbWS3us
        MKtaOat9jms2jhHciwkXUhmGybyhT5rwm8RZqZLCE3lP0T13hvvW3rGT+R84cDbKfF16v4UPY22bV
        F7/McCtkUNeatMVFJXU/p1VsxkWYmcYc8j5afI+Gup+JbRXBxgjTv3BRlZDWwfpRW02m2hWNJ09S9
        yYFmplGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwBUS-000Ogt-2m; Sun, 03 Jan 2021 22:05:04 +0000
Date:   Sun, 3 Jan 2021 22:04:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210103220444.GA28414@casper.infradead.org>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
 <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103215732.vbgcrf42xnao6gw2@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 03, 2021 at 11:57:32PM +0200, Kari Argillander wrote:
> > +		/*
> > +		 * mirror of len, but signed, because run_packed_size()
> > +		 * works with signed int only
> > +		 */
> > +		len64 = len;
> > +
> > +		/* how much bytes is packed len64 */
> > +		size_size = run_packed_size(&len64);
> 
> Does (s64 *)&len work just fine?

No.  run_packed_size() is going to load/store eight bytes to/from that
pointer.  You can't just cast a pointer to a different size and expect
it to work (it might happen to work, particularly on little-endian,
but big-endian is going to get completely the wrong value).

