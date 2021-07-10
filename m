Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080773C34E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jul 2021 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhGJOw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jul 2021 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhGJOwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:52:55 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65982C0613DD;
        Sat, 10 Jul 2021 07:50:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g22so16344374iom.1;
        Sat, 10 Jul 2021 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWore22eLyBsBJGycYlgM0tgMHUGUoW82D+D2xyuYsw=;
        b=hkz2ya2knFyImRzBOXOZldaewegYbmyt20RIXiZHYrtvkr4bm912VIw/X/rLeH0aCB
         BCiYXrOF8QaKyvIdDgpPme+rDV4VbzHI1+YvaHoIwTNuaHAnnNHnOeGkABmKUcu4YuZT
         axfGDZS2Aq8U0T+UkLoUGKNNwOIL6fMJglDZ1UiGqlF1J4fRdDywVMA0Ny6p12v8oz7J
         35CeBQCgS8B1+LhYqE0BSiW3xbY9iLtI2hvwazh3HY4EiGlCa/KvVCMW4d4KIx1ja53y
         SaLu7S9CVlpDaHm/KouvsxjW9Fr8VdsqCdnRvQXYszOUl43m+76qztD+8R6uHxYcNYkO
         lc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWore22eLyBsBJGycYlgM0tgMHUGUoW82D+D2xyuYsw=;
        b=QhucTusRns4kwfUzrpyxKKhCzSVZW/IvwlexlIVY+NGYIGQORn2+iVX8F73K4+CMpv
         BxdrGniATsA6QjwgLtwiPHMsB1HMOgHQRpuFVzwNaueVWy6eigUaPqyGJzlO6NJKR8jh
         slS3dXltMpFqBmCDJIskcAWMrWkIfXxt/LOMkp9PnayivxWfAsV+c10OTUesLXxt42fI
         Vjc+k2gf9pthBx51OtbHGVCxjqHJZPDG4J6pm5C2qRx+QY0AWqCnjcasKTmGCVy6q8Gu
         pqD9JaGoDNq15k4F+IHhhOrhFDxPuL+2lcvQ4X9RYSIJcp5gv1Uom/7dToF+vlNg9pn8
         xvJw==
X-Gm-Message-State: AOAM532gXxAOSAjm8a8b280u1b4/YLw4s54LSOqy97UR28R+olwrkB7H
        uBFmZEQGAV+gNlEy9GjNQT0+sGU+1hBipWjbpkY=
X-Google-Smtp-Source: ABdhPJwXBCTBHzcwFYZPYP0UDXPKt/dQDTeWhshu9Mw49NXmcPmHzuv2kPLbVZDXknbnR7jZNuyRG4u3ZT9iqhXGdkg=
X-Received: by 2002:a05:6638:4120:: with SMTP id ay32mr37148960jab.120.1625928608509;
 Sat, 10 Jul 2021 07:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623282854.git.repnop@google.com> <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
In-Reply-To: <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Jul 2021 17:49:57 +0300
Message-ID: <CAOQ4uxj6-X4S7Jx1s2db5L+J5Syb2RE=1sGV-RJZahwgzOE-6w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:22 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> allows userspace applications to control whether a pidfd info record
> containing a pidfd is to be returned with each event.
>
> If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> struct fanotify_event_info_pidfd object will be supplied alongside the
> generic struct fanotify_event_metadata within a single event. This
> functionality is analogous to that of FAN_REPORT_FID in terms of how
> the event structure is supplied to the userspace application. Usage of
> FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> permitted, and in this case a struct fanotify_event_info_pidfd object
> will follow any struct fanotify_event_info_fid object.
>
> Currently, the usage of FAN_REPORT_TID is not permitted along with
> FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> limited to privileged processes only i.e. listeners that are running
> with the CAP_SYS_ADMIN capability. Attempting to supply either of
> these initialisation flags with FAN_REPORT_PIDFD will result with
> EINVAL being returned to the caller.
>
> In the event of a pidfd creation error, there are two types of error
> values that can be reported back to the listener. There is
> FAN_NOPIDFD, which will be reported in cases where the process
> responsible for generating the event has terminated prior to fanotify
> being able to create pidfd for event->pid via pidfd_create(). The
> there is FAN_EPIDFD, which will be reported if a more generic pidfd
> creation error occurred when calling pidfd_create().
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
>

[...]

> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index fbf9c5c7dd59..5cb3e2369b96 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -55,6 +55,7 @@
>  #define FAN_REPORT_FID         0x00000200      /* Report unique file id */
>  #define FAN_REPORT_DIR_FID     0x00000400      /* Report unique directory id */
>  #define FAN_REPORT_NAME                0x00000800      /* Report events with name */
> +#define FAN_REPORT_PIDFD       0x00001000      /* Report pidfd for event->pid */
>

Matthew,

One very minor comment.
I have a patch in progress to add FAN_REPORT_CHILD_FID (for reporting fid
of created inode) and it would be nice if we can reserve the flag space in the
same block with the rest of the FID flags.

If its not a problem, maybe we could move FAN_REPORT_PIDFD up to 0x80
right above FAN_REPORT_TID, which also happen to be related flags.

Thanks,
Amir.
