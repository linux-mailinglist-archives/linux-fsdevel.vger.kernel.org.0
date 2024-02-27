Return-Path: <linux-fsdevel+bounces-12928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A12868B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872E21C22BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917413540A;
	Tue, 27 Feb 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0LxqWWV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B712FF98;
	Tue, 27 Feb 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024673; cv=none; b=mm2ZJjz0LtRp4cVue+u0QJ66ru+WU1uGrx5TXsFr8F91sG+JlwyLUjM5LurNtecV/acLSnTEbisTFE0samlCdXzA/WTUOZVhkDre3EIdRnsfHs8vKZVvJo0ccu3WBlkQpg9Eclegxw4m2c4Gso9X3UkWt9wekDgNDOeilfgE7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024673; c=relaxed/simple;
	bh=Oj6QUXhE3TKC5x3LLfgn9nU0BNYadHx45h5xMqCQBWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ8MKm6VIymLDB2YGSDO4j+GVl/8hI2ZLzoVg+C+tdz1KYTwvpmrAwLbTyaQ8sFr4F5yuP1OsMJKOH9BW5FbE+RFTP/Jg9Ji4csjrMAdSJeYrzKDKLlX+DFyWEc3KQgYBlcqYceySqhsFGp6r0oe2kvSETMYG6kEvGHwnIbDDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0LxqWWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00964C433F1;
	Tue, 27 Feb 2024 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709024672;
	bh=Oj6QUXhE3TKC5x3LLfgn9nU0BNYadHx45h5xMqCQBWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0LxqWWVPPhp0tiVjlSAHb6+NFMlL9oLj4So/V0Y4RFLIH8LcIryOqkkUP80dH7Y0
	 d60V3DDtwpUeaTSAT2U36Db0UxT/0K9h+sgT7FT4+qUNeMOU2QOXhMJNnvp0pKGU1H
	 wWC1y9uMyllpCvbcVSgvIlEC1F1CF4b6fCK7iBmcO9eBuEaJ0/Zu8n7UWBmn9mtBXY
	 BGoldirESKzjvgdaFknqe0NtERnFasUxXq0fnZMAFjrBSFobBfMY4CcOk0KUflhFBH
	 UGGNHNZalfNDOV3FkClCnk6AXu2jlb4AxjJKcpeAsZXUXFRf0KmUJf4gaf/WamZoFq
	 zbIRpbC9EwQSg==
From: Christian Brauner <brauner@kernel.org>
To: chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] vfs: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 10:04:24 +0100
Message-ID: <20240227-westseite-kursziel-72040f653d65@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135315.830477-1-chengming.zhou@linux.dev>
References: <20240224135315.830477-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=brauner@kernel.org; h=from:subject:message-id; bh=Oj6QUXhE3TKC5x3LLfgn9nU0BNYadHx45h5xMqCQBWw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTeXTqjJYXp2L+gNUEP165uM11i9WqjiJ+i0vrkJ5d8D /xlW8p+pKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZ+8wMrxc05sS8WD6+gkX 5Sb+eD8jxpVfRpdrnaLZjeuz9/Nol3EwMlytfjfvw/aFlv67vrf96J7HI3+MoS/gelvUw7J810f PWtgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:53:15 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Commit message was updated to link to SLAB_MEM_SPREAD removal.

---

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

[1/1] vfs: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/2b711faa0ee2

