Return-Path: <linux-fsdevel+bounces-70642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCDACA31BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58A4E3027E03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918C33508D;
	Thu,  4 Dec 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1dqUrYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534332DEA87;
	Thu,  4 Dec 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842205; cv=none; b=lCtTO9YrDO8KYS4RMHvSE9awuWoXtZnFQr0TgjfjWJq09AjBNY1rIgerRYY2ODFlYy4z3LGnBNWQ+2k01fjWkSXAbdXEEixhHVngNqrrosKenyt9FtDo+MI9DxsjQyFwBnl4X4CWElF2qUl852olDp1fz9irD1mJ+eyOZizCPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842205; c=relaxed/simple;
	bh=9Qhz+M0mE4BVe5zm5uXYgD6QJyTY93swUsvK+Ezekmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW9rIiEgDMHf3gXRmTPNd6lfECYh8HJdCAraan0JWrIIGMscAxo4C8ImDi0dSyVfWUFggEYFYRsht/ITmwLFWaxJebGncMMGwQvkL3wkQyyduO1TCgsSRceFUFIRStTK/aqQTS0Bh4aj1eKoYEKjLgX3WJ5l/CumRmFgClwYQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1dqUrYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21FC4CEFB;
	Thu,  4 Dec 2025 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842204;
	bh=9Qhz+M0mE4BVe5zm5uXYgD6QJyTY93swUsvK+Ezekmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1dqUrYZjWwB9FxIMb2qo3Owsmnp9L15WJaCU84yMqyMmKd5+d6Q+SAztzru/uXUk
	 YaSchmMli2vmfz/yKDL3N37m0gbjoOwhP4O84cbJeA9cfeEElIap49SsLzLXp9b2un
	 ikPMDKB+ChBJ5oVUIj/PHrXJq68zGwGIRd9bp9bzNBlKO3i+7myTs9EtXVR4pZ12PS
	 qHSC1tCi2QjWhBsWsA/hKO8F73K309csPenZ+LwJ8VB3bxsMypEGZA0TqHwpAEIrpw
	 MBkI4TAIxe7QPz0WBvUbVMBk9oshLDsJR/WHbzj77S5cD+Nebj3LVlxZsbZnccFCt8
	 i8oW9QlIVP0Zw==
From: Christian Brauner <brauner@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v7 0/3] statmount: accept fd as a parameter
Date: Thu,  4 Dec 2025 10:55:59 +0100
Message-ID: <20251204-mondfinsternis-sowohl-fd9f566ae1d0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=brauner@kernel.org; h=from:subject:message-id; bh=9Qhz+M0mE4BVe5zm5uXYgD6QJyTY93swUsvK+Ezekmk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQaRl2+mbyvS2tO+mqN19ufZyz40nevZmW03c2GzlUz7 ng4Xb/Q1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR++mMDDtbTWcftw1/v356 e9v7NtYQq3a/0rdC15fKZCVa6c+uvsvwT5216pLSxzVvIheoib/SvbC/VfNLh9ri2+yLV10sL7q 4ngEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 29 Nov 2025 14:41:19 +0530, Bhavik Sachdev wrote:
> We would like to add support for checkpoint/restoring file descriptors
> open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
> Userspace) [1].
> 
> Currently, we have no way to get mount info for these "unmounted" mounts
> since they do appear in /proc/<pid>/mountinfo and statmount does not
> work on them, since they do not belong to any mount namespace.
> 
> [...]

This seems good to me now. Maybe Miklos wants to give this a nod as well.

---

Applied to the vfs-6.20.namespace branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.namespace branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.namespace

[1/3] statmount: permission check should return EPERM
      https://git.kernel.org/vfs/vfs/c/5d68cefb00d9
[2/3] statmount: accept fd as a parameter
      https://git.kernel.org/vfs/vfs/c/c5255171323f
[3/3] selftests: statmount: tests for STATMOUNT_BY_FD
      https://git.kernel.org/vfs/vfs/c/15d50368501a

