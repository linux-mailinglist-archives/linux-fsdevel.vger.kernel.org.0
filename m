Return-Path: <linux-fsdevel+bounces-35266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFA9D350E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B2F1F21C88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE9170A3D;
	Wed, 20 Nov 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN43AKKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE715B551;
	Wed, 20 Nov 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090139; cv=none; b=GZyW+nz6Tr24z7Bj9xx2vrOVBc6yCa3Uw48pbCTiCAIB80pemfXdzeWLZE2qH+Kl9HEScb9upxZWqD2lDLU39SXgvmEuDuqgLhCjVDT/nqMO0ZX5jN/2wBEjN06s5fx8qShhpH8U4sTgCCmmR1w3vdiWj13BC/PYDI5/rXWNmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090139; c=relaxed/simple;
	bh=QizDTXvqjbBtCmUXn7PUSAsmsMC2qT5IcgGZHZ/CgUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q648i8pV71l1BNiC4kHfk+is8wXhPX3Uyp1AKlIfc9Zz5zuualXEf1PDMlPCE2KQJCDGS/FnxmbnhVqAo7J1mZ7p6Hi78gBGH5bhy21QB4ZuTnf9eQJnXi+luA2tYGYZZpLBMA6/qwDbe68fUBExvLF4zAxZlnPYfZjrDw7iCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN43AKKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43220C4CECD;
	Wed, 20 Nov 2024 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090138;
	bh=QizDTXvqjbBtCmUXn7PUSAsmsMC2qT5IcgGZHZ/CgUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SN43AKKvadsCBNddFXvFQxupeDFVL3qWSHJIScRnUHVuXqqo9Ho3GQ8G+aBrzwBSv
	 HSa1Mnsm8Pzx2frjaZoSXZTHD2MmxAHBveG6K1TQOAR4s34F61+3r7VYHsl5tYzT3e
	 0hh4lr75uT87HF5uZlsEZhxJZxECWH7YP8mgkX7aie1r+xFwypHItvCvVC+KBykych
	 63z9FBWq1f8n6YndF9xtxkYYac95JPST3wCNlTHlnrfirzDvrHTs7bbiIFciDyPeJD
	 wMRyIqkp2Ue6KMA76N4iMerz3PFXufczQSVJr31mNnB1vm25XGHQ3nxc4g7OAoS4F8
	 S7Zv8z5Ett88Q==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: delay sysctl_nr_open check in expand_files()
Date: Wed, 20 Nov 2024 09:08:50 +0100
Message-ID: <20241120-obstgarten-vorne-f918e84076e2@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241116064128.280870-1-mjguzik@gmail.com>
References: <20241116064128.280870-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=brauner@kernel.org; h=from:subject:message-id; bh=QizDTXvqjbBtCmUXn7PUSAsmsMC2qT5IcgGZHZ/CgUE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzhTp2j9b7VPoai6Xs7fmP39i4cC+wkswNKjrVMSGy 6fam7z9OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZif5OR4QWLTdrGLpa5SxZ3 7r6vl5p2Ssp28+rw6CcTmg9JbbOVXsLIsHiqtvhczpZNcrmL9lqrGVkd8DfZoz+vj99A5k/mipA tzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 07:41:28 +0100, Mateusz Guzik wrote:
> Suppose a thread sharing the table started a resize, while
> sysctl_nr_open got lowered to a value which prohibits it. This is still
> going to go through with and without the patch, which is fine.
> 
> Further suppose another thread shows up to do a matching expansion while
> resize_in_progress == true. It is going to error out since it performs
> the sysctl_nr_open check *before* finding out if there is an expansion
> in progress. But the aformentioned thread is going to succeded, so the
> error is spurious (and it would not happen if the thread showed up a
> little bit later).
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: delay sysctl_nr_open check in expand_files()
      https://git.kernel.org/vfs/vfs/c/bb35f8709172

