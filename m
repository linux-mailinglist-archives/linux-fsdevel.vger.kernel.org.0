Return-Path: <linux-fsdevel+bounces-24596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE6940FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA881F24FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAA1A00F4;
	Tue, 30 Jul 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0E8omvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228B194A73;
	Tue, 30 Jul 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336044; cv=none; b=UlclsyauVS2dctyovupf+emX5rmG95N2T7c+t7to6WmorhanuciQkhCGJgcsC7THSUNPzFLa+JyP2/cKIYm1LJoppQuVT7OYGqY6wWwrh2fvsHM0PpGNhfZcQcf01tU5Tl7RbxU5SI9Gc4eAxC+7ULSAOM/UmxLjsruj3C9GxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336044; c=relaxed/simple;
	bh=GtlHiCXe3SP9GrzrDbzPMyQy1TggjvVpoEIpM1wJkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSoLgbQWifsDnkiJCx/OeD00/TcsSyMUgv8b/utqnvXK7gJpwM3H+iXyxLXaG7VU2ylKwvoSD2H0Bpt5ooIuwC00+aFFPHmn3aIVHa4dWX24JafXuU6LM4o/eos6/ZgBfKsz6jCzM6RmCwqjoKZPZHydYiA5VTdQg11u35remVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0E8omvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0972C32782;
	Tue, 30 Jul 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722336044;
	bh=GtlHiCXe3SP9GrzrDbzPMyQy1TggjvVpoEIpM1wJkFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0E8omvsDHYTL2czP0n0De4+h7DkgjBCVfSGLzuFxGLkYAK/0Pznw8IvCL7RKzyEb
	 aFCoes9IhXWAdQpPfBeK7RBQPilx2izghkYwF5Gef08hGlU9A5YxKlgo9EVm89XjLx
	 rkwrXNu3Hdyg1IdhFhUKcx27zTZ731W2iVm3FgpFbMZfO2YDAfW6LgS9R1XFtXXKjH
	 3cA7Vcrrzvz6DIRMkwolQ3gUwEIKxik1Z8Se4GDpuOgVFNTs3sMIdxNYARys4Sf7KY
	 z7IiZ3E5odkdcqOpYKleNWUyYI4MEA5DsnexQs9hFJAZZdLqjJJ39hb0z3TyoVPeUy
	 /jRxBRJrxNvuw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: (subset) [PATCH 00/24] netfs: Read/write improvements
Date: Tue, 30 Jul 2024 12:38:10 +0200
Message-ID: <20240730-humpelt-satzreif-0ef607a63e62@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=brauner@kernel.org; h=from:subject:message-id; bh=GtlHiCXe3SP9GrzrDbzPMyQy1TggjvVpoEIpM1wJkFw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStOCxvEn2hwPPa8wTxI72C4lJ3v3Rea/ReGNcXGxw0T yefRaW6o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJX5jD8rzu7t0Pz2KVvdqtv 87yVfHz0kKpZ/6QfIZ67Tgnvl4+4MIeR4X367lM/n+s+OMG0cIHnl8WHrnnU3G7J3q6ks8NQdPp ZZXYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 17:19:29 +0100, David Howells wrote:
> This set of patches includes one fscache fix and one cachefiles fix
> 
>  (1) Fix a cookie access race in fscache.
> 
>  (2) Fix the setxattr/removexattr syscalls to pull their arguments into
>      kernel space before taking the sb_writers lock to avoid a deadlock
>      against mm->mmap_lock.
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[03/24] - [24/24]

