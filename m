Return-Path: <linux-fsdevel+bounces-10315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E560849B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477C128227E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC41EB56;
	Mon,  5 Feb 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4XVfW+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E41CD06;
	Mon,  5 Feb 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137841; cv=none; b=CtKFPwpjTdcsGJU8uQV8yDClsAnAJ99LapG2WuUzEqDeXs4r801ktntg+dzPKibV8qWk5y24TNLnNjVWRm9elSldkIZi25GCULyD83tJUUOFW3acusaCytbzhRXi3so3dID5F9SN27cqnHXXIFcvhA/ysInfUDd3J/m3awoFGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137841; c=relaxed/simple;
	bh=7lZJZcNKjuQ5hjvoFRXqSwosvRruwbfXZHG9x6/U1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG9Tz+WvUbfyvZ3YwZXgyuB0jvA+EWT65qUh6dAt/vkNYW1qMNDJQlva57RNR8z7u94SEfZ0zo5QBKiN5/xEUqjRP5oJVnkWUoecLf1I9gM0X4XKTjsTcS3HWRNfKx0cLqRJ9HPRnKJm6wMo0MPxzz779OE7NAt2Y4VyCboq7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4XVfW+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD65C433F1;
	Mon,  5 Feb 2024 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707137841;
	bh=7lZJZcNKjuQ5hjvoFRXqSwosvRruwbfXZHG9x6/U1NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4XVfW+JmpuFc5K3N07g02AMbw6yEGV4t+Zv+B/1X7LK792nyFltFF7ZlQcuUPgOv
	 HX9U4lFwLqXAyqI1NfM+UU+VbR/QcfKoLL4q0nXE7mJyTYEtm+fGdF8n3ZAMalygHP
	 J1extlC1n1PlapQzW9ClV3vGAolvpjxE8YAUjePHhqJZxdABIQ0M8BvaglOD0DjntM
	 Stre8R+Zd6Wk87qLoemfP3/QmnS7H2IxjeK3XuRy9KmmLJrgptC8NN1AbJEkAOIFme
	 ldCFmbNskHqcLXtQLt3R3mpkjGWbV1TKLW5FRdYTrD/iOT/UQIOd+tiMQSjrT6cODn
	 A86W+Fd/dspcg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	Zdenek Pytela <zpytela@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease calls
Date: Mon,  5 Feb 2024 13:57:11 +0100
Message-ID: <20240205-urwald-daneben-6fda9fb87ff5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=brauner@kernel.org; h=from:subject:message-id; bh=7lZJZcNKjuQ5hjvoFRXqSwosvRruwbfXZHG9x6/U1NI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeuK0puzh/VW/civqHSuKbZzF7fY1udZ7wWvXEnakhX 3etmXjpVEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEKnwZ/goeK3fa39Z3z4/t 38k6bcOzDToT3zjNW3+0depd0SazH4sZ/le1eVivaFXdPW9+lN9cze3VSd9zeXSdSxemKRf/mh4 hwgwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Feb 2024 07:09:31 -0500, Jeff Layton wrote:
> Zdenek reported seeing some AVC denials due to nfsd trying to set
> delegations:
> 
>     type=AVC msg=audit(09.11.2023 09:03:46.411:496) : avc:  denied  { lease } for  pid=5127 comm=rpc.nfsd capability=lease  scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:nfsd_t:s0 tclass=capability permissive=0
> 
> When setting delegations on behalf of nfsd, we don't want to do all of
> the normal capabilty and LSM checks. nfsd is a kernel thread and runs
> with CAP_LEASE set, so the uid checks end up being a no-op in most cases
> anyway.
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

[1/1] filelock: don't do security checks on nfsd setlease calls
      https://git.kernel.org/vfs/vfs/c/ec457463e0e3

