Return-Path: <linux-fsdevel+bounces-41290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25979A2D74E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DA73A4E88
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA081F1806;
	Sat,  8 Feb 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxUmRQ15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493971F30CD;
	Sat,  8 Feb 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031988; cv=none; b=hoRcNCb6Das3itswJxJjMrMf9kSwGeINwWZmiCCN3CvT6nv7ORUZwKeAKd6zpPOTvm4IDw4DfFF5iGQrtE0tLaCofolCTcgbd/Z4ErYniqi+qXRyp0Lc+ugpoi7u/oTMiqsH6Qjy1cfwF4XvXx1PH3GOU7W9VtZslE0yeAg7f1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031988; c=relaxed/simple;
	bh=4bGNyjfePr6cLfEicYz5bD4g9j8T0BUJf9j7LFKGCEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+L+UOeSNOtn4L0Ib07UHWajRPWjN5Uwgc/1l8XFPrEUqGuedPN+T99mJKRVGbiTmFFE4tHkUSo2zS5D2/cWxBxUNhubMBvHOdhZFPsi1q0zM5D1g7ib6u5dSwMZa6+7C6koqZWbDQIQpH22Vb1LdJuC0kq4XVZv6L2hcxV3jME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxUmRQ15; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7800d3939so425451566b.2;
        Sat, 08 Feb 2025 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739031986; x=1739636786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=kxUmRQ15evLcPhmSOLE5na0FnYUl3gl564sZBhnqLXwE9NVhl6leKCReTrqHOQx74f
         brwe/846O6jZvMNAP9PHDEAxFnhZD/LfxrY2bL/h8PCHYzV8QhEK3edt/h7p+NbxMvXL
         YEqOT3oML319QyCR82G4ybYSFrF5FaJe5mcgZSSAfCUCbFSOHhtuhT1nT5uQMd66akjS
         5IXxpC22GpArGo60OSst7qD/boWLBWrq1Dq/0VbdLPWPMuWcRtbQ2avurLTB35KtNJAb
         hdrXSAtNkfIyLRnuCWo/EdeLIQCxs5xQFf5x/rl8KuXocW98QZ0zYtIQdN0AfGmyXn7T
         75Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739031986; x=1739636786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=bK8URX2DB00bSlGdVtBPLzGaNljUfiQsgLe7SOQrbOoGf/u76SiVIKBtzgr1/DjyXc
         kaJSEyWa/MmOMRReTl5D2hDiRuWCcItl3aHZS9w81uQB3MlFXOtKZiRKS6WBCvMbQ4zM
         dPDfv3WB9h6+diC2En86pR1pY+7aVMRNT61MzFHlnib34SyTtnmgaSpHV2yi6csvKS+8
         NbJVeVE/3Tei1NqHdypRWPqfnvF3d8Tq+FpT1TKYF1iVSortL8zHzz2P0MIKyHhCJ8as
         NEf/cevc9IFhYWxxeUSfYwxQ1h09yO/iqpBhqpOHj30xt/+ySjGSIKo+tuc0GA1a7hxH
         Xk6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/y0q/qKS/lDVqZzcgPOhtD2IGID1jYnT1wd1Stn044k7MIJHGRgfMlE8HkizUin+c60MQGTxkAeqGvZkj@vger.kernel.org, AJvYcCVJqHiF1y2LGBqy/glqDG4vWNREjhDtHFBT4KstKMgfnxQ/YEJwAy3ncF0zgymXyhj/fyqX/EitrBfakGuw@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGiNIkRhrjZY03mg5SEYUd/keuDYlTWRGLgWApScTu/tMomAI
	UpkLkqRM/XTKMKXAyx0OdlgOVwfSc0uyYAdZuwApZDgUxHZWMTo4
X-Gm-Gg: ASbGncvekBSfDdqwLqagGFydYko5KD2mA1EsWZ5mv6PUgH4C0ZdrZhW2yy/1W0MVeje
	PAztW78XfStV0O4d7Gn9b26LkESdbBEkhnDvXsdcguhTYuk+CgIqzFihAqFybjRp19B7MOQVPXE
	VBFlrJWm5Pb2/wB4qxx/xT/AZejbAam9riHPVZvH8dEqFklFizEZwteg6AhLAqCSWFT1CCQSs1b
	iywm11B18dxNRRKjGJ6ULYPuiqGlA/71KqRIkP3eLvq1qN9OFNSMOrPQuI1J2Fq1AwfmdvIhZVu
	9mUnU8hCo/3kKCygfiSBwZC8I4vSmVEpqA==
X-Google-Smtp-Source: AGHT+IH9YUAdLW0S/0pQV+X1l7/PpTLLvPYx8hqknsR52w1vNN7fpqViucvYL2zjbCwZzCG4CV0yqQ==
X-Received: by 2002:a17:907:7e97:b0:ab6:de3a:351d with SMTP id a640c23a62f3a-ab789a9eb33mr828172266b.12.1739031985501;
        Sat, 08 Feb 2025 08:26:25 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de47d6461asm3193943a12.74.2025.02.08.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:26:24 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/3] vfs: catch invalid modes in may_open()
Date: Sat,  8 Feb 2025 17:26:10 +0100
Message-ID: <20250208162611.628145-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208162611.628145-1-mjguzik@gmail.com>
References: <20250208162611.628145-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..21630a0f8e30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3415,6 +3415,8 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		if ((acc_mode & MAY_EXEC) && path_noexec(path))
 			return -EACCES;
 		break;
+	default:
+		VFS_BUG_ON_INODE(1, inode);
 	}
 
 	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
-- 
2.43.0


