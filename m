Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1344AB0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhKIKAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 05:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbhKIKAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:00:52 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A0C061767
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 01:58:05 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9dc9:efd5:4c6f:baa9])
        by baptiste.telenet-ops.be with bizsmtp
        id G9y2260031LAWtA019y27b; Tue, 09 Nov 2021 10:58:02 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mkNtB-00BCSN-OV; Tue, 09 Nov 2021 10:58:01 +0100
Date:   Tue, 9 Nov 2021 10:58:01 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Jan Kara <jack@suse.cz>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Nov 9
In-Reply-To: <20211109135543.00b9f6a4@canb.auug.org.au>
Message-ID: <alpine.DEB.2.22.394.2111091051380.2669071@ramsan.of.borg>
References: <20211109135449.7850eac3@canb.auug.org.au> <20211109135543.00b9f6a4@canb.auug.org.au>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 	Hi Jan,

As lore doesn't seem to have the original patch, I'm replying here.

On Tue, 9 Nov 2021, Stephen Rothwell wrote:
> Merging ext3/for_next (39a464de961f udf: Fix crash after seekdir)

noreply@ellerman.id.au reported for m68k/allmodconfig:
fs/udf/dir.c:78:18: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
fs/udf/dir.c:211:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

The actual code does:

         * Did our position change since last readdir (likely lseek was
         * called)? We need to verify the position correctly points at the
         * beginning of some dir entry so that the directory parsing code does
         * not get confused. Since UDF does not have any reliable way of
         * identifying beginning of dir entry (names are under user control),
         * we need to scan the directory from the beginning.
         */
        if (ctx->pos != (loff_t)file->private_data) {
                emit_pos = nf_pos;
                nf_pos = 0;
        }

and:

        /* Store position where we've ended */
        file->private_data = (void *)ctx->pos;

Obviously this is not going to fly on 32-bit systems, as
file->private_data is 32-bit or 64-bit unsigned long, but ctx->pos is
always 64-bit loff_t.

I do not know if UDF supports files larger than 4 GiB (DVDs can be
larger).
If it doesn't, you need intermediate casts to uintptr_t.
If it does, you need a different solution.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
