Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861B294FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502456AbgJUPVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 11:21:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34809 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502132AbgJUPVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:21:17 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09LFL480015217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 11:21:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6B5E6420107; Wed, 21 Oct 2020 11:21:04 -0400 (EDT)
Date:   Wed, 21 Oct 2020 11:21:04 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RFC 6/7] fs: Add more superblock error subtypes
Message-ID: <20201021152104.GO181507@mit.edu>
References: <20201020191543.601784-1-krisman@collabora.com>
 <20201020191543.601784-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020191543.601784-7-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:15:42PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
> index d0a45a4ded7d..6bfe35dc7b5d 100644
> --- a/include/uapi/linux/watch_queue.h
> +++ b/include/uapi/linux/watch_queue.h
> @@ -110,6 +110,10 @@ enum superblock_notification_type {
>  	NOTIFY_SUPERBLOCK_ERROR		= 1, /* Error in filesystem or blockdev */
>  	NOTIFY_SUPERBLOCK_EDQUOT	= 2, /* EDQUOT notification */
>  	NOTIFY_SUPERBLOCK_NETWORK	= 3, /* Network status change */
> +	NOTIFY_SUPERBLOCK_INODE_ERROR	= 4, /* Inode Error */
> +	NOTIFY_SUPERBLOCK_WARNING	= 5, /* Filesystem warning */
> +	NOTIFY_SUPERBLOCK_INODE_WARNING	= 6, /* Filesystem inode warning */
> +	NOTIFY_SUPERBLOCK_MSG		= 7, /* Filesystem message */
>  };

Hmm, I wonder if this is the right break down.  In ext4 we have
ext4_error() and ext4_error_inode(), but that's just a convenience so
that if there is an error number, we can log information relating to
the inode.  It's unclear if we need to break apart *_WARNING and
*INODE_WARNING in the notification types.  So I'd suggest dropping
*_INODE_ERROR and *_INODE_WARNING and let those get subsumed into
*_ERROR and *_WARNING.  We can include the __64 for block and inode
numbers for *_ERROR and _*WARNING, which can be non-zero if they are
available for a particular notification.

I *do* thnk we should separate out file system error and blockdev
warnings, however.  So maybe NOTIFY_SUPERBLOCK_ERROR should be
redifined to mean only "file system level error" and we should add a
NOTIFY_SUPERBLOCK_EIO for an I/O errors coming from the block device.
For that notification type, we can add a __u8 or __u32 containing the
BLK_STS_* errors.

I suspect in the future we should also consider a new block device
notification scheme, where we can provide more detailed information
such as SCSI sense codes, etc.  But that's a separable feature, I
think.

Cheers,

					- Ted
