Return-Path: <linux-fsdevel+bounces-59359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0484CB38105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0DF1B6082C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57A35082A;
	Wed, 27 Aug 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3pGY5sK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823B39FD9;
	Wed, 27 Aug 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293994; cv=none; b=KSADDgbJ0n7IXnoVVXULdEbEnORbHyDpJptM2bVsJ3/HMOpQtQQC7rs3/qHy8z/LeJAOtzeUWNwyRx26fPIRme0aAY0xPncyXolQflKRI5XrKfa79/bkH8SOuMhJD/PBYk3y24osFWV/wEch5tBkBiNMRZNiwEjoC5wUimnAOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293994; c=relaxed/simple;
	bh=l85OcvGiwhn2VrrWlEAGaZ/H57AIifVg0uM2EwRx45U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzv0e64SAod0FOrGxKKh4+4JEO292abYZjXlH0qjMd7ZIhRWoRGT8Lqxnjemyrjha0/s7SJRwukn+NOS4dbblbwOOd6C6bp+KWuNoGIshCi5ZJntU8A4BaTPAWx9vOPjlIpCr59tRAwkW5bxlYR65AjrmnEf/plWHbEmSenx7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3pGY5sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E2BC4CEEB;
	Wed, 27 Aug 2025 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756293993;
	bh=l85OcvGiwhn2VrrWlEAGaZ/H57AIifVg0uM2EwRx45U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3pGY5sKTjhlEhSHA7ObU3sMSrSSeIdTBUg4lTmgR4JYjWfyKNwRnFjDnxXh2uCTe
	 IKOTYN0ao7UTqH8eKMhWXmS5nmh3RC3SjMeKWVE8PBAjDYJFHlbQ04ozdzgdye32SG
	 ggH5j/SB23x8iJ82twloZss7kVBDc6nb5yceuTHqexRL5Bq5mNgYDBN7Cny/TWbJZ3
	 6iQmpyEA4yy7cBt5OF5//wMCZWP3XSkN08UXnXDXRulc/GTbd+ia5NRKRJxBlYDrAZ
	 EYUm1KydBk4HtD+ts8aUcNtd2Js8EIubzASTrbtowU7pw1FpXRnAdvn9uEcK6OMu9J
	 jznP9IcEhuLWA==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: Re: (subset) [PATCH v2 02/54] fs: add an icount_read helper
Date: Wed, 27 Aug 2025 13:25:49 +0200
Message-ID: <20250827-liebt-anhalten-390d7eb79013@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <9bc62a84c6b9d6337781203f60837bd98fbc4a96.1756222464.git.josef@toxicpanda.com>
References: <9bc62a84c6b9d6337781203f60837bd98fbc4a96.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=brauner@kernel.org; h=from:subject:message-id; bh=l85OcvGiwhn2VrrWlEAGaZ/H57AIifVg0uM2EwRx45U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSse50cavAz2/rwthlPVMwyN+2v5X+/U0XmbVNvWGBEO s/FiZ8YO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSu4/hn3atpz/7qQ3xSRO6 yyWjrlht0Quc+cFWZsGLizvFAvmnJjP89wuevnZ71qmU0nVFC46Vuy7YtDpUs6A1I9Mk5Eq+SeY BbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:39:02 -0400, Josef Bacik wrote:
> Instead of doing direct access to ->i_count, add a helper to handle
> this. This will make it easier to convert i_count to a refcount later.
> 
> 

I moved icount_read() right after mark_inode_dirty_sync() as suggested somewhere in the thread.

---

Applied to the vfs-6.18.inode.refcount.preliminaries branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.inode.refcount.preliminaries branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.inode.refcount.preliminaries

[02/54] fs: add an icount_read helper
        https://git.kernel.org/vfs/vfs/c/2927b1487093

