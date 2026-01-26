Return-Path: <linux-fsdevel+bounces-75473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCJxFY6Ld2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:43:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C08A45E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE0C4301BEDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31534028D;
	Mon, 26 Jan 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkry+gta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52933DEED
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442132; cv=none; b=IgU2Zng5CmWi4etsLSgt5J7rUH96gJ458SgdzZOOMq6ZrtTn+f3frZORN3PP+zFxMb6ccAZVeqg867w0FEp/asyakVFTDOxIHy3rUj+UmULYNhOVV1mWHE50lviMt1QqSi5PpD/UqIkQ26u3GmzO3FIUjmTiscZmvdBE10U7+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442132; c=relaxed/simple;
	bh=tDX4/j/4ahIfg9o5XRxBR2QuO+1qYjcCp7uZcGAX03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgNJBTp1BQsCyOJC2Izn9snrJUUc+gbmnq9x6bV8JdWdha99mpFzY6+qs78ZiMdb4lUnEJTutH6UE+ePFVs9MSQlYQC9YaMK2/W25XNP7PqjJxCjjzRnFKBTUQ2V3+APXoAvBOvJYYfgV6S9rLNdtblp9ndRxlaYjWNzFGhSobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkry+gta; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823081bb15fso2414052b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 07:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769442131; x=1770046931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/KlZEx+u0e43aEKml6MIGqsrdovDvYZ8jhKvUs4y8zM=;
        b=Rkry+gtaQzFD2JFs7fslO+jz3JiSSZ/eWp8x/NoKgaFXLWH6Y8Yv12fy780wzy33iX
         iRbk6ih/gSn6JjO/4rmxYPBW+5UzrgIs2S+QAgI4Ert7zkjzGrvf7yzcSj4weemR5AmB
         L8y4oddm8p3h+jsESK4nNtq83fq1YMJJXJBqFLyyTsKySBawyXre+OoqaFNR+RLfUrCm
         nCLjDDuCFKF6xk6KO722hBv0g35fcTDkbqvSMnQSgNW0SRlLo+6Hh+5DkKp7pQrdX42Q
         TZQG2VfwbV8DJ5Sq4PfdQc2f2ONnghf2cTcD/ncYlOPVTUAzASfci9juRhfVvD4CkEw3
         PGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442131; x=1770046931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KlZEx+u0e43aEKml6MIGqsrdovDvYZ8jhKvUs4y8zM=;
        b=UF2rJrglmosZzY/k3kA4MfojHIKwoSSIu4oU/KfYh7ctlESkExR6fcxtTI+9hLj/H0
         ChSUdeDwb8rR1WPWyxGR7dU88SHvFKsPiesyYdl5rDtuotSYB4GWnXJJ8wZNhGs7LqeG
         mPGxXXtczyWGFOdsGTd4ubwlQX8kqMTpK8+jsmlduQ3Ugd/MGFXxA7UrHPWGiN8LgkB8
         Uy8+4vyb1GNirE5ZydhTkT25UTOvF/fKwcmAVOFB8M0HpE/hJssxyQEiSfFoMn9GYTsw
         4P4gHb9hbGblRGilUYXXw/82BngRwRkNo+PorG7MOqwHHHJFqzpR4dIkh4gtVLd/wz/r
         Bm9w==
X-Gm-Message-State: AOJu0YybdrK/CwgTxPEuHamDbtM1Lr+VQJNlEbsSb6f5iuayl022vbaS
	fBacEANBbOpDZmt3Gnitdqx3Zle3fvBH+Q6VC80gP3ZxeuYUVqiwjT/vVQtCaw==
X-Gm-Gg: AZuq6aIxQ5pnvF74bzKHStYFy5xq8SYQNIyIVTqN/0tE70oKJxUk+xur6eAqn+38vEq
	88yzdOyYcd9wNEbBewkavQp4To18YIS7t97m3AezBCdj4eclBi4otOV2ufAUu7RbH+AZ2ySmh1B
	WgVkRHiZxFTCZv0juG1r7SS32XlgsZDYg0UWaYXVfdp6H0slbXKwoNHWy0iHXXF9Y2HVyJnGwk/
	DtJk1mAa7ptrsnVd8pJAHzVK3TGV7rK6IST7cun8fzDjfIFuWoorJy7hTsgpJP1mJTyl+kLImad
	2d2MPVVW89/PFS5I1ugBdt11eiTg+AQo9xKczVQ0WdqA7Cx+aI8S3nGaRZZyps1+rQ3A1fJElky
	QJetjn3ysVjpOny+FHKMzjFHxzA/M8UlTj+m/X7ZDVRepAkY1R0tDsP4d5SoIfdIxd/yExP6RSh
	VLcerNsvWiJzvoj35CNThhHBx0nmx4MpkkNROGv/7Q7j8=
X-Received: by 2002:a17:90b:3b44:b0:341:abdc:8ea2 with SMTP id 98e67ed59e1d1-353c41c97a7mr4093004a91.37.1769442130618;
        Mon, 26 Jan 2026 07:42:10 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536d88b098sm8649100a91.3.2026.01.26.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:42:10 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de
Subject: [PATCH v2 0/2] O_REGULAR flag support for open
Date: Mon, 26 Jan 2026 21:39:20 +0600
Message-ID: <20260126154156.55723-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75473-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E55C08A45E
X-Rspamd-Action: no action

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

I am not quite sure if the semantics that I baked into the code for this
O_REGULAR flag's behavior when combined with other flags like O_CREAT look
good and if there are other places that need the checks. I can fixup my
patch according to suggestions for improvement. I did some happy path testing
and the O_REGULAR flag seems to work as intended.

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (2):
  open: new O_REGULAR flag support
  kselftest/openat2: test for O_REGULAR flag

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           |  1 +
 fs/fcntl.c                                    |  2 +-
 fs/namei.c                                    |  6 +++
 fs/open.c                                     |  4 +-
 include/linux/fcntl.h                         |  2 +-
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 19 files changed, 74 insertions(+), 4 deletions(-)

-- 
2.52.0


