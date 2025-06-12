Return-Path: <linux-fsdevel+bounces-51452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9CAD7058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0551BC70EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B89423BF91;
	Thu, 12 Jun 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5AWqYnd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A052343C2;
	Thu, 12 Jun 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731143; cv=none; b=h+TMM97kchjmhtW63jhNpgXy6tJRGCNbNz/AYk24SGxkQyZuQVZdqJN3hi1+kwgrWyXSCOVc0mvQ8e2adHNk9h7XqIzM/bAaj8xraw5b5lDiaylMfu8Cx5RRlONbxUT/USdK+XhKBBVms+Ql9uUzazi5xi63ZUZWP9jgNYuVzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731143; c=relaxed/simple;
	bh=fhxt9KDDMfu8DAvllcGY/h6Qfloebu1ce3iX49ytBC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzPrvaK6LXZRtx6YFdkI1b/SGGWIdzgtP50izpylG4Juk9I5S3phkZWLKpZzwWZa+r2odjVLEo/8u0glLS37P+Ms9RXNztE9YVqctyhj/ojFz458XtDfW1i8kvjkYqmFwr70mggC4UPm3lsCYmBWfY+YJVc1jlfTHhWLfI6TJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5AWqYnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431BFC4CEEA;
	Thu, 12 Jun 2025 12:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731142;
	bh=fhxt9KDDMfu8DAvllcGY/h6Qfloebu1ce3iX49ytBC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5AWqYnd4Lz2uSy72ZQLNwgIZGWbCZsk5y7BKZ1V8gjb99m8X29JhwlqVFgHphcYY
	 AjMJDn4CTHz95C2YVXFVJlOLZjK39wTlQylziiWnIZkUoPm4WnZ6uvmShg4VsvP2mX
	 RB/K9LdysWh7M9vOCXIuGToqaUiaEv1mWzmsO54EGm3+Agf8d2rUpAqwyemmtdPUeQ
	 8GSO54Ias6c/zSK7ez8ccqmox+sz1zekZwM+fWS6Jtr56bcNDv0Jkvyi3dd9nL1Di/
	 oKzP4a8uh5SLICrhaHP2b7AlrqAQrxYGXDzRvAqaAPvgs1j1c4YcOWWXXdwE2vxNhz
	 qvRYJE0QgQ0hA==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH] ovl: fix debug print in case of mkdir error
Date: Thu, 12 Jun 2025 14:25:35 +0200
Message-ID: <20250612-musisch-gattung-7ae7cac68257@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250612072245.2825938-1-amir73il@gmail.com>
References: <20250612072245.2825938-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=brauner@kernel.org; h=from:subject:message-id; bh=fhxt9KDDMfu8DAvllcGY/h6Qfloebu1ce3iX49ytBC0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4HXcoWBX9wOtQ8bzj+9YtPGk3e8XNRoVZjy8+27LC2 88qQ/oQY0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBELkcwMiw7Vdh15mP2+aAS lmWBL3zLlonNOBLw6qMj15GE5p08rL8Z/lcVWMV6reWpS+Y/qJIzjYv9u2Cj3YPvB4wLKoS2/48 1YwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 12 Jun 2025 09:22:45 +0200, Amir Goldstein wrote:
> We want to print the name in case of mkdir failure and now we will
> get a cryptic (efault) as name.
> 
> 

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

[1/1] ovl: fix debug print in case of mkdir error
      https://git.kernel.org/vfs/vfs/c/527c88d8390d

