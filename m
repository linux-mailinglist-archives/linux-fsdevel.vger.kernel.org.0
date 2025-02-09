Return-Path: <linux-fsdevel+bounces-41333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC31A2E012
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388851884A10
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854941E3769;
	Sun,  9 Feb 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOxhzWuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578821E2613;
	Sun,  9 Feb 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127341; cv=none; b=CSDheAggnp1zc0uz1uPpdA3W8ekb4hHdhajmMG6n4CiaYrDblNr/3aMYsKPggoPSZOebx01Ga9HhPrY6ciQtkCJL7uKVl2EWr/N7PCSY/hTBlh/gwS08RnCIAxU8AQBV0i71XWyhmtb/uiq9xZZb6xHNkpUDbiqqzkWF/QeOVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127341; c=relaxed/simple;
	bh=4bGNyjfePr6cLfEicYz5bD4g9j8T0BUJf9j7LFKGCEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaziV5qq9tXevrUN2w+fmnhiq/XX2RcmbSCenNDCytEiejJHiBmO4Lr1NqJ/xc/sfiRs6vDmnJO8uwr6LywL+7r3ZKKRJ09m9Z24x1gGR0R03DjtFvhtI2Lg8bJMr+Mpfw2Yy2AR/GeuZxfUnO6AVFDMPO++x2NL2Ql4qkKUpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOxhzWuy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeec07b705so593166066b.2;
        Sun, 09 Feb 2025 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739127337; x=1739732137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=NOxhzWuypVX2Stc72ezRgeknKF1iPxeQGX+FvW6+0cefpQ/sbQNrslLBV+BeYK3UWq
         hKngVAbuEFbHhDINwYo58s8vxIo+MsLIahdkSndIDqQTAbyqUakuIjG8WKObYn7pg16l
         6uQ8J7xBgWtQ52On9imskCd7dLKZmc/gl3AmvQVBYXM4ZM4sEj35XPSLwMycQOjCwf5j
         080PdhvXCMZxqIXDJ/YeZR3RWHe2qJbfHqmwItxOAkQU5YK/9Bz1gpsV77lAQJgFe1OS
         XclsMHBi0u5bKEo5mOMNY21KedsVnWJVObw4+WF6GLhObwzzd+nSafUOCxjKoK+aaFXT
         kCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739127337; x=1739732137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=lHZj5hR0ISltrNzvXe4uJsmlEJavfDBEC8puC1tg6EuMFQDZi5n7JZjzNvf5MQd3Em
         1uOc16pZDzHiidLCWB3r0lCdMypu1QKxp9O4DIpKvwRxpfWxU5TPX/n/H6LQdtQg6kYd
         //c51gWD72mck82Pq5Q14Os2iqbtKbYrwNtmq5yrsRT/T4w/rGSh5NIxiIHrJUUdIbq8
         R/NwA0jUGkAuB40iJPR0xbuVQUuDLqSTSs1TmYqCzHgzEOW3hVGv4cKeqpRXR4bcj8Bl
         1N7DCp8qgszg7Brtkh8mDeznitTjJyB03GqaXqBdpNeYYFl2LABY3Dz1ztCUdiOJ0hjJ
         Q+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+3ACWCXRiTuq7Tp4tgK9aX6gWch+3MtkdaEfp///+bbqHhfkt6l5D6hjt6wqj+bPOW9bvzgKU7Hi4FPE@vger.kernel.org, AJvYcCVrFkbJSeIRC8FlfbySeYN3Oufe6oqRhjHVVYY04t4rIqTpfhee8YQwcknF3hRNVcs2145DcIeOT44FiCSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YypbRRc1URTlli1Muu91y7WtdejuRP+tyRITMlW/UT9wsoDBhry
	I84scplpWeG+9Q3ybk2MGyAJ3PhEYNOF3uaFAmifaEhfX/DJkVP3bjWCiw==
X-Gm-Gg: ASbGncsORPnMAPxor1BBf9ym0p9SSIuK12bM8oJhh9PGdkGRUSvXildLs1fbsOpkWKV
	LIhs7s/oNEwYctu1uhIADDwt4YMIkbQWIVRYUxPeQmZ+Hy9EYwgGPigAPeA+rPNtzkyZp1O3HsR
	9xH3yvJmtaOeCyCfw2VcD0Qy9Frnumjc1DzyIaGqJl2VvPQqg9EfR1ndBJjo0JCYNm/0SnY6sm6
	h93GXWW2u8c/NEpqV0Bln2ZCcE3CmwNfgbhhmbKzO+CWCy/MUggStOsRZXRa+OU04XBqS9B6Zyd
	zCMxAt5fmlhv3TyJ8K+KnH1IKxGGZSyOxQ==
X-Google-Smtp-Source: AGHT+IFuROLubKDuUUgKlNZuHaYwDlsVRWyvDEWASNekr0cwZyx/WMFCIELIUUionRX1mduBCK/msg==
X-Received: by 2002:a17:907:3f27:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab789aef91amr1175828966b.34.1739127337332;
        Sun, 09 Feb 2025 10:55:37 -0800 (PST)
Received: from f.. (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a82dba37sm318478566b.165.2025.02.09.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:55:36 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 2/3] vfs: catch invalid modes in may_open()
Date: Sun,  9 Feb 2025 19:55:21 +0100
Message-ID: <20250209185523.745956-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209185523.745956-1-mjguzik@gmail.com>
References: <20250209185523.745956-1-mjguzik@gmail.com>
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


