Return-Path: <linux-fsdevel+bounces-63281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA4BB3F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36CA84E1FE2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE743112C9;
	Thu,  2 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFW1gj2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A22FF652
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409723; cv=none; b=f0QB7wYcFaQRdq3l/chGZ/SS3JK0X2ghBQEgp/WS32dm0LawX1NJFa0DHfytRtkWVX3Y8OeTQbAM+/N5REqidTtFk55yAt7KslTGps66iZyd/1VBD75V/c+/HjLVSKcEkJJMJ9x6PsZmOp82JpBwP7JCQ318bnzXPjm1wfMdmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409723; c=relaxed/simple;
	bh=yN84qKGbZsWN1bFX7EhQjuckEU2DAlmtOO/CedBfCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vA00g7aN4k5EFy3eOcFi+b0dzu8xPXk8G+AkCCdt/ATFHq+9w2wKS3FsueeIHU5hh2TGKrkEBCe8+H8026VaOeCWhtoqk+zuAyG7b854o7G7blBOdODYziM2bsfSfNzEow5IqNXTRcVhJw6tOJf9BjHV8gUkKp/yPDT8wqEEQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFW1gj2S; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781206cce18so907333b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409721; x=1760014521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wr9/ShQDFGHOa6bX/AYuqfV+eOi5oty1cVkVheB6GYw=;
        b=TFW1gj2SdP+mF/UMsUAcIJocbpBpDPkA9c2QPB6MDAmRl2SbMTdRHr3exGon7P8tOc
         174s5PJE2rN1qoI8ogotulIrefC7JAA3L294NY7VmKpJaLn2YUm+hk4oqKGNR0sKSk37
         bZRZYjU7/LuK5QKRheBIFVp1F2R5CvPpM5kCB31mDfksmWyB5eRRR39h+RLRrEo06urY
         Cy9gjUtVEbhqvEmMt6ZNVk3IN+1muzFkmW5EOS1F8UKiN6e3eHe33yq5TTZXIGAl8wWA
         dIcCvDfkQQIUWsBNw2aLjDhiXh2JP0VJ5Chmi1W2c2A3mW/pOi1wOPsiAmbkveBIGi+K
         UP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409721; x=1760014521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr9/ShQDFGHOa6bX/AYuqfV+eOi5oty1cVkVheB6GYw=;
        b=KRO2y989fLYjcBYuFZaqqfcB/PyvLeNy5ONGxXIEUbwAanosTOrgxXR39Dpry+EKNN
         feq9Vf0X/oU9mUTPFLHO6SxMIym8tkUq/JT38DCPhHnzm9xVKiaUYLWMABptpfvuHGIh
         VDTT2yG3VxUzTRQm5ok6AYfF077trWIUwoCSN1lk8CSR8WpCePqanWrfLyCySGd8v3YA
         aWHnW8fdcmEJA3x2qPytvS8koJMpGI9nXMYTaUKP/ELkvEnU0hxf3OVTV6CSB05PXBO3
         5LVv+lXdH6LhLT4UOoy95PydbW3qDIFUbspx9DlVDHfXwBM6EvthGsJEqlah8AXqbjod
         2Mqg==
X-Gm-Message-State: AOJu0Yzq2t3ssGMGx9h9huhWAmda72uuv1/wFfqNu65CcxvXqCDma7zt
	Z089eeFtPh90cazq/+9fSTiImziZXf1hFffff6IGmDSDCpAWRh8sN1f1
X-Gm-Gg: ASbGnctNheZkbOmvk4BfR5UoAVXPDozgy2tQE7Bs8oWjZA8L0T5MKMz4//WXB/r4wvX
	Npq87ZBxxZbcbliGiJSvSIzikd2KRXq8eNYF2O4I9pn1trodkkEkf35BFmtu/ELzqZ9zs/Zo5nO
	GFXKOtyGnvokN+vFjzT7Y+Pgv51TSn2GA395lyKsn7/tGi57khhNr3Wma/eTiK7YKrp6NXaoCG+
	UO8bRzLWLB6E69FGKyEJOvechAbafofhl1Gfj5ZCOWUP9/xDbaDlYFPnngLA0NXwK1AE9Lo5wga
	Y3os/Dfl32fnsAy9rcqYfRIVgF7ORxDwZYdXRDlJiwEw0tC+u2Vgbmg5A3RqiV8pM5qWmwwi5tZ
	406KdF9M5XEDZ4YOZCfHqiWcnp1tT/2RAToskon0PCGF563U=
X-Google-Smtp-Source: AGHT+IHoza2pEWGLfeGUjFWLs0SPjFJeH1/3tLfeD4XMsTN6Z66G0e+jglYaN8kKBUo+/721fB2SNw==
X-Received: by 2002:aa7:9dc2:0:b0:77f:9ab:f5 with SMTP id d2e1a72fcca58-78b024ab0acmr2478427b3a.14.1759409720898;
        Thu, 02 Oct 2025 05:55:20 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:55:20 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 0/4] export mount info for "unmounted" mounts
Date: Thu,  2 Oct 2025 18:18:36 +0530
Message-ID: <20251002125422.203598-1-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By "unmounted" mounts we mean mounts that have been unmounted using
umount2(mnt, MNT_DETACH) but we still have file descriptors to files on
that mount. We want to add the ability to handle such mounts in CRIU
(Checkpoint/Restore in Userspace).

Currently, we have no way to get mount info for these mounts as they do
not appear in /proc/<pid>/mountinfo and statmount does not work on them.

We solve this problem by introducing a new umount_mnt_ns for such
mounts. Instead of their namespace being NULL, they get added to this
umount_mnt_ns. This allows us to use statmount on such mounts and export
their mnt_ns_id through statx.

We use this patchset with CRIU to support checkpoint/restore of
"unmounted" mounts in this pull request:
https://github.com/checkpoint-restore/criu/pull/2754.

All these patches are also available in this branch on github:
https://github.com/bsach64/linux/tree/umount-mnt-ns-plus-statx

Bhavik Sachdev (2):
  statmount: allow for "unmounted" mounts
  fs/stat: export mnt_ns_id through statx

Pavel Tikhomirov (2):
  fs/namespace: add umount_mnt_ns mount namespace for unmounted mounts
  fs/namespace: add umounted mounts to umount_mnt_ns

 fs/d_path.c                     |  2 +-
 fs/mount.h                      | 10 +++++-
 fs/namespace.c                  | 62 ++++++++++++++++++++++++++++-----
 fs/stat.c                       | 15 ++++++--
 include/linux/proc_ns.h         |  1 +
 include/linux/stat.h            |  1 +
 include/uapi/linux/nsfs.h       |  1 +
 include/uapi/linux/stat.h       |  4 ++-
 tools/include/uapi/linux/stat.h |  4 ++-
 9 files changed, 85 insertions(+), 15 deletions(-)

-- 
2.51.0


