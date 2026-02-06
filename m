Return-Path: <linux-fsdevel+bounces-76522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLwPOyVkhWl3BAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:46:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839EAF9D5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92275301158A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B7332EA5;
	Fri,  6 Feb 2026 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA8+Tc0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04298299A8F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349597; cv=none; b=qT8dkep/KNlrDBimfSBuEK8MImiSlEb1qqKajMdflhcT9AYk3AAirtl0SI4MGNEOvHty2qQbW2GW/B5f+L5cN4MtEyrI/zdnn7A8qYXgvVVuEdVhPqFqs0pB23Fwq1a3wI7FAk9HQs4xanrxFDclr5rMLiHxjJ5kuqDfeu7mrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349597; c=relaxed/simple;
	bh=gwM2LUHb9TAPh2tE7TqxrtSQQMv9r1lI0fQ6UfgX5sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9Uc3G+yFvVZx9Vk42YIuW4cBBvDAW+IyZYmAmHGsSdIT1FwPSvpNYmOeK4Od+tJ7ms7iI5+rE7KfYm7DbmT8d5kMjXC4USqCk9XwXo/7yjdr59CGSEsmLRDFZ2BctT1tHmROyIbyGF+U8QKh1Fy+YIRp7AVULGVBJ63FBnlaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA8+Tc0D; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c635559e1c3so729386a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 19:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770349596; x=1770954396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpc0aIq3h/5eq/m7ua4SavOGe3EcgByFz1tv4Xr8XWc=;
        b=hA8+Tc0DmsOwSFVhGPPOihEdgUoMlT1I0yNl5raBQ8jWTryXJKpYJxGfuT1AJMmGav
         GYfwr7yOVVMUmsYrdyQz76oT65HMVDq/NkVFnbnkgKepOXh4H7G4H7W5dFflQhOIKhZK
         YY5bZML06hqEPy5VYOoV+C4n5T57ruYuHFlPpCZRyfhxtgV7mKsuAvZ979FtdswOJs0R
         4A1zT9gpToyvwFlpW4qwW+g0Bo8HheSYOSZxrl9gBdicbXizMBrFQvNEHFokCf6+QBsK
         TV4j5hDlTXHPrMZPOPk4riB6yCsSQ9MkmiDLUOCblYRmo24A9nrdmwAbk534SshGFrO9
         yTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770349596; x=1770954396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gpc0aIq3h/5eq/m7ua4SavOGe3EcgByFz1tv4Xr8XWc=;
        b=f4ujtrhc0i1xsqRWFJk4fscRu5JjuZi3K97tg+7UNAWg8/3JwxItR3lKfF/O0/2wXJ
         ig/pvfK/Kq3AgSRTmCZwcXil2glrtr8I29OqYdlf2g9K908BjPWsFUYakfd0gGH8Ul41
         YiHCfe0IeguY3cFkKqDkpEZb5n9e+ERO4TuqnivmZQz8g87fUAznI1tsaGLF/lBUU6vK
         qXFCNArG9ImPQuWgmgIVU1sXEaj+yyZmCKngTq4IJNvCsPILN1Bnthhy6hQsYfITUY1G
         oG7fjyJRxhIFE1to2ghZx2pgvYt44+CLuSg9Ve8UD5vBgeQ03DKgGiMHUGACrBvR4soU
         9lsQ==
X-Gm-Message-State: AOJu0Yw3jjiRz4UEzU5X5EWml3tiJhyWYEVLrpyW2WYlD7KJlOY1mEOf
	TzqOf5/i9GZEWE1LCrITjI13bCqwIHOOc2bSgKmnsBHQhmU1EyvXhKBZ
X-Gm-Gg: AZuq6aJnbNH8HOVAsZclj9i9Loq/lyR/vdwxi8qvVdXATSwcrTTuYjih7008ADNyKXu
	12hk53ifdQeAnNbw674WJx+EnMzvyx5tNgGSqapvea1hClARdLPKXs0b4oepj3Gi9E6BLAcL2no
	NyzhpHMCqfoe/8M8SMS4r3CXSMs28iRN9CxNkpLswKudes13or/Ju1vQJzSLkcki/AhWGHrPbyc
	fL3t1pVPmLI6dPbMBFDuScYABTxVKuP1efmO+K+s2dJD/U4Yjof1Y5Yqh1AJsPfmZW1V/Dj2/UL
	YZKRnHymSAevxmH0Af7xZUtkDtBjOPGJhgzOA/35Q3VbSogcbsXdExR7Iej+/+PESXuob+PPh23
	NFn06qXAc4IJGfI0Qb+ZI4kZvFXXAWqnh8dheKNxae4MNEetJBwT5RDwXgpZMWsxF/RCDcJ7qqQ
	g2TO9QJMQq5/k40sFmKXLSY7zvTqmD1FhWBd6P4S/Jb40Ist9p
X-Received: by 2002:a17:902:e5d0:b0:2a7:516d:18d6 with SMTP id d9443c01a7336-2a941052a66mr49553825ad.5.1770349596244;
        Thu, 05 Feb 2026 19:46:36 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c809desm8796435ad.30.2026.02.05.19.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 19:46:35 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
Date: Fri,  6 Feb 2026 11:46:31 +0800
Message-Id: <20260206034631.1189468-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
References: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76522-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,7c31755f2cea07838b0c];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 839EAF9D5C
X-Rspamd-Action: no action

#syz test

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..4f514e487e35 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -413,6 +413,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 			return error;
 	}
 
+	memset(&fa, 0, sizeof(struct file_kattr));
 	error = vfs_fileattr_get(filepath.dentry, &fa);
 	if (error == -ENOIOCTLCMD || error == -ENOTTY)
 		error = -EOPNOTSUPP;

