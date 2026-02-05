Return-Path: <linux-fsdevel+bounces-76386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFQ+GBJ1hGkI3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:46:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7809F1716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AA030238C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ADD3A7836;
	Thu,  5 Feb 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="TaZk3GHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544791F1537
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288388; cv=none; b=Q/yjNGpGPTgTodkAYSEMM5caXU3MgSPp2kW2aWgJwdIu7hqIT6ymNG0a6QfOZcuI21xTv+5pKyzpgX2G97uh1uNP8EXkBeEQK1Eb1fQhGKYyQvk9j7DkTCleqhUBQDocYZqFhLeahi4o9Y0n3BILTBWn95QOjkYgbbA6eejboJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288388; c=relaxed/simple;
	bh=FntRL1qpxfsNfmvPILCwbU6dqigMGKuJ0zJnx7gXrxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgDsWvczxshwQE2Q08MCHVKDbdkrdhVcTPXUb/NhebwY/56G03w/XuoQLHDzaDLiT5Xo5riQDAH4talmYaHLopKDJYgEHJHNsSWXb0f9FW+J3D4RUhaeNpb+ipgOeDibkMTw+AyVEmk+qSthNJGPwkhCMGtIeZ5FEFVCEdbmW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=TaZk3GHv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359228b7c6so542686f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770288386; x=1770893186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pI+I8Y4vd8PrLGBnjDW8Sa0zt5Y1hsnun0xp3Gdhd6o=;
        b=TaZk3GHvcIEe2sT+plbieP5K2VYopl7ILZjpw4m5IHR16O9JXem0J9GvruTYqwJwzo
         phVz2+hSLhhob1YfzZo+BYuvdb7uipF1JFO+X+UWPi0LlSr+Pgs8Nqli9x+tBQfFvtyG
         mYOGqORAEAfAo28anmd2r8YSydNK/zGpgBfRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288386; x=1770893186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI+I8Y4vd8PrLGBnjDW8Sa0zt5Y1hsnun0xp3Gdhd6o=;
        b=OYKqMw/jcKRZIIChUyOmg7f9vQVGvXcYKZDO/IM0v5cdmB0XVLnkwRo8z1oiwnzxAD
         VYGsDtj5y5VyFpH3iierKaeI2+9TQQjsLLvJaiIMe9ZcxzxfVA7TBI/Pz5RqnxcUSOji
         TK5LwOs2NS2aa2in08EwGs5uCXS4+ethpRI12env5BkMEvgzeVvFKhfRPV7OWV0TfgPt
         T6BPf+sTpklSm2E+6OdUbRvvr/fxsUCqdOtawdhSvs/R7lWY9Wx0sNejrsp2M07x2gKV
         BL2Iu7ILG05f6mCMWhVtDa1MBZwz6/nwGdbtriemNiR7RKR5uW2KXfBpfl6oxp5Og6SK
         tnFg==
X-Forwarded-Encrypted: i=1; AJvYcCVxeeWwSJAOd1ly6SnhtmAl1WkoAWDL45LdkEzpAvqykP456HWt5yYJggmG27f6IH03GS9F3T6rIT2OFlj3@vger.kernel.org
X-Gm-Message-State: AOJu0YzRy3fVa7xZMZJ7xlLQi4jW8ohnXvZ3chICcEf1ys/YUGmYuLtO
	ZPrWVBFnR4PKXivaaq8TMyxO+RTJ2GRi0q6wcFMEoLlXWkii2LI/kxYr8ZlargAtMJg=
X-Gm-Gg: AZuq6aKpJqT2zv1IRdCFfCpgXsUU+HzyRDpM6IdUWZ/wrKCvmZ3u1xXnKgyodjLYLlm
	G6xX4dlb+y5yWfYxLGnnVGV5uV93rxotEFW479Ugcm5mIA6tesGjcY8ueI3aMp10UopB/x+qbrX
	pwqJ4KmckwZwNTdiU5H4P76bkEO0ZwX8/m/YgZG2DYEmcEHpLTzQraAyOEv1Dksm7wbcByQ8QZX
	oYQch5cmgdfQI9WLzVq3N2SuRUvuKXzSxJZ2l1I8bkOaPDrctnOD2tz9Rg3KcuEr1OgWAsRk0d0
	S1Cu8+3hfWTysTo3VeF4wLGuoSYC1d7NfbCvce7/24746j9YP2x477SUtO524flvET4dT+Js2ss
	gUFuxzgrs0z6/fdoMIsnvShSQKxGXvZutDLIPMO+2Ypipqfnq0iViBKj+tistOHZwxzzhzEILVG
	M/QC2SvExrykjJck/qzE1pf5KjbotYE8IJWKOJdkEtuU0EN0v8nD6eI8k2BmSZWbA+t95Ikp5nE
	EYcgKT5JAs=
X-Received: by 2002:a05:6000:2207:b0:435:faa5:c154 with SMTP id ffacd0b85a97d-43618053a3fmr9052159f8f.37.1770288386357;
        Thu, 05 Feb 2026 02:46:26 -0800 (PST)
Received: from alex-laptop.lan (p200300cf574bcf00678f3cb95ec6a9da.dip0.t-ipconnect.de. [2003:cf:574b:cf00:678f:3cb9:5ec6:a9da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f66sm12351476f8f.25.2026.02.05.02.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:46:25 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: ast@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
Date: Thu,  5 Feb 2026 11:45:41 +0100
Message-ID: <20260205104541.171034-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76386-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: B7809F1716
X-Rspamd-Action: no action

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Instead of FS_USERNS_MOUNT we should use recently introduced
FS_USERNS_DELEGATABLE cause it better expresses what we
really want to get there. Filesystem should not be allowed
to be mounted by an unprivileged user, but at the same time
we want to have sb->s_user_ns to point to the container's
user namespace, at the same time superblock can only
be created if capable(CAP_SYS_ADMIN) check is successful.

Tested and no regressions noticed.

No functional change intended.

Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
- RWB-tag from Jeff [1]
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..d8dfdc846bd0 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	int ret;
 
-	/* Mounting an instance of BPF FS requires privileges */
-	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
 	.kill_sb	= bpf_kill_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_DELEGATABLE,
 };
 
 static int __init bpf_init(void)
-- 
2.47.3


