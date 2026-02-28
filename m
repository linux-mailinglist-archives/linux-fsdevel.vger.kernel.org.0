Return-Path: <linux-fsdevel+bounces-78814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJhUDpWnomkK4wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:30:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F171C162F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 504F63049303
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DDD3E95AC;
	Sat, 28 Feb 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek7RWcc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3272C030E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772267395; cv=none; b=UQe8IyKBF0d8zz0U23oHG0ab+oMvv2REgjdBS9VlsJ3OZr2mcox8NLh7R5qp4yKzbJah14pfDM5dlAufvxaEMmMgbKZAVXNT1JT5JaeRZfqa9Fe2THGlQTqMyyi8ZfgrezDVTe4BzRA72lPhu1ZlAL6hvDO0W0b8r8NtjQlZ6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772267395; c=relaxed/simple;
	bh=GSPUoSIz+9pB97rCfmIDKkMYJEqxB9ztnB1NXD4TE4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1uWnRiKitvVFJjyVLUe8qGyB7NKs0oRmq5YOmCvhGGtjrQRAXD6h1+HNLD4ivORBXVJTs7CaVzPZVVmp73Awcx5DOdq6DFATdesQw/XcJ0SLYKa1R6CdVcHRj2iwd/ZbFpHai3ms2qetjdlWkPTT5W35OGn/ZO6vEND2N2n0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek7RWcc2; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso23862925e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 00:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772267392; x=1772872192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q8ZvKHkpjnAA8I/B72ngNzENTZUf11sap4CueXWS5I=;
        b=ek7RWcc21J0sLhfWlJ5S+z44a9WFVmZvavTh/so71Tv3oMJCb3XaVxVYV8E5mo6nQk
         l83NNlmA8NwXmNWw/btfY06BLZrFHbCq5gUu5fGJ+kwRyG9DUN/jExEIPhPE8McL2Ms5
         hDj3Gnb7DoPetI34CpcWRcyku7DUF5Gfj2T+isPt7urtOZGrFv9Rd9dzuzWEtd06Fy92
         DFIXwx9B/ACPquTZ2pF0jGM+o0ZEBzmLVvAUGnA/wI0znh5vPQN2Q+mWrBEJKGXeMc7O
         m9TMoUz5d5Tw8/jcP1LkKXJcbm6kWInV/vUoElI4tahIttUkNglx9jb99JcUv03qgLlJ
         ou2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772267392; x=1772872192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q8ZvKHkpjnAA8I/B72ngNzENTZUf11sap4CueXWS5I=;
        b=iVt22gz9cfiIxEAYa1l4SB1/u7XIHh/zyb02qxnuYY0O6eC4XaJ6zUh12FmfeDeKuT
         31dYZaPkM842092Vy6JCDkez4ZjlH4QI453XdvrXy1sGQIBojJCHIVskNNPf8bDpMNEM
         Ki8mX2PHjxOFoiZdPdYKowBBXPp7AFDi1ppLckn2ikwqRbD9VwUdok7T1mdJU6HrrPKN
         nsVGvd1eqBE/VD1ds0hP2QtjpBDXbTkoA80jftF9c27shDDJsyUNHf4oUEU6gkg1aW89
         hllokW5BEH73G7411HwOZyor4iITxzr/Xng7cSTALnjs8xbN9q6HwyX0J7kSpNnwYC7h
         xi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5yXuSYTm3yQTHjAaMYOd8e75MivG1bscVOI8KmQtebKXwuJX8kmxyfAl8DP26i7zwDVm0vRxuWZcRwfXh@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIg2gKSNf6lguwjPctE/SxWsyn+isQIEwXfRA+kiMeZEQrukb
	PAgkUYwc37yetbUcuHGJ37gzIy+bb2wpT9NPVtVVSitteFQvgJlyzFnv
X-Gm-Gg: ATEYQzy8kuZgs2N7U8YLXTBRm+axtKG/I51g3nQfDEH6GVsJVf6RwmfC6Ng0ciNweaQ
	F21AEPSjVXZQy8nlsiKA5UnK/E49T2N+1quZBkGqbOs04nJzQ/0bLyr7tTAhNk2fYYiTPdX2Odu
	ft9rdCITaQ3Hixn3HI438sQk/x3y+FLdYwWkArO4dmNSGMGjYdKX5c4cvvs/XeGji8Q2035+shz
	UAFtnhqJNQyhXUheWQ59lLsTOO7vY/3W/QyLg+tcDnot521ATbJl16INyyVkCnfos1ryYCpivOS
	gVKhuj+bXRtrn87+feHNTaEUPRLmIzB0u1LJfjc4AJaLwggxd/JxOhgGoADvHhOQofjJTbIm8N8
	NL3vOxmrz3lfed9Zt9eTveLp+OfdSCCy3PAGyuc/vFNtELDAL+zjMsUfhEzyxVlJJ4RCg50tAEh
	HZGznnIxdtj5nFBm9POeNRQwEO3Lr1QFFh5CRXZouGVi+cygx4Pg==
X-Received: by 2002:a05:600c:3e0b:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-483c9b6d539mr97952825e9.0.1772267391632;
        Sat, 28 Feb 2026 00:29:51 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm239122975e9.6.2026.02.28.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 00:29:51 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
Date: Sat, 28 Feb 2026 16:29:42 +0800
Message-Id: <20260228082942.1853224-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a1a0eb.050a0220.3a55be.0021.GAE@google.com>
References: <69a1a0eb.050a0220.3a55be.0021.GAE@google.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78814-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,512459401510e2a9a39f];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: F1F171C162F
X-Rspamd-Action: no action

#syz test

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..34a5d49b038b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5383,7 +5383,7 @@ int filename_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	dentry = start_dirop(path.dentry, &last, lookup_flags);
+	dentry = __start_dirop(path.dentry, &last, lookup_flags, TASK_KILLABLE);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;

