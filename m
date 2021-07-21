Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A53D19D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGUV6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGUV6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:58:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920DC061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 15:39:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q13so1360051plx.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgSFlgIErcE20qOtBjVS3tEuJuhNy+gIfspSfkxg+jg=;
        b=FmtIS2QP+SG1tZGGEc3x7dlWedV8xt76PF0aijqIROWCNhFyaxFg7DZcqySV2vBtyM
         TUcBON3fQezuxRAhLI3ofPJupt7SsuVx4LpdYs8j1nPopT0WThoow6S71k5trra4utzL
         FI5/rf0W8UDyAJiO1jnQilnUuGMdNk4Jp7AOCumLK/iVpMplRNCCprP14q4KL7qamWbW
         P6fSjM6yjxyueVTah5b4kfetvPlf8mq4M+s+OavKjtfMKj6QrLBO2jvDlmQV7rLRLXx2
         MTfgEnwEKJk7nnK+0jPGwv9VsoEDjyMgxUlzYoNO1o14Gl6c4dluT2Mn0P2uFLMt6rLV
         EGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgSFlgIErcE20qOtBjVS3tEuJuhNy+gIfspSfkxg+jg=;
        b=nNvAOdNxdVUEw4DfV0nKVcltrXlrKJiogHBYM7+m64y/3669oYhGJLfrTzA84dDLeZ
         9e+Ly4jh4AMabZyQRaSTAfYj16Hg5qkmsdPeVFrKQKAi05IlK/6+9k7hIaGILipvF0kn
         NktHgrWHGup06cZ4u/U8VHi1p1YnlOB6bL7g9gaxQb4RvOvoxQzp+VcDXKyj/4yq5GKD
         5U6Wc5aiuAdTP7ImzYAZ3M/Pu4YTvRvWCcYlLJgfz/KZ+CkEIgcZB7wP7J2uzV9VDLql
         xmCoL3OTOOfMI2/0J6MDnSYoYKgwWPiqOuTyrk5X2G2f2wOUIc+/IBagV2CqsdP+kwyA
         l9ng==
X-Gm-Message-State: AOAM532co0cR4T1sllErCh0K0CP37Q7P/NycelPB0eTYPyegkWlJpgIO
        +i+wmAh+soUCQGbNFUJQGFqrAw==
X-Google-Smtp-Source: ABdhPJwud0FGocuPTKNSo7W7DBEItQNmDXHKuGbfLPko2JI+TsbsDJGYYyxOHu+/u8Sz/9dQTib/9A==
X-Received: by 2002:a17:90a:550a:: with SMTP id b10mr5973295pji.103.1626907143106;
        Wed, 21 Jul 2021 15:39:03 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:5ef6:1575:7ff9:6e66])
        by smtp.gmail.com with ESMTPSA id ft7sm873941pjb.32.2021.07.21.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:39:02 -0700 (PDT)
Date:   Thu, 22 Jul 2021 08:38:51 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fanotify: fix copy_event_to_user() fid error clean
 up
Message-ID: <YPih+xdLAJ2qQ/uW@google.com>
References: <20210721125407.GA25822@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721125407.GA25822@kili>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:54:07AM -0700, Dan Carpenter wrote:
> Hello Matthew Bobrowski,
> 
> The patch f644bc449b37: "fanotify: fix copy_event_to_user() fid error
> clean up" from Jun 11, 2021, leads to the following static checker
> warning:
> 
> 	fs/notify/fanotify/fanotify_user.c:533 copy_event_to_user()
> 	error: we previously assumed 'f' could be null (see line 462)

I've made a couple comments below. What am I missing?

> fs/notify/fanotify/fanotify_user.c
>     401 static ssize_t copy_event_to_user(struct fsnotify_group *group,
>     402 				  struct fanotify_event *event,
>     403 				  char __user *buf, size_t count)
>     404 {
>     405 	struct fanotify_event_metadata metadata;
>     406 	struct path *path = fanotify_event_path(event);
>     407 	struct fanotify_info *info = fanotify_event_info(event);
>     408 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>     409 	struct file *f = NULL;
>     410 	int ret, fd = FAN_NOFD;
>     411 	int info_type = 0;
>     412 
>     413 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>     414 
>     415 	metadata.event_len = FAN_EVENT_METADATA_LEN +
>     416 				fanotify_event_info_len(fid_mode, event);
>     417 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
>     418 	metadata.vers = FANOTIFY_METADATA_VERSION;
>     419 	metadata.reserved = 0;
>     420 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
>     421 	metadata.pid = pid_vnr(event->pid);
>     422 	/*
>     423 	 * For an unprivileged listener, event->pid can be used to identify the
>     424 	 * events generated by the listener process itself, without disclosing
>     425 	 * the pids of other processes.
>     426 	 */
>     427 	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
>     428 	    task_tgid(current) != event->pid)
>     429 		metadata.pid = 0;
>     430 
>     431 	/*
>     432 	 * For now, fid mode is required for an unprivileged listener and
>     433 	 * fid mode does not report fd in events.  Keep this check anyway
>     434 	 * for safety in case fid mode requirement is relaxed in the future
>     435 	 * to allow unprivileged listener to get events with no fd and no fid.
>     436 	 */
>     437 	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
>     438 	    path && path->mnt && path->dentry) {
>     439 		fd = create_fd(group, path, &f);
>     440 		if (fd < 0)
>     441 			return fd;
>     442 	}
> 
> "f" is NULL on the else path

Uh ha, although "fd" on the else path also remains set to the initial value
of FAN_NOFD, right?

>     443 	metadata.fd = fd;
>     444 
>     445 	ret = -EFAULT;
>     446 	/*
>     447 	 * Sanity check copy size in case get_one_event() and
>     448 	 * event_len sizes ever get out of sync.
>     449 	 */
>     450 	if (WARN_ON_ONCE(metadata.event_len > count))
>     451 		goto out_close_fd;
>     452 
>     453 	if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
>     454 		goto out_close_fd;
>                         ^^^^^^^^^^^^^^^^^
> This is problematic
> 
>     455 
>     456 	buf += FAN_EVENT_METADATA_LEN;
>     457 	count -= FAN_EVENT_METADATA_LEN;
>     458 
>     459 	if (fanotify_is_perm_event(event->mask))
>     460 		FANOTIFY_PERM(event)->fd = fd;
>     461 
>     462 	if (f)
>                    ^^^
> 
>     463 		fd_install(fd, f);
>     464 
>     465 	/* Event info records order is: dir fid + name, child fid */
>     466 	if (fanotify_event_dir_fh_len(event)) {
>     467 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
>     468 					     FAN_EVENT_INFO_TYPE_DFID;
>     469 		ret = copy_info_to_user(fanotify_event_fsid(event),
>     470 					fanotify_info_dir_fh(info),
>     471 					info_type, fanotify_info_name(info),
>     472 					info->name_len, buf, count);
>     473 		if (ret < 0)
>     474 			goto out_close_fd;
>     475 
>     476 		buf += ret;
>     477 		count -= ret;
>     478 	}
>     479 
>     480 	if (fanotify_event_object_fh_len(event)) {
>     481 		const char *dot = NULL;
>     482 		int dot_len = 0;
>     483 
>     484 		if (fid_mode == FAN_REPORT_FID || info_type) {
>     485 			/*
>     486 			 * With only group flag FAN_REPORT_FID only type FID is
>     487 			 * reported. Second info record type is always FID.
>     488 			 */
>     489 			info_type = FAN_EVENT_INFO_TYPE_FID;
>     490 		} else if ((fid_mode & FAN_REPORT_NAME) &&
>     491 			   (event->mask & FAN_ONDIR)) {
>     492 			/*
>     493 			 * With group flag FAN_REPORT_NAME, if name was not
>     494 			 * recorded in an event on a directory, report the
>     495 			 * name "." with info type DFID_NAME.
>     496 			 */
>     497 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
>     498 			dot = ".";
>     499 			dot_len = 1;
>     500 		} else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
>     501 			   (event->mask & FAN_ONDIR)) {
>     502 			/*
>     503 			 * With group flag FAN_REPORT_DIR_FID, a single info
>     504 			 * record has type DFID for directory entry modification
>     505 			 * event and for event on a directory.
>     506 			 */
>     507 			info_type = FAN_EVENT_INFO_TYPE_DFID;
>     508 		} else {
>     509 			/*
>     510 			 * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
>     511 			 * a single info record has type FID for event on a
>     512 			 * non-directory, when there is no directory to report.
>     513 			 * For example, on FAN_DELETE_SELF event.
>     514 			 */
>     515 			info_type = FAN_EVENT_INFO_TYPE_FID;
>     516 		}
>     517 
>     518 		ret = copy_info_to_user(fanotify_event_fsid(event),
>     519 					fanotify_event_object_fh(event),
>     520 					info_type, dot, dot_len, buf, count);
>     521 		if (ret < 0)
>     522 			goto out_close_fd;
>                                 ^^^^^^^^^^^^^^^^^
> 
> 
>     523 
>     524 		buf += ret;
>     525 		count -= ret;
>     526 	}
>     527 
>     528 	return metadata.event_len;
>     529 
>     530 out_close_fd:
>     531 	if (fd != FAN_NOFD) {
>     532 		put_unused_fd(fd);
> --> 533 		fput(f);
>                         ^^^^^^^
> This leads to a NULL dereference

Sure would, however if the intial else path is taken above skipping
create_fd() then "fd" would remain set to FAN_NOFD and "f" would remain set
to NULL, then this branch would not be taken and thus not leading to a NULL
dereference?

To make things clearer, avoid any future confusion and possibly tripping
over such a bug, perhaps it'd be better to split up the fput(f) call into a
separate branch outside of the current conditional, simply i.e.

...

if (f)
	fput(f);

...

Thoughts?

>     534 	}
>     535 	return ret;
>     536 }

/M
