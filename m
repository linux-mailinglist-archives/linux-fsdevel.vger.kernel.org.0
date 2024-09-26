Return-Path: <linux-fsdevel+bounces-30194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589AD987849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6C1F23339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986815DBB2;
	Thu, 26 Sep 2024 17:29:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD13136337;
	Thu, 26 Sep 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371791; cv=none; b=QrfnR7ZyW1mgtEqyWERGp/BZkm2DIs3Lqxc+cF6EaBFQ2NSRJYRP1ZFUTcG3Jhk9kiEgbSHQ79AzhGLnb1uphXEG1hgzZ3XmiUNgUIdgpZnNhoF5tF+ZtZChXyH4ddt0+eJDu6w3Ej7VdfAE2oLnylhVhQlhH18TTlxyMvKSZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371791; c=relaxed/simple;
	bh=4afPFV6dbcYoMxauCprHFhl/iT5djV7VSu1CLYr4mu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM8zJkkqpwoIlZNvG+2oBIaHEUcl4smA3nHlL0vHLjyG4ryKvJ3Nx/0+SPRdHt20gsmYiQ7ZDjL1+BbsrmDEeOV/C7A5zwa9857+wnNVu7EM5/Ml5S36K4rSTVT+VhEEBeJMelZ4v1kveBhQgdAofZ+wVpc5sWIGl5RoDtv9hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so1297396a12.2;
        Thu, 26 Sep 2024 10:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727371788; x=1727976588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4afPFV6dbcYoMxauCprHFhl/iT5djV7VSu1CLYr4mu4=;
        b=kQ7hOg6UlYyXf49fR+VpnEJGZ1NfcFtUhSE34fww26RqlYVQ9cjisHAdvwhcM+0YtQ
         ZCPdXkbjmPlp/3J0DVuaVmdiOOAgrArLUYKv0JC8U/CX258k2w+JOaZV7YZtIv29UBz2
         qFeMU8hN0AJOUbkQSsh+rTG/1NJocWxL3tj65jIqRtB2WYh7ltLZaAXeONFmeFxED+KV
         7wLXmJPpiafLCgGBeexiOgvLkwAGVUdMdW6x/44DxclKKeBaunbIvRLMPFH5Dl77EJaO
         I7pDQUGNSz5PykbTwdcRZjhu2RBeUch1E7diORbC4rLeNGKZmPpzSMwHX9RFhCN4lvxS
         jMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7cWEFlEd8hsZgPLX5DpOuKYXFzdoQEvcPyAc9ZiodPkRo+wrekfWg0SvGr2WB+U+xgeGqp0no/kmCM7vi@vger.kernel.org, AJvYcCVbryu4tmpQEIYgaqYv1KwUfwa8oYw73D2m2eHfneF4Lkg8ZWuFiN/voICRdq93tKelVEeoYYycMD3dftKOrg==@vger.kernel.org, AJvYcCW+IoOdsVrVXatsVVa2iW4Yxf2oMsKyg/Bk7hPuZpJBs93TyDcSDqIyxaf/Pt+J5bFkuMzX2fBN2XEiM5qGvw==@vger.kernel.org, AJvYcCW27FyPhUuXvLpF6vbylHKA3BYyu7EUChDyVPfZk5JwUSXZE5nShAVOv3xm8XljICdIuT5Br5uiBUvauAMk+ClEc+pKhvep@vger.kernel.org
X-Gm-Message-State: AOJu0YyapNt1aL5+Ax7zNxhKA9DGxyY0gH2CG4vuvRtebV/2JPlnwDdy
	zw4Nm1AqZuNAl5Jz4UPxgS0wDB0gmnSPUNFl8S27ARtNz9bBS5NY
X-Google-Smtp-Source: AGHT+IG0A5dujC3CjHvj9UIpzlSW1clgtQTDw6ZAJgzcvSavTZk1wMdg2ScfHyrsjW3CMML4CP+HRA==
X-Received: by 2002:a05:6402:2552:b0:5c2:609d:397e with SMTP id 4fb4d7f45d1cf-5c8825fe1eemr373033a12.15.1727371788365;
        Thu, 26 Sep 2024 10:29:48 -0700 (PDT)
Received: from localhost.localdomain (109-81-81-255.rct.o2.cz. [109.81.81.255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245eb15sm145336a12.49.2024.09.26.10.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 10:29:47 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v3] remove PF_MEMALLOC_NORECLAIM
Date: Thu, 26 Sep 2024 19:11:49 +0200
Message-ID: <20240926172940.167084-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
I am reposting these patches after rebasing them on top of the current
Linus tree 11a299a7933e which should contain PRs from trees which
confliced with these patches previously (LSM and bcachefs). The previous
version was posted https://lore.kernel.org/all/20240902095203.1559361-1-mhocko@kernel.org/T/#u
and there are no functional changes since then. I have folded in a doc
fix which has triggered a warning.

I have preserved all the acks, please let me know if I should drop any.


