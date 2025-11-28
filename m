Return-Path: <linux-fsdevel+bounces-70123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB75C916FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650BC3A5F61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BA30217A;
	Fri, 28 Nov 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYCa9AmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF52DE6FE;
	Fri, 28 Nov 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322023; cv=none; b=cs+vxppADwZDTQJLAqk27wHE/P2HFpOb7fJ26lvLWh0CsOAdjVw+ogbbzcowE2MXjgfDZp5RUfUhx09qvdp3eq3VAXrFIwyy51+yLahF5n5xGKfbGYeOxgIj8rrc1aA/IeV4JI7Yfty1fMoxT+jLUrYtCRHLPPmdMVPjCohA0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322023; c=relaxed/simple;
	bh=AlY3X2T1PfR8V1LW9CYSCdvNieV/rNZFyZ8VO9Y0fgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSdHwKkfaTvCt3VTyRlKcxbgjldN4tiQ6Lffzrc2o+rqHA3yGqB4A2/xiFT8RICujOd1y8Yd/ZdakRh+Od1YKqauzdQOClRj0Wd42cn4klfLiG6ZSJALokulXjIYfV2bGAw6FGW/bvI15g67trn9+zKjTBY47myC1vcVyD5jRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYCa9AmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE733C4CEF1;
	Fri, 28 Nov 2025 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764322022;
	bh=AlY3X2T1PfR8V1LW9CYSCdvNieV/rNZFyZ8VO9Y0fgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYCa9AmTVDfKb1hnavOKQvUhethpJbzwGYqhDbb7j9Wrb7oLzZvOhDYRrPeYxQYhu
	 Kmoc+0ahiB+dqcejyoSzOLwhV4LHqhNZt6oaj0zpDbAu0qzjCDnmU59VhzBADFv89c
	 LQF1AWxWv2Z+wzmf3VJk77tFAkMaGOlxWfdnHLJRMUcOrt0tnqdxrcYZLdIKHNY1VZ
	 TCtCFAMmHsmanP+CzlT+ISk0Qq4t4eF/VvShd6XWfcgOerthy0y0VuITLSvBAUCPct
	 T051wGx4ZG9ezWcPtUOJ3+Q0RuCd09QopotBRbwRRXXxHDUtF/7HuLkT7nVPntyC/4
	 op3cuSRpV6stw==
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+94048264da5715c251f9@syzkaller.appspotmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] fs/namespace: fix mntput of ERR_PTR in fsmount error path
Date: Fri, 28 Nov 2025 10:26:35 +0100
Message-ID: <20251128-leitfaden-aufpassen-c0ecf32c1020@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128035149.392402-1-kartikey406@gmail.com>
References: <20251128035149.392402-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org; h=from:subject:message-id; bh=AlY3X2T1PfR8V1LW9CYSCdvNieV/rNZFyZ8VO9Y0fgo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqZj20vB8iffKbTfQ+JqWfLhOXuFl4H1k6ubzYSOaPY mKAS7pcRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES4uxn+R30pFLeaEXNd4o/k jndpdV36O6VXJnhZ6a/SupJgm5ZeyPC/LpPLSPTI9B1tz7aG719Rs+LpVY3znX909r2Y5S88ecl XBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Nov 2025 09:21:48 +0530, Deepanshu Kartikey wrote:
> When vfs_create_mount() fails and returns an error pointer, the
> __free(path_put) cleanup attribute causes path_put() to be called
> on the error pointer, which then calls mntput() on an invalid
> pointer value (e.g., -ENOENT = 0xfffffffffffffff4).
> 
> This results in a general protection fault in mntput() when KASAN
> tries to check the shadow memory for the near-null address computed
> from the error pointer offset.
> 
> [...]

Thanks! Heavily rewritten but I retained your authorship.

---

Applied to the vfs-6.19.fd_prepare branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.fd_prepare branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.fd_prepare

[1/1] fs/namespace: fix mntput of ERR_PTR in fsmount error path
      https://git.kernel.org/vfs/vfs/c/721ebc9c4a95

