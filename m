Return-Path: <linux-fsdevel+bounces-57089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A90B1E9F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC937B4638
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013127E043;
	Fri,  8 Aug 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIb96Fhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A81B7F4;
	Fri,  8 Aug 2025 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661978; cv=none; b=XtRDlyCw2ILfZ6H8ctsJsdNt+/gwY+UiRXhEjvcvvDnTL9Y/P9ajyxokoFXm3/JFy77GPgzxsLhTO5BT73lVmM8/yiEuUC4pV3obtqguGjso24MsSuMsx5xA+gCbPED7IE+rxVmYqzj1nBKdwta5CfnvFMWOWq7yldMaFm1xpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661978; c=relaxed/simple;
	bh=hllP0vfjoOHx7x2Rtw7H5LUbK6b0VbY0wcpLTbQ7yLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmSTHG6YT+I7bIj+YJLyvtJrvfFXHs5tAGFcGm4Jy8JMH5CGzduOU/1/q8rR9Nkrf8KR06tbH4g/nybFUJTzaBDK7e+PutAHEdQy12th4B3DwEWsE9k9NvushR6V0cEtom39VXGfISspPK9rSS6oOu1Z+8J5oan5xR7KAYZfzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIb96Fhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E62C4CEF4;
	Fri,  8 Aug 2025 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754661976;
	bh=hllP0vfjoOHx7x2Rtw7H5LUbK6b0VbY0wcpLTbQ7yLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIb96Fhiq+jgyfvofugO+MBXEuk2akuWuJfWqCSF0F7VVEf8Zyz89e6UFfa5HOo5M
	 9e0VEz0FLA1rX5DLfYSNyzNH61m5Wj9fj45V18BM692nh0YriSBHAbOkqnlkaMUeUk
	 HVItMlxNxrWzCpnaMGnKVDRMlgs/3cMXzFQld5xD1FS8GNPMEX3+VmHDCG7vgH+OTQ
	 ry4A0mZ1sZOjDB2Jvr85U8uJcQEDADtZNmGUK42aya679ZD+cs87VdiQ9bz5ITayLv
	 5QDxUYhIJbAkwYFQ9MuuYMikflTZ2twu8XEUXSXqlU356DioQwnw2Fa0+SiLJRHPYx
	 jnUKtHfQzqOxA==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 0/2] fscontext: do not consume log entries when returning -EMSGSIZE
Date: Fri,  8 Aug 2025 16:06:05 +0200
Message-ID: <20250808-landkarte-parodie-14c4a95037e4@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=brauner@kernel.org; h=from:subject:message-id; bh=hllP0vfjoOHx7x2Rtw7H5LUbK6b0VbY0wcpLTbQ7yLA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRMYwlO0HN7oJhnUKTt3fzkb+e5PGGml76Wu1/xHpl4w udwTdOejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUBDL8U1imHPfWhLs9dOrk Bu8k8W8mEl6eEv8+is2Vnau3OkiumeF/udmfJQznrZQ+lCRXP98/IX6/2uknHzOmPzE+vOy+CAc zHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Aug 2025 03:55:22 +1000, Aleksa Sarai wrote:
> Userspace generally expects APIs that return -EMSGSIZE to allow for them
> to adjust their buffer size and retry the operation. However, the
> fscontext log would previously clear the message even in the -EMSGSIZE
> case.
> 
> Given that it is very cheap for us to check whether the buffer is too
> small before we remove the message from the ring buffer, let's just do
> that instead. While we're at it, refactor some fscontext_read() into a
> separate helper to make the ring buffer logic a bit easier to read.
> 
> [...]

Applied to the vfs-6.18.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.mount

[1/2] fscontext: do not consume log entries when returning -EMSGSIZE
      https://git.kernel.org/vfs/vfs/c/b78c4328c498
[2/2] selftests/filesystems: add basic fscontext log tests
      https://git.kernel.org/vfs/vfs/c/d70b6ceebd29

