Return-Path: <linux-fsdevel+bounces-36607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04389E66F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 06:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C87169E41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39109198A39;
	Fri,  6 Dec 2024 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JTufesEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="60d68sIj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JTufesEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="60d68sIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003A81AD7;
	Fri,  6 Dec 2024 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463727; cv=none; b=LUoJRf7OXgpoPrIuVuRe0FwgC+r38qfn4USxDN2Z3zh5h5M6CqpbVGgmo1el5kmDdFQnH0+6Pue/033a6QAPzP5Ilj3iD3jRwKb8Yzgwz1KGWQ57hSygRkNYv/0kebXngA4HQKQcHujhEleuoQ01btFCXDUKBe/DoYbdl2olh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463727; c=relaxed/simple;
	bh=PUxLvfCl6KJyXXMGbhhtBsq6maKDNzBQiGf1/xAE83E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d8bsa7Apom5cPnGw+QgytIhYx20U/EeFrwAsPY8uHtdKznfUZVvE9UymU3Iv1MHydm0/tbdh9OXqtcmPry6EIUMty5H+HwszbJxbtTpkHh96ed6Dru9segz55qYFf/KD3hRb87pIO6q7MjIk5AbKXxJxolTsIaLsBNgWPN85gsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JTufesEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=60d68sIj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JTufesEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=60d68sIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3693821172;
	Fri,  6 Dec 2024 05:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733463723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2/YqRsgeQkF+LBizAiXkmcCtt6rgLZU8mASqpDwY/I=;
	b=JTufesEWJkxVFTmUzbcaApibfI4KRxOe8VIEkuLDkrMY6JamP3jNvicUCdgt7nYTpJMHNx
	tYosMUYbgjlKju6BQI95LZ7Jd1WPR/5C9nDebAVxicQ8ELNWAmLFg4KQA1dlwz6WVR+PBu
	72vGDFhhPORgNrclTAxaoSrUPAQTSlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733463723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2/YqRsgeQkF+LBizAiXkmcCtt6rgLZU8mASqpDwY/I=;
	b=60d68sIjSfMSplvmLlXVKQqGfqIUm+O7YKcw735fb0kUfRll2zsjSTMt2K4HbUqlwSRa0L
	cs3toFnRLODdSxDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733463723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2/YqRsgeQkF+LBizAiXkmcCtt6rgLZU8mASqpDwY/I=;
	b=JTufesEWJkxVFTmUzbcaApibfI4KRxOe8VIEkuLDkrMY6JamP3jNvicUCdgt7nYTpJMHNx
	tYosMUYbgjlKju6BQI95LZ7Jd1WPR/5C9nDebAVxicQ8ELNWAmLFg4KQA1dlwz6WVR+PBu
	72vGDFhhPORgNrclTAxaoSrUPAQTSlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733463723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2/YqRsgeQkF+LBizAiXkmcCtt6rgLZU8mASqpDwY/I=;
	b=60d68sIjSfMSplvmLlXVKQqGfqIUm+O7YKcw735fb0kUfRll2zsjSTMt2K4HbUqlwSRa0L
	cs3toFnRLODdSxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7716613647;
	Fri,  6 Dec 2024 05:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6jeC6mOUmeTUAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 06 Dec 2024 05:42:01 +0000
Date: Fri, 6 Dec 2024 16:41:55 +1100
From: David Disseldorp <ddiss@suse.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: ksmbd: v6.13-rc1 WARNING at fs/attr.c:300 setattr_copy+0x1ee/0x200
Message-ID: <20241206164155.3c80d28e.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,opensuse.org:url]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Namjae,

I'm hitting the following warning while running xfstests against a
v6.13-rc1 ksmbd server:

[  113.215316] ------------[ cut here ]------------
[  113.215974] WARNING: CPU: 1 PID: 31 at fs/attr.c:300 setattr_copy+0x1ee/0x200
[  113.216988] Modules linked in: btrfs blake2b_generic xor zlib_deflate raid6_pq zstd_decompress zstd_compress xxhash zstd_common ksmbd crc32_generic cifs_arc4 nls_ucs2_utis
[  113.219192] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted 6.13.0-rc1+ #234
[  113.220127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[  113.221530] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
[  113.222220] RIP: 0010:setattr_copy+0x1ee/0x200
[  113.222833] Code: 24 28 49 8b 44 24 30 48 89 53 58 89 43 6c 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 89 df e8 77 d6 ff ff e9 cd fe ff ff <0f> 0b e9 be fe ff ff 66 0
[  113.225110] RSP: 0018:ffffaf218010fb68 EFLAGS: 00010202
[  113.225765] RAX: 0000000000000120 RBX: ffffa446815f8568 RCX: 0000000000000003
[  113.226667] RDX: ffffaf218010fd38 RSI: ffffa446815f8568 RDI: ffffffff94eb03a0
[  113.227531] RBP: ffffaf218010fb90 R08: 0000001a251e217d R09: 00000000675259fa
[  113.228426] R10: 0000000002ba8a6d R11: ffffa4468196c7a8 R12: ffffaf218010fd38
[  113.229304] R13: 0000000000000120 R14: ffffffff94eb03a0 R15: 0000000000000000
[  113.230210] FS:  0000000000000000(0000) GS:ffffa44739d00000(0000) knlGS:0000000000000000
[  113.231215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.232055] CR2: 00007efe0053d27e CR3: 000000000331a000 CR4: 00000000000006b0
[  113.232926] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  113.233812] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  113.234797] Call Trace:
[  113.235116]  <TASK>
[  113.235393]  ? __warn+0x73/0xd0
[  113.235802]  ? setattr_copy+0x1ee/0x200
[  113.236299]  ? report_bug+0xf3/0x1e0
[  113.236757]  ? handle_bug+0x4d/0x90
[  113.237202]  ? exc_invalid_op+0x13/0x60
[  113.237689]  ? asm_exc_invalid_op+0x16/0x20
[  113.238185]  ? setattr_copy+0x1ee/0x200
[  113.238692]  btrfs_setattr+0x80/0x820 [btrfs]
[  113.239285]  ? get_stack_info_noinstr+0x12/0xf0
[  113.239857]  ? __module_address+0x22/0xa0
[  113.240368]  ? handle_ksmbd_work+0x6e/0x460 [ksmbd]
[  113.240993]  ? __module_text_address+0x9/0x50
[  113.241545]  ? __module_address+0x22/0xa0
[  113.242033]  ? unwind_next_frame+0x10e/0x920
[  113.242600]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  113.243268]  notify_change+0x2c2/0x4e0 
[  113.243746]  ? stack_depot_save_flags+0x27/0x730
[  113.244339]  ? set_file_basic_info+0x130/0x2b0 [ksmbd]
[  113.244993]  set_file_basic_info+0x130/0x2b0 [ksmbd]
[  113.245613]  ? process_scheduled_works+0xbe/0x310
[  113.246181]  ? worker_thread+0x100/0x240
[  113.246696]  ? kthread+0xc8/0x100
[  113.247126]  ? ret_from_fork+0x2b/0x40 
[  113.247606]  ? ret_from_fork_asm+0x1a/0x30
[  113.248132]  smb2_set_info+0x63f/0xa70 [ksmbd]


284 static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
285 {
286         unsigned int ia_valid = attr->ia_valid;
287         struct timespec64 now;
288 
289         if (ia_valid & ATTR_CTIME) {
290                 /*
291                  * In the case of an update for a write delegation, we must respect
292                  * the value in ia_ctime and not use the current time.
293                  */
294                 if (ia_valid & ATTR_DELEG)
295                         now = inode_set_ctime_deleg(inode, attr->ia_ctime);
296                 else
297                         now = inode_set_ctime_current(inode);
298         } else {
299                 /* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
300                 WARN_ON_ONCE(ia_valid & ATTR_MTIME);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^--- here.

Looking at smb2pdu.c:set_file_basic_info() it's easy enough to see how
we can get here with !ATTR_CTIME alongside ATTR_MTIME.

The following patch avoids the warning, but I'm not familiar with this
code-path, so please let me know whether or not it makes sense:

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6013,7 +6013,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 
        if (file_info->LastAccessTime) {
                attrs.ia_atime = ksmbd_NTtimeToUnix(file_info->LastAccessTime);
-               attrs.ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
+               attrs.ia_valid |= ATTR_ATIME_SET;
        }
 
        attrs.ia_valid |= ATTR_CTIME;
@@ -6024,7 +6024,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 
        if (file_info->LastWriteTime) {
                attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
-               attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+               attrs.ia_valid |= ATTR_MTIME_SET;
        }
 
        if (file_info->Attributes) {

