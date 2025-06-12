Return-Path: <linux-fsdevel+bounces-51480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694FAD7220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7551C25573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A30246BBE;
	Thu, 12 Jun 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAcVf+XH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7723E353
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734770; cv=none; b=BBm3WrFFOgGZDR/DtzXxc/WSDeFM1sw1aHQZyRstR9AV+s1Gn2TOveWOV8dsqzdCy47sEVRruTY3PD4M7b5T0b2tpWkpO3DcrrIefbtNWw3dWctOPW2lyLKKeCZSvS9pzKTF44D+2dUq3/Dcv4vHMW25d2rzoS99mwn/BaiT1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734770; c=relaxed/simple;
	bh=k2Mhdgo8la0kY1zhjQEmq8NcJS+yzBH3eb4NunXSt0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t+OBqPEyvIBVGZDD0avaC+zj/quZiYr4pn9gdGxI3oBu7SERdX+GVbytMYnHYorRfOE0nug4ZiEDARQMv7Xn2oaz7UqMfoPMutyCyF9YNz4DCJuntkOp5GBHvVUZdKpv9L3iSKwh99+xqCvBjHVd5lg69KSGwv6tN1GQkafk6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAcVf+XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BC9C4CEEA;
	Thu, 12 Jun 2025 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734769;
	bh=k2Mhdgo8la0kY1zhjQEmq8NcJS+yzBH3eb4NunXSt0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JAcVf+XHZ/qneK4D9cYHCkoTaox5VxtIiqK645AEEDkU93hW8KcINJz1sgSLlupFR
	 SDMnDG4AffbFVb9EsQ8pSkVw3nAtyhfyPTmuf2Jo7HSfHr6PEnrzqQv2MPtZGf1usc
	 RwFbbb0U/o+1bVkHOLRtVKW4KdxOnLg/n4m4IlwxN6eOu0EjtRgslsB/uVzRW1NsXl
	 jDaSRBrTa3FI/Xy/BIL6IjwSL/ItnKyla1tLN/h3rCxylYXFdbjGyEdMBQMjeTjBpV
	 1iCzvl/u5qy+eZvAgJEPgVEA19oDWLK3PaWlllwTldQFHXfPiGCAGHcDhnPuZgX4TQ
	 qJZ6d6XkHD67A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:33 +0200
Subject: [PATCH 19/24] cred: add auto cleanup method
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-19-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=618; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k2Mhdgo8la0kY1zhjQEmq8NcJS+yzBH3eb4NunXSt0E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXWvfP367E9Jt6tOl0/uf3KPX1CnJVx4LXvHoZ82a
 9u/8Ty921HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFzaMDO/Ty2+x+aw3E469
 ffDhpo060t1c0xcVThTaMk+0so/NyJ7hn6m43or6s9OFlItOFT31NPLtiNuzeJNxe2Ko4MxHunU
 3GQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple auto cleanup method for struct cred.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 5658a3bfe803..a102a10f833f 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -263,6 +263,8 @@ static inline void put_cred(const struct cred *cred)
 	put_cred_many(cred, 1);
 }
 
+DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))
+
 /**
  * current_cred - Access the current task's subjective credentials
  *

-- 
2.47.2


