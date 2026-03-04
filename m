Return-Path: <linux-fsdevel+bounces-79359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNGXHuwyqGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:26:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A62005D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37904318E5C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755A28DF07;
	Wed,  4 Mar 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMnjl+Xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2E1AF4D5;
	Wed,  4 Mar 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630386; cv=none; b=UkpIHf+Rs5W5JTHYHMgZMTgMzvgH+CUyQlcwWNWR4+YrL2ZvhHiuHMYeVTBvTUeML6ZF3Uum8th+kpqDqMdPTEiY0BMSpibMibZomdQe41jC8tEZATHK/mX1CczivH3UAOC6gWUubwsuTH3IHzY9LhJgPNuORpLLcdTjPsLD93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630386; c=relaxed/simple;
	bh=iMvm0f//FWJU5C6mRge/z/RIgnWYB5qR6a2WvDyeC80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axH96La+/Ec4Mu44QmmQ5Xt4bRElKMp8PLT4bpUfvH/Rq95t5fgkSgUC4jWaajUgLThE2sSrXjsGlVrMK7/GUyx0ag5jKB36fTqDnJafrLOd8fXfBk5rdQGMhzvINzepkKVs1Zd0Py+hcrzAAvr0+HzqM04HJz3guPkVmROVPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMnjl+Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA7C19423;
	Wed,  4 Mar 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630386;
	bh=iMvm0f//FWJU5C6mRge/z/RIgnWYB5qR6a2WvDyeC80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMnjl+XxUAi6xq3MCrUI+I4sc3Is1cfwRF/roQYjzK7R753JRS4569pcDq7GdBfKK
	 CQc5lqlG68+6ivDBEmBNPt9HppAl8Uh5Zj8XYiuOzZyN1LLAOE2JJJ4y7hEKDP1Y3o
	 OM4EBzgkPQynU/j6DDUB0VDutqFnUKxJESq/M1pKKGWJGZWEwYjZp57PLxdQaNo2yM
	 PnT4jRDT1/ysGHAvA+3+d390Lpwrzx+rYtWvQUNSmHPdkuy+sj57lbhz965QX47OfY
	 KfosAZ9Dri0jkzoSbao8jqI2druie66nlIbNeBotkYv1j59GVNUqDjzuTEtqdgWiea
	 cN5gcxKvABsSA==
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] iomap: don't mark folio uptodate if read IO has bytes pending
Date: Wed,  4 Mar 2026 14:19:40 +0100
Message-ID: <20260304-appell-aufbrach-79e916696eb7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303233420.874231-1-joannelkoong@gmail.com>
References: <20260303233420.874231-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=brauner@kernel.org; h=from:subject:message-id; bh=iMvm0f//FWJU5C6mRge/z/RIgnWYB5qR6a2WvDyeC80=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuMMwVrTNQWrXYNeKN8XZWhuSlc/wOtZdY39tkV8JwN TQ++/LsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIls72X4X+DyaNuK7P6GJasW z23N3v/pStG9XwIH7zX8FFZ7pxlSspbhv2vZlr1xtZF95uu4p4sJOPCYNq3/6//swRz7Az85LZc 78AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D75A62005D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79359-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 15:34:19 -0800, Joanne Koong wrote:
> This is a fix for this scenario:
> 
> ->read_folio() gets called on a folio size that is 16k while the file is 4k:
>   a) ifs->read_bytes_pending gets initialized to 16k
>   b) ->read_folio_range() is called for the 4k read
>   c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
> 0 to 4k range is marked uptodate
>   d) the post-eof blocks are zeroed and marked uptodate in the call to
> iomap_set_range_uptodate()
>   e) iomap_set_range_uptodate() sees all the ranges are marked
> uptodate and it marks the folio uptodate
>   f) iomap_read_end() gets called to subtract the 12k from
> ifs->read_bytes_pending. it too sees all the ranges are marked
> uptodate and marks the folio uptodate using XOR
>   g) the XOR call clears the uptodate flag on the folio
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

[1/1] iomap: don't mark folio uptodate if read IO has bytes pending
      https://git.kernel.org/vfs/vfs/c/debc1a492b26

