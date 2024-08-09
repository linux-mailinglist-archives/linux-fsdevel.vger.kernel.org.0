Return-Path: <linux-fsdevel+bounces-25511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E21B94CFA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45D62852F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971C193091;
	Fri,  9 Aug 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd6Pbelg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38F1553A2;
	Fri,  9 Aug 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204642; cv=none; b=GWVzr7zdhK4Brz13EzbSwZVGSxAU0fxEPC8r/+2aL3q7iqfV3V+iq/T5WHpXsBt7cwvXsDX0ZYWt1Xeu6ZMTBj1F9icUE0MEpPDKe8aXttAZ3fpJ1oy8m7S1VLo0HmdpGYslWlFUk1JL1/c5aXytixXARCb2/zyQPX7yPt0ZUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204642; c=relaxed/simple;
	bh=oCiN2idKp9IW3aS5vqr9XUsUigXl+Y+PA5C0bMS0u/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obeejPPJNAUjPvV3vA585V9GnManVRCr5ZrGXMYiOEtnk0ZMjQm99CurtbDkg0y6NHIpu08UZSwAdJniUckWs3YhaclhTgpRLXJit/eGlEQzrDvNmAav8pn+K0xJTp5zXbYAAMMg+pMdTW+9Z8dZzrzOWPqq896JLFniUlQmwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd6Pbelg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA13C32782;
	Fri,  9 Aug 2024 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204641;
	bh=oCiN2idKp9IW3aS5vqr9XUsUigXl+Y+PA5C0bMS0u/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fd6PbelgT0u4bqxCsMOEKa0rqy8/7GKGF5Vdk3DN5jd8Cr0NPcK8XlWBXsLVwy16J
	 hgAtGyuDygjsVTWuKetvzUjy3qzGpQ6sZbTCI0VVV9qApYBQ8Jvhdu6+0+gpTayJEH
	 LkQBUnu03VcW6uQX1rmpArNRqndRwSo11JmNRBSI7E+lVuJ7wY376kYCwJfVRiMcAd
	 F7Q5aLaJDaZ9gS6UheBuRgla5ndj6JU+0bYe/Hm3Opuaw9zHtCSSiGfSvbuBuudu7E
	 rBdqhQHg/2BK/BTwyeMlbZjbZpRf+ap34IkIg8yVUAhLoAzouQcqMzNMDKaKjRTv0v
	 yMGuZRS51xZpw==
Date: Fri, 9 Aug 2024 13:57:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 04/16] fanotify: introduce FAN_PRE_ACCESS permission
 event
Message-ID: <20240809-heizen-umgehen-b56bbe6b3409@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <e8d1f99389aa81f0bfbfb082f9cbaa614e59f994.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8d1f99389aa81f0bfbfb082f9cbaa614e59f994.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:06PM GMT, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
> class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.
> 
> Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
> in the context of the event handler.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill the content of files on first read access.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  3 ++-
>  fs/notify/fanotify/fanotify_user.c | 17 ++++++++++++++---
>  include/linux/fanotify.h           | 14 ++++++++++----
>  include/uapi/linux/fanotify.h      |  2 ++
>  4 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 224bccaab4cc..7dac8e4486df 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -910,8 +910,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
> +	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
>  					 mask, data, data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 2e2fba8a9d20..c294849e474f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1628,6 +1628,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  				     unsigned int flags)
>  {
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +	bool is_dir = d_is_dir(path->dentry);
>  	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
>  	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
>  				 (mask & FAN_RENAME) ||
> @@ -1665,9 +1666,15 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  	 * but because we always allowed it, error only when using new APIs.
>  	 */
>  	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
> -	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
> +	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
>  		return -ENOTDIR;
>  
> +	/* Pre-content events are only supported on regular files and dirs */
> +	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +		if (!is_dir && !d_is_reg(path->dentry))
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1769,11 +1776,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		goto fput_and_out;
>  
>  	/*
> -	 * Permission events require minimum priority FAN_CLASS_CONTENT.
> +	 * Permission events are not allowed for FAN_CLASS_NOTIF.
> +	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
>  	 */
>  	ret = -EINVAL;
>  	if (mask & FANOTIFY_PERM_EVENTS &&
> -	    group->priority < FSNOTIFY_PRIO_CONTENT)
> +	    group->priority == FSNOTIFY_PRIO_NORMAL)
> +		goto fput_and_out;
> +	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
> +		 group->priority == FSNOTIFY_PRIO_CONTENT)
>  		goto fput_and_out;
>  
>  	if (mask & FAN_FS_ERROR &&
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 4f1c4f603118..5c811baf44d2 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -88,6 +88,16 @@
>  #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
>  				 FAN_RENAME)
>  
> +/* Content events can be used to inspect file content */
> +#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
> +				      FAN_ACCESS_PERM)
> +/* Pre-content events can be used to fill file content */
> +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> +
> +/* Events that require a permission response from user */
> +#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
> +				 FANOTIFY_PRE_CONTENT_EVENTS)
> +

Fwiw, this is one of my pet peeves with fanotify. It uses nesting of
defines very liberally. For the occasional reader that needs to
understand what flags are checked for its quite an excercise having to
go back and resolving multiple levels of defines. I would humbly urge
some restraint in that area.

Reviewed-by: Christian Brauner <brauner@kernel.org>

