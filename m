Return-Path: <linux-fsdevel+bounces-46262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A08A85FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E430178DD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678E1F0E44;
	Fri, 11 Apr 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp7E9eCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2C1F0E32;
	Fri, 11 Apr 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380173; cv=none; b=mPTbc1sbM6ilDCqt0h0hMgMlg7vtBgRm6TaN8aB7D/Tuj3DaZfbwWSKF0ltFSsTC3zvvM6t+LiMQZ5omLFDw5VkfV3zQPdbQ/8ZDMF3hlW/B8vkfP+6x4sbU3LASP8lSkhK5CNNyuSOuK++9uEqnEVn5S0WJezRitMvdHy2BOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380173; c=relaxed/simple;
	bh=L028CyjHdE2jxczbIM6pBy9pM8llSElkIkRS2OiXwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qpr08Ei8vSCPdgyIrX+37Zaf2VnfKDLAW6dArrQzHE7qte+XO9vs34egf6rTMpTTECbNIRPk51zveVjddqFzWFVbp2BxdBxFWVmF3Hcdb6PVzT18P1aRCzWwEwYCgHBXUvVnFJGzd2bytkunSz4QSxGNan2qglGs4ntcR6C7ebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp7E9eCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848DEC4CEE7;
	Fri, 11 Apr 2025 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380172;
	bh=L028CyjHdE2jxczbIM6pBy9pM8llSElkIkRS2OiXwDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pp7E9eCgI9DFYb5sLbeeMuVNF457lPAOtI0tZDKWJsevrSA/kg5avoarhIqKUl0or
	 4EsbDFP1tEYXc8tRRzc6VkVOAxG53WXcfgunBVz9jOshAk8A8lZmz2dNp4Pfgtk7XQ
	 PacQnSFcNwImN07bw4o5OubUTOLSR/oeEaoMwAGoOaboOB5K9M2cXPsxGUcnjE5dTJ
	 Nn/JnId6zL717stJSLpO6xDKcflGYOljRDQcAMvyZ/CFqShK1JCTOTwQgseB2OQsoN
	 Bvlz+Zpe23oJpTPS0hbXSFXOU0d+/EdakMbV5z69ltll3eXxeFr6nf+8K68xZP8ko2
	 +saTpy3nZCgVQ==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	hch@infradead.org,
	Gou Hao <gouhao@uniontech.com>
Cc: Christian Brauner <brauner@kernel.org>,
	gouhaojake@163.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	wangyuli@uniontech.com
Subject: Re: [PATCH V3] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Fri, 11 Apr 2025 16:02:44 +0200
Message-ID: <20250411-ermorden-sagenhaft-dea43a3c41f9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410071236.16017-1-gouhao@uniontech.com>
References: <20250408172924.9349-1-gouhao@uniontech.com> <20250410071236.16017-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=brauner@kernel.org; h=from:subject:message-id; bh=L028CyjHdE2jxczbIM6pBy9pM8llSElkIkRS2OiXwDc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VGQ5d/6RNrMYY6o774XS86cvit0S+1v26chxL/8f+ +8Z1slwdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEup+RYckPh1zRewnhj9eK ypwJFSly43/zPf3SyyXlX3YZ+m8oKGZkOJHK+sfbpsZGd1J8j030rqK1H1rv3Vy6a6eZiqmrUog ZBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 15:12:36 +0800, Gou Hao wrote:
> In iomap_adjust_read_range, i is either the first !uptodate block, or it
> is past last for the second loop looking for trailing uptodate blocks.
> Assuming there's no overflow (there's no combination of huge folios and
> tiny blksize) then yeah, there is no point in retesting that the same
> block pointed to by i is uptodate since we hold the folio lock so nobody
> else could have set it uptodate.
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

[1/1] iomap: skip unnecessary ifs_block_is_uptodate check
      https://git.kernel.org/vfs/vfs/c/8e3c15ee0d29

