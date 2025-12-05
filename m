Return-Path: <linux-fsdevel+bounces-70744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C2CA5C47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0747731712A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909D1C84A0;
	Fri,  5 Dec 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDzyQ5J0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C171EFFB4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896327; cv=none; b=W/44bzKsg7PKawQKV37P8Wi33RYipKs0EsMANBxgeAI+qCOUMcRevKOug7Zn9lTRi78/4jT+0WQpS4H2gqWIcRyQtKmmY0CchtvDb9ZJFqEi5ry1FTookctpGVcZ6cL6ewwPBYLfzivx1Ut9cYLbE+mYHNO6FJFwBjKUz5ilJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896327; c=relaxed/simple;
	bh=CIVMhsmo/TLmEOyl5Xrhk9a4+n50fRfvlX0rCbVLbJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jJQqNeq7sh/MQzWnQhT8gzaEJIPuQR7kOb3HNX5TJTCAi/EIXRLsj9tJmSYedIvLldJ33sYsCd4+eiD9CUoAhb4cfqIyyFfwP0jUEFvYVCexBYD9OKV8jmZkek3mznUD0TN3RVcI5ueQUW0uhwsbDMETHIZJShr3/FfHlXCYO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDzyQ5J0; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6574d564a9eso1906404eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764896325; x=1765501125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OkIFDglYe+NNTa2m54quJMQQhad7qn1qBiLg81dFGHA=;
        b=cDzyQ5J0U4qOPMkcoGx0c1R+qunsQRIyLAeqgBgcR2kk9LLmtoaribCYz9cp3x3XDy
         7EMlB0jLhu9zUb6pwexYrjnBqA+8yccAcRKB4GPUjtiPNGSrdDqwMlwUd7+FZiTqqEn0
         67h/1w2b8b2Nwe5F6Z3SdG44E4whXdJuiVPnTsarKG2TH/3g2LDiC59sWnbjmzPcnQia
         2VKQVi3INO5sWYBfcTRVhTfcRHGCBdXXsBy+e0eUNMsxHm1nfaLrZcopy9tpW4Luk5ah
         hKJk6P6KAAWOY4KwEB0M25/xbDJMGYDVSNFrxTi0njkPEehlN3ClwrY1rG9wFWqi8cNk
         EEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896325; x=1765501125;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkIFDglYe+NNTa2m54quJMQQhad7qn1qBiLg81dFGHA=;
        b=IqXyG10TTHWMz8Y+k8RiNHOQa0wVZ+Or80Vl81TSHHoLno62a4oE+G+Ggz/+iugnDk
         2Kt6gdR8ZgCFmNpvd3fHRgUEQqUKx5otFwwNa3mJghxG2Rgl6GPPvkbKJK6EzzxOUIzU
         d2Rg9HfzrgsC8aTXO+NMvW3KRqfMtTKy6EoLAVBhtiyFcFy6RIdnPnXRCbBap8n1rLJE
         Pl3z4fKGV11k/S8WZfXhKwfYcc2Y26gczcsiCPTd5X6XsshE/oeV9WSxrE+ZKu5lu4YU
         i7sO++aIUhcuV9CvvftqG6/oxLi3rs/WIf0aLPQuJYbZXTOrZjgr3FtKA5lxZSFpdfbX
         j37A==
X-Forwarded-Encrypted: i=1; AJvYcCVmWJlpqbxRLkyDIxKQdriIlCnVRcJc09kW/kapA91lh5zKlif+vuobjhTZQ+ecIYq/P6MZ3gY7MHzqtBbz@vger.kernel.org
X-Gm-Message-State: AOJu0YxDt+ECX/IplnLXV/3QV1ec+FTvyECubSSBlpRB5+/4MusDIs5x
	tSGwLyKp9X6e4zxPUQdG6rpt6pz7uefKsqJ7nuU3kQuG5iXNKMNh9CdPNu1O++zGkb8inIDM8ny
	piQjW8A==
X-Google-Smtp-Source: AGHT+IHj0LPEa/ejQQf0MUYWeJwJfYADQwqU4BCYqxCRyoUpapAb59gw8xQzZvkTJOVDLbICm1TVHGWi4NY=
X-Received: from ioby11.prod.google.com ([2002:a6b:d80b:0:b0:949:806:8e17])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2383:b0:44d:aa8b:58f6
 with SMTP id 5614622812f47-45379d21b91mr2858055b6e.1.1764896324986; Thu, 04
 Dec 2025 16:58:44 -0800 (PST)
Date: Fri,  5 Dec 2025 00:58:28 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205005841.3942668-1-avagin@google.com>
Subject: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch series introduces a mechanism to mask hardware capabilities
(AT_HWCAP) reported to user-space processes via the misc cgroup
controller.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster. This patchset allows users to
configure a mask for AT_HWCAP, AT_HWCAP2. This ensures that applications
within a container only detect and use features guaranteed to be
available on all potential target hosts.

The first patch adds the mask interface to the misc cgroup controller,
allowing users to set masks for AT_HWCAP, AT_HWCAP2...

The second patch adds a selftest to verify the functionality of the new
interface, ensuring masks are applied and inherited correctly.

The third patch updates the documentation.

Cc: Kees Cook <kees@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>

Andrei Vagin (3):
  cgroup, binfmt_elf: Add hwcap masks to the misc controller
  selftests/cgroup: Add a test for the misc.mask cgroup interface
  Documentation: cgroup-v2: Document misc.mask interface

 Documentation/admin-guide/cgroup-v2.rst    |  25 ++++
 Documentation/arch/arm64/elf_hwcaps.rst    |  21 ++++
 fs/binfmt_elf.c                            |  24 +++-
 include/linux/misc_cgroup.h                |  25 ++++
 kernel/cgroup/misc.c                       | 126 +++++++++++++++++++++
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/config      |   1 +
 tools/testing/selftests/cgroup/test_misc.c | 114 +++++++++++++++++++
 9 files changed, 335 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_misc.c

