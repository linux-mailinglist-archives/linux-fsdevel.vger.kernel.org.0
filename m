Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83564C1059
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiBWKfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 05:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWKfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:35:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BAE79C69;
        Wed, 23 Feb 2022 02:34:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 350581F3A8;
        Wed, 23 Feb 2022 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645612496;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xZW9zYFBouxDjIYC0rSD0Sgrek9SILSKvcSd/K79F0=;
        b=EXWJ1vyIIWmPklldEBBW9QqTc2LQT8gcrxGL97uNrgVSIidFiJ5ejSLw3kDQU2XT8toKyi
        MtQrpCiClqrrvoqk4HauN4B3zKCOJl6D8WDNx5fgASJXqB/ufhFAmKfImOWZtaAw2/vY8a
        PDFs/pL95i1Wq+AkGkHUGpexMnTpdXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645612496;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xZW9zYFBouxDjIYC0rSD0Sgrek9SILSKvcSd/K79F0=;
        b=Epe56xSRFMqObI96K2A9S/Dg0pGe0qqFbqpDSKmhLdPgkeo1MSGn11Q8Mm1oJ2U/8PYlyR
        vyv4pR/oID/xQuCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F208EA3B8B;
        Wed, 23 Feb 2022 10:34:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BBCB8DA7F7; Wed, 23 Feb 2022 11:31:07 +0100 (CET)
Date:   Wed, 23 Feb 2022 11:31:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Message-ID: <20220223103107.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
References: <cover.1645157220.git.naohiro.aota@wdc.com>
 <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:14:19PM +0900, Naohiro Aota wrote:
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3240,6 +3240,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	u64 length;
>  	int ret;
>  
> +	/* Assert we called sb_start_write(), not to race with FS freezing */
> +	ASSERT(sb_write_started(fs_info->sb));

I see this assertion to fail, it's not on all testing VMs, but has
happened a few times already so it's probably some race:

[ 2927.013859] BTRFS warning (device vdc): devid 1 uuid 4335c7a6-652c-4389-8ea9-270c00fa9880 is missing
[ 2927.017693] BTRFS warning (device vdc): devid 1 uuid 4335c7a6-652c-4389-8ea9-270c00fa9880 is missing
[ 2927.022921] BTRFS info (device vdc): bdev /dev/vdd errs: wr 0, rd 0, flush 0, corrupt 6000, gen 0
[ 2927.031780] BTRFS info (device vdc): checking UUID tree
[ 2927.045348] BTRFS: error (device vdc: state X) in __btrfs_free_extent:3199: errno=-5 IO failure
[ 2927.049729] BTRFS info (device vdc: state EX): forced readonly
[ 2927.051787] BTRFS: error (device vdc: state EX) in btrfs_run_delayed_refs:2159: errno=-5 IO failure
[ 2927.058758] BTRFS info (device vdc: state EX): balance: resume -dusage=90 -musage=90 -susage=90
[ 2927.062457] assertion failed: sb_write_started(fs_info->sb), in fs/btrfs/volumes.c:3244
[ 2927.066121] ------------[ cut here ]------------
[ 2927.067682] kernel BUG at fs/btrfs/ctree.h:3552!
[ 2927.069214] invalid opcode: 0000 [#1] PREEMPT SMP
[ 2927.070926] CPU: 2 PID: 22817 Comm: btrfs-balance Not tainted 5.17.0-rc5-default+ #1632
[ 2927.075299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[ 2927.080897] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[ 2927.092652] RSP: 0018:ffffaed9c610fdc0 EFLAGS: 00010246
[ 2927.095227] RAX: 000000000000004b RBX: ffffa13a873db000 RCX: 0000000000000000
[ 2927.096898] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
[ 2927.100514] RBP: ffffa13a55324000 R08: 0000000000000003 R09: 0000000000000001
[ 2927.102518] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa13a6922f098
[ 2927.104330] R13: 000000008cfa0000 R14: ffffa13a553262a0 R15: ffffa13a873db000
[ 2927.106025] FS:  0000000000000000(0000) GS:ffffa13abda00000(0000) knlGS:0000000000000000
[ 2927.108652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2927.110568] CR2: 000055fdf2a94fd0 CR3: 000000005d012005 CR4: 0000000000170ea0
[ 2927.112167] Call Trace:
[ 2927.112801]  <TASK>
[ 2927.113212]  btrfs_relocate_chunk.cold+0x42/0x67 [btrfs]
[ 2927.114328]  __btrfs_balance+0x2ea/0x490 [btrfs]
[ 2927.114871] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 131072 csum 0x7e797e3e expected csum 0x8941f998 mirror 2
[ 2927.115469]  btrfs_balance+0x4ed/0x7e0 [btrfs]
[ 2927.118802] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 139264 csum 0x27df6522 expected csum 0x8941f998 mirror 2
[ 2927.119691]  ? btrfs_balance+0x7e0/0x7e0 [btrfs]
[ 2927.123158] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 143360 csum 0x9f144c35 expected csum 0x8941f998 mirror 2
[ 2927.123965]  balance_kthread+0x37/0x50 [btrfs]
[ 2927.127299] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 147456 csum 0x1027ab9a expected csum 0x8941f998 mirror 2
[ 2927.128016]  kthread+0xea/0x110
[ 2927.128023]  ? kthread_complete_and_exit+0x20/0x20
[ 2927.128027]  ret_from_fork+0x1f/0x30
[ 2927.128031]  </TASK>
[ 2927.128032] Modules linked in:
[ 2927.131390] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 155648 csum 0x428b86d5 expected csum 0x8941f998 mirror 2
[ 2927.131400] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 163840 csum 0x8fff7df2 expected csum 0x8941f998 mirror 2
[ 2927.131401] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 159744 csum 0x9893a835 expected csum 0x8941f998 mirror 2
[ 2927.131416] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 180224 csum 0x83d83877 expected csum 0x8941f998 mirror 2
[ 2927.131832] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 524288 csum 0x1a0c8fd4 expected csum 0x8941f998 mirror 2
[ 2927.132128] BTRFS warning (device vdc: state EX): csum failed root 5 ino 258 off 540672 csum 0xcaaf83cc expected csum 0x8941f998 mirror 2
[ 2927.133105]  dm_flakey dm_mod btrfs blake2b_generic libcrc32c crc32c_intel xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash loop
[ 2927.144290] ---[ end trace 0000000000000000 ]---
[ 2927.145080] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[ 2927.147738] RSP: 0018:ffffaed9c610fdc0 EFLAGS: 00010246
[ 2927.148220] RAX: 000000000000004b RBX: ffffa13a873db000 RCX: 0000000000000000
[ 2927.149126] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
[ 2927.150057] RBP: ffffa13a55324000 R08: 0000000000000003 R09: 0000000000000001
[ 2927.150676] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa13a6922f098
[ 2927.151297] R13: 000000008cfa0000 R14: ffffa13a553262a0 R15: ffffa13a873db000
[ 2927.152529] FS:  0000000000000000(0000) GS:ffffa13abda00000(0000) knlGS:0000000000000000
[ 2927.153646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2927.154280] CR2: 000055fdf2a94fd0 CR3: 000000005d012005 CR4: 0000000000170ea0
