Return-Path: <linux-fsdevel+bounces-33061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DF9B3036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147E01C20AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC931DA614;
	Mon, 28 Oct 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOSHXXAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734771D934B;
	Mon, 28 Oct 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118453; cv=none; b=YVZqgiqRHxrfFRmIsXsAxSosTAHjjkF7ryAeH8qjtR90GAp3Ot+UXQ+Co1a7zYDy/PKiXBkW3r/mW11PNbOpjq/RPucVTm8mWklY0yn9/2O5FvSPYW48J7d0t7ucIzLVGiYOCP+F5aLRP+Lcq0MY4vFw/4GK13WMG97xvU7CC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118453; c=relaxed/simple;
	bh=dBjKbQ72OiI43nKphYScHzSn1tB9+kybe2uOdPkKmfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSBmDG+2HdQmwQ2bppGfWOST9Iqy9hWtahu58E+ehTOUGHT3tRICJ4bWXOKz07enHV2oaqZoTfjG+E9hEPXZIOaAhOOVMGc0GZd9EN1jdRWDnNtD+8PSpUSEvRx+oyNPb4dkJs/udpzrQik0BiMoKskeXmidm9FTxA254zNv6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOSHXXAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37D2C4CEC3;
	Mon, 28 Oct 2024 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730118452;
	bh=dBjKbQ72OiI43nKphYScHzSn1tB9+kybe2uOdPkKmfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOSHXXADjGIBHyQ2Iftg3bbghvOAJhq4EiqJMrhlWca7rTdICjxerGGqjybHz8Qbc
	 1qq4wiHrRsAx7igB0qYo6Fqnnd4v2M9lfSoJiAEGsptqUmxJ3sPaIMsxPQFCXqFOFL
	 G+8gnI756fFPrU5ye1iVoLnZitTPARuyPmAm5Zr5zW9eEIWd87YAkF5UWbkl8dzTD2
	 Uyg1eVjUX/UcLLTT43Tpkx9dTMBwIE6R8L9X9vh1BDbi0Yg/K36rlQ2o1QGqS89eCT
	 w666gTjX8lDiJQgsvbQmQAEqb5SeAZ7EXAbq3j/7n7enXbhgYmzw0IOiEXpI0DWbHu
	 erUXacxTtG8bQ==
From: Christian Brauner <brauner@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christian Brauner <brauner@kernel.org>,
	cgroups@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	willy@infradead.org,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	akpm@linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a folio
Date: Mon, 28 Oct 2024 13:27:12 +0100
Message-ID: <20241028-jazzclub-kulant-81ce918f186d@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926140121.203821-1-kernel@pankajraghav.com>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org; h=from:subject:message-id; bh=dBjKbQ72OiI43nKphYScHzSn1tB9+kybe2uOdPkKmfk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTLN2uu+DzdfEnhecaTkubfhQ409WjqduxOmMF7KdigI N+yyLeio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCI68xn+WZ87u07/2LedTZON LEs8muedMzWVfFfzOC1n1XFJ7/Ypcgz//bxEjzupHb2h6ccRwHzg3uLVWQlS/A75P0Ptmaw/fzr GBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 16:01:21 +0200, Pankaj Raghav (Samsung) wrote:
> Most of the callers of wbc_account_cgroup_owner() are converting a folio
> to page before calling the function. wbc_account_cgroup_owner() is
> converting the page back to a folio to call mem_cgroup_css_from_folio().
> 
> Convert wbc_account_cgroup_owner() to take a folio instead of a page,
> and convert all callers to pass a folio directly except f2fs.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/writeback: convert wbc_account_cgroup_owner to take a folio
      https://git.kernel.org/vfs/vfs/c/30dac24e14b5

