Return-Path: <linux-fsdevel+bounces-58245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73269B2B80F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29245525580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD42FDC5F;
	Tue, 19 Aug 2025 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xG3ndZBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tfx7uqe5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xG3ndZBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tfx7uqe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3842AD3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575449; cv=none; b=YJLaVWoAGzsdlCkpqBtQ6dHuhvoRDEs7KfDdqx9G6dSm4jIVMB3JhRuWZ5i2y7Ab037KDx/aLxLrvuoRMpv/hQfvEQUJdTsjY01k8TRXYNw+SD6cK/PAIwf9ZcwnlTIW0QVvnKEl0na7a4omO4r7FwHQcxjbjN33tUlsLyDKfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575449; c=relaxed/simple;
	bh=huNOM2AWSEo5Ig0s7OYg5gdvDCPovkYG5xn3yerGtjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIcDCuOFmxdfMopWAcYK782q2kSfCFgj/xLytTucEs2GoweRNezGMo+oTVpCvGKWB9vPSmCxtEBTkcjSmjLk9EXeV6T+oZovdkxdbPKiMvrSMRGX6ryLQVevR4aXqY/hJDQYL73NNELMMHvzI49rZvU5JkyekMd9M65/T8rsMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xG3ndZBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tfx7uqe5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xG3ndZBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tfx7uqe5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8DAF1F785;
	Tue, 19 Aug 2025 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY//bCy/hJA3sSR9n10aI0G0G+SSEGSonHoY9P7C4Eg=;
	b=xG3ndZBgpttYNUbLUraXJIpJ9+2xF0I/qj4OzfF+2fmVNBBcFf7uuM3xb4Fhu+hsKZbUTn
	+NvbZhJHjm1+58zY66LXZJtbpa2ZMdXnQtMsm1nDaduzwy4R2Uba8C4wLIsXQndKPbVO3Y
	JR6pvSy/cVsKubAa0EGCmU90X6iQlSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY//bCy/hJA3sSR9n10aI0G0G+SSEGSonHoY9P7C4Eg=;
	b=Tfx7uqe5yiDuV/JDV6zVL23ltQ6rUniBjRekirV/DbN9yVzUPTt3euH6MSQ14S2RhxMPll
	qEGLCK0CT/e8NVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY//bCy/hJA3sSR9n10aI0G0G+SSEGSonHoY9P7C4Eg=;
	b=xG3ndZBgpttYNUbLUraXJIpJ9+2xF0I/qj4OzfF+2fmVNBBcFf7uuM3xb4Fhu+hsKZbUTn
	+NvbZhJHjm1+58zY66LXZJtbpa2ZMdXnQtMsm1nDaduzwy4R2Uba8C4wLIsXQndKPbVO3Y
	JR6pvSy/cVsKubAa0EGCmU90X6iQlSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY//bCy/hJA3sSR9n10aI0G0G+SSEGSonHoY9P7C4Eg=;
	b=Tfx7uqe5yiDuV/JDV6zVL23ltQ6rUniBjRekirV/DbN9yVzUPTt3euH6MSQ14S2RhxMPll
	qEGLCK0CT/e8NVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC0E5139B3;
	Tue, 19 Aug 2025 03:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8PifHHD0o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:50:08 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 5/8] gen_initramfs.sh: use gen_init_cpio -o parameter
Date: Tue, 19 Aug 2025 13:05:48 +1000
Message-ID: <20250819032607.28727-6-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819032607.28727-1-ddiss@suse.de>
References: <20250819032607.28727-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

gen_init_cpio can now write to a file directly, so use it when
gen_initramfs.sh is called with -o (e.g. usr/Makefile invocation).

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
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


