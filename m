Return-Path: <linux-fsdevel+bounces-41389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A51A2EBE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF843A3463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA21F3BB1;
	Mon, 10 Feb 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQAVgxq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76114D29B;
	Mon, 10 Feb 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188243; cv=none; b=X12u+xOun3ZoEchON+/iwVxe0pj0DrSWQ3y875CIxOupA0w7jU6A4rBRIkg4esfoIbhUA5yhBSaIE7ZkMp1dkKtuwo1EdlsZxXaDXKWvBQusdjjA0cWrxyschshr8T/8fO388aLWGsTog2odP4n4Li0WzxtIPyLVD/FKTMjLJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188243; c=relaxed/simple;
	bh=i87Zw8NJPj9DKr2+z0myfp7yke30qMpIKuFY1BQ+7CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apuoXXKUqJGwgE3sakl4vM06ShOENLSg56m/wFg0w6nyvBXGM8HGQLmuyG9pBMihFku+ogKSmSGzkJXihOcdRx9emVQJvrBYrL+a5u2am/FUT/UEb12hnd5CspBCznyn93WOd5ei7f/JOlhzauqGgh4LtZvJlUnleBx4VASmFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQAVgxq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F25FC4CED1;
	Mon, 10 Feb 2025 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739188242;
	bh=i87Zw8NJPj9DKr2+z0myfp7yke30qMpIKuFY1BQ+7CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQAVgxq1O+lAzZS0GQqRSt2WSeUVwYDPeDh6pM+e0ROil+pUqRiLrHys9TypchQ5m
	 Ox09/NDV2CVwmZ/SNdde+AoDsq4JdHgg2DE4zmOSD+xzFQyMRCnna/zE/eJBkr5L+u
	 /A3nZQxRRCTp3U/76ZjVxoqfJ5yPsDz3iE161ebGXXN8oF1VlMnVDpBv0hZTcsjTmZ
	 QKlPme0nZ05z2k7oCef+vZVMN3GL9R5RZDli8KL5+u3te+bLD0qhtYcV5j/TtIHcoa
	 CX/L28y024pkpDgLT/lypXhdNYkjOLXlARAgrMEI2Pj/OA/0uBXogU0w7iv0qiwOgd
	 cWS/1FVdgsvfQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v6 00/10] iomap: incremental per-operation iter advance
Date: Mon, 10 Feb 2025 12:48:14 +0100
Message-ID: <20250210-umrahmen-ortseinfahrt-7a20d8b89df2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207143253.314068-1-bfoster@redhat.com>
References: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=brauner@kernel.org; h=from:subject:message-id; bh=i87Zw8NJPj9DKr2+z0myfp7yke30qMpIKuFY1BQ+7CQ=; b=kA0DAAoWkcYbwGV43KIByyZiAGep6Ayh4eOEaNr+c9Qd0nt+mNCdG/l+4xNldma6bxpb+hVgB 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmep6AwACgkQkcYbwGV43KJRzgD+MYl0 EApMQXpJlaUT/iTOy00riRhdqigZLE9O90/oUFwBAIKHAu3rJS7uz5yZ3GUG5MeXEtY/TmDXAel r+eBgaXoF
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Feb 2025 09:32:43 -0500, Brian Foster wrote:
> Just a couple comment changes, no code changes from v5.
> 
> Brian
> 
> v6:
> - Comment updates in patches 6 and 7.
> v5: https://lore.kernel.org/linux-fsdevel/20250205135821.178256-1-bfoster@redhat.com/
> - Fixed refactoring bug in v4 by pulling 'processed' local var into
>   patch 4.
> v4: https://lore.kernel.org/linux-fsdevel/20250204133044.80551-1-bfoster@redhat.com/
> - Reordered patches 1 and 2 to keep iter advance cleanups together.
> - Split patch 3 from v3 into patches 3-6.
> v3: https://lore.kernel.org/linux-fsdevel/20250130170949.916098-1-bfoster@redhat.com/
> - Code style and comment fixups.
> - Variable type fixups and rework of iomap_iter_advance() to return
>   error/length separately.
> - Advance the iter on unshare and zero range skip cases instead of
>   returning length.
> v2: https://lore.kernel.org/linux-fsdevel/20250122133434.535192-1-bfoster@redhat.com/
> - More refactoring of iomap_iter[_advance]() logic. Lifted out iter
>   continuation and stale logic and improved comments.
> - Renamed some poorly named helpers and variables.
> - Return remaining length for current iter from _iter_advance() and use
>   appropriately.
> v1: https://lore.kernel.org/linux-fsdevel/20241213143610.1002526-1-bfoster@redhat.com/
> - Reworked and fixed a bunch of functional issues.
> RFC: https://lore.kernel.org/linux-fsdevel/20241125140623.20633-1-bfoster@redhat.com/
> 
> [...]

@Brian, you would help me a lot if you keep adding the full cover letter
message in each series. I always retain the cover letter when I merge
series such as this. So for work like yours it serves as a design/spec
document that we can always go back to when we see bugs in that code
months/years down the line.

---

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[01/10] iomap: factor out iomap length helper
        https://git.kernel.org/vfs/vfs/c/abb0ea1923a6
[02/10] iomap: split out iomap check and reset logic from iter advance
        https://git.kernel.org/vfs/vfs/c/2e4b0b6cf533
[03/10] iomap: refactor iomap_iter() length check and tracepoint
        https://git.kernel.org/vfs/vfs/c/f47998386623
[04/10] iomap: lift error code check out of iomap_iter_advance()
        https://git.kernel.org/vfs/vfs/c/9183b2a0e439
[05/10] iomap: lift iter termination logic from iomap_iter_advance()
        https://git.kernel.org/vfs/vfs/c/b26f2ea1cd06
[06/10] iomap: export iomap_iter_advance() and return remaining length
        https://git.kernel.org/vfs/vfs/c/b51d30ff51f9
[07/10] iomap: support incremental iomap_iter advances
        https://git.kernel.org/vfs/vfs/c/bc264fea0f6f
[08/10] iomap: advance the iter directly on buffered writes
        https://git.kernel.org/vfs/vfs/c/1a1a3b574b97
[09/10] iomap: advance the iter directly on unshare range
        https://git.kernel.org/vfs/vfs/c/e60837da4d9d
[10/10] iomap: advance the iter directly on zero range
        https://git.kernel.org/vfs/vfs/c/cbad829cef3b

