Return-Path: <linux-fsdevel+bounces-26698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8B95B1B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F381C2033D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A015572C;
	Thu, 22 Aug 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdxHW9dQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2E16DECC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319067; cv=none; b=UxMqjahBv8XR58HV5eG/EB3IQx8t1G4f40+2wclsA1iB9WX5T18TXIQHOHZ9sf1CbAaxg76X0cWRvy7Z+jiCW2DKXAlNQ3pYNzW7fIRjq9q1UwhL+CkOnpBxz59zYw+RG6jtnvLz664OvjKnJR58SJ6LXIVT4+IUTYC0kb+OEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319067; c=relaxed/simple;
	bh=HPO2ALoEqL0Q8f6Lvx3CUXTHc9R2C2N62LNYF806c0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZK98rwpzADKorbQhHFIgX8DDsX7PxZ5zvfaNUa2sXao0Hxc2gmFUnonCDSNAKrNrfDgBSvg15mQ/vLFYVNDG5TLobiVK1iMOVIh623YzOlOIh2JZeg7eYv+x3MOr/K+kuPNok5AQY9+hVOrvBcwk7tGMIIh+rSgGGWMjHksnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdxHW9dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8566EC32782;
	Thu, 22 Aug 2024 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724319066;
	bh=HPO2ALoEqL0Q8f6Lvx3CUXTHc9R2C2N62LNYF806c0I=;
	h=From:To:Cc:Subject:Date:From;
	b=OdxHW9dQc4b3CheYsQmVzqMtwTcok6AR4bXsbNxz4I1SgQabdQ39J3jfxxKaWIegK
	 2qL12hb29llQcLIiNhcHfCf1oGpRBFnf6+TNiwoG48UPUHe5TlRqdgqMOhhFsdyxCr
	 Oapl/IV7OVFwJxSgs+tq1n2tLM1qfXs+rfAl8NZ20zuYd17a115SjEI7OIKJYyJhOS
	 Vjije2ohNuud2b4q4UBZcGdTEu/3znKQdr9Vbp04Bt/6Ivk61FvpfoChqGTFCEDFlA
	 c3xlu9AiAm1MuATjWUwKV8P4ZRoMX//hWpRXjC5KZHn4EgaLMFnuDYmqlLvAwAJC3C
	 F5XW9ahjjcfTw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: s/__u32/u32/ for s_fsnotify_mask
Date: Thu, 22 Aug 2024 11:30:58 +0200
Message-ID: <20240822-anwerben-nutzung-1cd6c82a565f@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=640; i=brauner@kernel.org; h=from:subject:message-id; bh=HPO2ALoEqL0Q8f6Lvx3CUXTHc9R2C2N62LNYF806c0I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQdZw3ZsOlbTKSCY9Wxv9u4lD64HZNrftvxoO/lPSvOX a37nX+96ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4gRGhiuegeJVbOUNU7Ia FsyQvVWxYOuM17XHlj56Hrzu1fZdb9UZGRavSTl49B57wesyfiW2uQvePJgTt/jO27NmlVNyPfl u3+QAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The underscore variants are for uapi whereas the non-underscore variants
are for in-kernel consumers.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23e7d46b818a..7eb4f706d59f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1273,7 +1273,7 @@ struct super_block {
 	time64_t		   s_time_min;
 	time64_t		   s_time_max;
 #ifdef CONFIG_FSNOTIFY
-	__u32			s_fsnotify_mask;
+	u32			s_fsnotify_mask;
 	struct fsnotify_sb_info	*s_fsnotify_info;
 #endif
 
-- 
2.43.0


