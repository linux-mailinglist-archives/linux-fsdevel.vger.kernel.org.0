Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8D3EDB17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhHPQlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:41:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhHPQlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:41:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2724C1FFA0;
        Mon, 16 Aug 2021 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629132047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5mvDbyXu38EQg7d4bfWnpLk/l1fW+Wsj5gUw54o9gA=;
        b=Zt3lYYGzbKNRAJa39AbOvG6Nd/EZDb1ofETzUnQVeAC79MWchH/mFZT5Ts3nXtZCRWmhkW
        M+7I34t4DkXmBEPJIpq9hg1zxakGIVX++M3arzjPfJRI3NxKVLBmUohd4ovt1hQ4NMlqgZ
        9gVn8FSX0iuCtTXvJWz+D3TlNp6i+0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629132047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5mvDbyXu38EQg7d4bfWnpLk/l1fW+Wsj5gUw54o9gA=;
        b=uqO6KNWfCTLD6qYgtQfXp6hDsHL6toqXp7Q/LBwNiYliP2YN1hs6NY3kiS46IC/RJBdSTB
        013BVcwgwNSKJ+DA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0F4A8A3B94;
        Mon, 16 Aug 2021 16:40:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E07DC1E0426; Mon, 16 Aug 2021 18:40:43 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:40:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 21/21] docs: Document the FAN_FS_ERROR event
Message-ID: <20210816164043.GK30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-22-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-22-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:10, Gabriel Krisman Bertazi wrote:
> Document the FAN_FS_ERROR event for user administrators and user space
> developers.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

<snip>

> diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
> new file mode 100644
> index 000000000000..b03093567a93
> --- /dev/null
> +++ b/Documentation/admin-guide/filesystem-monitoring.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +File system Monitoring with fanotify
> +====================================
> +
> +File system Error Reporting
> +===========================
> +
> +fanotify supports the FAN_FS_ERROR mark for file system-wide error
   ^ Capital 'F'.                     ^^^ I'd rather write "event type".

> +reporting.  It is meant to be used by file system health monitoring
> +daemons who listen on that interface and take actions (notify sysadmin,
           ^^^ which  ^^^^^^^^^^^^^^^^^ for these events

> +start recovery) when a file system problem is detected by the kernel.
> +
> +By design, A FAN_FS_ERROR notification exposes sufficient information for a
> +monitoring tool to know a problem in the file system has happened.  It
> +doesn't necessarily provide a user space application with semantics to
> +verify an IO operation was successfully executed.  That is outside of
> +scope of this feature. Instead, it is only meant as a framework for
> +early file system problem detection and reporting recovery tools.
> +
> +When a file system operation fails, it is common for dozens of kernel
> +errors to cascade after the initial failure, hiding the original failure
> +log, which is usually the most useful debug data to troubleshoot the
> +problem.  For this reason, FAN_FS_ERROR only reports the first error that
> +occurred since the last notification, and it simply counts addition
							      ^^^ additional

> +errors.  This ensures that the most important piece of error information
> +is never lost.
> +
> +FAN_FS_ERROR requires the fanotify group to be setup with the
> +FAN_REPORT_FID flag.
> +
> +At the time of this writing, the only file system that emits FAN_FS_ERROR
> +notifications is Ext4.
> +
> +A user space example code is provided at ``samples/fanotify/fs-monitor.c``.
> +
> +A FAN_FS_ERROR Notification has the following format::
> +
> +  [ Notification Metadata (Mandatory) ]
> +  [ Generic Error Record  (Mandatory) ]
> +  [ FID record            (Mandatory) ]
> +
> +Generic error record
> +--------------------
> +
> +The generic error record provides enough information for a file system
> +agnostic tool to learn about a problem in the file system, without
> +providing any additional details about the problem.  This record is
> +identified by ``struct fanotify_event_info_header.info_type`` being set
> +to FAN_EVENT_INFO_TYPE_ERROR.
> +
> +  struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +  };
> +
> +The `error` field identifies the type of error. `error_count` count
> +tracks the number of errors that occurred and were suppressed to
> +preserve the original error, since the last notification.

So is 'error' expected to be errno? Or is that some fs-specific error
identifier? Will it be positive (i.e. real errno) or negative (as errno is
usually passed in the kernel)? I think it should be specified here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
