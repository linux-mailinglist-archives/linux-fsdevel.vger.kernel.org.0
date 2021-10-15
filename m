Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDB42FA93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhJORzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhJORzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:55:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8806C061570;
        Fri, 15 Oct 2021 10:52:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y17so7991680ilb.9;
        Fri, 15 Oct 2021 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amlc9QudWu6bGQ2O1D9yionrThKbMX1K6SQ0Rc14rNQ=;
        b=Zat5qg7cyjcufDhYPw6xeWqdociB6JPgRklpW6DB5dpvtxOQBehWSfpFOLGFH/eXmZ
         Y8FHJpo/oz6/clanMewrGC/HAkkWD6q8UNEF5QPcshop0dLEhEAjkLr7gFzR7L3YmAbK
         49rqj2OEoovO9M9perqHPbo43/+QbWuBQH6nF2hgD0v99yMpTzXG1EnJvuyJnslSo5yD
         xzj+hwPmB9+vyp9us21YH+6oiA7UcvOuP5OFOJJuwJn5w1kGwDeIEIlt8y5aGzZRox48
         FTL+VnosPVX4v2sDNMd8opvvSq/Tt5hUcLEpMaKiCcoURIBdMs6BjaxBxjcoGwuzt2lH
         0DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amlc9QudWu6bGQ2O1D9yionrThKbMX1K6SQ0Rc14rNQ=;
        b=sYuzxiQfow1SMX6HS7jqidklv1GZuO0JyCNLCiWQWRxXbwOBXAEvF5S7DKwkMmQ2o/
         4ukIn0PvXrO8K/9zlCsZhnNPyaj/K7HDllP/5/bfci0eH978i21urgzkgMBg8+rVebpR
         T6v+BOchtRWofLI/SBjyGF51a4O8ZJUZW7gYZesLxySujCR12/keWWVY90YQBnYApYmW
         U/4wNL1nZrRNNwNKtpyvf2SPBy6Odl7ZxGkOs258PvTHx6eb46m8aCBF05TmGLskyq9J
         uXL34ENJ7cguiI+eDBkqZFdLqsGif8SQfJdBIhqMamoP1mlsa5urSIEi7kppX8Zpm+CR
         4eJg==
X-Gm-Message-State: AOAM532PLhHDm+eq//WlEPOSp0tkAgs4s1kfKMlCy1/WO8A78fNfCLHQ
        QfaDnuHlXPqB3L5vU6ZCrLHmvZ5r8/nkS0L20jv6MvIe
X-Google-Smtp-Source: ABdhPJyYGxhVXOyq4bV5oREKy6FKFGWMckVSHajY6GxY9tQwvK9l8f6zRQD7BhyC9hStCRHnIfM6MxEIEM8aQkvLAfY=
X-Received: by 2002:a05:6e02:20ed:: with SMTP id q13mr4950672ilv.254.1634320375244;
 Fri, 15 Oct 2021 10:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-22-krisman@collabora.com> <CAOQ4uxiOhQjQMruHR-ZM0SNdaRyi7BGsZK=Y_nSh1=361oC81g@mail.gmail.com>
 <87pms6p6t4.fsf@collabora.com>
In-Reply-To: <87pms6p6t4.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 20:52:43 +0300
Message-ID: <CAOQ4uxizDrR=cnPQzSx8C7-b3fUCWujvpKeCrq0kcMK8kw3=mw@mail.gmail.com>
Subject: Re: [PATCH v7 21/28] fanotify: Support merging of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 7:54 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Error events (FAN_FS_ERROR) against the same file system can be merged
> >> by simply iterating the error count.  The hash is taken from the fsid,
> >> without considering the FH.  This means that only the first error object
> >> is reported.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  fs/notify/fanotify/fanotify.c | 39 ++++++++++++++++++++++++++++++++---
> >>  fs/notify/fanotify/fanotify.h |  4 +++-
> >>  2 files changed, 39 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> >> index 9b970359570a..7032083df62a 100644
> >> --- a/fs/notify/fanotify/fanotify.c
> >> +++ b/fs/notify/fanotify/fanotify.c
> >> @@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
> >>         return fanotify_info_equal(info1, info2);
> >>  }
> >>
> >> +static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
> >> +                                      struct fanotify_error_event *fee2)
> >> +{
> >> +       /* Error events against the same file system are always merged. */
> >> +       if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
> >> +               return false;
> >> +
> >> +       return true;
> >> +}
> >> +
> >>  static bool fanotify_should_merge(struct fanotify_event *old,
> >>                                   struct fanotify_event *new)
> >>  {
> >> @@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
> >>         case FANOTIFY_EVENT_TYPE_FID_NAME:
> >>                 return fanotify_name_event_equal(FANOTIFY_NE(old),
> >>                                                  FANOTIFY_NE(new));
> >> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> >> +               return fanotify_error_event_equal(FANOTIFY_EE(old),
> >> +                                                 FANOTIFY_EE(new));
> >>         default:
> >>                 WARN_ON_ONCE(1);
> >>         }
> >> @@ -148,6 +161,22 @@ static bool fanotify_should_merge(struct fanotify_event *old,
> >>         return false;
> >>  }
> >>
> >> +static void fanotify_merge_error_event(struct fanotify_error_event *dest,
> >> +                                      struct fanotify_error_event *origin)
> >> +{
> >> +       dest->err_count++;
> >> +}
> >> +
> >> +static void fanotify_merge_event(struct fanotify_event *dest,
> >> +                                struct fanotify_event *origin)
> >> +{
> >> +       dest->mask |= origin->mask;
> >> +
> >> +       if (origin->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> >> +               fanotify_merge_error_event(FANOTIFY_EE(dest),
> >> +                                          FANOTIFY_EE(origin));
> >> +}
> >> +
> >>  /* Limit event merges to limit CPU overhead per event */
> >>  #define FANOTIFY_MAX_MERGE_EVENTS 128
> >>
> >> @@ -175,7 +204,7 @@ static int fanotify_merge(struct fsnotify_group *group,
> >>                 if (++i > FANOTIFY_MAX_MERGE_EVENTS)
> >>                         break;
> >>                 if (fanotify_should_merge(old, new)) {
> >> -                       old->mask |= new->mask;
> >> +                       fanotify_merge_event(old, new);
> >>                         return 1;
> >>                 }
> >>         }
> >> @@ -577,7 +606,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> >>  static struct fanotify_event *fanotify_alloc_error_event(
> >>                                                 struct fsnotify_group *group,
> >>                                                 __kernel_fsid_t *fsid,
> >> -                                               const void *data, int data_type)
> >> +                                               const void *data, int data_type,
> >> +                                               unsigned int *hash)
> >>  {
> >>         struct fs_error_report *report =
> >>                         fsnotify_data_error_report(data, data_type);
> >> @@ -591,6 +621,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
> >>                 return NULL;
> >>
> >>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> >> +       fee->err_count = 1;
> >> +
> >> +       *hash ^= fanotify_hash_fsid(fsid);
> >>
> >>         return &fee->fae;
> >>  }
> >
> > Forgot to store fee->fsid?
>
> Not really. this is part of the FID info record support, which is done
> in patch 23.
>

Sure, it does not really matter for bisection when FS_ERROR is not yet
wired, but it is weird to compare event fsid's when they have not been
initialized.

Logically, storing the fsid in this patch would be better.

Thanks,
Amir.
