Return-Path: <linux-fsdevel+bounces-51715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C8EADAA24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939033A82D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047FC2144A3;
	Mon, 16 Jun 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOVcITC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AA1F0E2F;
	Mon, 16 Jun 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060791; cv=none; b=iGD6RQyuN02hvoGXX6SufjX3BbcZDGAWUeMExCPDWM5IzJdO8OdaqSLPupsO5K+wyXU1zMOKPj0FI6BkXHF9UpJpyChTnqjAWQunMXx55zWsiujfjZah4Ol9dOpDzIFvsjn46/uRvaG9iu9/VksSoneG8/GsIIptygCKVEwJWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060791; c=relaxed/simple;
	bh=M3kirMB7I0PslYpcYITprtiGrb3XS15fDjXTKOawV4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlMkKOkQPDw54d+Kc0VYmFkWlCa9VB6fgzV5GXa/LdlfIRv3iLiMneUEfdrwh1AScmwTdogPFcYaNDiK/v7cpy+m8Mw35s4fdWkpz85LuVEivrMoRIMyhGwP0g1OwvqlCV7w4NUraOQDaamtMY/AEa0kTFEhgoChrzqQvpBKmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOVcITC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FBCC4CEEA;
	Mon, 16 Jun 2025 07:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750060790;
	bh=M3kirMB7I0PslYpcYITprtiGrb3XS15fDjXTKOawV4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOVcITC3IPfmG2wgtHqZpSiFBYi6jqGqSOzNeoH9vfkSmo5kvKx4FoP3Bt3TVo4f3
	 pBjVjs51cBw3wFGszj9ozgzBgx5oItB89616pE1op+KOHFWEDy2OlSZCfoBLkO6oQV
	 TCQjxj1GqPswCC5RkYxuy2cPFOgHh9VDhN7IrZVrF3HpCmPhwm4gmAgVkxbrgp7p6G
	 qWLZEqHvWmFGk4+Ik0bDFYK1ifXEMh/6sE2ebTl6uen5NcERNT3kda4vZgniVCoTde
	 k4L+NK07M9i/Br2ELNClsTfrtNIsHoU8uAtBGH7oc7TBjU8HXmdTGM335V60Uzxq4E
	 iv2tdKZvumacg==
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] fs: drop assert in file_seek_cur_needs_f_lock
Date: Mon, 16 Jun 2025 09:59:37 +0200
Message-ID: <20250616-entflammen-braten-00f78640ddce@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250613101111.17716-1-luis@igalia.com>
References: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com> <20250613101111.17716-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=brauner@kernel.org; h=from:subject:message-id; bh=M3kirMB7I0PslYpcYITprtiGrb3XS15fDjXTKOawV4M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT4n/t4cvXZUreskAUSR3c9z7cxDPjidU2z+qPJ3J+P1 E7vUPlxs6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiD7cw/Hf0dbJfwle6psXq 1s7eU/X9B3P8ns2zDZ1982vpjt+/21cz/I+ZPJGTve5ycczGaRIX30fvsPjiO6PElMl7s295bmH oRAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 11:11:11 +0100, Luis Henriques wrote:
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because there are many users of vfs_llseek() (such as overlayfs)
> that do their custom locking around llseek instead of relying on
> fdget_pos(). Just drop the overzealous assertion.
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

[1/1] fs: drop assert in file_seek_cur_needs_f_lock
      https://git.kernel.org/vfs/vfs/c/dd2d6b7f6f51

