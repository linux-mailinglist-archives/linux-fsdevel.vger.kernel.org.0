Return-Path: <linux-fsdevel+bounces-66316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F92C1BCA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB525C8D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3A2BEC32;
	Wed, 29 Oct 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqF3Fack"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577972512E6;
	Wed, 29 Oct 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749865; cv=none; b=uB9EgAzeOKZpdFmY/KU1VXQ2ARKgqG6a4h31IOwtKIizl3p+A4D3J6JMJAlG1F4oVS4jbfjVt4fCVfd/gkeujIKQW0eFwjaV+scHvzDmRpcJgyXAzDFJoiq/g74kiZtDENBoyp41nE1oB8fCjhI6txQ9j5Nr4A+BV0B+Q91kZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749865; c=relaxed/simple;
	bh=Cxi1vassUFklBybcI3XkPveEgel9I8hiB7hbIhZWh+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7G0FeKPEytgE7Fe2AEsJo+9bGDhAGuhi3yFY/KiQXg2lwOJ4ofdRPMs+OUICf2CpRAShf6pxcUwrAO7DOoRcfa/5s8xiZpCGb5OSQpt4K2fpgpw+gMdP4KA9B3MHXYrHpQeLaANfSsHAwOY3idQgwC/LEu4DGzSGbriJAL7P8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqF3Fack; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51569C4CEF7;
	Wed, 29 Oct 2025 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749864;
	bh=Cxi1vassUFklBybcI3XkPveEgel9I8hiB7hbIhZWh+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqF3FackJ9Pn0Wf9+7STvoKX6z8kxeibQdZliJyVoZljUSsPAcJVqsXsSb4avB3L/
	 g+F+GPJaPJdj+17DenwrZ/hCR+PPCjX9MXznFPPqeNNCO8CB5nuuBgBHOKCJJZxu/4
	 3vG/cFD6A7uIc8rBaOwVPfjbx+MaoCabA1g2iidZ4aWBGXtwalRtICzL8eIRmk4flp
	 NwH3FQiotrYi2kTHIsSVJaI0p3+fHEa+F9Sulv2/bZl53JQLfXpdUvCNzIuYq/+pDu
	 lWdbq2fa86V936dZ+5MqoABf8P5Xomk6MpSW0bawoIdnHDB36JsCoTM+ogWTTi6hjT
	 J4oXoFW2c/cCg==
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mnt: Remove dead code which might prevent from building
Date: Wed, 29 Oct 2025 15:57:33 +0100
Message-ID: <20251029-allseits-wehgetan-cba7e7684b40@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024132336.1666382-1-andriy.shevchenko@linux.intel.com>
References: <20251024132336.1666382-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=brauner@kernel.org; h=from:subject:message-id; bh=Cxi1vassUFklBybcI3XkPveEgel9I8hiB7hbIhZWh+w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyaSf/6DTrn9HbnLRtwqVvfabvA6/MmM9zZOOVj3IKs yy+b0rK7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIrycjQ8uC7Y8u7rQ2F26f I73rhgLH1dwgBZllSTd/f2Vi3f4snYGRoWHqxVi+OUrf/lVXfJgY2ui9OnVOr/9KX7Xbe7/H9jr msQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 15:23:36 +0200, Andy Shevchenko wrote:
> Clang, in particular, is not happy about dead code:
> 
> fs/namespace.c:135:37: error: unused function 'node_to_mnt_ns' [-Werror,-Wunused-function]
>   135 | static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>       |                                     ^~~~~~~~~~~~~~
> 1 error generated.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] mnt: Remove dead code which might prevent from building
      https://git.kernel.org/vfs/vfs/c/9db8d46712d2

