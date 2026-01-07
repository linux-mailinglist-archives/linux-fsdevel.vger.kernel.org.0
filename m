Return-Path: <linux-fsdevel+bounces-72674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64CCFFAD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE57C3005F34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920F359F89;
	Wed,  7 Jan 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxzF2TBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D6332EBB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806613; cv=none; b=cYtvNK0M2LJ64uKt0qBd85KAtaxunD0rByVFJchw0vmjmY/sQ3xyiBudP004X4DkRVNwYBgqV+nQvL4BldgZYVQQNXtV3sIIWAEby8NCcgE2wgNMVRPPZN/HeL2RhP2TO7rH30/pmc1OqcN/QnmedyEIA+kQ0dUCLXbrB14YVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806613; c=relaxed/simple;
	bh=JZb4un39BlPP+OGm49xPg22uNlLarYMy/HsntlA1Vg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ladkQ4jLl4VgbkQQpgS9NRC7/96xaAaWAtie35tLkdkBONVDZb/meT5QM5EN/FvUBzaMSgHhpFV1e4IYi4NoiNvETfxwsXbrWqIB5zU0b8McMEcD1WM3eq9Bh2EBHROAq1I2M3OZ9REEvWYPCPM0zCX/xef36hnGYsSDBWJCO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxzF2TBH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso18499475ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806600; x=1768411400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txgoLEmMjHER+EBzHDKZOrkZdUQtWotXYsSwAupxNQg=;
        b=TxzF2TBHcneh9xVzUNi49/rHLKmx7Plb4ofTgjqhjsJEIO2FvQh3i4iZMDvHal+L0w
         beGQBA8ESepSKXRme5RllHzAmHp6xOvuiHaoVW0U6kIE/FqdJjJ/meZIPpQV8NBRUtsy
         dnuCy/Epf2TlgSAQ0xDuF2kKRlQQ0GABsslcNOoDG2jgLcotyzv0MCLehFpjb5MRW68u
         fA448uFrsbZtuXBg9+g8zTidjkuxsEvqQiz07YoZ0w4e9bCg7BAf7m6GaN4zLH+PvNcA
         0F3ELJ87FS3u67XFJo4JH0dgIWC/e5pmu3x587x7am4DmQ2mzn4Nktr5FI95nlI8Uk6A
         xWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806600; x=1768411400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txgoLEmMjHER+EBzHDKZOrkZdUQtWotXYsSwAupxNQg=;
        b=XtafKGg4ULC4HJk0+zi9tk4HUd4v2hoyMjntMruSM/6CqDTsKin/ByZ1IuAgRb3RC9
         Sz2/jvrh/8Bq3x44868Vg+MfDYbVswVpTJDj1gFmvDebr+eGFdZ3kIe08yVbbsFslijc
         6+yUPKmqlqS+yRkPn0Vdq7Gwq2ysHrnyZAuBjrM3u6VpLiJRBpXOIzBdxm2BM2mPHmdk
         1FhPwtCVZ+mqKt2HyyRl+EAso79T0nS+mX+fW+h8dX8aXYCIMI5vawh2wUq4WjSxk9Lu
         9Onquq3f1osCkqs0ugL8pXAuMN5hv0zkCMz66C/5qVaq3Cs21PMozjmmSqPuSY/Dq9I2
         WpEw==
X-Forwarded-Encrypted: i=1; AJvYcCX2zmWJod4TyZMUPIKnzQc1hp0KycA1FXU49W+oN7S63iStlIBR2lkUwLMKkRBf7eunTgKR+oFQ9CTW4PgB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zXu9484PI83vlrjpA9hyvTyaThcrPDWkibH/2xFUw5i1BCdE
	cdE/yEX5oclIEGwSqk/WlWBHNK+nyOmeBqHUoqLl8rZR9g0LTM5Veo+DPwQG8A==
X-Gm-Gg: AY/fxX6d+70CgqKHglWIyZNxsg+QczU1TclYwas5mUlxISlbCIMuLmZPW0JNPmQm3sU
	IeiA7HsM+S/2AMEwWRJyM8/WopaEEMRQbYEA4uszvppjO+PZIiNy/xtXuMh1ritSIsEBMxAnLar
	0mqSlmoC3/8djQOVGuzw6WRy5glUa9whmi8IyV0biUrAO5sxVIOuWx1FyoqM38JFBXRQPUuqYKq
	6zw8i//v3a8EvGS7KPawXOjpJe99N8JBMJix3L6V+JArAz81yvuS3X3iTFXM3iITySr3VkgmmmO
	k7RYY5elac7v/OSGLVifjyTI8Qm310GlrMEdevGfLpNkK93f+Hh7cqJxDm9yZS0f8dfSviPzFVF
	C1tq2NEOREqQMsW87LuOgG+tU+fpavhDE80GHeOrZz5PsoccrBn5nFe1UTC51VxkhyPaxNjtHMD
	cJWXV7+NWb6KF32Jj39+uWrFxE3wtOkolw0xug7erEVKgw
X-Google-Smtp-Source: AGHT+IFI7aw5Hflr3Zesdi0nYazb40KN8jZ7mrRBERbvb07PBqlelReQ+seRv6/V7wYnwshvoEme0w==
X-Received: by 2002:a05:6808:144e:b0:450:b14:7a6a with SMTP id 5614622812f47-45a6bef2392mr1217539b6e.60.1767800088459;
        Wed, 07 Jan 2026 07:34:48 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:48 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 0/4] libfuse: add basic famfs support to libfuse
Date: Wed,  7 Jan 2026 09:34:39 -0600
Message-ID: <20260107153443.64794-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153244.64703-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (4):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add API to set kernel mount options
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 47 ++++++++++++++++++++
 lib/fuse_i.h            |  1 +
 lib/fuse_lowlevel.c     | 36 ++++++++++++++-
 lib/fuse_versionscript  |  1 +
 lib/mount.c             |  8 ++++
 7 files changed, 194 insertions(+), 2 deletions(-)


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.49.0


