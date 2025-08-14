Return-Path: <linux-fsdevel+bounces-57839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542FBB25B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC69566B23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB12253E9;
	Thu, 14 Aug 2025 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eqn3nTfJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hM6/zLqM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eqn3nTfJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hM6/zLqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFC224AE0
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150550; cv=none; b=iz9n6+WANS3xJsIj5JzSTyXyk/JpBfTTOK1mi9vVNt6h9fHQ9kOZMc3l8MKNrZvXCACHKDNKKL3z4sLGIm0exFvmsMsUhOT7D+++g+Gs42gcFH836ELbf8lfEV12CzviV7cPDewHiBXZwSQWzkdQT1zRuBj54nt3OrMbsXYd3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150550; c=relaxed/simple;
	bh=pZ/gOI0k4sDj/lLAzb/QoiEwC4zgMq88cnBUTJoxozQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns7QT8TLeC9/KYjKZtJ5RtzE1KeQ9wpsGN6A+ZnB4Z2kZwjwUXRcAYc5+q/yWMug2o0zYVxpQfPwxzeXtaL8kgTt6NSqYBR/Ej9Aq7gzo/h/dbFqHW34YxmHPLF4RyOVads5wkwKKrKiOI+IZ/GYsx0cQpu/CgXoC3p0UGedz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eqn3nTfJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hM6/zLqM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eqn3nTfJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hM6/zLqM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0597E1F7D1;
	Thu, 14 Aug 2025 05:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnh4KOoFyfui8L9tod3Xuqssl1j5kS74I0ySiKi//IU=;
	b=eqn3nTfJtIY5OSOrkYm3Yxi2JUXwvS8SjiwKxPUhNumfJQDnaeu+F15zeNpM3v37vy5Apn
	duNYTSHZeM/OQJpBIir8GZzaeBenUCe0FSCxtaZz5/wEY0QyR+IbAVvQKFmUT6ib88g+p8
	+0NYVofrLI1P0lOVTXiwjzDzznUQFG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnh4KOoFyfui8L9tod3Xuqssl1j5kS74I0ySiKi//IU=;
	b=hM6/zLqMQSikb1oDd88BfOctuxaa5YzMNr8G4k0XZ7/Gu5vTZEqza9ucruIxQM8VMns9mE
	mjVWUG0OPrUq+YCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnh4KOoFyfui8L9tod3Xuqssl1j5kS74I0ySiKi//IU=;
	b=eqn3nTfJtIY5OSOrkYm3Yxi2JUXwvS8SjiwKxPUhNumfJQDnaeu+F15zeNpM3v37vy5Apn
	duNYTSHZeM/OQJpBIir8GZzaeBenUCe0FSCxtaZz5/wEY0QyR+IbAVvQKFmUT6ib88g+p8
	+0NYVofrLI1P0lOVTXiwjzDzznUQFG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnh4KOoFyfui8L9tod3Xuqssl1j5kS74I0ySiKi//IU=;
	b=hM6/zLqMQSikb1oDd88BfOctuxaa5YzMNr8G4k0XZ7/Gu5vTZEqza9ucruIxQM8VMns9mE
	mjVWUG0OPrUq+YCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C94913479;
	Thu, 14 Aug 2025 05:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cB7eAcF4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:49 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 5/7] gen_initramfs.sh: use gen_init_cpio -o parameter
Date: Thu, 14 Aug 2025 15:18:03 +1000
Message-ID: <20250814054818.7266-6-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>
References: <20250814054818.7266-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

gen_init_cpio can now write to a file directly, so use it when
gen_initramfs.sh is called with -o (e.g. usr/Makefile invocation).

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_initramfs.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 14b5782f961a8..7eba2fddf0ef2 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -193,7 +193,8 @@ root_gid=0
 dep_list=
 timestamp=
 cpio_list=$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)
-output="/dev/stdout"
+# gen_init_cpio writes to stdout by default
+output=""
 
 trap "rm -f $cpio_list" EXIT
 
@@ -207,7 +208,7 @@ while [ $# -gt 0 ]; do
 			shift
 			;;
 		"-o")	# generate cpio image named $1
-			output="$1"
+			output="-o $1"
 			shift
 			;;
 		"-u")	# map $1 to uid=0 (root)
@@ -246,4 +247,4 @@ done
 
 # If output_file is set we will generate cpio archive
 # we are careful to delete tmp files
-usr/gen_init_cpio $timestamp $cpio_list > $output
+usr/gen_init_cpio $output $timestamp $cpio_list
-- 
2.43.0


