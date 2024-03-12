Return-Path: <linux-fsdevel+bounces-14213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392487967D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F931F21604
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854E7A709;
	Tue, 12 Mar 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3e2PeWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D733E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254164; cv=none; b=g8w5lIHmD0wyqeLF+tXK2yWklaZm13PcWj2zsDkT1H0tLnD+sWAmSqu89FBA7hcGw0UqzRZACNY1qcQ6Lt/U/Zkpq0ATrYXCqEJhf2dfyxwnDBEuuvyrIdoWZuFaAj2/HitrUfQRY3lpwJjD363Ckt5h7wn7I5CiTnroFvS7aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254164; c=relaxed/simple;
	bh=rwdB4PjR6k7L07TZ2P4zpLJ/xGRnxwQ1YxgPdmWvXZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqGD9hHmU98i/C/L1icesOPJ2HTRoc1MW9jx+5+z3b9qRzNvEJFoS3tTT+OH2+de/IHBxyBT2nAijyXSRNY5NSRgB4jNqJ+AckB07vVdOSxgz1DlMa0SFlLR7/Fk13WZ03kqQ0/YM0mbhtAS5GQIBTWeb78UOJWcO96SETIxPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3e2PeWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA14FC433C7;
	Tue, 12 Mar 2024 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254164;
	bh=rwdB4PjR6k7L07TZ2P4zpLJ/xGRnxwQ1YxgPdmWvXZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3e2PeWgcRLR34a7IV4RfgBdYKMvK3cC2pD7n8KPEO7IsRWa9IU88AhWOlCU/aV8N
	 JZVQtuRX4zFR1ixfuriAuY4EzBeNBNk7Kwh0UGATApsoyVw1gTRv+F2sA5jhYKpfgg
	 G7HlXv7Qb3gXS3pmXPtA+jl5MlOHG8ox6RQYYxxr7lJrKWZpCYSV6L4aZMOJV16A9h
	 8u9GpLsiOqpzd/SPB3SQA3BAnPgdfGdCzwiawuI1JB36sdzvaRFwb4WltMV9h3mY+l
	 Zd702qG05kp3CqM3ceOEzR9htEMSLVWOhxOHJRBGNs12ZgJXlwLGjAWtU+CnEpZud8
	 R5I3mg58nvSEw==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bill O'Donnell <billodo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] vfs: convert debugfs & tracefs to the new mount API
Date: Tue, 12 Mar 2024 15:35:56 +0100
Message-ID: <20240312-auftrag-empfehlen-8e04cc33a8c1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=brauner@kernel.org; h=from:subject:message-id; bh=rwdB4PjR6k7L07TZ2P4zpLJ/xGRnxwQ1YxgPdmWvXZs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+yPA9y3nulfQWmWu8xo7Jh+KUnl6tjHjnrHb2fu5Vl TfMMlWJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN55MPI0CBeFG3B8GlzZOTb ZPFTSXzySecT555dp5jyhONnzu7it4wMn5/av6lIN7RPUjexcrTSuGnuuL5bWbmzbu59KY5pDwK YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 17:07:29 -0600, Eric Sandeen wrote:
> Since debugfs and tracefs are cut & pasted one way or the other,
> do these at the same time.
> 
> Both of these patches originated in dhowells' tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=ec14be9e2aa76f63458466bba86256e123ec4e51
> and
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=c4f2e60465859e02a6e36ed618dbaea16de8c8e0
> 
> [...]

I'm assuming that your Acks meant I'm good to pick those up.
Please yell, if not!

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

[1/2] vfs: Convert debugfs to use the new mount API
      https://git.kernel.org/vfs/vfs/c/393b0b4c609e
[2/2] vfs: Convert tracefs to use the new mount API
      https://git.kernel.org/vfs/vfs/c/140a2056102a

