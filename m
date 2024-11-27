Return-Path: <linux-fsdevel+bounces-35959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47369DA25B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EB0285700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977E145B3E;
	Wed, 27 Nov 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HsDZI3Lm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lgRYlioc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H13YLU3B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xZ6Vzia7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4DF9DD;
	Wed, 27 Nov 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689352; cv=none; b=LMCbY4Jq5A0HRLDKo/SQj9ZViX+gScY4QyiUf2dj0uP61kkg3e35cwOfwKvRg2uwpy7YmzeJmt0wHKezHGTjjQLq13k10AkdoKucmvDgLMcTivT8Y60VtSYe6yp6bCRB++JpMVvWNIEO4kyA4Mllj8Uqm9nGUQDC9qTKjj045TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689352; c=relaxed/simple;
	bh=SUfgzpzxnC4WeNURXFlb0PoDCg9wzNpPEvTLn4ZFOm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPwLwIY4GR/jiw12p4DzJIWJ1zaHzKIJS0Xsc8eASGWsF0u8XQFQq2RSdnQL7osshxfYKMnl5q7HI79P7acLO1P8HLuDOa8rXa7YHE1VZ3vr86KRaTyRsgNi5T7aNbFIcM4sm01z1To30PQ7schePn6+2kA2Si34CYY4VcPa/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HsDZI3Lm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lgRYlioc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H13YLU3B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xZ6Vzia7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D47EB1F76C;
	Wed, 27 Nov 2024 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732689348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMsed4tenz0hQyrryAqiuzNCD/mnemu0mWc0jY7/9+0=;
	b=HsDZI3Lm+lbyPGWzvmKqkpGoQUY802EtvnRK8xDJKfE2YjBNMfayQptkRXlZ6xYZtf+Q6I
	z/3PtbnQvR1/gI81svFJibJa9EhYQNBbEmSDzqgE+qk6z69wdQs1noaciZyZLd0xKRt+su
	yEOT/VVKZSF91d5LRmYC1hdqF1Gt5D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732689348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMsed4tenz0hQyrryAqiuzNCD/mnemu0mWc0jY7/9+0=;
	b=lgRYlioczH2Y+weEtRSfhibO4Uqw8XEHMF+No+MxVtCM3EiZN+vYDg5XK7BKfgc4Fm81kb
	y6C42nw1X0zIniBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H13YLU3B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xZ6Vzia7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732689347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMsed4tenz0hQyrryAqiuzNCD/mnemu0mWc0jY7/9+0=;
	b=H13YLU3BQe15V3ZXElc+BjG18qkuDjM9HbWvHq9ehgU/6xXnsefddEivauzwyoOzyC/oow
	Ft0iy8ChLtDN5skRVhixeE+XRebhZ7F0B3ZdKgF4PG7mTePWl0ZbemnfRJiMlVAG9NbFtL
	NKpfPaui7ocIMkYhNQm9qK5iHcGYvGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732689347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMsed4tenz0hQyrryAqiuzNCD/mnemu0mWc0jY7/9+0=;
	b=xZ6Vzia7OeViQMNsNrs6M9U/QS4Ba5Wnm7fkdlElfQ0kaBJy8gNwpyn86XiT25s7Em5jGU
	O+vH7Mq9c2JfE7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24A7513941;
	Wed, 27 Nov 2024 06:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S/R2M8G9RmfDCQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 27 Nov 2024 06:35:45 +0000
Date: Wed, 27 Nov 2024 17:35:36 +1100
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 8/9] initramfs: fix hardlink hash leak without
 TRAILER
Message-ID: <20241127173536.76815a5b.ddiss@suse.de>
In-Reply-To: <20241107002044.16477-10-ddiss@suse.de>
References: <20241107002044.16477-1-ddiss@suse.de>
	<20241107002044.16477-10-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D47EB1F76C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu,  7 Nov 2024 11:17:27 +1100, David Disseldorp wrote:

> Covered in Documentation/driver-api/early-userspace/buffer-format.rst ,
> initramfs archives can carry an optional "TRAILER!!!" entry which serves
> as a boundary for collecting and associating hardlinks with matching
> inode and major / minor device numbers.
> 
> Although optional, if hardlinks are found in an archive without a
> subsequent "TRAILER!!!" entry then the hardlink state hash table is
> leaked

One further leak is possible if extraction ends prior to fput(wfile)
in CopyFile state, e.g. due to lack of data:

  nilchar="\0"
  data="123456789ABCDEF"
  magic="070701"
  ino=1
  mode=$(( 0100777 ))
  uid=0
  gid=0
  nlink=1
  mtime=1
  filesize=$(( ${#data} + 20 ))   # too much
  devmajor=0
  devminor=1
  rdevmajor=0
  rdevminor=0
  csum=0
  fname="initramfs_test_archive_overrun"
  namelen=$(( ${#fname} + 1 ))    # plus one to account for terminator
  
  printf "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s" \
         $magic $ino $mode $uid $gid $nlink $mtime $filesize \
         $devmajor $devminor $rdevmajor $rdevminor $namelen $csum $fname

  termpadlen=$(( 1 + ((4 - ((110 + $namelen) & 3)) % 4) ))
  printf "%.s${nilchar}" $(seq 1 $termpadlen)
  # $filesize reaches 20 bytes beyond end of data
  printf "%s" "$data"

bash data_repro.sh|gzip >> initramfs

unreferenced object 0xffff8fdb0192e000 (size 176):
  comm "kworker/u8:0", pid 11, jiffies 4294892503
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 1e 80 5d 00  ..............].
    80 7d a1 a7 ff ff ff ff 10 b1 2f 02 db 8f ff ff  .}......../.....
  backtrace (crc 807bd733):
    [<00000000e68e8b32>] kmem_cache_alloc_noprof+0x11e/0x260
    [<00000000a6f24fcd>] alloc_empty_file+0x45/0x120
    [<00000000130beec8>] path_openat+0x2f/0xf30
    [<0000000024613ad7>] do_filp_open+0xa7/0x110
    [<000000005f4f0158>] file_open_name+0x118/0x180
    [<0000000003ed573f>] filp_open+0x27/0x50
    [<0000000091ec9e44>] do_name+0xc4/0x2b0
    [<000000008e084ec8>] write_buffer+0x22/0x40
    [<000000002ea2ff4b>] flush_buffer+0x2f/0x90
    [<000000009085f8b5>] gunzip+0x25a/0x310
    [<000000000c1c83c3>] unpack_to_rootfs+0x176/0x2a0
    [<00000000c966fda5>] do_populate_rootfs+0x6a/0x180
    [<0000000051fb877d>] async_run_entry_fn+0x31/0x120
    [<00000000a3ee305f>] process_scheduled_works+0xbe/0x310
    [<0000000083c835bb>] worker_thread+0x100/0x240
    [<000000006ea2f0b3>] kthread+0xc8/0x100

Not sure whether others are interested in seeing these kinds of
leak-on-malformed-archive bugs fixed, but I'll send through a v4 with a
fix + unit test for it.

