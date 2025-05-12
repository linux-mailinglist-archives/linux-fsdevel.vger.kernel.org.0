Return-Path: <linux-fsdevel+bounces-48745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B0AB3898
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690553B239D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94729614D;
	Mon, 12 May 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj7fCRXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB62957CC
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055976; cv=none; b=MOOhjs/90rdsbSmqZL7+K76ef91vNGvnuiiSHxgqWCcBrJOtRi8t3Ae0ndhcxsoOCzdr4E4Qx/t4P2Ypiv4FzndcvbO0I2bnNkQ9hqYud5VUf4EChYIclUKw4o7JqquQUI97XTS+Iy0TwF9MGCetYm7LWrpMr2cGmTP4l/q0nWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055976; c=relaxed/simple;
	bh=Sow3ieK523EXyMicqcCSjkd/TH+5nWsIoTZ6MRpL6MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDgfYaOqAnil72QFRPEjR/0S0GwIfkuLaNgmbV/eIOwvlQ1Ao2fUwVGICFH0UEZR3va4uZf+s7gmtW8bFDdwJN7R0OouZKBf6kpj1HNmrws7VPlS8WEJik76oBGka9DO3SH6x73vzK/JoOnal6uPXLaxdqdgp2LEqony6xLjf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj7fCRXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDXnQGld1rGn7NpA5vNTnzaJVN2Ft1voUe3ylxYDySo=;
	b=Aj7fCRXBBgGLOiSchMJBtJVGjdm6L41pvBxMqCMZYiCnIy4+2oFgReop+A9ZfSFRQ3bPtm
	ogRbOrcaxBDFovCCsTbE2taa0vT7adAvOcJvauDAZEANWN/Q/C6CgLyoubNeS1Gx/Bfpa5
	JHK9CMAIW1KtODODWpaL0vxssrTNDcQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-6TcJI6baOuWfUePZu1HLgQ-1; Mon, 12 May 2025 09:19:29 -0400
X-MC-Unique: 6TcJI6baOuWfUePZu1HLgQ-1
X-Mimecast-MFC-AGG-ID: 6TcJI6baOuWfUePZu1HLgQ_1747055968
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad239523a14so160878566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 06:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055968; x=1747660768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDXnQGld1rGn7NpA5vNTnzaJVN2Ft1voUe3ylxYDySo=;
        b=LGaNJKIDVlmDA/V9gxWP21S9Lq0ZVOOUTEWcJ5X8YCHrYvMHzgSpuhcjGBEExIjZsY
         8rLcqRDR9AdVab3Yq5iddZMg7IVmOSU/5RL6IWAfn9/Rm4RzakmeR86jc1BHcd1pE9nC
         07tBpFKdT9baerWuZwJFuf4mTZvK6dS1tpPrDJTivEF0MHhI1YPlX9QYs6NYdcnlvacp
         l+obNkFNDf9JVE9xSMtSCNHfcsl6eFdTHf9CGHwgNMy+Nd6f7SSrhar007QaGZJoWF9l
         hT/Unm9at0rp/41yHMcIA8IGBbQjZAbQrwSgdKz5/GSqACBSHOMZK0gzmEPUbevD+mNX
         JnLg==
X-Forwarded-Encrypted: i=1; AJvYcCW85BMzVtUZPn62bdSQflMjJ048QGDshGXIqK5tQwSzR+Qci6KrOEKozhfg7ZMIwXZkK7GwYclrvMKCWxgy@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlXsWTa+w168MDrJzNCcYjbM9KqHNQbMXwWOUDbcaa4ELVJDl
	619PkRISTMhjoOpa2kp1lEnkVknFmRcz159UmdUPCslUWLj/fMoPbiQuX/qCCUZ5RX7rJS4Y2BN
	YkbBafKKQbeLESERp8wIEBfGkFOGIwYwMKZNZZd22sIXDE1E82wWIexoZXnfY5w==
X-Gm-Gg: ASbGncu90pbFivo1dhMi1yn/zgffw1N+VsqpPOr3vBqlzCHwuAjq5UQVrDyhtahUDCa
	kNpxTq703OgJ0JqEdxCr5kLDnT5BZOUJWMlhboxvjOpRS2ewXTd9Mh6IWlq/eQOGTWit0wwOZYe
	3iB/vo2+LOJnbw5HS3+Mp0aPuMh0S16WHnawhsEVIqCBiMM+69hNEjPtxbwYW3xW9NOfKGcmFoS
	hI0iWEcb5pwsJqYIj18NoO50IUi1lAli7ZKoDNnCkGS0cIYvwWe/36ku9v7XuC1cNhF/XpM97Ok
	AGmLpeOuYrUweq6ugl8QTIy4g1k=
X-Received: by 2002:a17:906:6a22:b0:ad2:cce:8d5e with SMTP id a640c23a62f3a-ad21b16d4d8mr1361761666b.7.1747055967998;
        Mon, 12 May 2025 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Wm34D/72hdzOITX/1P+LJJ3f88CMImIhv4h5FTIdAsUC2LOrFnS2VVLTTqMPzoKoT8uong==
X-Received: by 2002:a17:906:6a22:b0:ad2:cce:8d5e with SMTP id a640c23a62f3a-ad21b16d4d8mr1361754066b.7.1747055967429;
        Mon, 12 May 2025 06:19:27 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:26 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:57 +0200
Subject: [PATCH v5 4/7] fs: split fileattr/fsxattr converters into helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-xattrat-syscall-v5-4-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=Sow3ieK523EXyMicqcCSjkd/TH+5nWsIoTZ6MRpL6MI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+l+d2NV18V2W7kMGnsp1P5oOhUkzLv1iXWyve
 u6BgJTb4oCOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE8kpYPifV7rt5W3p05uf
 VJmX/T9pu3iZ1uHej6nJczr3l3gX/F8dz8jwtzfAKvXqrcigX7ucu9t/uaQYyQb8rb92wEHraHl
 ATC03ANV+Srw=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This will be helpful for file_get/setattr syscalls to convert
between fileattr and fsxattr.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/file_attr.c           | 32 +++++++++++++++++++++-----------
 include/linux/fileattr.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index be62d97cc444..d9eab553dc25 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -89,6 +89,16 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
+{
+	memset(fsx, 0, sizeof(struct fsxattr));
+	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_extsize = fa->fsx_extsize;
+	fsx->fsx_nextents = fa->fsx_nextents;
+	fsx->fsx_projid = fa->fsx_projid;
+	fsx->fsx_cowextsize = fa->fsx_cowextsize;
+}
+
 /**
  * copy_fsxattr_to_user - copy fsxattr to userspace.
  * @fa:		fileattr pointer
@@ -100,12 +110,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+	fileattr_to_fsxattr(fa, &xfa);
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -114,6 +119,15 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+{
+	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_extsize = fsx->fsx_extsize;
+	fa->fsx_nextents = fsx->fsx_nextents;
+	fa->fsx_projid = fsx->fsx_projid;
+	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+}
+
 static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
@@ -122,11 +136,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+	fsxattr_to_fileattr(&xfa, fa);
 
 	return 0;
 }
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 6030d0bf7ad3..433efa0f4784 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -33,7 +33,9 @@ struct fileattr {
 	bool	fsx_valid:1;
 };
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);

-- 
2.47.2


