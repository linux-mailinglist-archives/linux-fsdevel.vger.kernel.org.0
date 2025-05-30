Return-Path: <linux-fsdevel+bounces-50136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FCAC87B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A277ABCB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A471E833F;
	Fri, 30 May 2025 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reOMA4aC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7D1459F6;
	Fri, 30 May 2025 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581824; cv=none; b=tv7O0QEtbLZ9eIjN5GYbXNpldGpoEQWOw2jgYymXrkY7elZhn7g3Skxf32yIP1VzzwTV6KCCXWum35sk3yZ0AUo3l6NvMjJSTEbkjvvLsP4Byj+NSSmJVxUFLVc4m8HZzWHLbF63iJDrjsS5/pj/jI9O7UFHORCGsMcQ2Jz1gkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581824; c=relaxed/simple;
	bh=4RT5vsz1LOvei+MoRVu8Z59r6E8Fw2khz3RGvLjrUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfFK9fOKdBwPFhimZCqoClXZgbbimBSMJ3ccyNYKAI02ZT7+Lv4A2qJ2sWyybPNyZeUUd16NAb22gY4fBt7Nw0TmyBRIlJyY6wHsD6kl6i5IWlxCsoswc0M/wjFJDM5K4mtsnzmmAaY0395PJFXGIs+L7745GUkgfzPuwLJoYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reOMA4aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D38C4CEE9;
	Fri, 30 May 2025 05:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748581823;
	bh=4RT5vsz1LOvei+MoRVu8Z59r6E8Fw2khz3RGvLjrUwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reOMA4aCTAiEV/Fst6bkVn5X9CcvVOD/PyvgtkLLZWqcyJUDySM0iO8RGoVdw8W8B
	 7V22ihRvBw/aIDnLofWbsoe0AQesgFyNb3l6gZlsQQkFsOzikARtH5LdzPgj6Wdz7z
	 cYjacp85XI1jWWcqs/sZxkcwXBsYP1dubo/a+jiz6+aeVExj4p29DvePinKbBRDh/6
	 YA+2bKO7vmaaIVu0tTPKo/5A3BYq4+SxbI6JpLnKvKe29EHxzG76P9jIpZBhe6op1E
	 3wXSMm7tnkwxsKpkLcBRopqJTXrmh3kmTDZodUiyHca+UM1ev5jdyfpBAY4xRSYQAu
	 1Q/8ZUKv2xWyA==
From: Christian Brauner <brauner@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Ted Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	dan.j.williams@intel.com,
	willy@infradead.org
Subject: Re: [PATCH] fs/dax: Fix "don't skip locked entries when scanning entries"
Date: Fri, 30 May 2025 07:10:08 +0200
Message-ID: <20250530-gekreische-rauben-91838ad7cb45@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250523043749.1460780-1-apopple@nvidia.com>
References: <20250523043749.1460780-1-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=brauner@kernel.org; h=from:subject:message-id; bh=4RT5vsz1LOvei+MoRVu8Z59r6E8Fw2khz3RGvLjrUwY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRY2m5/63/620FjlXOpTx6p73O4tSN15czPPycmKTdeN ZvqtlXUrKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi3lsZ/ie2zn+1edKl5S6N BSzTnifcUTz0fbZkZN8cV5+YnQ0rZkxj+M0ScfSLyXb9iMx5muV7OfrvhuZFV4vMj/PQ5fodbrS glg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 May 2025 14:37:49 +1000, Alistair Popple wrote:
> Commit 6be3e21d25ca ("fs/dax: don't skip locked entries when scanning
> entries") introduced a new function, wait_entry_unlocked_exclusive(),
> which waits for the current entry to become unlocked without advancing
> the XArray iterator state.
> 
> Waiting for the entry to become unlocked requires dropping the XArray
> lock. This requires calling xas_pause() prior to dropping the lock
> which leaves the xas in a suitable state for the next iteration. However
> this has the side-effect of advancing the xas state to the next index.
> Normally this isn't an issue because xas_for_each() contains code to
> detect this state and thus avoid advancing the index a second time on
> the next loop iteration.
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

[1/1] fs/dax: Fix "don't skip locked entries when scanning entries"
      https://git.kernel.org/vfs/vfs/c/dd59137bfe70

