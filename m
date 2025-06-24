Return-Path: <linux-fsdevel+bounces-52703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB8AE5F5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBB17EC5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEA258CE8;
	Tue, 24 Jun 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwbgCOgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EF25B302;
	Tue, 24 Jun 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753788; cv=none; b=RMNJNNGjfsc2ynopKfwdThBoQr+j0vfZ+t8tbq4DIaCetqS8n4ZR6jKnJoqSZ/MIxi2kMhW9TuA1K4joMMJvWnrYZXrv8BZSVfdEsdOrcqespOjG21GYFglyQp4uG/YC3nSZjdmIpkU+wZHPAGOezjXOVKllKdE0YUiLxdv0GK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753788; c=relaxed/simple;
	bh=KrK8lbTCdb06XchgncN951ODBKYkzA/QBalZbj7oftA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwYSMyOuaMCd5u6ftCZcXgiATHAQG/ylmkft+bflVfJIs9UTRarW6TnvnMRC7r4BwfOqxV9OBblmXejnXdvweiyGThrazCGApJdzWOc+oEYCM/4Al2al0neW5SYf+L2vz/Q/L7YiAR0UuOrKkgYBlVxCUEA538X2hzQ9QtKFyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwbgCOgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDEEC4CEEF;
	Tue, 24 Jun 2025 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753788;
	bh=KrK8lbTCdb06XchgncN951ODBKYkzA/QBalZbj7oftA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AwbgCOgN2N95oXc9Wdyxm8+OTwISjCErqPozZBvKdEiyx1smKOdcsSRtDTZpVLnbc
	 /DHJQTYynk6++Ai8NqMIqlojHUCwGH9UMo8lb+dJgXJHahqdf9Xdmf+DGw+MJ6V6qI
	 Of3FtoYorh+ezVE1IMSaJyu18nOetzIQF3+D77zgGRvXbIwS8z481krodCVktWlHmZ
	 0vQwIhJfEFuP17+4mVQjlk8eovlhIbTGNBv72Hl6kPAf+Gee0hDLV4xXTUzMnjYY/2
	 U6rvaMuyhnp3yOu1b84sbxDST/8wgjjJA58ASHK5lizWAtsTR2CNGRrMnBuYqO4UC3
	 ZWnqcpMcqpvSw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:11 +0200
Subject: [PATCH v2 08/11] exportfs: add FILEID_PIDFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-8-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=591; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KrK8lbTCdb06XchgncN951ODBKYkzA/QBalZbj7oftA=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGhaYejIIGqjhgBpqQXXFJxW4MHN5hktRPziS0Xt6LnjMRobr
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmhaYegACgkQkcYbwGV43KLNagD+O0a4
 QSXeVf8beIMA/2UXr4kukgRtqG6ccsxqrgOLb9QA/iP0f5qA9By4NQZ6NCi/ySpgKZ/uPjrTSZF
 pB4KzHMkF
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Introduce new pidfs file handle values.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/exportfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 25c4a5afbd44..5bb757b51f5c 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -131,6 +131,11 @@ enum fid_type {
 	 * Filesystems must not use 0xff file ID.
 	 */
 	FILEID_INVALID = 0xff,
+
+	/* Internal kernel fid types */
+
+	/* pidfs fid type */
+	FILEID_PIDFS = 0x100,
 };
 
 struct fid {

-- 
2.47.2


