Return-Path: <linux-fsdevel+bounces-55415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13EB09EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455CF3A863D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3E295D95;
	Fri, 18 Jul 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry2CK0u5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446729345E;
	Fri, 18 Jul 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829890; cv=none; b=FSlDGovdlTrkGM2VrM8QpZgCsKTu/obHr8AlLb3XDmxV9lHaht8oL+6DDxKhts1GdgKgB5PYzTF8zrd+f7tG2PldXiW/obyvd6Nz0KXYDN/C6CkzKCejKo7WevC00lvl15P42TPclfBAFuNilHjNQWyWjmM/ub+WDOuH+Gno0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829890; c=relaxed/simple;
	bh=MbCdnea9ZJyq6fhP0c/zVlePTXr7pc5/kKRdCAy0I6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsjJj2Ix1bjKI6K9GlztlNG6XgdAeQaO78ioeN2Bt2ONw/Re5pakvrIAf8XE9hG0Wh4WS004yIOzDfJd+HdJ9WahTTpgKLyYCxAxLwapD1QgE3VbuGkTIHro+RCQ+VsX9DXSObx1zvj70hfh9M65TmwhiKtEiBtPZWpcF7EF4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry2CK0u5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087DBC4CEEB;
	Fri, 18 Jul 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752829889;
	bh=MbCdnea9ZJyq6fhP0c/zVlePTXr7pc5/kKRdCAy0I6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ry2CK0u53wG5ldih4cSB0LgXH6k94lU8ydkgE/npWdfSZaKoJsvYukupsHz6mnooX
	 xPHGxwDdqjqXWNOpyJWF97VZpMwrcQStbnjijsz4pFB1eC/4tb+6q8BNODdC5JILF2
	 aM6g6SdncxwmLwTdyIhiKl9OaKSnxSgU7xnIRjQjJ5chJye1Q4WjZpJduUwgNCP4lF
	 lEnZj8kG/Y8ifaiaXljWTSuc1LyyVgA9tKdGSTGR/RlNhuJuCkKW/Pcl/qXZBF8ExC
	 ji0eSmkKrLegEDputyHT8nWrGT+/49YiMqeqxSK/SFuOZUXzc2dm6RvAHE5lytEyBD
	 7qsxL7X7QY7aA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
Date: Fri, 18 Jul 2025 11:11:18 +0200
Message-ID: <20250718-querverbindung-knieoperation-40867cf9097f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3337; i=brauner@kernel.org; h=from:subject:message-id; bh=MbCdnea9ZJyq6fhP0c/zVlePTXr7pc5/kKRdCAy0I6k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRU8e8RXGh83i6hU431z/MNh85/2WKn/nLFor2FhV4na zao79r1qaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiaZ2MDDtK9Z/6be429upd MbXuck7u5Ene3um3Zzg4eR86u+pEVy4jw6Y3f5as77Nrkt5hmtfZpyC1lf1HtKrk/3/bzh1MMTJ TYAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 10:44:11 +1000, NeilBrown wrote:
> More excellent review feedback - more patches :-)
> 
> I've chosen to use ovl_parent_lock() here as a temporary and leave the
> debate over naming for the VFS version of the function until all the new
> names are introduced later.
> 
> 
> [...]

Applied to the vfs-6.17.file branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.file

[01/21] ovl: simplify an error path in ovl_copy_up_workdir()
        https://git.kernel.org/vfs/vfs/c/9d23967b18c6
[02/21] ovl: change ovl_create_index() to take dir locks
        https://git.kernel.org/vfs/vfs/c/c4f8f862b31c
[03/21] ovl: Call ovl_create_temp() without lock held.
        https://git.kernel.org/vfs/vfs/c/d2c995581c7c
[04/21] ovl: narrow the locked region in ovl_copy_up_workdir()
        https://git.kernel.org/vfs/vfs/c/a735bdf0b785
[05/21] ovl: narrow locking in ovl_create_upper()
        https://git.kernel.org/vfs/vfs/c/a07052e07b67
[06/21] ovl: narrow locking in ovl_clear_empty()
        https://git.kernel.org/vfs/vfs/c/4f622bd9f3e5
[07/21] ovl: narrow locking in ovl_create_over_whiteout()
        https://git.kernel.org/vfs/vfs/c/e460bc4d012c
[08/21] ovl: simplify gotos in ovl_rename()
        https://git.kernel.org/vfs/vfs/c/76342c9eb8e2
[09/21] ovl: narrow locking in ovl_rename()
        https://git.kernel.org/vfs/vfs/c/05468498cd2f
[10/21] ovl: narrow locking in ovl_cleanup_whiteouts()
        https://git.kernel.org/vfs/vfs/c/7dfb0722ad07
[11/21] ovl: narrow locking in ovl_cleanup_index()
        https://git.kernel.org/vfs/vfs/c/8290fb412d2f
[12/21] ovl: narrow locking in ovl_workdir_create()
        https://git.kernel.org/vfs/vfs/c/61eb7fec9e79
[13/21] ovl: narrow locking in ovl_indexdir_cleanup()
        https://git.kernel.org/vfs/vfs/c/d56c6feb69cb
[14/21] ovl: narrow locking in ovl_workdir_cleanup_recurse()
        https://git.kernel.org/vfs/vfs/c/a45ee87ded78
[15/21] ovl: change ovl_workdir_cleanup() to take dir lock as needed.
        https://git.kernel.org/vfs/vfs/c/241062ae5d87
[16/21] ovl: narrow locking on ovl_remove_and_whiteout()
        https://git.kernel.org/vfs/vfs/c/c69566b1d11d
[17/21] ovl: change ovl_cleanup_and_whiteout() to take rename lock as needed
        https://git.kernel.org/vfs/vfs/c/2fa14cf2dca1
[18/21] ovl: narrow locking in ovl_whiteout()
        https://git.kernel.org/vfs/vfs/c/8afa0a736713
[19/21] ovl: narrow locking in ovl_check_rename_whiteout()
        https://git.kernel.org/vfs/vfs/c/09d56cc88c24
[20/21] ovl: change ovl_create_real() to receive dentry parent
        https://git.kernel.org/vfs/vfs/c/ee37c3cfc5df
[21/21] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
        https://git.kernel.org/vfs/vfs/c/fe4d3360f9cb

