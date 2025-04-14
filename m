Return-Path: <linux-fsdevel+bounces-46352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348DA87D1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E7F188FF04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F5269B0E;
	Mon, 14 Apr 2025 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZV95Tyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0E2698BE;
	Mon, 14 Apr 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625349; cv=none; b=TRH69vBlN5mVcMkbKnLuwGr0xi5bUZSy2bOo6wKNH6IZ66HG1jXYposcenlo/ah01SY9LGBMlditEftI4ndm5w+bAXcWfbsL6jqiQFeHO1kpsuSEHAPrcfJbAgX7+/vvJwE5lA+u/fu+Z9WR1pWj0V1Aau6XwSiFySnkd1ZY4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625349; c=relaxed/simple;
	bh=iYgJGM+ELKUPOGb8b/QLqMww9EWRkl/iutAxpaWye3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEANP23gW4/2bd2YX3f6vmXk3H4UdyBWgy3apz2J8pKNH6X9Kqc/XdxjGOHIL92NSOzyNYW4SnuSQd0/chS9MtH0wBTl4B6Px6kUAbUWkVyXpx61C4z/j+lMXg8giY86tS1vDSvcdn8Q7zN3hoNdfWoNeDwbB35J3YrMgChXSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZV95Tyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5644C4CEE2;
	Mon, 14 Apr 2025 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625348;
	bh=iYgJGM+ELKUPOGb8b/QLqMww9EWRkl/iutAxpaWye3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZV95TyxUu7Qtbh9b/1T22ep35nRHWVScOeX6QfmgePQyCmWbkIKM62eiNhNOfNcK
	 nIu1LU/7wyJwfuc21s7WpxIPGcf3uBsZtpbtlhKk+jBeHpZG4k2CyPk2GPObCfKNwB
	 78F8D8fiQr5so+rhURnVrH9Pylo8WQbKTDaH1AkbzbfZlKVAQCGVGKVbwwodBOHRIb
	 2jI8nEuBPs+to99k06hX12Ya5Art7PnAuBDNDPr7L9Z9euvHJBEvDmprlEnYkW2Z6l
	 8pPKIxc3Gvzyq2MedTHYiGmm6nD213/nuMibPYfLJYEWaI13Ccu/uVuqo2uO83wY+p
	 C4UOu4hY/66BQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: improve codegen in link_path_walk()
Date: Mon, 14 Apr 2025 12:09:02 +0200
Message-ID: <20250414-gezollt-bareinlage-890370cd835b@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250412110935.2267703-1-mjguzik@gmail.com>
References: <20250412110935.2267703-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=brauner@kernel.org; h=from:subject:message-id; bh=iYgJGM+ELKUPOGb8b/QLqMww9EWRkl/iutAxpaWye3k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/ubc/YNdU5nc1busF9xzwswhxDvn1X2r6wvtlZmfau NaKHwpY11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARMVZGhl3c39LmO9TPMhE+ 8v3vzZd7fJ5OmpB6IjpW5qRh/t8jpa0M/91nVj68O239gsm76nz2xk3RZHqo8yF59wqJ6RaPRMo VVvAAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 12 Apr 2025 13:09:35 +0200, Mateusz Guzik wrote:
> Looking at the asm produced by gcc 13.3 for x86-64:
> 1. may_lookup() usage was not optimized for succeeding, despite the
>    routine being inlined and rightfully starting with likely(!err)
> 2. the compiler assumed the path will have an indefinite amount of
>    slashes to skip, after which the result will be an empty name
> 
> As such:
> 1. predict may_lookup() succeeding
> 2. check for one slash, no explicit predicts. do roll forward with
>    skipping more slashes while predicting there is only one
> 3. predict the path to find was not a mere slash
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fs: improve codegen in link_path_walk()
      https://git.kernel.org/vfs/vfs/c/80cf41f567f5

