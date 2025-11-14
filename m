Return-Path: <linux-fsdevel+bounces-68459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C982DC5C870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A534229FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB33101A3;
	Fri, 14 Nov 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPwVByzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121230FC18;
	Fri, 14 Nov 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115333; cv=none; b=H2AYgcRZ7xkb+xf8zJFaTJI9abzq+3LhRvbZ1FVyTiJ/wWB+kpaPbJWt/JOKOAgIFuEBo9liwnLzYl8IHmBi+fXDQAxy7kB9xkK927zGM9jYVJXQB94or0ACDwLQvHkmgLZdSnlnrcJxi0/VhtdqiSEdlmGiR5PQ/ro4bfhGZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115333; c=relaxed/simple;
	bh=xxGmr78zm8u4YoVUi2DmguUH+VqTj0pJav3No1te3AM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M7NVB2a2swXZwNAr6BfRf2JBHYvWIwdD2qj9/CjBjmeso9KS+ihSNM+wNRUt1baA/tkolymbcJcFkWsBxpeZUzMu9DaovBJzJgC/w+03UGiEKZViJsws6DMSJAe72P8Lu+/24ML3hSWcP0DIXdah0IQ75zAtVZ81VZ8MknWK4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPwVByzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883B7C4CEF1;
	Fri, 14 Nov 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115331;
	bh=xxGmr78zm8u4YoVUi2DmguUH+VqTj0pJav3No1te3AM=;
	h=From:Subject:Date:To:Cc:From;
	b=PPwVByzGOA7/N182YdkY2QAEqNE4w7EVUeJoTLrzgBmhWji0loZRwQq6t0jIx54Do
	 Xy24a2/gFN8cp3du2tvIVcI5eBUzDCZYRnhRi59vuQRx9+qGISI+xV0gdz6bTAq3hO
	 KUMhhQhKrQwMB4xJalO/yxlh+PSVInM+fAANMCAX9Rl46wZFUIc7MnuaFUO+gWhDNo
	 Ka54/3TcA/RnAHuRLqipkhyx74JG0nuMw1Eabi+H77pv00eJYRSYgke4m6X7l75C0t
	 5hz3TO0eA3nav1AVTABuFP2N6Ydl9ALthV9iGxeK2AqvNU09GExA6eRnumcJuSP2o9
	 XddlXolB1MFbw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/6] ovl: convert creation credential override to cred
 guard
Date: Fri, 14 Nov 2025 11:15:15 +0100
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADMBF2kC/y3MQQrCMBBA0auUWTuhE1sUryIu0mTaBiUpE6xC6
 d2dFJf/L94GhSVygVuzgfAaS8xJg04N+NmliTEGbbCt7Ymow0+WJ+b1hV444PR2EnARXpww9md
 LLV+4o/EKKugf4/fQ7w/twRXGQVzyczVrmuoZ9Uz1zOGZvwf7/gPKkL8koAAAAA==
X-Change-ID: 20251114-work-ovl-cred-guard-prepare-53210e7e41f8
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xxGmr78zm8u4YoVUi2DmguUH+VqTj0pJav3No1te3AM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzqKrjl5maX+oURd3ulpFq3bfv5lDjiyXEly9bqq7
 nXyUf/ZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiUMbIsKJst9p9cTn7dc48
 1SuWdExsOr1IZ4LsFvEJOtutbn071cjIMH//SkkLMbdZz77+Ncy+yV///Fd13rubSZouRqIKRoV
 8TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is on top of the overlayfs cleanup guard work I already sent out.
This cleans up the creation specific credential override.

The current code to override credentials for creation operations is
pretty difficult to understand as we override the credentials twice:

(1) override with the mounter's credentials
(2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id

And then we elide the revert_creds() because it would be an idempotent
revert. That elision doesn't buy us anything anymore though because it's
all reference count less anyway.

The fact that this is done in a function and that the revert is
happening in the original override makes this a lot to grasp.

By introducing a cleanup guard for the creation case we can make this a
lot easier to understand and extremely visually prevalent:

with_ovl_creds(dentry->d_sb) {
	scoped_class(prepare_creds_ovl, cred, dentry, inode, mode) {
		if (IS_ERR(cred))
			return PTR_ERR(cred);

		ovl_path_upper(dentry->d_parent, &realparentpath);

		/* more stuff you want to do */
}

I think this is a big improvement over what we have now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (6):
      ovl: add prepare_creds_ovl cleanup guard
      ovl: port ovl_create_tmpfile() to new prepare_creds_ovl cleanup guard
      ovl: reflow ovl_create_or_link()
      ovl: mark ovl_setup_cred_for_create() as unused temporarily
      ovl: port ovl_create_or_link() to new prepare_creds_ovl cleanup guard
      ovl: drop ovl_setup_cred_for_create()

 fs/overlayfs/dir.c | 151 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 80 insertions(+), 71 deletions(-)
---
base-commit: b4f90b838f462d46522e17de86431b171937adc2
change-id: 20251114-work-ovl-cred-guard-prepare-53210e7e41f8


