Return-Path: <linux-fsdevel+bounces-31636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF799934C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932DD1C213ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4561CF5C3;
	Thu, 10 Oct 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="m7vk0v+z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A551B6539;
	Thu, 10 Oct 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590580; cv=none; b=Bg/ySAa/84SJ9+HOJuC7yuK2w2DMlJ08KKEnOJLHL7o9Hm/1borvvPtobmBSzeioD9Wsf1f8qMtaytkExuP1wGmto+ChyUFFQSsWQNgYC5hiMqxA+AxSZ1C7jZ+o4TkW202hBfVQS4fYvQBft6SItxwR2ZsEdOH8KO09MhD6yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590580; c=relaxed/simple;
	bh=d6ebuleT1VhfQboLECKP2pxXJvA/S/XhwyVIZdv/DKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XoKF7cDv42yY1Fl+jPrqNGpx3pOO85V1++70JBly+ZfUXJwKYxgO6qofx3hetNLA7TNnjN8bo687kOsBJXQN72dzl7wstXkVDkvb1yugA7OeVKu/4/4r/2Gp7CGDBcBb6XscDpR6Bep7w82QSpv+djBDSiL1yazw3xWgFuqzTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=m7vk0v+z; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=khlqzlnZpEblAJNrRRX2+0G/VzYas/P6WVQ3loReDAM=; b=m7vk0v+zLvvqoKiLAYbpAMQqNc
	qZB3fycjDvmRQYI+jJoeO+BHcljNge1GesnpvDy4RyCZik4wwi7Lrpq1HzkEowXrzbkO74L+xHYjl
	IOXO42Uq7WUmPkRNaJD3StawTzofaw/LPYcPM63KccpMYctlXRJFcr6RY217hj8CxNA+fj+21Vi8t
	oOgsNZTuiq8bxTcxVUNxuxeT2iEZFwWHmzG36aw+ryFZ+64rqIht3toOIb9j2gGwERQO3tdh77DKJ
	S+8XkFRgqcPpzPyj+HeFjkQSCFa9ujvXKEg+YwMypszTYH+cmsVmOZOOrTx22mPRnm/WuVkbAR03p
	wL3oTAuA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syzN4-007SzJ-G1; Thu, 10 Oct 2024 22:02:50 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: krisman@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] MAINTAINERS: Add Unicode tree
Date: Thu, 10 Oct 2024 17:02:42 -0300
Message-ID: <20241010200242.119741-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unicode subsystem tree is missing from MAINTAINERS, add it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d01256208c9f..54278e086a47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23777,6 +23777,7 @@ UNICODE SUBSYSTEM
 M:	Gabriel Krisman Bertazi <krisman@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
 F:	fs/unicode/
 
 UNIFDEF
-- 
2.47.0


