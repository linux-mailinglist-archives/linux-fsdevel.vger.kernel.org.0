Return-Path: <linux-fsdevel+bounces-51415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E42AD68E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B5E17F207
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DE213252;
	Thu, 12 Jun 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8y/Y/tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36313211A21;
	Thu, 12 Jun 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712972; cv=none; b=fqTvkJeBKAlxZ1iiaSqR1jwBxC1x9JHRSbOVYlZcxH0epfDbffY1qNAjDUyhBsDWvWv80/vrIw4Y5HHDzjLBYgdt4j3DFrFMXHSK3wMJoSb4hJ3GWb0/+m0eRMztmARGqXxQEFzcWFHrjSnDEqjMArC/X/ZrvMwJWaF1Zry1GDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712972; c=relaxed/simple;
	bh=YQ9Ys5bbNSICFv16tGNfSXU5oIdcjT2McjeDq7dKVBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5YqOqliQfYmKo454yBzAml+3XHz+QRm9rzP1V2IN6RVt4+k6ssFCeNFvHMCrVOhIOXFcRWnGb+GRya1/Q35mcfZT11IifShXf2JWNjDvRv7rkkGhT5kwZnaTxJosnK6vgmmH1ZEjyZQlpQwd8QxZN457EIMtYf+jUnxvxz2H8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8y/Y/tk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso1158017a12.3;
        Thu, 12 Jun 2025 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749712968; x=1750317768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHuN/5udPgMHegAvrgKv02bOqJOz+gFjUiMoKyXmaRI=;
        b=b8y/Y/tk4JF3G7uDxUvX0V/U4p/omJCcC4WdBW39KnNHBoTTNzENOqSYWWg64C7Vm7
         w+e5/7dDHIDH5tCalzwtNQrEq0hg8HvnHnTVR09ELzM3x+WVY5ZPwDm3KCvc6taklfTK
         EaKjWKHgu29Zo22QtR8/nIWtZvzxaAdd/5nI5q6X1HMPFB86Z9gQMknaSuwnu0cVPG+U
         xk3hlkHKYoeWtlorseL5RUR+Sxk7rft0G+f82gXjFNiyUnliBQQ89xQ5anq1GF0KEANg
         pqr18QSX/1aN72MYYbiyM6wBBNYIKjA2bpus30Nh2Yiesr6LKMjpytj+ljlJ+s1O3mLj
         TECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712968; x=1750317768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHuN/5udPgMHegAvrgKv02bOqJOz+gFjUiMoKyXmaRI=;
        b=SzynSTqX1+eCiPon8tetSPjx+F/ec9u/UkkgFqbbv8aIAO1bgmBU9uuXhvq3R4Srgu
         CSz4/hRX8vlYeapgyQKVvIJumbUpZ27lhHwoKdEHQaEVdGwNjQkWr8BaLSnmyEbUnj91
         JkbOklwm2QvuMwoED6eznFcVUbWJEY/3678SJsbDokYYCmXH+ySkFy85462UYSB13x+S
         x9LBjWg/gvhkW7RgAwxM+BkwgkuFL3pw1KoX3kXkaP5HsQwcsBb1ah95sX7NKczkw32m
         yPWXresxXpC6wJkBgMGBPnpnVq7b/CYQA2bIH/ZCLzf9Ig5+1Uw1yY5YFo+VbUSpXDhR
         hSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQrAl0MBchu1QahSNi0g3Eprpme4MrHJbtOpRm3t/87K2QrYZr6mkHgwMJl0ZCstuBE7kJeIQuIM6A1SxQ@vger.kernel.org, AJvYcCVwPPy6e7dLIuCul57YAG7O87PFp1BwRZHL7gmSOyCFNpMiibqixdAiG58SEG5XZ4mi5ZpBnmXmVhf8//JuLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2DzGavCCsTmqd/nGPudeoj94hgPYXa2OKhLftKQ837Ab/2dT
	gAjBVMYGZnAn2JsSciOU86BxmMdlS2ixO6XMtUPe7D7Gkr53eeJE3IgrZC1nktVr
X-Gm-Gg: ASbGncss0Q2e+WEz0CqyEdTPRFwfHpMx/catuARHMRt/yJV+h8nPdwq9/3Vw+2O7A1+
	B+t/CZHxnfM89+pQBSQH+5mrCxyhUG+Q1zdJIjqXCVo6bOwIQ1LCuH30yjQIitPEgNNj8xx00Ey
	8f4KtGnDGluvvniTXPjTQUw9gNZzu+HFf5mGl+L6wgfmo2j+cBe0Ulv5Gule92NGUF8+G+of2LA
	9wKFPPL55eRZSUya1+7X0LSWfFPhIYv+1Y/DP2ohtQ6QMsgtdMVeX+FO97E2onZhKIL86n+Yj4A
	QWFlsVuY0qY5Xnrfgsfmysr3B4LIOA4GbZWOhQvsv39GEXqiHDt1E9Vp4jdqWUWR9Nai9a3Yiuh
	UlX/QFmybs6qyDzJEmSlugokvmEAFLcpK2JK23725Oh54vCO3w57Yk0VcSto=
X-Google-Smtp-Source: AGHT+IE8eJXavTx5SUDo2+tMHq6vWd3Ca0V3HXMWEJoRFoRv2ARZSR61exxtd0msxAlXcqeTf6qopA==
X-Received: by 2002:a05:6402:1d4b:b0:5ff:f72e:f494 with SMTP id 4fb4d7f45d1cf-60863b093d4mr2236083a12.31.1749712968083;
        Thu, 12 Jun 2025 00:22:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086b1e456csm737334a12.47.2025.06.12.00.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:22:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Neil Brown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: fix debug print in case of mkdir error
Date: Thu, 12 Jun 2025 09:22:45 +0200
Message-Id: <20250612072245.2825938-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to print the name in case of mkdir failure and now we will
get a cryptic (efault) as name.

Fixes: c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Another candidate for vfs.fixes from fallout of vfs API changes.

I noticed it by chance when reviewing Neil's new vfs_mkdir() patch.

TBH, I don't even remember seeing the v6.15 patch during review.
the patch review timestamp suggest I might have been on vacation
at the time and then must have gotten burried in my mailbox.

That is the second ovl regression that got in due to vfs API changes
that has no record on list of being reviewed by ovl developers.

I think we need to be a bit more careful in the progress of Neil's
work that the ovl parts are better reviewed and tested.

Neil, if you need help setting up fstests overlayfs testing
let me know (or read fstests README.overlay).

Thanks,
Amir.

 fs/overlayfs/overlayfs.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8baaba0a3fe5..497323128e5f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -246,9 +246,11 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
 					  struct dentry *dentry,
 					  umode_t mode)
 {
-	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
-	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
-	return dentry;
+	struct dentry *ret;
+
+	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
+	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
+	return ret;
 }
 
 static inline int ovl_do_mknod(struct ovl_fs *ofs,
-- 
2.34.1


