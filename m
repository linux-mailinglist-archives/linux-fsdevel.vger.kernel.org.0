Return-Path: <linux-fsdevel+bounces-33394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8E9B88A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BDD282AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6983126BF9;
	Fri,  1 Nov 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gznpW+A5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174F62171;
	Fri,  1 Nov 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425097; cv=none; b=jX+kfAWCybjPy3roYFLE1eRu37opXZFokYDfgOw7FNrbob6+lr7L7Two3G+Z22bAt+h20DrjuDySTTYh+jSCItrVvfNU/wFJZe3ui1XLniTmnWabV6HQ7vzWE4zG+K9I2Vdcl02V4gklQVi15etuzAPBa3sJ8vGRH+lXm9qWhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425097; c=relaxed/simple;
	bh=hEwA0s8kgPtjcWS5yi4u6+2i6EWcdddcnRavgD+HWvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LVlE3ZPOCgy++Tfc3p7PoE5/o91f1j+SLZt4xL09MiFBo6L8yl3Y13riHcXpFSc+q5ef8hjCL0xMHtceSmzTjsr4Hv2z0gw/myq40pitj6BfAboL4gWieY4nvB8KnWcBvOWGhQuxEC6WcYdduykOdHdvbGlgPBjPOYQi0uO6I0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gznpW+A5; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RTWnA8DrzuqfAHlNHY/1Gv0zDO0kpbTJfJo5kTH2GZY=; b=gznpW+A5iFUUAupNyMoWzCdQ9r
	i+gZaRh8gjDZFQwYD/UkPXHdi1DRItSUA8oFyY7K2Elf2CDwJU0RJmPOW9AKzJLwEreeAv0YFPFL5
	wArFprYW8u7CJYlkLEaLP2PMr0ojjl12hmEfeoMCQdETcEu9LdZ4QeU6t3WmTZaj3dtShhPr1eb32
	tFBlK35WVMz+qrWEaLOXWupDHWUn49EDaMr1pS9VTny9tjw7mxQgqD5Bqt3eMZNpGc0I8YliXYmFg
	7LGpbb0ma1jHpI2JsOd6SwDBDNvVxN0zKDyUXObTBQtu0NH+hBnY3VEETWSUCrZZ9v4YyQpeQMvi0
	DT1DJx/g==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6gbl-000G0m-TW; Fri, 01 Nov 2024 02:37:50 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/3] tmpfs: Casefold fixes
Date: Thu, 31 Oct 2024 22:37:38 -0300
Message-ID: <20241101013741.295792-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After casefold support for tmpfs was merged into vfs tree, two warnings
were reported and I also found a small fix in the code.

Thanks Nathan Chancellor and Stephen Rothwell!

André Almeida (3):
  libfs: Fix kernel-doc warning in generic_ci_validate_strict_name
  tmpfs: Fix type for sysfs' casefold attribute
  tmpfs: Initialize sysfs during tmpfs init

 include/linux/fs.h |  10 ++---
 mm/shmem.c         | 105 +++++++++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 42 deletions(-)

-- 
2.47.0


