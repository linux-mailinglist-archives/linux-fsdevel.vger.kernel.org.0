Return-Path: <linux-fsdevel+bounces-48461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1FDAAF61A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DCE4E2287
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868C262FFD;
	Thu,  8 May 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Q4yfrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2457238178;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694454; cv=none; b=gS8MlseEn7bAdfZ1VLpy+GYa3bJGDX07c+0VHWJitrtuQnRrNItReBfzldFOi8Zj1EhNLDBekb5uCxO+A2rez/MQOjfiDjwrKP7bX+TVPIA/s+JxpOFk+RE2mbc6EaBMf7uk11WS4in89eYIcPULpih+wZG6DSaJP2cZQ4xxEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694454; c=relaxed/simple;
	bh=EefenSng1ckhszoQFgYawbUMHZnq3C6b7k2QovafbEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rY8XQXqsnJcdWtNm6YWTR1m8NdrF3TLjfrYDNsk7JQgv95D6SD07oT1ZsOzMOL5pCWUHxiThGFusS/MgM6WtaHKQAY27iSPgpN7209Ir21TfhiWUXJXCTIVbGPnIS4LkTVaMM3QfYCe0gY2O83zZ4iHJNC2Nkl1qgPv9oddq50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Q4yfrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47EB5C4CEE7;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694454;
	bh=EefenSng1ckhszoQFgYawbUMHZnq3C6b7k2QovafbEU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n9Q4yfrGwDEZS0gkZCG2O58+0k0etADQy7zrmNz+6hkkvX5dBcHf/QjfQ2xNcvIO0
	 mlvijuK5NNgqvha8ICjtfPb/7YSSsgTgQHtCe9oszxemfeIez0gP+aSu+l3VOmSAOC
	 DvhIIkzgV+yrVIog1oM8GlC6AsyUyg3NCqKLRMtpg3oARISqvuPDgzMmGJUypnJG/b
	 qzNdWPeuZn8zcNC3CiPHmvwVS++F9wkrhvznjOfWcecCE3oPhmNnLZmgLo4du+WrH/
	 /9G1cHu8uScd8ZbrKkVokmVrUBzy7q4XftzYcWldCYeKv8oQUEgso/azEgntfqbAsw
	 7uneyGprFGLvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF7C3ABBE;
	Thu,  8 May 2025 08:54:14 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+chenlinxuan.uniontech.com@kernel.org>
Subject: [PATCH v2 0/3] fuse: Expose more information of fuse backing files
 to userspace
Date: Thu, 08 May 2025 16:53:43 +0800
Message-Id: <20250508-fusectl-backing-files-v2-0-62f564e76984@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdxHGgC/zWOwQqDMBBEf0Vy7sq6otGe+h/Fg42rWWpjSVQs4
 r83FXp8A/NmdhXYCwd1TXbleZUgk4tAl0QZ27qBQbrIipAKLLCCfgls5hEerXmKG6CXkQOUVYY
 d1ci6rlTsvj33sp3eexPZSpgn/zln1uyX/o0ac6qpTHOtUZdAYCy7Udy2tO62uHhnZmNTM71Uc
 xzHF97ZToOxAAAA
X-Change-ID: 20250508-fusectl-backing-files-6810d290e798
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen Linxuan <chenlinxuan@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460;
 i=chenlinxuan@uniontech.com; h=from:subject:message-id;
 bh=EefenSng1ckhszoQFgYawbUMHZnq3C6b7k2QovafbEU=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBoHHEeWQ45itwERzLYrNzAswRnl5y/AU4mRxJmF
 bniqrasptCJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaBxxHgAKCRB2HuYUOZmu
 izvNEADRmsQWebLMMUC28QwvIbCU0ZVKYx6ZBDqsh/X+UJ3rse8Wtg8BWE8krz1+38ncNvIsU3E
 ajQ2dED/IzDHx0rga/yRFbRWy0n7O66avYwcKgY9R0yu6iSkOaRTtQTixX9EkRQMG4GjroNQoci
 zNO1UL15EoU+jHG9FQXtu+DCUzui04dzyAT4w9DRDWAJDyi2LjdACc2LLSvqlx+p0So0yvZsa3M
 5UsBhXmCXO+p6F8GxzPOA/Jkzg50U3ISG+Rtd+iGpiDALEwv3tfHOr6i31LmqJ8mp7ho65uvL9o
 RKyCQBXT2TPpS4CLu0PachovyeiAdSxXgNVq4zTtCzHHJYIGuQ8pl/jq09ubvs6IgKiylYGXjjE
 DWgFKVAkNvo8uifXtH6W/cXNXLqPI1dpW0X5yVEQ4D8PgKJHigCYMxjeITPBPYULlAJzCXDT+NF
 yv3P8WvTt8Xvwx7yN93ijFGHR8IY6aVsniCPDJazvGrFD88tdqPTbFkcEG4lj09f5JUBABbj12p
 zNwT3dZvPRtqDvLi7pnV+GHteFDLVegJwWc2jknDyDJq/LV46o7HKEtvYvikHkG3d7Bj7y6DZsh
 1bBSIAOjfm7OB/SOBwdiNjjg5g1yDBRaIVJAfILaape70uW4mCVCV+LqhAowpREOxNBREs12b/q
 wHktPdWe62/zDUw==
X-Developer-Key: i=chenlinxuan@uniontech.com; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for chenlinxuan@uniontech.com/default with
 auth_id=380
X-Original-From: Chen Linxuan <chenlinxuan@uniontech.com>
Reply-To: chenlinxuan@uniontech.com

Please review this patch series carefully. I am new to kernel
development and I am not quite sure if I have followed the best
practices, especially in terms of seq_file, error handling and locking.
I would appreciate any feedback.

I have do some simply testing using libfuse example [1]. It seems to
work well.

[1]: https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v2:
- Void using seq_file private field as it seems that we can just simply
  returning fuse_backing_files_seq_state in start() and next()
- Apply some suggestions from Amir Goldstein:
  - Use idr_get_next() for iteration
  - Do fuse_backing_get/put(fb) around dereferencing fb->file
- Update fdinfo of fuse files
- Link to v1: https://lore.kernel.org/r/20250507032926.377076-2-chenlinxuan@uniontech.com

---
Chen Linxuan (3):
      fs: fuse: add const qualifier to fuse_ctl_file_conn_get()
      fs: fuse: add backing_files control file
      fs: fuse: add more information to fdinfo

 fs/fuse/control.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/file.c    |  34 ++++++++++++++
 fs/fuse/fuse_i.h  |   2 +-
 3 files changed, 171 insertions(+), 3 deletions(-)
---
base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
change-id: 20250508-fusectl-backing-files-6810d290e798

Best regards,
-- 
Chen Linxuan <chenlinxuan@uniontech.com>



