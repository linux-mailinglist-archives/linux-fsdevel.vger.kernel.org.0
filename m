Return-Path: <linux-fsdevel+bounces-13544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED27870A6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D100F1C20E9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164097D413;
	Mon,  4 Mar 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLSKjNmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD97D3FE
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579558; cv=none; b=GL4Kb01r8Xfz8dQBVOnka//3IfYfHfpjy2Vz+tLv2K1HzYbP1Lkfi/e8XwQ+d92LDuTn+KaP8M9vJdKUtDdMR5D6k1ae6wSloRINgYis7Z+qivXUDaXCBQw1r/DPupvhkF7kHuYASc+6f5tI/dQU0Z+gRajQgfQlvKu5Pgv5Sys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579558; c=relaxed/simple;
	bh=INc7MitHePby7vAUkDxfEehRxdrWRG6wEUUVyYbtgRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeKYmVXavyLbbifdyjSNy3+qfVdCT8DyXEi2u3b79uS0sOCc8noIhExbIkatcFuHZwcAv5bVRs5zynyamDKBCkdspomSeFnUmUJRGXGhaUJJ8du0JexUqC26Ku95pDo9fpVqOPubuY/JxdCzqA9qHPpVTSfx4oFo2+wbH6JqOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLSKjNmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXZxugOLeL3RCRxiry5bYRXbpoWIDFypQghiFAJrD4=;
	b=bLSKjNmoPLMOV9xS4IHPj0jQkNGIzNHWcJwNarDhzfBItpIH7FEJDAhwoY9wwaMrIMkvVB
	mkqFrCT8vC3unhAYoHOZcIUJOsbpMnNUZMNxxLAoveCoPlGZe9LYRCrv3nXoWz71F8K8bV
	XRrxHKdRBtC8ONJl5Lql6c0MH/Xr8eI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-uZt9KSJUN7iC9MUl7K92UQ-1; Mon, 04 Mar 2024 14:12:34 -0500
X-MC-Unique: uZt9KSJUN7iC9MUl7K92UQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513340d10ccso2299015e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579553; x=1710184353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdXZxugOLeL3RCRxiry5bYRXbpoWIDFypQghiFAJrD4=;
        b=n0e7ov/CoMiLWAr6WF9rCtS3yUHyHxs0n0yIeoceiz1uI8Mc/SATyCyCK+ZJixvqmo
         BlT+m4Gk3iP97qyq7BqxT6NJwTpvXVow5BEgbnNYjIAEg/448X1VTxpCgZEe/kEModZ+
         ojMKAaIIqErezKFnO6ku4Uqg7XPy8aoG2tSR6/lBDWq5agfixmvSVOkJlDX9/ZaouxcQ
         wtZ5oDBtwP+753l+Bc8QuK5rqp614PzKkLB/OLg+bkGGFjgrvPYXwbFw2zDl/pPt66Mq
         nR5JRKP2PlE6Bp9hJ9G3kLpVclFuabm36DXvIBPkab1BBFlM3O3r/JdSAwjSCfroq/Vj
         uxiA==
X-Forwarded-Encrypted: i=1; AJvYcCWI5f77mrfxkQwrrhRCIiDe7H13w7Dgv+6f6iYP1unNNkFFEBQkt2KfYuOTLmODbaCg0pJjk+6E1wuhiTWShmpQdcDdaI+vfFKk1ysD1w==
X-Gm-Message-State: AOJu0YypBD/ziwlHRVY7C97Zqy44nnQWY1xsiNu4FehBASnV5HPejckH
	rc83TXMWVoiMeOvW9SsEfXaQ9bWlyrJN365Fn2rktfiYLKHVrN689a+NrSJvOVwECJVNCEZ1dq4
	l2g+RomR0YSmq5By/RXiNFqfOnoBwNAI06fhdlLD++Ry6XD2/TpXtGT5OIG4zoQ==
X-Received: by 2002:ac2:42d7:0:b0:513:49fd:c63a with SMTP id n23-20020ac242d7000000b0051349fdc63amr1699739lfl.56.1709579552850;
        Mon, 04 Mar 2024 11:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETsl9dsoS2dwS0BLYcGhPQprHJfq00rS2fw55aSA7GEdV3c2F87uy+0BYF6vYReQxkQ1fYiA==
X-Received: by 2002:ac2:42d7:0:b0:513:49fd:c63a with SMTP id n23-20020ac242d7000000b0051349fdc63amr1699729lfl.56.1709579552630;
        Mon, 04 Mar 2024 11:12:32 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:31 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 23/24] xfs: add fs-verity ioctls
Date: Mon,  4 Mar 2024 20:10:46 +0100
Message-ID: <20240304191046.157464-25-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ab61d7d552fb..4763d20c05ff 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -43,6 +43,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2174,6 +2175,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.42.0


