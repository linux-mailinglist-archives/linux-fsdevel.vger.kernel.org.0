Return-Path: <linux-fsdevel+bounces-69737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D4C8421B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966694E6F70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA42D877D;
	Tue, 25 Nov 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ71WtGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5612261B6D;
	Tue, 25 Nov 2025 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061496; cv=none; b=MPm1OzltfXzw0Ib9tOf/kmQzt314GWfPyTYzrlsnOXzCA/FKnpAb+1GKhjmBzztcLUkMjtcKPZ2+mCse40XPMQdLbTyITypb8SSHswJajNpYLEuaHNjgwqk+VglfQK8WMkXB+zpVMj9yMC4JqWcaWKhhLqCeDN57juUqW9vEmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061496; c=relaxed/simple;
	bh=uzFHDWI/HfqfGY3kbPqNmBLSABu8KT5KWQ3Wa/LOfXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fy68Ntb7lOiKfVZ6+6f/neDf1ZNEKgqg/oYxuFpZZ8kFxFhBcZlR9u90RPzPGDAXpCWlrTYOJ3cIl6GNpa007BZdECY7Bb530K2Bkv3lQ9NodfeuH25yK2fxqRxTnewuDB5U4B0q0JzDhE85QjUTTyA3FPLLZpDC1jmXn9O1nQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ71WtGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E9BC4CEF1;
	Tue, 25 Nov 2025 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061496;
	bh=uzFHDWI/HfqfGY3kbPqNmBLSABu8KT5KWQ3Wa/LOfXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQ71WtGQVwvh4pzsmWnkaFF6GatGNMcMQwZuNjVXsymYXDqGzCuZ/bMquBVhrEUk+
	 t7p/uojD7XS6sf7Lz0I3xAgy1t6y5PuOwepKRp70BIkkPyp7+5S1FIg4rbqJk0sNv/
	 9dXY/WU3rpPpT85PmoT9koLbdA4pcYQDSIih8PFl1v+3ibVY57OrrWXhzn3kLJvj6I
	 jRUVJJHAi8RAVlHVQmLkBwTO4kfnyD7ATM2Mn+8qBK0rOYFwYWW3neccFOy9lvH2ww
	 phMUp0mcxsIgrB7TCDNK92H8ZiJ9LbT5hPIjlQv96zDZUcTMBW0zRoHAa5i/blFuJg
	 fyx8solIsIGgw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: mark lookup_slow() as noinline
Date: Tue, 25 Nov 2025 10:04:50 +0100
Message-ID: <20251125-variabel-zellstoff-67b8a698b87f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119144930.2911698-1-mjguzik@gmail.com>
References: <20251119144930.2911698-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=brauner@kernel.org; h=from:subject:message-id; bh=uzFHDWI/HfqfGY3kbPqNmBLSABu8KT5KWQ3Wa/LOfXA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqFhpv3H2xKUeEQydcYsG0O/7aCRZ+Cw+x5n7a2cT2h /Ef36m4jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImEH2L4Zx1855uMbZdg5iP5 lyuU2DdpzmwMWC6oarhyqY3x8tOqLYwMZy9eY5X/yvLJI2z1U8PDbTe+XVc3KJS7fZG7coPKXCN 3ZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 15:49:30 +0100, Mateusz Guzik wrote:
> Otherwise it gets inlined notably in walk_component(), which convinces
> the compiler to push/pop additional registers in the fast path to
> accomodate existence of the inlined version.
> 
> Shortens the fast path of that routine from 87 to 71 bytes.
> 
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: mark lookup_slow() as noinline
      https://git.kernel.org/vfs/vfs/c/8d79ec9e7f63

