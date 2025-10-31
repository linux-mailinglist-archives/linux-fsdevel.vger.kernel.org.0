Return-Path: <linux-fsdevel+bounces-66581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD62C24F4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42621A6210B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9C272E45;
	Fri, 31 Oct 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU7yhMST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E918B0F;
	Fri, 31 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913055; cv=none; b=oOsiVXVlRk8rZOJAztU1o8EanfsqVprbcyQdX9jSfMjLfqiqq9X5wT+QDMFMXz5EZDXcaj+m7JVV60vJSfcv4y74/nj984zgpPvzUnCtgqgGXF2JwkHEqi2xLt0S7eRMSn94ROrZpqK0uDpUIcy/3iMGddgzmGH3MOBLsCF8YvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913055; c=relaxed/simple;
	bh=PV4plpBGvn3ySVNYP8sVJMuvqxynaDfi65OYBZcuFAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDGnojHESFRv7rhudDBBd6Qe9THxaO2hvQndgmvw1Gg9MvhrdnQI2B6ApHzJMQysuX70o4TGVEGuQLFXwDlYMo44Z03mre3CbhjVgTvi+62bBSrQuimJXsLG6OUrU+KQG02BSStXtJcbGZX8nqwppQt6Q02S9nKwgGzG2+f2EiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU7yhMST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3CC4CEE7;
	Fri, 31 Oct 2025 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913054;
	bh=PV4plpBGvn3ySVNYP8sVJMuvqxynaDfi65OYBZcuFAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AU7yhMSTBAVXAJwe55CqU3D+Qq1L53m8rGCH1+bemEy68qjNIhKtUcPMUEDRHvxsz
	 UcaAD1GZk1PWYYhlakg824nl3N+QjMR8zgcAtyq0zry4jwE7oMaw/i+1F62vajlxcV
	 2Rr7Vaju9Gv5gatvpLDOY5AhFBkuK6tQtX5vAPE+rF3SeAY1l4OPjgc8lhXlZqO9bb
	 G8fZKqzzvKMLHIZIgPrFiSeibIKAzfCaJvHrUpQw+O66kCHD8/FQHh+yYX4bypXMQM
	 lb+6X3nLv1waXfwcw42iLEhOTVLlph3G53kTHlkMRQGNF47Ne4bokzx10sdfIM6kym
	 4c3Bvzl9LDTRw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: push list presence check into inode_io_list_del()
Date: Fri, 31 Oct 2025 13:17:27 +0100
Message-ID: <20251031-brombeeren-gelee-7fe1553b6b5d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029131428.654761-1-mjguzik@gmail.com>
References: <20251029131428.654761-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=brauner@kernel.org; h=from:subject:message-id; bh=PV4plpBGvn3ySVNYP8sVJMuvqxynaDfi65OYBZcuFAw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyrLiRtVD4RsK/c78Oak20XGi74to3C9s3isXzGuZeq BeRuF/V3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnyaMDJ9269y8p3N/U3EO q8S+zzlmbWsM9nkyrDMpaK1UEL91Tp3hf1UHy/+dKtVLFl+cenX66z5vbv8Vgiqbrtze9SeslJF 9AR8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Oct 2025 14:14:27 +0100, Mateusz Guzik wrote:
> For consistency with sb routines.
> 
> 

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/2] fs: push list presence check into inode_io_list_del()
      https://git.kernel.org/vfs/vfs/c/7ba2ca3d17bb
[2/2] fs: cosmetic fixes to lru handling
      https://git.kernel.org/vfs/vfs/c/7e42cf8f61bb

