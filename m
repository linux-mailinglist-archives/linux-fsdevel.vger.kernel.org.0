Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22D3D152F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhGUQ47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhGUQ46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:56:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F1C061575;
        Wed, 21 Jul 2021 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIOeAssJiAIvzmBOsIJ5kA5U16lQSx2xMldjNfs0508=; b=EZCzRd5PKRp+8KRIDqdcuggQcW
        hUc43nT6G3bxoSHFgyJOeYIHPiCWlmbxu3P1DcYGicKBhjq5+BT31M97v79DC6h7kN0BPQlahcD9J
        XdITNhAkFIYYSG99uMvwH5FeFZZRXuEmRwRWPyNAi65t0JxR/WQkYmf6W+vSi3h7sCzZi5BQIGe7y
        14kZ0yA+lnmiqZDS6C8FfDUss4R8Wfv0WZaYhimu6QliZw1t6422dFdkSZTsL3HGRRbFXC0+tPKrP
        iYBR1I6NtnOIAWQcY/uyH1B7cwwEs7yLglvd7/BxsITaWgzko4ID74Gkae7sl3nMrG2wsowDRL4Ys
        jp1LhFJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6G9r-009Rb6-KG; Wed, 21 Jul 2021 17:37:26 +0000
Date:   Wed, 21 Jul 2021 18:37:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <YPhbU/umyUZLdxIw@casper.infradead.org>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> minix_super_block pointer
> sbi->s_ms = ms;
> sbi->s_sbh = bh;
> sbi->s_mount_state = ms->s_state;
> sbi->s_ninodes = ms->s_ninodes;
> sbi->s_nzones = ms->s_nzones;
> sbi->s_imap_blocks = ms->s_imap_blocks;
> sbi->s_zmap_blocks = ms->s_zmap_blocks;
> sbi->s_firstdatazone = ms->s_firstdatazone;
> sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> set sbi->s_log_zone_size

So what you're saying is that if you construct a malicious minix image,
you can produce undefined behaviour?  That's not something we're
traditionally interested in, unless the filesystem is one customarily
used for data interchange (like FAT or iso9660).

