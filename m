Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C41433CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhJSQtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:49:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34194 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhJSQtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:49:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E81C22196D;
        Tue, 19 Oct 2021 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634662054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGaPuv31UfSY7MzqbTTvLJbAn2A/its3lnIVP/6dwtE=;
        b=iXNmh1SHFpPh1eTWHLRhaMCsPIzEubN1tblfc6v8Vzf4D3unWM9bNvZfN/vC9GK/O1A3Bq
        MWDi/PeY4tX28f1Zf+TsLpkLRhNf9nEYNESbuCYDvBgz3WL6BDd8uo31kmvDGmMJ1oJ+0k
        Vp6GUy9Ke/hBSob+Iihk4b+au5TQxnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634662054;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGaPuv31UfSY7MzqbTTvLJbAn2A/its3lnIVP/6dwtE=;
        b=1H582NFamAi4ZMk1WdNvtErWxFI4KGkDrD7zoa4T5HpXx/FgcQfqUYLz+gq7lp8FjBoQ+B
        rSbpYyWVWRYy/1BQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D07FDA3B9A;
        Tue, 19 Oct 2021 16:47:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A80791E0983; Tue, 19 Oct 2021 18:47:33 +0200 (CEST)
Date:   Tue, 19 Oct 2021 18:47:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 32/32] docs: Document the FAN_FS_ERROR event
Message-ID: <20211019164733.GU3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-33-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-33-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:15, Gabriel Krisman Bertazi wrote:
> Document the FAN_FS_ERROR event for user administrators and user space
> developers.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes Since v7:
>   - Update semantics
> Changes Since v6:
>   - English fixes (jan)
>   - Proper document error field (jan)
> Changes Since v4:
>   - Update documentation about reporting non-file error.
> Changes Since v3:
>   - Move FAN_FS_ERROR notification into a subsection of the file.
> Changes Since v2:
>   - NTR
> Changes since v1:
>   - Drop references to location record
>   - Explain that the inode field is optional
>   - Explain we are reporting only the first error
> ---
>  .../admin-guide/filesystem-monitoring.rst     | 76 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/admin-guide/filesystem-monitoring.rst
> 
> diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
> new file mode 100644
> index 000000000000..f1f6476fa4f3
> --- /dev/null
> +++ b/Documentation/admin-guide/filesystem-monitoring.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================
> +File system Monitoring with fanotify
> +====================================
> +
> +File system Error Reporting
> +===========================
> +
> +Fanotify supports the FAN_FS_ERROR event type for file system-wide error
> +reporting.  It is meant to be used by file system health monitoring
> +daemons, which listen for these events and take actions (notify
> +sysadmin, start recovery) when a file system problem is detected.
> +
> +By design, A FAN_FS_ERROR notification exposes sufficient information
             ^^ a

> +for a monitoring tool to know a problem in the file system has happened.
> +It doesn't necessarily provide a user space application with semantics
> +to verify an IO operation was successfully executed.  That is out of
> +scope for this feature.  Instead, it is only meant as a framework for
> +early file system problem detection and reporting recovery tools.
> +
> +When a file system operation fails, it is common for dozens of kernel
> +errors to cascade after the initial failure, hiding the original failure
> +log, which is usually the most useful debug data to troubleshoot the
> +problem.  For this reason, FAN_FS_ERROR tries to report only the first
> +error that occurred for a process since the last notification, and it
                           ^^^^^^^^ rather for "a filesystem", no?

> +simply counts additional errors.  This ensures that the most important
> +pieces of information are never lost.
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

I'd add a note here that the ordering of "Generic Error Record" and "FID
record" is not really guaranteed and refer to sample code for sample
parser.

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
> +The `error` field identifies the error in a file-system specific way.
> +Ext4, for instance, which is the only file system implementing this
> +interface at the time of this writing, exposes EXT4_ERR_ values in this
> +field.  Please refer to the file system documentation for the meaning of
> +specific error codes.

If 'error' is filesystem-specific number, then how does this work with
"filesystem agnostic" tool? All it can tell is "something happened"... If
the error was generic errno, I can see some value in the tool being able to
tell this is fs corruption (EFSCORRUPTED), hardware problem (EIO), thin
provisioning running out of space (ENOSPC) or something else. But yes, I do
realize it is going to be more painful to make all filesystem generate
these sensible error codes. Even within a filesystem it may be sometimes
difficult to propagate proper error code to fsnotify so maybe error codes
will not be usable for decisions like above... What do others think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
