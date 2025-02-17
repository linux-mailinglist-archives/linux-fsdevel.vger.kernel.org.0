Return-Path: <linux-fsdevel+bounces-41832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B2A37FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649AD3B02C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E521770B;
	Mon, 17 Feb 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhLhjfqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E266216E0B;
	Mon, 17 Feb 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787641; cv=none; b=N7qXhp9azfe0eD8Z25iijQJEh/ETaBdYJIalMIEXOwhdoH6mRGkuFz3x04j94litFNSRAi0L5jcs8uNygw1HgWECu0VSsJn+wst6J2nJswRe01BT2A5RG1ZL5TAFMGvCN5aKD4RvHZMzuj5BvxI5dq1D7+X3zoG6+w/atFNojuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787641; c=relaxed/simple;
	bh=qFMP0OrZPlYJcsFpyZZLmmzVbi1ZKUkY1I113FQPu3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezIQbewMsoBBoovhO8pKCjmClAa+6aNBkIn3IaPwM93ogsm0mYy7N+XszSF6/tmm+xHZXxv0omui5Tk8bt/HFMqXhiOQHb6czkaHx+R4xoueBRlcvnwNL+DsH42iXoGz52IWyFmwTKN2s+UOq2+2Afz0SWJeE3xAzq+u7fu2/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhLhjfqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF5C4CED1;
	Mon, 17 Feb 2025 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739787640;
	bh=qFMP0OrZPlYJcsFpyZZLmmzVbi1ZKUkY1I113FQPu3M=;
	h=From:Subject:Date:To:Cc:From;
	b=JhLhjfqiT2C9hXWdhsu85NsNFftAT02TDUc8/d5LG0m0wnOXlNH0vfHjn0leh8U6w
	 QnTcYF25Oz36NAKPKCf9BYVHmqTSKFOeiKqd07DlpKPAEZZOw0hSxxrDwEkLqqjEv0
	 FIwNQ1AfezOpkY1KoIiuKXdzjgr7rk4vfpzlUM+hQX1VQFrO7YlnCB0/IMGwwbpqW6
	 /1/VMg5XW8HtNN/cYGaU2wu4BrBAJHoyEx83JJtakWAwuI1xBcgdDoSLjsLsyu98rl
	 sFiTkmbTNQSSrimgK8z6AL0XxSZYYfuzjLRIMlM1QngB7mJx0uJPwmkZY3Hwz3K28d
	 zl8i6MPfVfxLg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/2] ovl: add override_creds mount option
Date: Mon, 17 Feb 2025 11:20:28 +0100
Message-Id: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwNs2cC/3WOQQ6CMBREr0L+2hKKBYwrExMP4NawgPYXGrA1v
 1glhLtb2LucSd6bWcAjGfRwThYgDMYbZ2PIDwnIvrEdMqNihjzLiyzngn0cDcwFpLGZtWdKSy2
 FVBW2CiL0ItTmuwsfcL9doY5l23hkLTVW9psrRK5MeZE+3dtOG9UbPzma9xeB7+y/wcBZxkRZK
 H4qK3VU4jIgWRxTRx3U67r+APoUOYrTAAAA
X-Change-ID: 20250214-work-overlayfs-dfcfc4cd7ebd
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qFMP0OrZPlYJcsFpyZZLmmzVbi1ZKUkY1I113FQPu3M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv5i2rW3bJMOLrOZu+5CRvtRSZW6ukfdb/vMvi8polZ
 Zoxt71vRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQWxDH8z85gd3pjJ3gwzCst
 T+Rmwo/EJ8ZxQUs05xf+jVkoLmhhx8hw/0nG58d7vFzu3W4s4LjG5VLG8+fagjsT4mUulscEFy7
 iBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs uses the mounter's credentials for it's
override_creds() calls. That provides a consistent permission model.

This patches allows a caller to instruct overlayfs to use its
credentials instead. The caller must be located in the same user
namespace as the user namespace the overlayfs instance will be mounted
in. This provides a consistent and simple security model.

With this it is possible to e.g., mount an overlayfs instance where the
mounter must have CAP_SYS_ADMIN but the credentials used for
override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
custom fs{g,u}id different from the callers and other tweaks.

I'm marking this as RFC since I've written this down pretty quickly and
I'm not sure I've thought enough about all the possible pitfalls. I
think overall the concept is sound but there might be additional changes
needed in ovl_fill_super(). Right now I'm just calling override_creds()
when creating the index and work directories.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org

---
Christian Brauner (2):
      ovl: allow to specify override credentials
      selftests/ovl: add selftests for "override_creds"

 fs/overlayfs/params.c                              | 22 ++++++
 fs/overlayfs/super.c                               | 11 ++-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 89 ++++++++++++++++++++++
 3 files changed, 121 insertions(+), 1 deletion(-)
---
base-commit: 7a54947e727b6df840780a66c970395ed9734ebe
change-id: 20250214-work-overlayfs-dfcfc4cd7ebd


