Return-Path: <linux-fsdevel+bounces-23736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AEB932132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17C92821DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438262B9DE;
	Tue, 16 Jul 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptlHl7ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6374C7B;
	Tue, 16 Jul 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114933; cv=none; b=e8IgO0uPtWfZKxNUlhLUbrjLm1PRYd3h+G5ilhpnTbbRhID4cMFRT8LuqfZwo+ZK27AaUMxvCXNaI7cByWZzCT0sw8sjBEAt5hEEfWbFmMp/r+5wqKc22/WOdOD0JhCSggfkbHMEDLgV5M7zBfmmPkYFfftl39IurqHsDhAC4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114933; c=relaxed/simple;
	bh=UAzx36SH0wPhjQ7qhoNQCI+0LWVSDG33NTmQZeA18Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c30bxyP/HNMs7nik4yHpEXxjOgmEmIcsyDrFGhaVs8AHAfsYUaE4RZ6iRgPuP+ABwiGPR+lI7LRHTXpPIWn8TCZnRiT9Bx7Zp+eQaw868N66ZXato5HXpIxyBv+7FjcYoxY0GO+52mISx13XoY3nD6F8+w1KnCZhKJi+jlO26V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptlHl7ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56D2C116B1;
	Tue, 16 Jul 2024 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721114933;
	bh=UAzx36SH0wPhjQ7qhoNQCI+0LWVSDG33NTmQZeA18Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptlHl7kahu5keqDU2790FlrXYD0BOTtQ7TbQTwB0PxrNCH3e2rtOeGoRJBfMM4CBg
	 519c/LdG6Y2E/JHLYPO4PP1BgQldPJnldNp3DJjw0h368UjKIJza7R28viaFjP1tGB
	 Pm0G4S7vNmVJ0lkHhe6XIzDFK19ox93KqGN6bsx6kT3RqZqKLzQGnfCGz7xG+/fGux
	 zs6yVLKWiOmm+LEC58Fog6f1pZ+yd2kxjIu3kbcG1juqQBXlvgCMo0RL6jAKcmdIKc
	 VS3Ie4LqQWhHei/TDurhIHawgSnmt9P3tc6mwBIgsr0MOeVEmdr9V14I0HfOGakzHq
	 J2Wo5UgRs7swg==
From: Christian Brauner <brauner@kernel.org>
To: syzkaller-bugs@googlegroups.com,
	syzbot+a3e82ae343b26b4d2335@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>
Cc: akpm@linux-foundation.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH] nsfs: use cleanup guard
Date: Tue, 16 Jul 2024 09:28:44 +0200
Message-ID: <20240716-unsterblich-ausnutzen-7c57cce852e4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716-elixier-fliesen-1ab342151a61@brauner>
References: <20240715205140.c260410215836e753a44b5e9@linux-foundation.org>, <00000000000069b4ee061d5334e4@google.com> <20240716-elixier-fliesen-1ab342151a61@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=brauner@kernel.org; h=from:subject:message-id; bh=UAzx36SH0wPhjQ7qhoNQCI+0LWVSDG33NTmQZeA18Vk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNU9Qr87DwVuex/m/sv6drj4VD82MpYbee/Atyp4q6U xNVbRM6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJqJ4iOF/4eHZ/kHvWE63JHA1 fvjyJmplCMfZ81f8D1vNi+Sz2XRPnZFh75zS+VXNi9vy8i5bnWx226wltCVqxYbPQj0fcnIT7P3 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 09:19:11 +0200, Christian Brauner wrote:
> Ensure that rcu read lock is given up before returning.
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

[1/1] nsfs: use cleanup guard
      https://git.kernel.org/vfs/vfs/c/0052b241e3e5

