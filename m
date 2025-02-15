Return-Path: <linux-fsdevel+bounces-41782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC9A37154
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E399D3AE013
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C91FCCE1;
	Sat, 15 Feb 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAOF4YbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0C1925AC;
	Sat, 15 Feb 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662800; cv=none; b=AI/BqxbDBPSRqks3I08mUON9HzNBEIAyoHv+Fd4mcm9B1i1lnz5zVAeRLUm8fF9bnaS6gCPAWQ2fI6ctIivyjLjAGUvC8cs7Rze6gq6KO3Kky/ru4/XexigusIXs7/Dd8Zrlx0GTvf62wGZFEuOip6Vg25HLHZpashKeiuX3Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662800; c=relaxed/simple;
	bh=C03vfY/YewPcsWqb71F4heYY/J42ivxfv87i7Ms0uoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7Eb2gBu1c8LFi+bb9HO+4UtolIoGN/SX7fkpR6DHNYC3JP4Hjw4HgyYJ+ePqWvNROrUGSwYMUiX+rWbwJJMQVBVLIki6KQFh3w9C6K4XfPvRp4C4TrYF5w242yHG9J1q9X6eWU8OLTo2XTBBW8jLmCNh8/YWETfk/L5CrPBa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAOF4YbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35203C4CEDF;
	Sat, 15 Feb 2025 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739662799;
	bh=C03vfY/YewPcsWqb71F4heYY/J42ivxfv87i7Ms0uoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAOF4YbT8Fkxq+UQItc/1gGn5BPEEE5z5GToaY8kBogwjZ2w7ege97NXCmFPMR2kM
	 CMkiz4TasJm3XFfwQPKLuaMpceBUxTNP10KZPEiivB3gB9rX0q4zC7Pra9joHKGhog
	 sqBAO0sIh+ynP20z2RyoUAIlz7OgtrE/Xy0Y52bRV6jcYqKO9HQhOGg37G6Frx8khd
	 iTvbAl+uMpdCxIhAFqnCKvWcaRx2BT9KDw7BhnQ5XIDGqzKAETulRiOTL7XkPAadzl
	 YtAH/mut35SRiUdWwPgVtGJqo2qSBj5sRuq0+ojq9424u/6mHrJCXr0ROX5PIY8RF8
	 xAf24EmBTYJoQ==
Received: by pali.im (Postfix)
	id BAB14676; Sun, 16 Feb 2025 00:39:46 +0100 (CET)
Date: Sun, 16 Feb 2025 00:39:46 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Immutable vs read-only for Windows compatibility
Message-ID: <20250215233946.cxznczjjiu7vqazf@pali>
References: <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
 <20250114215350.gkc2e2kcovj43hk7@pali>
 <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com>
 <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
 <CAOQ4uxjj3XUNh6p3LLp_4YCJQ+cQHu7dj8uM3gCiU61L3CQRpA@mail.gmail.com>
 <20250117173900.GN3557553@frogsfrogsfrogs>
 <CAOQ4uxhh1LDz5zXzqFENPhJ9k851AL3E7Xc2d7pSVVYX4Fu9Jw@mail.gmail.com>
 <20250117185947.ylums2dhmo3j6hol@pali>
 <20250202152343.ahy4hnzbfuzreirz@pali>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250202152343.ahy4hnzbfuzreirz@pali>
User-Agent: NeoMutt/20180716

Some updates...

On Sunday 02 February 2025 16:23:43 Pali Rohár wrote:
> And how many bit flags are needed? I have done some investigation. Lets
> start with table which describes all 32 possible bit flags which are
> used by Windows system and also by filesystems FAT / exFAT / NTFS / ReFS
> and also by SMB over network:
> 
> bit / attrib.exe flag / SDK constant / description
> 
>  0 - R - FILE_ATTRIBUTE_READONLY              - writing to file or deleting it is disallowed
>  1 - H - FILE_ATTRIBUTE_HIDDEN                - inode is hidden
>  2 - S - FILE_ATTRIBUTE_SYSTEM                - inode is part of operating system
>  3 -   - FILE_ATTRIBUTE_VOLUME                - inode is the disk volume label entry
>  4 -   - FILE_ATTRIBUTE_DIRECTORY             - inode is directory
>  5 - A - FILE_ATTRIBUTE_ARCHIVE               - inode was not archived yet (when set)
>  6 -   - FILE_ATTRIBUTE_DEVICE                - inode represents  in-memory device (e.g. C:\), flag not stored on filesystem
>  7 -   - FILE_ATTRIBUTE_NORMAL                - no other flag is set (value 0 means to not change flags, bit 7 means to clear all flags)
>  8 -   - FILE_ATTRIBUTE_TEMPORARY             - inode data do not have to be flushed to disk
>  9 -   - FILE_ATTRIBUTE_SPARSE_FILE           - file is sparse with holes
> 10 -   - FILE_ATTRIBUTE_REPARSE_POINT         - inode has attached reparse point (symlink is also reparse point)
> 11 -   - FILE_ATTRIBUTE_COMPRESSED            - file is compressed, for directories it means that newly created inodes would have this flag set
> 12 - O - FILE_ATTRIBUTE_OFFLINE               - HSM - inode is used by HSM
> 13 - I - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   - inode will not be indexed by content indexing service
> 14 -   - FILE_ATTRIBUTE_ENCRYPTED             - file is encrypted, for directories it means that newly created inodes would have this flag set
> 15 - V - FILE_ATTRIBUTE_INTEGRITY_STREAM      - fs does checksumming of data and metadata when reading inode, read-only

FILE_ATTRIBUTE_INTEGRITY_STREAM can be enabled for individual inode via
FSCTL_SET_INTEGRITY_INFORMATION or FSCTL_SET_INTEGRITY_INFORMATION_EX
fs ioctl call, available on Windows and also via SMB protocol. So
de-facto it is read-write attribute, just over SMB requires separate
operation for changing it.

In similar way can be modified also FILE_ATTRIBUTE_COMPRESSED and
FILE_ATTRIBUTE_ENCRYPTED attributes.

> 16 -   - FILE_ATTRIBUTE_VIRTUAL               - inode is in %LocalAppData%\VirtualStore, flag not stored on filesystem
> 17 - X - FILE_ATTRIBUTE_NO_SCRUB_DATA         - do not use scrubber (proactive background data integrity scanner) on this file, for directories it means that newly created inodes would have this flag set
> 18 -   - FILE_ATTRIBUTE_EA                    - inode has xattrs, (not in readdir output, shares same bit with FILE_ATTRIBUTE_RECALL_ON_OPEN)
> 18 -   - FILE_ATTRIBUTE_RECALL_ON_OPEN        - HSM - inode is not stored locally (only in readdir output, shares same bit with FILE_ATTRIBUTE_EA)
> 19 - P - FILE_ATTRIBUTE_PINNED                - HSM - inode data content must be always stored on locally
> 20 - U - FILE_ATTRIBUTE_UNPINNED              - HSM - inode data content can be removed from local storage
> 21 -   -                                      - reserved
> 22 -   - FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS - HSM - inode data content is not stored locally
> 23 -   -                                      - reserved
> 24 -   -                                      - reserved
> 25 -   -                                      - reserved
> 26 -   -                                      - reserved
> 27 -   -                                      - reserved
> 28 -   -                                      - reserved
> 29 - B - FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL   - SMR Blob, unknown meaning, read-only
> 30 -   -                                      - reserved
> 31 -   -                                      - reserved
> 
> (HSM means Hierarchical Storage Management software, which uses reparse
> points to make some remote file/folder available on the local
> filesystem, for example OneDrive or DropBox)
> 
> From above list only following bit flags are suitable for modification
> over some Linux API:
> - FILE_ATTRIBUTE_READONLY
> - FILE_ATTRIBUTE_HIDDEN
> - FILE_ATTRIBUTE_SYSTEM
> - FILE_ATTRIBUTE_ARCHIVE
> - FILE_ATTRIBUTE_TEMPORARY
> - FILE_ATTRIBUTE_COMPRESSED
> - FILE_ATTRIBUTE_OFFLINE
> - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
> - FILE_ATTRIBUTE_ENCRYPTED
> - FILE_ATTRIBUTE_NO_SCRUB_DATA
> - FILE_ATTRIBUTE_PINNED
> - FILE_ATTRIBUTE_UNPINNED

Hence this list needs to be extended by FILE_ATTRIBUTE_INTEGRITY_STREAM
attribute.

FILE_ATTRIBUTE_INTEGRITY_STREAM is interesting attribute as it allows to
enable checksumming of file content.

> And if I'm looking correctly the FILE_ATTRIBUTE_COMPRESSED can be
> already mapped to Linux FS_COMPR_FL / STATX_ATTR_COMPRESSED, which has
> same meaning. Also FILE_ATTRIBUTE_ENCRYPTED can be mapped to
> FS_ENCRYPT_FL / STATX_ATTR_ENCRYPTED. Note that these two flags cannot
> be set over WinAPI or SMB directly and it is required to use special
> WinAPI or SMB ioctl.
> 
> So totally are needed 10 new bit flags. And for future there are 9
> reserved bits which could be introduced by MS in future.
> 
> Additionally there are get-only attributes which can be useful for statx
> purposes (for example exported by cifs.ko SMB client):
> - FILE_ATTRIBUTE_REPARSE_POINT
> - FILE_ATTRIBUTE_INTEGRITY_STREAM
> - FILE_ATTRIBUTE_RECALL_ON_OPEN
> - FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS
> - FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL
> 
> From the above list of flags suitable for modification, following bit
> flags have no meaning for kernel and it is up to userspace how will use
> them. What is needed from kernel and/or filesystem driver is to preserve
> those bit flags.
> - FILE_ATTRIBUTE_HIDDEN
> - FILE_ATTRIBUTE_SYSTEM
> - FILE_ATTRIBUTE_ARCHIVE
> - FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
> 
> Following are bit flags which kernel / VFS / fsdriver would have to
> handle specially, to provide enforcement or correct behavior of them:
> - FILE_ATTRIBUTE_READONLY - enforce that data modification or unlink is disallowed when set
> - FILE_ATTRIBUTE_COMPRESSED - enforce compression on filesystem when set
> - FILE_ATTRIBUTE_ENCRYPTED - enforce encryption on filesystem when set
> 
> Then there are HSM flags which for local filesystem would need some
> cooperation with userspace synchronization software. For network
> filesystems (SMB / NFS4) they need nothing special, just properly
> propagating them over network:
> - FILE_ATTRIBUTE_OFFLINE
> - FILE_ATTRIBUTE_PINNED
> - FILE_ATTRIBUTE_UNPINNED
> 
> About following 2 flags, I'm not sure if the kernel / VFS / fs driver
> has to do something or it can just store bits to fs:
> - FILE_ATTRIBUTE_TEMPORARY
> - FILE_ATTRIBUTE_NO_SCRUB_DATA

