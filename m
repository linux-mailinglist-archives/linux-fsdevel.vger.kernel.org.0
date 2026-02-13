Return-Path: <linux-fsdevel+bounces-77089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCXzNIjZjmn9FQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:58:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE7133C17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E266F301DED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D831327F;
	Fri, 13 Feb 2026 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3nWG8tt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16A2D8DB1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969473; cv=none; b=Z6az2dvGXz3I1Kg1ed+dd6XZmAmF1fkpTvaQBaAQfFdYv4LUOFSvAtuGse1vX1ijB/ZiOzmGhDCbRWDCq+tIKvXqCpGsdOri5NJsb01sHw/c1390AsIhf4NTfp8YVy832x48MiGERRr5UfwVRbKnO87U8ywwamKbRMGiBWBHEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969473; c=relaxed/simple;
	bh=SoEmzecez9HkGA98kp/yjJIQ5dMOebfjCdrMct2EToQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnwi9i3ptnqsx/LT5/toUytcTgyrTlWxcNJIOQBGmFVlCngoabJnv5X/2vJOoldarhGKsLzuwI7cnj8aBaLP9kQ1JT+jXs2fzyFJbZyUBYXu0Ik2CSzbVFmCFFyAaPWoy5cDEdjjhAONU015dH7mIjlQjGsiNWvXpXb1xM57uTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3nWG8tt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8230d228372so423232b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770969471; x=1771574271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igCts1z0yuFi0lGGmkgngwDc03obakUIXzRutDr5OB0=;
        b=J3nWG8ttZ53fRuLgI/NJ8slHqhQ2j5dFgHkiVkhW9SRIdTLwxPewK3Nb3AgBPGont4
         DDhyC3kL8eihFONH+EiF5jRDsgFPyyUoX9+6ppckAk0Ttl0VF89seDNjaBYulNV6FR9Y
         L6RWpaayFrWXhOL7CGmzm0SV4I6uTT5EhsWoGPg2X71/ad8uGBQGXyVMWHNONIm4sdAV
         GszCm3ZJLruB+jonhnsKAhyRtD4BSiRg/JMVOM+P/BABcxkfqV6UygfoKXCcnO60vsp6
         JTJxuj0GqdjxXKx6VNCrsTCIjQYcUzUYNNfp4Wd5QE6bAODHY1BoBkMWEdHKNTEnLnyH
         AXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770969471; x=1771574271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igCts1z0yuFi0lGGmkgngwDc03obakUIXzRutDr5OB0=;
        b=IAqlEIk8CbY1UqkJoN1QtqunzuL55DtQb42QzP1ioCRqz0tnTW+u+3znTTEnxCEgwI
         CgGLTulRJyRmQ+Yr6ekAZZyRn2C6/VLj88GZayCzgTOQGd7EnNISTR4HRjIVg4vEeSti
         vGejdx3tYIXgjACYw89+YaRvJ6JObo1PLkSzx32ARvHN2ho1qeZAUZMzD1pQLDIhJtK9
         vD+5grHN0wOAx7e2AynFcqS4JUwfoPcAnazI36DeR88uAPcPEecUX/yo6BW+/tRcNXLx
         9tbYTOq6kIWa73lWhK/68bHiUWNEYnoVkkhHXRjEbkm2/bc7LG1E2JDCE2lajzWzTdEJ
         zI4g==
X-Forwarded-Encrypted: i=1; AJvYcCWDAXGS6oPgqsuhaY3O5raCF4PfJVUda/+UxEJxtxEHQISwSf1f0nsC3GupTeWbq/WEWPoTeDPnJUJjlr7x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy96WKKkPjPitLHyCfpwhIFW1I1Ups1qlvwdH7iCJlmJKKTHcb8
	fU+J0jAXg+OxcqEneouxkvNCDq9VQE+oVRVCyLHBiMr3dWIo8d6LJ62/
X-Gm-Gg: AZuq6aKtZR/wqluDODeu1mRsiaryf9i1v1SvijtRZMcHMD/ZXoDUMFbr1jOPeidhW3I
	2oycKaa93/tCPAoDiJXVLpIR33wv7NzfCMuWQJW6uASi1DCiMr1PFUW78zSO9qU9X9bi9E5OVd9
	JZ1xuazTNJWKv/LionFalJtRFy09h0lfzu2ZLhBnJ2wDYTIzIY3a4iyHZI9HfZvqjwzmsMcMxZq
	FOtNubxBEKunTyenxWA/BYFl10e3iPcbDvXi2RP/JfZLto9UkiHuxMRmIk1WSUslsD70b/ToUvd
	kCOPvK3AM2JVrnX/K99zFqeUcw4YZSAchrTi2RjLYJcZKrK+jle+ZK4QDj94KQcT0+oe4rMediK
	YKBBr2v0FPbmN4SC/lx4sJVh4oSUB+hGVeMVxvT9MrnW9b+WskmISaIn+nSEQApZ23JvKhu/iMI
	02E7RniJtW9kvZ4r6NszcCQOq+svYdkWjH1kaD+m2HLlMv/kbhjQ==
X-Received: by 2002:a05:6a00:2d87:b0:820:f4fb:e914 with SMTP id d2e1a72fcca58-824c95bbba3mr1160727b3a.42.1770969471252;
        Thu, 12 Feb 2026 23:57:51 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94009sm1560665b3a.52.2026.02.12.23.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:57:50 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in grab_requested_root
Date: Fri, 13 Feb 2026 15:57:42 +0800
Message-Id: <20260213075742.2398200-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698e287a.a70a0220.2c38d7.009e.GAE@google.com>
References: <698e287a.a70a0220.2c38d7.009e.GAE@google.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-77089-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7DBE7133C17
X-Rspamd-Action: no action

#syz test

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..d769d50de5d6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,13 +5678,15 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 
 		s->mnt = mnt_file->f_path.mnt;
 		ns = real_mount(s->mnt)->mnt_ns;
-		if (!ns)
+		if (IS_ERR_OR_NULL(ns)) {
 			/*
 			 * We can't set mount point and mnt_ns_id since we don't have a
 			 * ns for the mount. This can happen if the mount is unmounted
-			 * with MNT_DETACH.
+			 * with MNT_DETACH or if it's an internal mount.
 			 */
 			s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
+			ns = NULL;
+		}
 	} else {
 		/* Has the namespace already been emptied? */
 		if (mnt_ns_id && mnt_ns_empty(ns))

