Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D251DD5B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgEUSKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgEUSKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 14:10:49 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4398C061A0E
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 11:10:48 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w18so7973316ilm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eziYTdN7Cbbju+lQIY5AHmjIyCLBG/Lihey9HYQAoUA=;
        b=e3l2g9R6G2/OA+p6EjTsU1olNiMUCPLdkodrIQRUD7+k3nvqD3G9oIDn+E7/tyDBTq
         9XKENtgM3B80WpcMvWWy6x9cceOIFHwrOmRyUrddpnXY7/fyBLy77vrMQvzOcL9V1qDj
         Mss3nkCHg15b6MHZYo4nEQFL5L83nEt0611/uQuz6N8mPj4Jhy94XansuJn7nChlpda5
         cN9rPZuU5T8tjzYtSFdHwJbiqSVGDH0CJYRGdyC4R+25nLzph/7JmJhh4pkcGOksGefY
         SQ+2LNBRJS1+gQzJi7c/MareCwQyq7xDEEJ6PuNzw2TDraYlDiwgDELrtz3ePb5YoqyN
         YE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eziYTdN7Cbbju+lQIY5AHmjIyCLBG/Lihey9HYQAoUA=;
        b=IGpT4/oxgo453qwyExkdYuuFjzGJeg/q6FvfqGkJt9IyKjRESbJN/MglbBAydDxJww
         CPJ8PfLxZEolPO4Ep/a6AQQSdHccWSE6rLbeni2FYlioEokEvuzGMAMFHtYq77qTrIBE
         XGQ4sTvkjNl+cHxzDZ5rRqKi2Ao8/cWt7Of7tLm2cKNGVvbTtja7hQzSGcX26B6TOhoK
         mf2aWwYXLEBFtgRvp2qq/0K3+BpysjeoToqQ6RgoWmkyWI4EUsUUz7/YB1JatDBo+M8T
         vKdyio1KlXl46pyqg6JlTYx5+gzy3VkY+vFc1SX5SEbyGZaDPyxbGfPqzI+B8sHzGzCI
         ya+g==
X-Gm-Message-State: AOAM531usXVgRwvylZsxr5R6b/7JReqxlq+138Kg8jYe1fLUP+wrC1CB
        RX2LQaQxCCjxD9rA2v22Y5bi6XnzpQuW63ba/+I=
X-Google-Smtp-Source: ABdhPJxOwr/KDQuQaXPuVwzATQ7XDWwIoc11avhwoqgJxurbzX8hZCEfL2ivXe2/DJCraPuu+hx5RSFO1IPlia2TLCg=
X-Received: by 2002:a92:db12:: with SMTP id b18mr9753966iln.250.1590084647850;
 Thu, 21 May 2020 11:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162443.GA26052@quack2.suse.cz>
In-Reply-To: <20200521162443.GA26052@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 May 2020 21:10:36 +0300
Message-ID: <CAOQ4uxirUfcpOdxFG9TAHUFSz+A5FMJdT=y4UKwpFUVov43nSA@mail.gmail.com>
Subject: Re: Ignore mask handling in fanotify_group_event_mask()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 21, 2020 at 7:24 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Amir!
>
> I was looking into backporting of commit 55bf882c7f13dd "fanotify: fix
> merging marks masks with FAN_ONDIR" and realized one oddity in
> fanotify_group_event_mask(). The thing is: Even if the mark mask is such
> that current event shouldn't trigger on the mark, we still have to take
> mark's ignore mask into account.
>
> The most realistic example that would demonstrate the issue that comes to my
> mind is:
>
> mount mark watching for FAN_OPEN | FAN_ONDIR.
> inode mark on a directory with mask == 0 and ignore_mask == FAN_OPEN.
>
> I'd expect the group will not get any event for opening the dir but the
> code in fanotify_group_event_mask() would not prevent event generation. Now
> as I've tested the event currently actually does not get generated because
> there is a rough test in send_to_group() that actually finds out that there
> shouldn't be anything to report and so fanotify handler is actually never
> called in such case. But I don't think it's good to have an inconsistent
> test in fanotify_group_event_mask(). What do you think?
>

I agree this is not perfect.
I think that moving the marks_ignored_mask line
To the top of the foreach loop should fix the broken logic.
It will not make the code any less complicated to follow though.
Perhaps with a comment along the lines of:

             /* Ignore mask is applied regardless of ISDIR and ON_CHILD flags */
             marks_ignored_mask |= mark->ignored_mask;

Now is there a real bug here?
Probably not because send_to_group() always applied an ignore mask
that is greater or equal to that of fanotify_group_event_mask().

should fanotify_group_event_mask() re-apply the same generic logic
already applied in send_to_group()? Maybe there is no point.
After all, fanotify_group_event_mask() also does not handle
FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY, so the
assumption that send_to_group() is doing some of the logic is
already there.

Not sure if I helped answering your question.

Thanks,
Amir.
