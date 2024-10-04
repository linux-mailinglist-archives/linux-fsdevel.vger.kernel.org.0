Return-Path: <linux-fsdevel+bounces-30954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573229900E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833C91C20FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8629F15535B;
	Fri,  4 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkkzIa3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E8145B11;
	Fri,  4 Oct 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037430; cv=none; b=PK+O3xFhbCydUOQrXLANrI51HeP4mn/EqIP3NG6eixiJoH/n/OuZ32Chj+xVG99VLVZWORa7QTNqbXlYyLXf1vNRE40teBYnIhbL/0w2i8AK9By24V5bD6Lo6DlxwHI3zrxzXPODl4vEHzg8PMts9j4UGh0DRTBHQAi2Uxmxrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037430; c=relaxed/simple;
	bh=dAKMQF3GLbDRcSOJBLzM221/McMuN7XRRYNmN6tcocE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yh5dSHireUWkoFufh0d9eck5f+obtI7cNiXReL7L+vW+S7tZIsa3+R0CgdUeG2uwUz6ErYV9Wrlj2yE/mFOFe9huYjMBfCatdAUiRDHnh4H58lwS/x3JAMsY07DrmFLmnpqsaK54cgHH5fZNb/uAfgz3iOvz3M9ik/CW/ZE5Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkkzIa3G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so248762766b.3;
        Fri, 04 Oct 2024 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037426; x=1728642226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSBuv71RODyv9vVGLjJeyrdPq8AWRCs+uwrPQATE1pU=;
        b=hkkzIa3GlQx/0L2MVq0P73FaFme3sFTQSX6XFtwWTatQ0vpaWdDCZE3q/CkvEn9+PN
         OGr18bta7jNcjP8eJupnwdTFxS99TtRm/DVJCQqg57mFx02zpCLwkKflvMu7SwwhDWTF
         3TmGxgT490vxekgi9UWTnk4d+Br16BelyU7fv4XvtXLHJIv2HkbXoh0KMJrMKfBi6I13
         gJQL8ES4pqhqX3yUPb/EO2dQiC/Na2nKuVzEpsSrGneL2vdr8d4MpZed8YNs4CJ21LCT
         Awk/jmxvIPPO9GtXtZXqA2pDpqbgsq0isDBSyvoqxHJD4L2tErJNiJqFzXDvL5gak70r
         8esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037426; x=1728642226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSBuv71RODyv9vVGLjJeyrdPq8AWRCs+uwrPQATE1pU=;
        b=vHMMXiDDFRdlIRAYnBR35nZYBRBPjFf0nUfkI8m+hPKCy19tcGbeVVvMGxM8R/qeYy
         jBB644arHiSo/26SchYloMoBueykaT7ywuT8QLieeLqBIsV5AJ5OcOpZeOc1Nku9ipYg
         UpyyuljFcKawdW3CzkTutCLfqOAmk8mcud5To/HLBHV+AWb3q/xDlQDnEhxEjDQJ4X9d
         C/IeVA2wkJhXBEMu85VHJ6i5zCyyXkp+Sq8bmZLeCETWRbeIbQwhRRsXK/UwfAUTFiwW
         FIsk46AvTeslon6xn+NKLeUf0I7bwZ6dPzA5d+x2HqJJPbHBJ4eHDgPEuHfkDkpwWbYU
         nUsg==
X-Forwarded-Encrypted: i=1; AJvYcCWRq8U9wmzN8ImS3xCo/WNOh/lLSpPpYNqdyndrH7L0RoLNXESdyHzFBRHo7+qg7FCbgJngExg7ZpjauWIT@vger.kernel.org, AJvYcCWSnX6pnXiPoMVXZIOaxBi2Ssew11quv2bWsSw7strXwhpUGg8g+dX+9ySwDcgGGrAe5pebHVLMb+YtX1TIPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcC945INpCM1WdmnZVNKOuOVcdLLLXbk5L4st8yztAK8WijW5r
	FhypubOCUU0Ddlxc0PzW01ZetSpxLWMWLgwJNq0QtCPOoUleo5dFvRaF12EV
X-Google-Smtp-Source: AGHT+IHhRZU3TIi+IS04RTt3fTQIXhR8+ulZH5Ci413dusoCdHTKptGtezB7LLAQip6R142vnK09hw==
X-Received: by 2002:a17:907:3689:b0:a7a:aa35:408c with SMTP id a640c23a62f3a-a991bd137c8mr211914166b.8.1728037426123;
        Fri, 04 Oct 2024 03:23:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a37cdsm207335066b.3.2024.10.04.03.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:23:45 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 0/4] Stash overlay real upper file in backing_file
Date: Fri,  4 Oct 2024 12:23:38 +0200
Message-Id: <20241004102342.179434-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Al Viro posted a proposal to cleanup overlayfs handling of temporary
cloned real file references [1].

This is a proposal in the opposite direction to get rid of the temporary
cloned file references, because they are inefficient and cause for ugly
subtle code.

Al, I think that with these changes, overlayfs no longer has value in
using the proposed fderr struct?

FWIW, struct backing_file has no dedicated memcache pool - before
Christian's diet to struct file, struct backing_file was 248 bytes on x86
and now it is 200 bytes, so the addition of 8 more bytes to strucy
backing_file changes nothing wrt memory usage.

Miklos,

The implementation of ovl_real_file() helper is roughly based on
ovl_real_dir_file().

do you see any problems with this approach or any races not handled?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20241003234534.GM4017910@ZenIV/

Amir Goldstein (4):
  ovl: do not open non-data lower file for fsync
  ovl: stash upper real file in backing_file struct
  ovl: convert ovl_real_fdget_meta() callers to ovl_real_file_meta()
  ovl: convert ovl_real_fdget() callers to ovl_real_file()

 fs/file_table.c     |   7 ++
 fs/internal.h       |   6 ++
 fs/overlayfs/file.c | 230 +++++++++++++++++++++++---------------------
 3 files changed, 133 insertions(+), 110 deletions(-)

-- 
2.34.1


