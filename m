Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6813044AC2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 12:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245664AbhKILDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 06:03:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbhKILDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:03:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA7AD218B0;
        Tue,  9 Nov 2021 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636455625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZH5tP3Blxs0l/FkD7PofF9MPbMEWtCzxQETbZ1kcLE=;
        b=b9TmF+Nv9U+zjo2qWonwJdTbtYXocQGTSNQAdLHrRWsLw/LoVwUcyX4xOuxFmLVm/+CeYd
        6pQPIrHjq7iXMpi51P9UTQoOJthOFtKHRZfr8z9/piu+pCg476U9+bQVsSZBKTqzrvGh1A
        SJkWu+3SJPFCgPismia1njocTIhWU1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636455625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZH5tP3Blxs0l/FkD7PofF9MPbMEWtCzxQETbZ1kcLE=;
        b=E+RMqx3smZFFkRS6lt0rLJeuKtnSQliRfpUXgVEEO8zejKa9UGlQnIpQ7kTSTRpAp7JCbs
        hfVyPcVY0SW26NAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B7929A3B83;
        Tue,  9 Nov 2021 11:00:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D8D51E14ED; Tue,  9 Nov 2021 12:00:25 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:00:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Nov 9
Message-ID: <20211109110025.GB5955@quack2.suse.cz>
References: <20211109135449.7850eac3@canb.auug.org.au>
 <20211109135543.00b9f6a4@canb.auug.org.au>
 <alpine.DEB.2.22.394.2111091051380.2669071@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2111091051380.2669071@ramsan.of.borg>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-11-21 10:58:01, Geert Uytterhoeven wrote:
> 	Hi Jan,
> 
> As lore doesn't seem to have the original patch, I'm replying here.
> 
> On Tue, 9 Nov 2021, Stephen Rothwell wrote:
> > Merging ext3/for_next (39a464de961f udf: Fix crash after seekdir)
> 
> noreply@ellerman.id.au reported for m68k/allmodconfig:
> fs/udf/dir.c:78:18: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> fs/udf/dir.c:211:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> 
> The actual code does:
> 
>         * Did our position change since last readdir (likely lseek was
>         * called)? We need to verify the position correctly points at the
>         * beginning of some dir entry so that the directory parsing code does
>         * not get confused. Since UDF does not have any reliable way of
>         * identifying beginning of dir entry (names are under user control),
>         * we need to scan the directory from the beginning.
>         */
>        if (ctx->pos != (loff_t)file->private_data) {
>                emit_pos = nf_pos;
>                nf_pos = 0;
>        }
> 
> and:
> 
>        /* Store position where we've ended */
>        file->private_data = (void *)ctx->pos;
> 
> Obviously this is not going to fly on 32-bit systems, as
> file->private_data is 32-bit or 64-bit unsigned long, but ctx->pos is
> always 64-bit loff_t.
> 
> I do not know if UDF supports files larger than 4 GiB (DVDs can be
> larger).
> If it doesn't, you need intermediate casts to uintptr_t.
> If it does, you need a different solution.

Yeah, thanks for the heads up. I've noticed the warning from 0-day as well
and realized this is a real problem on 32-bit systems. UDF does support
dirs larger than 4G in principle (although practically anything larger than
say 1MB is probably unusable due to linear directory structure :). Anyway,
I'm working on a fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
