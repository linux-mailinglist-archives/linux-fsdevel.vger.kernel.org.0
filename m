Return-Path: <linux-fsdevel+bounces-53385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE1AEE443
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D77AECBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1E2980D4;
	Mon, 30 Jun 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTlECQm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DA29009A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300442; cv=none; b=Tk+OZRNbY9GuP4ICRQsk2tyJaMxy3gQbJtYs1IdKT552BXc9nNKmrJs+nXBSY4hGQ/8fyaFYfPNeYBXaFJy9UgNRn39hE9frEM/M66YFG3ph4XJ6iB6/J7J0hfJeYcpvL6UpkD+tE3dKQN7LbagNRwz/mzApU7HrajYFb/NBe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300442; c=relaxed/simple;
	bh=1fmnKQClA+Eq4TXGJEAAeuvdJ0gw1NSpnjK1+MgJX8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8R6wNX1BwVPAWb8YJZcxn02MAaen0jtktS4+mDWuxOPt55O8HwZfLXCVA2KR0ofvp5feqk64UlxobMi2MpXK62DqVBKn/V+sHXIf8ApQSBbIJumjzKIwYwE5X+SlJ8QWqe+gWFKkYan/yzwyE6y12GrWS1WtJZYGeG6T+hlmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTlECQm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=retAznaHagyZVmXo9T/cqkc6BvJhqtSJTEOEchYRx98=;
	b=FTlECQm6ltIuMi68JG+hSmOjwXWzZEz839mVesLwk9y0QswXKr95bcen+XldC6n4IyUfjY
	+ev7Fi8pU+UDqfEowj1OJiLcEq3chv2R12n2HCZc45H9MQTAV5eG7pkPxLtNBvElU/u4eB
	5o9Rtzd/4gD5zoyD2qAoh0mUFCp3JQU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-qn__u3YPORu41ymrlOQhWQ-1; Mon, 30 Jun 2025 12:20:35 -0400
X-MC-Unique: qn__u3YPORu41ymrlOQhWQ-1
X-Mimecast-MFC-AGG-ID: qn__u3YPORu41ymrlOQhWQ_1751300434
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ee06160so17608555e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300434; x=1751905234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=retAznaHagyZVmXo9T/cqkc6BvJhqtSJTEOEchYRx98=;
        b=KlKUwGdc6crPQ11tCmnWeCb9WJqcSZxkL8MgjPt/MKB+F0PiLMhBgLMbYWPh7A41hW
         dGF6OcKNsmTpaLwTBzCv/bcOYxLz3qYae6IRIRise4HqSVPBh8V3mWqeEmNeiHi/QHEo
         l7m8wBW4DKuLy7y1q2m1C9x4bRmRNIgTP3vPWDz2Z93EAX25uwyy40jwTxjfmSkPY24F
         /C0+vnr6dqGxpzK4Ad2Tn1DEnAGTx7Q6dmQYtxZyIsjo0fe5kBofIEgBYxZ5S6UukQm5
         4EK8UO1Ol7gEPaGA0VNpRg/Mm7tXHU3bWbcun1iEBcUSWEsnzhrB1oxcFDcECG6oApe/
         7DSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmYg625VBMkXHk9TiixRswXzvJw59w4NBPleAZ12neGyuhUrmdGms6Fiacz7FYx9IK4kzjPP/jwEzJx0M@vger.kernel.org
X-Gm-Message-State: AOJu0YxKl4bFy3ccA+BWmG6lm0GGtrutf7/XaX4Gf6rsW4FKGf9KMoOi
	LoLbLiKpx/pXnvQBj7KZgzLjCTikdWSMJcWVM9qSWfyRrJhBrLhnew7aDRUSBP8DxeteA4t0oj8
	qhVtR4FbxpZkf3XVHU1i7Fpf4u/2Ljh+WsLpnUItyNDy7e0gXv/4+O/cvtvpDOcCPZw==
X-Gm-Gg: ASbGncsve7LX4MFvzqSdZrr+ymeNPjjIMgBMGxvrSt7ZSDQ8hExvUpZAozQAM3/sTPj
	xuRdzWKYKouZsANzDD4lMJr/Zo6tYGVru7jj05VXp2ZEJcNouGDI1zgUTVRXLhw2Gsfc+5BTbKb
	vNvvCcL7HTQ0BUT0mvay1S1ToCSdHkQRi4StEAyMKetKIrAg6Kab0Tjv2atZS7Hf4kcRkYqJiOF
	e4RHnWcIgeotUXX0MYpocYK/04WZhPJArllcJPB90FtSzijHeIT/Kp/8zBeCbSGWhqzbmcHZmXB
	KI5v0rtqMkgKl7NmCDTTXoUyUaPN
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4538edf9e08mr161397315e9.0.1751300433925;
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWz29iLt9Ec8/QxCebaTYhDNjHorIH/1Bz8WoGZW+4+aLu8ceqioBoXyyLjXlnzKczI0zmg==
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4538edf9e08mr161396915e9.0.1751300433504;
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:13 +0200
Subject: [PATCH v6 3/6] selinux: implement inode_file_[g|s]etattr hooks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-3-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=1fmnKQClA+Eq4TXGJEAAeuvdJ0gw1NSpnjK1+MgJX8U=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2enPFVZ/teivMYHN62xWL+csXzExLCz/utC+5a
 qlnSu+es2IdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJtLpxfA/JuEJW8yuCy1M
 T8/dSOzS2vKR9eSE8LZb6+3t7Q8UKSrYMzIsni+mekNPS2F99OTy5xf2ZfnlXYgJXX4lZxPf5md
 lmZX8AEY/R7U=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These hooks are called on inode extended attribute retrieval/change.

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..be7aca2269fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3480,6 +3480,18 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	return -EACCES;
 }
 
+static int selinux_inode_file_setattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_file_getattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
 static int selinux_path_notify(const struct path *path, u64 mask,
 						unsigned int obj_type)
 {
@@ -7350,6 +7362,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_file_getattr, selinux_inode_file_getattr),
+	LSM_HOOK_INIT(inode_file_setattr, selinux_inode_file_setattr),
 	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),

-- 
2.47.2


