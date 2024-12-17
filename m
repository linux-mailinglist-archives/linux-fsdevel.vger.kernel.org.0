Return-Path: <linux-fsdevel+bounces-37659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9845E9F579C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FCF16E241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA391F9A92;
	Tue, 17 Dec 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQlxWyv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED614885B;
	Tue, 17 Dec 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467139; cv=none; b=skN/FzXR6aA5P5e77ADYQtuCnybDA5UILYgrGcwKlZ+Igk76l6QXAm3ZmcN53C4C9f9FfNuYB6Gcqm+udIZuG2enS0fFNydYT+0dfkIyusYNBw2JtHQkzn6ApVMmT8i7p7IlKFsUKj71MT+Sbs5jVRl/754fAsvPJWks8EQsYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467139; c=relaxed/simple;
	bh=0bmB1SlLSF8LnUIlZba2LBEOXa+e8exkzejO3GYFJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJf4uOX4I7wzNZZR/QCezDbUaxPjp/1ypqr16A2D8Z5azwBhmG4zPfS/3E2eewjyJosRhKcix0Jos5YQWO9sh0o/eILfKp4q6iG7nO+QZCDepBjDX0rJnYgvd7BxXrHjx2QxEsXSshC1dNw6i+NO+BsauEiYPPurINCt4G4NOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQlxWyv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D8C4CED3;
	Tue, 17 Dec 2024 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467138;
	bh=0bmB1SlLSF8LnUIlZba2LBEOXa+e8exkzejO3GYFJ50=;
	h=From:To:Cc:Subject:Date:From;
	b=UQlxWyv3XpsR7+2SQ3FiR6JKlLAVtzC5Oi5HE2NGF4jXgPIlQ7PDnSKuRlunY19hN
	 +Al3WPUK466WT1MeR3s9KDSSnOoTFFS2W1vi/+zUebUZRw8JFnm5x5fZkP50c0x2h/
	 gwp9FtQ3kATKRp8cRaTZ6CD00MMtwgmxNVwdUor6vtIDavqliE3gBbOHj7z215koMu
	 MDDaQxJej16ovMnvepvgoznfb4+2tfkmZ9jBhjGDFwBiySJQdSzhn7leDolBmlSogL
	 QBKE0umBPemJjxHO3FLGrV1mFxQA2TwYNpL0IAOacDyF8JTfsgd4XFxrEx1fwzzGDq
	 fjVHa+36YfUjg==
From: Song Liu <song@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@meta.com,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Song Liu <song@kernel.org>
Subject: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Date: Tue, 17 Dec 2024 12:25:23 -0800
Message-ID: <20241217202525.1802109-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reading and testing LSM code, I found IMA/EVM consume per inode
storage even when they are not in use. Add options to diable them in
kernel command line. The logic and syntax is mostly borrowed from an
old serious [1].

[1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsung.com/

Song Liu (2):
  ima: Add kernel parameter to disable IMA
  evm: Add kernel parameter to disable EVM

 security/integrity/evm/evm.h       |  6 ++++++
 security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
 security/integrity/evm/evm_secfs.c |  3 ++-
 security/integrity/ima/ima_main.c  | 13 +++++++++++++
 4 files changed, 35 insertions(+), 9 deletions(-)

--
2.43.5

