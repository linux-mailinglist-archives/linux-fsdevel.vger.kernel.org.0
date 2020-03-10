Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A617F3A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCJJbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 05:31:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJJbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:31:22 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jBbEL-0006Oe-CB; Tue, 10 Mar 2020 09:31:17 +0000
Date:   Tue, 10 Mar 2020 10:31:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] fsinfo: Add fsinfo() syscall to query filesystem
 information [ver #18]
Message-ID: <20200310093116.ylq6vaunr6js4eyy@wittgenstein>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376246603.344135.4335596732820276494.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158376246603.344135.4335596732820276494.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:01:06PM +0000, David Howells wrote:
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
> 
> ===============
> NEW SYSTEM CALL
> ===============
> 
> The new system call looks like:
> 
> 	int ret = fsinfo(int dfd,
> 			 const char *pathname,
> 			 const struct fsinfo_params *params,
> 			 size_t params_size,
> 			 void *result_buffer,
> 			 size_t result_buf_size);
> 
> The params parameter optionally points to a block of parameters:
> 
> 	struct fsinfo_params {
> 		__u32	resolve_flags;
> 		__u32	flags;
> 		__u32	request;
> 		__u32	Nth;
> 		__u32	Mth;
> 	};
> 
> If params is NULL, the default is that params->request is
> FSINFO_ATTR_STATFS and all the other fields are 0.  params_size indicates
> the size of the parameter struct.  If the parameter block is short compared
> to what the kernel expects, the missing length will be set to 0; if the
> parameter block is longer, an error will be given if the excess is not all
> zeros.
> 
> The object to be queried is specified as follows - part param->flags
> indicates the type of reference:
> 
>  (1) FSINFO_FLAGS_QUERY_PATH - dfd, pathname and at_flags indicate a
>      filesystem object to query.  There is no separate system call
>      providing an analogue of lstat() - RESOLVE_NO_TRAILING_SYMLINKS should
>      be set in at_flags instead.  RESOLVE_NO_TRAILING_AUTOMOUNTS can also
>      be used to an allow automount point to be queried without triggering
>      it.
> 
>  (2) FSINFO_FLAGS_QUERY_FD - dfd indicates a file descriptor pointing to
>      the filesystem object to query.  pathname should be NULL.
> 
>  (3) FSINFO_FLAGS_QUERY_MOUNT - pathname indicates the numeric ID of the
>      mountpoint to query as a string.  dfd is used to constrain which
>      mounts can be accessed.  If dfd is AT_FDCWD, the mount must be within
>      the subtree rooted at chroot, otherwise the mount must be within the
>      subtree rooted at the directory specified by dfd.
> 
>  (4) In the future FSINFO_FLAGS_QUERY_FSCONTEXT will be added - dfd will
>      indicate a context handle fd obtained from fsopen() or fspick(),
>      allowing that to be queried before the target superblock is attached
>      to the filesystem or even created.
> 
> params->request indicates the attribute/attributes to be queried.  This can
> be one of:
> 
> 	FSINFO_ATTR_STATFS		- statfs-style info
> 	FSINFO_ATTR_IDS			- Filesystem IDs
> 	FSINFO_ATTR_LIMITS		- Filesystem limits
> 	FSINFO_ATTR_SUPPORTS		- Support for statx, ioctl, etc.
> 	FSINFO_ATTR_TIMESTAMP_INFO	- Inode timestamp info
> 	FSINFO_ATTR_VOLUME_ID		- Volume ID (string)
> 	FSINFO_ATTR_VOLUME_UUID		- Volume UUID
> 	FSINFO_ATTR_VOLUME_NAME		- Volume name (string)
> 	FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO - Information about attr Nth
> 	FSINFO_ATTR_FSINFO_ATTRIBUTES	- List of supported attrs
> 
> Some attributes (such as the servers backing a network filesystem) can have
> multiple values.  These can be enumerated by setting params->Nth and
> params->Mth to 0, 1, ... until ENODATA is returned.
> 
> result_buffer and result_buf_size point to the reply buffer.  The buffer is
> filled up to the specified size, even if this means truncating the reply.
> The size of the full reply is returned, irrespective of the amount data
> that was copied.  In future versions, this will allow extra fields to be
> tacked on to the end of the reply, but anyone not expecting them will only
> get the subset they're expecting.  If either buffer of result_buf_size are
> 0, no copy will take place and the data size will be returned.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org

You're missing to wire-up the syscall into the arm64 unistd32.h table
and this is all in one patch. I'd rather do it like we have done for all
other syscalls recently, and split this into:
- actual syscall implementation
- final wiring-up patch
Will make it easier to apply and spot merge conflicts when multiple
syscalls are proposed. I'm going to respond to this mail here with two
patches. One could replace this one I'm responding to and the other one
should probably go on top of the series.
(Please note that the same missing arm64 unistd32.h handling also likely
 affects the watch syscalls as I haven't seen them in there when I added
 fsinfo().)

