Return-Path: <linux-fsdevel+bounces-7994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6482E086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD511F2211C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B018E38;
	Mon, 15 Jan 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9TtCpNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="olYl/WN2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9TtCpNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="olYl/WN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5518E08;
	Mon, 15 Jan 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A02FD220BE;
	Mon, 15 Jan 2024 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705346169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ypO2u2HswE5GLQFEg6yrwIulDt47JQWATqj+vtBrcQ=;
	b=C9TtCpNg2LDrMuXcm76WCzl4QXoAJxdaDL8lWOdyZoEpRq1pDRioxEucsmBtxULarTet9J
	Bojvd2/ODlG91ZUanKgTfM3hs47KufAijnWAxUSYjQq5+Ec7xf+WYQkClYo9N+2ig6FTfb
	YVErgQEPagPVmO8S5ZhTovP908c7ZZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705346169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ypO2u2HswE5GLQFEg6yrwIulDt47JQWATqj+vtBrcQ=;
	b=olYl/WN27MYcJT3sF7KuUtiC23urv+V4Q6DPPy0QQGK0ax5ZUYfU9tvzUNtsFR2KEiepGa
	ROI3LawfgCE5+YDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705346169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ypO2u2HswE5GLQFEg6yrwIulDt47JQWATqj+vtBrcQ=;
	b=C9TtCpNg2LDrMuXcm76WCzl4QXoAJxdaDL8lWOdyZoEpRq1pDRioxEucsmBtxULarTet9J
	Bojvd2/ODlG91ZUanKgTfM3hs47KufAijnWAxUSYjQq5+Ec7xf+WYQkClYo9N+2ig6FTfb
	YVErgQEPagPVmO8S5ZhTovP908c7ZZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705346169;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ypO2u2HswE5GLQFEg6yrwIulDt47JQWATqj+vtBrcQ=;
	b=olYl/WN27MYcJT3sF7KuUtiC23urv+V4Q6DPPy0QQGK0ax5ZUYfU9tvzUNtsFR2KEiepGa
	ROI3LawfgCE5+YDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C3BE139D2;
	Mon, 15 Jan 2024 19:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5tnPHXmEpWXuEQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 15 Jan 2024 19:16:09 +0000
Date: Mon, 15 Jan 2024 20:15:52 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	kristian@klausen.dk, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_issue_discard
Message-ID: <20240115191551.GW31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000008d7a36060eff419e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008d7a36060eff419e@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C9TtCpNg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="olYl/WN2"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-0.992];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0];
	 TAGGED_RCPT(0.00)[4a4f1eba14eb5c3417d1];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.21
X-Rspamd-Queue-Id: A02FD220BE
X-Spam-Flag: NO

On Mon, Jan 15, 2024 at 09:22:19AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3e7aeb78ab01 Merge tag 'net-next-6.8' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f61d33e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a4f1eba14eb5c3417d1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bdfc0be80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177f3c83e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4c8a9f091067/disk-3e7aeb78.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8cb663b518a5/vmlinux-3e7aeb78.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc6d189cfcf3/bzImage-3e7aeb78.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e37fd964ba01/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/174ce0bdbd5e/mount_4.gz
> 
> The issue was bisected to:
> 
> commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
> Author: Kristian Klausen <kristian@klausen.dk>
> Date:   Fri Jun 18 11:51:57 2021 +0000
> 
>     loop: Fix missing discard support when using LOOP_CONFIGURE

This only adds proper discard support to loop device so it makes the
problem visible.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111924a5e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=131924a5e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=151924a5e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
> Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5071 at fs/btrfs/extent-tree.c:1263 btrfs_issue_discard+0x5ba/0x5e0 fs/btrfs/extent-tree.c:1263

1256 static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
1257                                u64 *discarded_bytes)
1258 {
1259         int j, ret = 0;
1260         u64 bytes_left, end;
1261         u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
1262
1263         if (WARN_ON(start != aligned_start)) {
^^^^

1264                 len -= aligned_start - start;
1265                 len = round_down(len, 1 << SECTOR_SHIFT);
1266                 start = aligned_start;
1267         }

The alignment check was added in 4d89d377bbb0 ("btrfs: btrfs_issue_discard
ensure offset/length are aligned to sector boundaries"), with the
WARN_ON. It seems that syzbot is testing unaligned discard requests,
which is probably ok but the warning is excessive as there's a fallback.

