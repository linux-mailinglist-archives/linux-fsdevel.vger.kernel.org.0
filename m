Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D83B8DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 08:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhGAGkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhGAGkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:40:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BBBC061756;
        Wed, 30 Jun 2021 23:37:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v3so6204836ioq.9;
        Wed, 30 Jun 2021 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3BOvpSFJuWPMMlKwpXq/9OQlZ1wmuvt8Dv+rwudvr4=;
        b=nMdjG/iCZeYAL97LQzmcYlULHTFWRe5Zx/oeJgtSWzvFz7eGfhibK+65/Y8P6Plp/M
         HfcF5/ET0r8eWJ7kT/zUrhA731G/az1ItckWNF4Fm25vMwebsfsqJxcBW+UakZykN3j7
         Sgo3OYYaHM/rrZueJf3cV30aw9VCO31HgQKAsMzNZ22RBUDtwoMW2IKAuQtKIpoLDUTj
         Y9fqmQHRl+bAIV2xVEuAdYCYKuFFv7gymW7Qfv3oSMeRcHpGVFUGCMuUGSs7x5TFG3zS
         d/WCKOhv2CyFgeT4VyOu4KE4keSq2pC58nRlK96WMGOfRSZbaUq/f9WDZTD8hR2G3/W4
         SlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3BOvpSFJuWPMMlKwpXq/9OQlZ1wmuvt8Dv+rwudvr4=;
        b=lcc3lSoFxqwHSFhRKodJv9WzgMqJl69vjCHWZ0ZS1q2IuSVrxDvFhQfC8QNCclsRhC
         b9HcDzGpodIrrf4FmfCcXAa9tItnKOn1PYtXtwMQ2aukpcnCxIpFCJDrZgl7ofD5zKvv
         zZlb8Gk8hMGhq1/lNu/ThSFwN3DY2vl2zq8ERVKghytv4FgrlG3ERrC16V0HjzYFOl7V
         cNEKDRtCXDXNlAygRpx7TsE4N4nWtNte+CKBCgZCLKtplBdL44HI6i0KqlEUCFNm3fNy
         DBOXRRpNGUecl1iAfxR6arX5SZGOvaM4AXEfPt7Xk2PsBLtffHebrixb6JulNfYQDV83
         /3mQ==
X-Gm-Message-State: AOAM531T406oFZM6NsQQrRtnEWOi+FBdgKCqInyp4yO1pxI7VCZ9NaXd
        WNmEeGSFks5VCzRVh5418wy6zHb3+BS/MEGNKPoX8CUtC68=
X-Google-Smtp-Source: ABdhPJy8xjBXxLjA9k0bdyXJHM22ZDqwIMMeWlAU53EmAX8kqwxELWBTvATPFoweKSLNb7rVZWiMRw6szGvuYgkvk8o=
X-Received: by 2002:a02:8790:: with SMTP id t16mr12276381jai.81.1625121457510;
 Wed, 30 Jun 2021 23:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-13-krisman@collabora.com> <CAOQ4uxiUYAwj561=ap_Hq6AwRdAdZFY1yQ99Y9_ahsd82-qFug@mail.gmail.com>
 <87v95vgsey.fsf@collabora.com>
In-Reply-To: <87v95vgsey.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Jul 2021 09:37:26 +0300
Message-ID: <CAOQ4uxjPHQdsPcKY-WL-WE7tWGzaTmF3gzDEhCEPxW2-U3zjcg@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] fanotify: Introduce FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 8:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> >> +       fee->fsid = fee->mark->connector->fsid;
> >> +
> >> +       fsnotify_get_mark(fee->mark);
> >> +
> >> +       /*
> >> +        * Error reporting needs to happen in atomic context.  If this
> >> +        * inode's file handler is more than we initially predicted,
> >> +        * there is nothing better we can do than report the error with
> >> +        * a bad FH.
> >> +        */
> >> +       fh_len = fanotify_encode_fh_len(inode);
> >> +       if (WARN_ON(fh_len > fee->max_fh_len))
> >
> > WARN_ON() is not acceptable for things that can logically happen
> > if you think this is important you could use pr_warn_ratelimited()
> > like we do in fanotify_encode_fh(),
> > but since fs-monitor will observe the lack of FID anyway, I think
> > there is little point in reporting this to kmsg.
>
> Hi Amir,
>
> Thanks for all the review so far.
>
> Consider that fh_len > max_fh_len can happen only if the filesystem
> requires a longer handler for the failed inode than it requires for the
> root inode.  Looking at the FH types, I don't think this would be
> possible to happen currently, but this WARN_ON is trying to catch future
> problems.
>

Don't get confused by FH types. A filesystem is not obliged to
return a uniform and single handle_type nor uniform handle_size.
Overlayfs FH size depends on the FH size of the fs in the layer
the file is on, which may be different for different files.

> Notice this would not be a fs-monitor misuse of the uAPI,  but an actual
> kernel bug. The FH size we predicted when allocating the static error
> slot is not large enough for at least one FH of this filesystem.  So I
> think a WARN_ON or a pr_warn is desired.  I will change it to a
> pr_warn_ratelimited as you suggested.
>

It would be a very minor kernel bug.
It would mean that there is a filesystem that matters in practice
for error reporting with different sizes of FH which you did not
take into account.

There is also a solution, but I think it is an overkill -
If you follow my suggestion to recreate the mark error event
on dequeue, you can update max_fh_len and re-created the
next event with larger buffer size.

In that case, admin will only see a few  pr_warn_ratelimited()
messages until fs-monitors reads the overflowed error event.

Also, I think it would be wise to use the NULL-FID convention
with different handle_types to report the different cases of:
- Failed encode (FILEID_INVALID)
- No inode (FILEID_ROOT)

Also, better use FANOTIFY_INLINE_FH_LEN as mimimum
for error event buffer size.

Thanks,
Amir.
