Return-Path: <linux-fsdevel+bounces-28896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4A9701AD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5950281BED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5E158536;
	Sat,  7 Sep 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P76BHhcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD61B85DC;
	Sat,  7 Sep 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725704576; cv=none; b=urpD0Wlponq7BMm5aAy2DvUoS9KFkrMlWuJE70RNFuRchQwm6sLnaGQx51woRx2LS50HUVvDrQUnsO2EmoA9n8HF6JLXCJkf/Uxx9WnMq2xxmg/wA2uufl95fjpOfnO7X6glO4HLoGBWAlQYnpCesYcWn3N4JPxnNKykOC0s2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725704576; c=relaxed/simple;
	bh=Q1pvLsvFqUeg52B5Bl4NZbvGj4evUD5AIy6A5sOYoQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFZlrOf0XsW3trzIfyLSPwXLP4Rcq4VSBuKQbLTGDbk9XBzpvBLZNhz1fSUO0j/84RN19lKxJjzJugaOL1gtocxvwCBGd54eplHIglbOLomayyJwV3neBs4Ed8X6ZIS8v/5D/BwUJzwaMaywTEcUu5/Tg7Xz0Nv3NyFn5ultSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P76BHhcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCCEC4CEC2;
	Sat,  7 Sep 2024 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725704576;
	bh=Q1pvLsvFqUeg52B5Bl4NZbvGj4evUD5AIy6A5sOYoQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P76BHhcrHVkM6n1eEyLPfK5/BCXlNrYBqhCOxAhoDUNsaJdeiiXTFFOrhOpP96km/
	 HKEbenXJ7kMhQAF+N5lBmZxJuPAAd7K+elZr+SdBs77R3wdIixGLcF7s/LOtizY4Eu
	 1WXhqShQzVB3l/zHv3hHup50bAH6eHO11spprLv+PcQu7ut/Rl5Rp53dHiNjxkBWFt
	 eLHc+TVsonNopAQfQllekbe2oNAj7SK+Zhk6MSKVkwJ8V+cWix3Y2DZuucq+LVL7Us
	 OFFLnbpVfp+dLWmMttOWtETyPdDzAujAnw+IfPw7SC3MZ/J83m7CdtfLhqWIYS5S4j
	 0+TS/eoMtQhiw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Tom Haynes <loghyr@gmail.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: (subset) [PATCH v4 09/11] fs: handle delegated timestamps in setattr_copy_mgtime
Date: Sat,  7 Sep 2024 12:22:47 +0200
Message-ID: <20240907-zumindest-knallen-d3f7cede5ab7@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org> <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=brauner@kernel.org; h=from:subject:message-id; bh=Q1pvLsvFqUeg52B5Bl4NZbvGj4evUD5AIy6A5sOYoQw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd0ax4H2xRNt3j98wP/cKx62LjTsef4xBkcd8/M0Jjg bvnsflhHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRf8rI0Pfd8+vGR2KRK2zK zGelxRjMyDp7Oay1lctRfxpPtGjFB4b/dapiqyb7TF6qof1n85mId9ZcVxdN6LhmWdfZmxwxc48 yPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 05 Sep 2024 08:41:53 -0400, Jeff Layton wrote:
> When updating the ctime on an inode for a SETATTR with a multigrain
> filesystem, we usually want to take the latest time we can get for the
> ctime. The exception to this rule is when there is a nfsd write
> delegation and the server is proxying timestamps from the client.
> 
> When nfsd gets a CB_GETATTR response, we want to update the timestamp
> value in the inode to the values that the client is tracking. The client
> doesn't send a ctime value (since that's always determined by the
> exported filesystem), but it can send a mtime value. In the case where
> it does, then we may need to update the ctime to a value commensurate
> with that instead of the current time.
> 
> [...]

Applied to the vfs.mgtime branch of the vfs/vfs.git tree.
Patches in the vfs.mgtime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mgtime

[09/11] fs: handle delegated timestamps in setattr_copy_mgtime
        https://git.kernel.org/vfs/vfs/c/b0d5ea249d88

