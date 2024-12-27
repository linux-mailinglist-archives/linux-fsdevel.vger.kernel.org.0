Return-Path: <linux-fsdevel+bounces-38161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834D9FD41F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A753A1227
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44551F1319;
	Fri, 27 Dec 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNl6NGnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225371465BD;
	Fri, 27 Dec 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301720; cv=none; b=Lg+2ZAI6hT3pgNckrsUykd7zGu3dYjkake6Ma1WQq9m/EPqQqQDMZHRUrtwKjuW8Ani3Dl4nMCGhSlHLWFUUX2JJlJueeFCXnChhNrnReThg37m0o8ZFG/vqbiHlvbT8PaUZifcK5aCbD+t+0kE3wtFUN5PVKbLpLIRi25Xs/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301720; c=relaxed/simple;
	bh=0h/+6s3xsdUpRpjWLBFQ+cLSn9ZKAwN8WlF+5UzlPds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=esCdYQBcnYjEubOUEDTWHv09oxUGo0KpAewywb6mD5y8aGoHfyfod2FHysTqy6ouQn83O8YUoviT7dW5yGI14RHNco8AZXThKCQgVdfWntXsWcxtzJ1SVkgs5K951xyU84pB3VnGCQuXFSzi2ovVjCA9V3nbH5jFO6mkvVYfbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNl6NGnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D1C4CED0;
	Fri, 27 Dec 2024 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735301718;
	bh=0h/+6s3xsdUpRpjWLBFQ+cLSn9ZKAwN8WlF+5UzlPds=;
	h=Date:From:To:Cc:Subject:From;
	b=RNl6NGnVFxsHf1PXB2aflArmZ3xlHi6DFPsjEPUe0ssQ5igea9/Njd+WtSpaPVGoq
	 y7eUDFR+/kLWELwyhzpTngO5iO38xZS4manCy46q1sMxhjvwq3ivIzhPsrJuILt+wU
	 3Q+IaVrU4snh7Kbr5OMP4jrciGN8nZTra+2gqDhAAY8EmizdwgKhD95M3xpluvtzWs
	 LcjfNQEzESQBxq6o6Ixld6snMc6ZSmcKf3y5cl5qFS8eOOyvcqYxThwY4EPRF2e98d
	 n5QfWjsiGAt0Wi7DMzeP6GKvAALwey2kT3X93W6g6rV+7ryAFxMe54nb/BQ05+Rl1a
	 UTFYbWWrFG0aQ==
Received: by pali.im (Postfix)
	id 3BBCF787; Fri, 27 Dec 2024 13:15:08 +0100 (CET)
Date: Fri, 27 Dec 2024 13:15:08 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Immutable vs read-only for Windows compatibility
Message-ID: <20241227121508.nofy6bho66pc5ry5@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716

Hello,

Few months ago I discussed with Steve that Linux SMB client has some
problems during removal of directory which has read-only attribute set.

I was looking what exactly the read-only windows attribute means, how it
is interpreted by Linux and in my opinion it is wrongly used in Linux at
all.

Windows filesystems NTFS and ReFS, and also exported over SMB supports
two ways how to present some file or directory as read-only. First
option is by setting ACL permissions (for particular or all users) to
GENERIC_READ-only. Second option is by setting the read-only attribute.
Second option is available also for (ex)FAT filesystems (first option via
ACL is not possible on (ex)FAT as it does not have ACLs).

First option (ACL) is basically same as clearing all "w" bits in mode
and ACL (if present) on Linux. It enforces security permission behavior.
Note that if the parent directory grants for user delete child
permission then the file can be deleted. This behavior is same for Linux
and Windows (on Windows there is separate ACL for delete child, on Linux
it is part of directory's write permission).

Second option (Windows read-only attribute) means that the file/dir
cannot be opened in write mode, its metadata attribute cannot be changed
and the file/dir cannot be deleted at all. But anybody who has
WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
wants.

Linux filesystems has similar thing to Windows read-only attribute
(FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
which can be set by the "chattr" tool. Seems that the only difference
between Windows read-only and Linux immutable is that on Linux only
process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
it can be anybody who has write ACL.

Now I'm thinking, how should be Windows read-only bit interpreted by
Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:

0) Simply ignored. Disadvantage is that over network fs, user would not
   be able to do modify or delete such file, even as root.

1) Smartly ignored. Meaning that for local fs, it is ignored and for
   network fs it has to be cleared before any write/modify/delete
   operation.

2) Translated to Linux mode/ACL. So the user has some ability to see it
   or change it via chmod. Disadvantage is that it mix ACL/mode.

3) Translated to Linux FS_IMMUTABLE_FL. So the user can use lsattr /
   chattr to see or change it. Disadvantage is that this bit can be
   changed only by root or by CAP_LINUX_IMMUTABLE process.

4) Exported via some new xattr. User can see or change it. But for
   example recursive removal via rm -rf would be failing as rm would not
   know about this special new xattr.

In any case, in my opinion, all Linux fs drivers for these filesystems
(FAT, exFAT, NTFS, SMB, are there some others?) should handle this
windows read-only bit in the same way.

What do you think, what should be the best option?

I have another idea. What about introducing a new FS_IMMUTABLE_USER_FL
bit which have same behavior as FS_IMMUTABLE_FL, just it would be
possible to set it for any user who has granted "write" permission?
Instead of requiring CAP_LINUX_IMMUTABLE. I see a nice usecase that even
ordinary user could be able to mark file as protected against removal or
modification (for example some backup data).

Pali

