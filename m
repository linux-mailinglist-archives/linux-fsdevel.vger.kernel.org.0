Return-Path: <linux-fsdevel+bounces-26253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED601956986
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A81C215AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52143166F11;
	Mon, 19 Aug 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSCyYUNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609315ADB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067672; cv=none; b=im9WhAWmgiswbwzlcBErYWVDVWlp8b4I/Ca+dsreyt19qOUB5dDOCjMlOMMWaXDUs1VNpDxjUS31buN6K3kj84v1jMfbLk3MUhSdjbmmkDJ7sGfJOE1ySFxotgv8cS5Xyj+3brY0eParoaJU1852cl6uaraBLSuwpkxxc510XKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067672; c=relaxed/simple;
	bh=ii3fHtLFGH2xK/PWkbrHcwHF/9cIc0M6iS4QAUDypYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F68tc+lueiCdWKtQQy6n2tkUpoCJvjONjSkEnutL7J2NK+b8ibmqHq2dbO7UtWb/kQGh3EtOojWjLA8DKkqaqHCclOFtiU/9OBApIzn7Sp5TNYTP/u+XBUcJSQymcgcLq1ZFbJRq4pM4Ba7t+24YK5rLq2AgBGkOVJc3cT7qn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSCyYUNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A517EC32782;
	Mon, 19 Aug 2024 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724067672;
	bh=ii3fHtLFGH2xK/PWkbrHcwHF/9cIc0M6iS4QAUDypYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSCyYUNCYXksJ43siohPDtD9YBNBexAGhkQprRmYMhC+m7rz9dd3CXYK9qctFlOSs
	 /l+ERTL9/Q+QywGQUtkLygjef5wY3EqEl0rJoUaQByrhZ35QFpUAyGk2yRv/TG+G22
	 YqBUYIeKNwYaNyU7VqL+NfpjLHR4qet+Xc259a0JDJsgzjFg7aanBlFPa7ZjcwuOCb
	 BYC0xxlIaiWAFx/HVh9k7vNM9wBXrUs9BCABnAqQ8Rc0SNSylzpzwDHh3D+7eqKSEO
	 GGX1Gv4rzuwGjQ2oDzIih5N9cIpVJH077lMc5gEpLvQQqqTmQM9UOu/pV+Q1r6obLi
	 mmqf2wEHVsoqw==
From: Christian Brauner <brauner@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	linux-mtd@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Finish converting jffs2 to folios
Date: Mon, 19 Aug 2024 13:41:03 +0200
Message-ID: <20240819-kursgewinn-koexistieren-489bc246a7df@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195915.249871-1-willy@infradead.org>
References: <20240814195915.249871-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=brauner@kernel.org; h=from:subject:message-id; bh=ii3fHtLFGH2xK/PWkbrHcwHF/9cIc0M6iS4QAUDypYY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd1g964v5Y3T+7a8Ghps5ne141zLzHYLAzl+HQNK7Fc kkxN+dFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk3Q6GP5zZO6wOH7/Xf0TX uLR30pUV3pt91Zoc3xz5P7X+1Mz47HCGfypLxa8q7FdlqP95n2vH37iN1373c71hc5ow6febJ+v K9rEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 20:59:11 +0100, Matthew Wilcox (Oracle) wrote:
> This patch series applies on top of fs-next.  I suggest it goes through
> Christian's tree.  After applying these two patches, there are no more
> references to 'struct page' in jffs2.  I obviously haven't tested it at
> all beyond compilation.
> 
> Matthew Wilcox (Oracle) (2):
>   jffs2: Convert jffs2_do_readpage_nolock to take a folio
>   jffs2: Use a folio in jffs2_garbage_collect_dnode()
> 
> [...]

Applied to the vfs.folio branch of the vfs/vfs.git tree.
Patches in the vfs.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.folio

[1/2] jffs2: Convert jffs2_do_readpage_nolock to take a folio
      https://git.kernel.org/vfs/vfs/c/bcc7d11e6c09
[2/2] jffs2: Use a folio in jffs2_garbage_collect_dnode()
      https://git.kernel.org/vfs/vfs/c/2da4c51a66cd

