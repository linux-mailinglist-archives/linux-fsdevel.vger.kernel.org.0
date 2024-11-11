Return-Path: <linux-fsdevel+bounces-34245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330149C4191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0643B228E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB901A08C1;
	Mon, 11 Nov 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzY/QDRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B425777;
	Mon, 11 Nov 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337821; cv=none; b=g3BO3ApUek8khk+ceBiTF3ffEZAlAz+CaugsLvgLu1aU38Z3EomXh6fqubKVGxRCwsC1Ko53JVFQuyRANBB5BY92Fik5tl9hVzA1GvRjlCf9Nh5o/cr5EftvIiZ1s9EwRzTrHL9VvpyzQyw/rX+IxxRk8ZEeW2EXy2e1lfMXTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337821; c=relaxed/simple;
	bh=eKdkZjo8ki0dpL5Pnyzp1K0d6j7dtfBALTBVl9rnJ6A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=drNviPw2QgW2ALIjFf43Yuib2VR2jwJpF/yGsrLWTPlFla2FpkSqcQK5vJqsMqF0pCsul9bwwugNPE3H3jDzatWRsU47uj1Us/cnGPshRWtv0LBVPr2XMvQxwdGsENFtOkj5/EKlSLAfTCmwOnGHcW1/Nmu/JK0R/Rax/IZHYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzY/QDRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3206EC4CECF;
	Mon, 11 Nov 2024 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337821;
	bh=eKdkZjo8ki0dpL5Pnyzp1K0d6j7dtfBALTBVl9rnJ6A=;
	h=From:Subject:Date:To:Cc:From;
	b=GzY/QDRMv14TDZ9+NcF7MAnOgIUfU7Rmc3Wbfj5QpVHEquQZuIrB+PgDmSB3SA77g
	 +XbuLe3PY/54eRsLRA4y4SCRw1FINT9dTeUg8Dj548KvnXcO/DMmjsRwCZuNa/WrQf
	 INuJnW0Bu+xya2cjwYA6Oq6lMD6wVJzZ3uKg54N79xWlVR9+6ARV+ZRJJZmZ/tt3dH
	 uLJDxEMyf7rO6LqhzmBz1UYYPXwMnPMCm0dxI3PCoU7cFRFcYtNKKeweAqUk38UL9Z
	 OcxHbkUZfFJ71IGdCIOb0bmUvTKJiIy11WxjivDXyPRggxuPBryvWZdd6Goam0pNyk
	 SY0d1aOBeqx1Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Date: Mon, 11 Nov 2024 10:09:54 -0500
Message-Id: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIeMmcC/3WNzQ7CIBAGX8VwFtMFWsST72E80AItUcEAEk3Td
 5f21PhznC87syOKOlgd0WEzoqCzjda7Amy7Qd0gXa+xVYURqQgDqBock0w3/3AJUyNAcq14bSQ
 q9/egjX0urdO58GBj8uG1pDPM669KBgy4FbSVRgneEDhedHD6uvOhR3Mmk78qwRWeTSKlonv1r
 dK1ytcqLaqSdSs4Yx18fJ2m6Q3+pYF9GQEAAA==
X-Change-ID: 20241106-statmount-3f91a7ed75fa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eKdkZjo8ki0dpL5Pnyzp1K0d6j7dtfBALTBVl9rnJ6A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnMh5RpuFxxGV4rbm0dHCE7Qg7aaytxzym+Bho1
 mGOarjkCyyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzIeUQAKCRAADmhBGVaC
 FX2IEADEkkq08ufD/9LByz4u2RFy8FaaPfxMlgd/DL8oHklsYAR+sswCJ/O9HxAm1PPMFFQHBir
 0Ye8gM9gfeMZTEnspOOAP9OWa/bgHnmqjVUDeykePaFanLY6xuoSblUPWC+lvcSqp0++xfA4uNH
 ez/w5POp7h9N4O1QAquYtsCcl31xj1aW4w4mJ66PMVZodUZSfePZyMmVJhi40QsBcodvJRyiSUs
 wU9elXkKlJXted5W3zGnum8GkHwkgrS/lVW/XQTSdpIINjPWDVxxoYfK78UIdtrXRCd6r/0PnbH
 BWO5j9YCXFezC0ImAQTLhnf5Mg/GygQWV8Cz36D2irk+CJ4M+Pm520KUynrJ3FEPESdltfA3zBQ
 7OtW+WOEMcIFZmOQgvb1QoE+UAjIfxupBep5nH9QyxHUnUC8JKaAI8sUmltab3XkM+84B7XHWV3
 32N/za98vmsT58NHb6sM5to1mBeEgd4bm0ri8fnSIKeGjSkDRJPC6VzX7AgB4eJ5jtx7j0gm5sO
 Ju5t7Do1uVu9nmVu3GUx2i+H/Ki9BK5GbC7O9tVlvi1AoC7TFJBMxgEZJBaxRKi8aVsLFzC9MPQ
 O9XIn53ZWECtYwvbIReI+jXlsGq95o7lCMqLXpsXZTHUqDm7SGTOJcfysSZTuAlh/XqPcc31eYf
 7tu0ltyH2rsu7dQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Meta has some internal logging that scrapes /proc/self/mountinfo today.
I'd like to convert it to use listmount()/statmount(), so we can do a
better job of monitoring with containers. We're missing some fields
though. This patchset adds them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Rename mnt_devname to sb_source
- Break statmount_string() behavior changes out into separate patch
- Link to v3: https://lore.kernel.org/r/20241107-statmount-v3-0-da5b9744c121@kernel.org

Changes in v3:
- Unescape the result of ->show_devname
- Move handling of nothing being emitted out of the switch statement
- Link to v2: https://lore.kernel.org/r/20241106-statmount-v2-0-93ba2aad38d1@kernel.org

Changes in v2:
- make statmount_fs_subtype
- return fast if no subtype is emitted
- new patch to allow statmount() to return devicename
- Link to v1: https://lore.kernel.org/r/20241106-statmount-v1-1-b93bafd97621@kernel.org

---
Jeff Layton (3):
      fs: don't let statmount return empty strings
      fs: add the ability for statmount() to report the fs_subtype
      fs: add the ability for statmount() to report the sb_source

 fs/namespace.c             | 68 ++++++++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/mount.h |  6 +++-
 2 files changed, 67 insertions(+), 7 deletions(-)
---
base-commit: 26213e1a6caa5a7f508b919059b0122b451f4dfe
change-id: 20241106-statmount-3f91a7ed75fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


