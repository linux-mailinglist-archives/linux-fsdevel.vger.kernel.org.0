Return-Path: <linux-fsdevel+bounces-12124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F085B64F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE92898F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3460EDE;
	Tue, 20 Feb 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeeiAhWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3A60ECA;
	Tue, 20 Feb 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419254; cv=none; b=ud4LuM5ZsmPN65+xCEdzLvWUA70SGLCsM79XoDThNvfPseG+s9bREcxwf+/RimYVQeD0W0a0TFlPYVZz6wU5AMhdQunqGkhB54UOftlqFB8j+AV8tnmB5wviMKIevvglFgdoGMYAP4GBNcOsd0CEAvEgdBXy2vJOhv3jibhQiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419254; c=relaxed/simple;
	bh=B6qD+njWAH/o7ZNCwh75UCFh4ZHfi8ezu7N8qDHMHw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+WA5RJ+oKWe8atNK6Qvz73nmRZ5bxmX9Tgb7YJarJ0SyRc4IDeo0I3iVGQiM7sgp7wBxiNrQonAJeerXLIyYNwRlJwn48j2tXKz51H0gISa4toaReOvnAXsU8ss+0N3V0f7/VtSVUQVI0RvCoMAP7e73twYDlsZgpQcMQ2Gudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeeiAhWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE6CC433F1;
	Tue, 20 Feb 2024 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708419254;
	bh=B6qD+njWAH/o7ZNCwh75UCFh4ZHfi8ezu7N8qDHMHw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeeiAhWyjcvwUk03TSAbocMadDU5HsYxS8+vtSeYC+fPbehwlourI3vJDZEnTICCy
	 QKAwXEzsZlPTh6yKmVHnpVrnjJl0xI+FgVSghN6izUPG3FMeblKWFilALK2ZF71a8y
	 WHNbHZ7lGx9zTu3HWdLOyrO5aQRc+oEHRmwILcF5+nA2VPbH2e+CYDpdYJ/IStxbLr
	 lRLNxCxkfnf7WOcM7k6wggrQ1fT2RRuBuFCXE7UCxwhG4jccixB4e0ocIP7eKcB+Rx
	 fB5v4G5cO8jJaSGxJegjV2s5jsuKj+lXfUaT958VskIrCXToK2L8sFgd2jzFH5/0dM
	 Jq/ybHqVcOXTw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] filelock: fix deadlock detection in POSIX locking
Date: Tue, 20 Feb 2024 09:54:05 +0100
Message-ID: <20240220-kundtat-abklopfen-214a31e5c522@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218-flsplit4-v1-1-26454fc090f2@kernel.org>
References: <20240218-flsplit4-v1-1-26454fc090f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=brauner@kernel.org; h=from:subject:message-id; bh=B6qD+njWAH/o7ZNCwh75UCFh4ZHfi8ezu7N8qDHMHw4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReyVj/YFkOw3Ujyw2zzs/XTVe8t8v6sJtwcNLy5O/mq W/V50umdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEU5zhN4v7pDLdU4tk101d vi2tLpvP4Z3m+m+m63afCfxmkBh7WYThr8Ah4ZU1wbU5bNMmLLm8bdbOspezzkfP3WZl++bN2hf NVxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 18 Feb 2024 08:33:28 -0500, Jeff Layton wrote:
> The FL_POSIX check in __locks_insert_block was inadvertantly broken
> recently and is now inserting only OFD locks instead of only legacy
> POSIX locks.
> 
> This breaks deadlock detection in POSIX locks, and may also be the root
> cause of a performance regression noted by the kernel test robot.
> Restore the proper sense of the test.
> 
> [...]

Applied to the vfs.file branch of the vfs/vfs.git tree.
Patches in the vfs.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.file

[1/1] filelock: fix deadlock detection in POSIX locking
      https://git.kernel.org/vfs/vfs/c/14786d949a3b

