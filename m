Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E321FD692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQVAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 17:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQVAr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:00:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBBA2166E;
        Wed, 17 Jun 2020 21:00:46 +0000 (UTC)
Date:   Wed, 17 Jun 2020 17:00:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/7] libfs: group and simplify linux fs code
Message-ID: <20200617170045.7d41976d@oasis.local.home>
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


What happened to this work?

-- Steve


On Mon,  4 May 2020 11:00:25 +0200
Emanuele Giuseppe Esposito <eesposit@redhat.com> wrote:

> libfs.c has many functions that are useful to implement dentry and inode
> operations, but not many at the filesystem level.  As a result, code to
> create files and inodes has a lot of duplication, to the point that
> tracefs has copied several hundred lines from debugfs.
> 
> The main two libfs.c functions for filesystems are simple_pin_fs and
> simple_release_fs, which hide a somewhat complicated locking sequence
> that is needed to serialize vfs_kern_mount and mntget.  In this series,
> my aim is to add functions that create dentries and inodes of various
> kinds (either anonymous inodes, or directory/file/symlink).  These
> functions take the code that was duplicated across debugfs and tracefs
> and move it to libfs.c.
> 
> In order to limit the number of arguments to the new functions, the
> series first creates a data type that is passed to both
> simple_pin_fs/simple_release_fs and the new creation functions.  The new
> struct, introduced in patch 2, simply groups the "mount" and "count"
> arguments to simple_pin_fs and simple_release_fs.
> 
> Patches 1-4 are preparations to introduce the new simple_fs struct and
> new functions that are useful in the remainder of the series.  Patch 5
> introduces the dentry and inode creation functions.  Patch 6-7 can then
> adopt them in debugfs and tracefs.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> 
> v1->v2: rename simple_new_inode in new_inode_current_time,
> more detailed explanations, put all common code in fs/libfs.c
> 
> v2->v3: remove unused debugfs_get_inode and tracefs_get_inode
> functions
> 
> Emanuele Giuseppe Esposito (7):
>   apparmor: just use vfs_kern_mount to make .null
>   libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
>   libfs: introduce new_inode_current_time
>   libfs: add alloc_anon_inode wrapper
>   libfs: add file creation functions
>   debugfs: switch to simplefs inode creation API
>   tracefs: switch to simplefs inode creation API
> 
>  drivers/gpu/drm/drm_drv.c       |  11 +-
>  drivers/misc/cxl/api.c          |  13 +-
>  drivers/scsi/cxlflash/ocxl_hw.c |  14 +-
>  fs/binfmt_misc.c                |   9 +-
>  fs/configfs/mount.c             |  10 +-
>  fs/debugfs/inode.c              | 169 +++---------------
>  fs/libfs.c                      | 299 ++++++++++++++++++++++++++++++--
>  fs/tracefs/inode.c              | 106 ++---------
>  include/linux/fs.h              |  31 +++-
>  security/apparmor/apparmorfs.c  |  38 ++--
>  security/inode.c                |  11 +-
>  11 files changed, 399 insertions(+), 312 deletions(-)
> 

