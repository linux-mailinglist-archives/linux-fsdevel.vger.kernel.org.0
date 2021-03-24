Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8AD347D02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhCXPv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhCXPvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:51:05 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603DC061763;
        Wed, 24 Mar 2021 08:51:04 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id u10so21777730ilb.0;
        Wed, 24 Mar 2021 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5KdwmXzDrc/T1ClgFmE5sx4ZXJQbzd5+6T0HPm0KrM=;
        b=VT3kT47I/Y+8c3Vr2PiY0GEcqPEGXF+rJRABmKmQ1E95ojBLATwP26JZsTrqHU570c
         Qh1hd96wtDJQE/wPOmfCFfLncplDLewQLieu+CsvTc1PLSXzc61N9PHNGBIv8v+MMtBG
         zSY5W8Ki/h0BLXkZBO53OoBqmtuGWMqocKb7aAUUjesDi9swK3joiFdE9+tCOTv7QdO9
         hAYy0dCACoK6QszWq5QOz0HG/kY/KRaARYkN1B39fIQgYd0lUSv8fRK9elnfB5TDRmLj
         mKEdcn12xRe4wnCV8lIuM1eknxSplqcsutlLYcRCQz7LWqsrxzlMeoHB/ip1WxzLmJyj
         Q2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5KdwmXzDrc/T1ClgFmE5sx4ZXJQbzd5+6T0HPm0KrM=;
        b=pQOjxncu+H9cqpvIO3/EnP4A+W8taUSQxTL7kvxjRCCHCpL8NnBsSQOopBbR1uHyA4
         lfPYMeGd6TFir1NM+z4qJd+8P4jK72XWHYYAIte+CY7RS0HeIastS8I8MrwxWZnEgiuw
         Y1t0CCWCK16xwUCYwXsaf0ITSUsCike7nAxGq4wtvu37SO77k9eOVQCpg+O0x0K/UjSU
         SDicz6AdVmijBuIDGPkEq2FHfz19mo8tVX2ZsfHgh3sUqfi3bIWkm+Ens5iwAtWjRWeQ
         jAIJfcsVA9EmJIV4CjOssKSu2hn1YMGJfxxk+mO0kuVhT3tp7FzU1sPtVfwvC8uE+Lha
         2B8w==
X-Gm-Message-State: AOAM532GmXWLRq182vYGjq7x7RXdjcJ9i+jnUCDb0HhyoHbY5RFXT4Z+
        gQ+8MSOOiSpJdnd3k9QMDh6GguUUN6T64RK7RxfylfUFibE=
X-Google-Smtp-Source: ABdhPJztYxkU74CvZE8zHiSXSYBHFfV5CGULz36eylcYVLTVtBU4211SjV3Uws8lB8YxyLz9m+TTkJaFtw9Op1bE1PI=
X-Received: by 2002:a92:da90:: with SMTP id u16mr3209140iln.275.1616601064295;
 Wed, 24 Mar 2021 08:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz> <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
 <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com> <20210324114847.GA17458@quack2.suse.cz>
In-Reply-To: <20210324114847.GA17458@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 17:50:52 +0200
Message-ID: <CAOQ4uxgjM8qC-Kre9ahMQzzhsOFtCXu4Vzd2HYUsSOstgf9Jyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > So I have implemented this idea on fanotify_userns branch and the cost
> > per "filtered" sb mark is quite low - its a pretty cheap check in
> > send_to_group()
> > But still, if an unbound number of users can add to the sb mark list it is
> > not going to end well.
>
> Thinking out loud: So what is the cost going to be for the side generating
> events? Ideally it would of O(number of fanotify groups receiving event).
> We cannot get better than that and if the constants aren't too big I think
> this is acceptable overhead. Sure this can mean total work of (number of
> users) * (max number of subtree marks per user) for queueing notification
> event but I don't think it is practical for a DoS attack and I also don't
> think that in practice users will be watching overlapping subtrees that
> much.
>

Why overlapping?
My concern is not so much from DoS attacks.
My concern is more from innocent users adding unacceptable
accumulated overhead.

Think of a filesystem mounted at /home/ with 100K directories at
/home/user$N, every user gets its own idmapped mount from
systemd-homed and may or may not choose to run a listener to
get events generated under its own home dir (which is an idmapped
mount). Even if we limit one sb mask per user, we can still have 100K
marks list in sb.

For this reason I think we need to limit the number of marks per sb.
The simple way is a global config like max_queued_events, but I think
we can do better than that.

> The question is whether we can get that fast. Probably not because that
> would have to attach subtree watches to directory inodes or otherwise
> filter out unrelated fanotify groups in O(1). But the complexity of
> O(number of groups receiving events + depth of dir where event is happening)
> is probably achievable - we'd walk the tree up and have roots of watched
> subtrees marked. What do you think?
>

I am for that. I already posted a POC along those lines [1].
I was just not sure how to limit the potential accumulated overhead.

[1] https://github.com/amir73il/linux/commits/fanotify_subtree_mark

> Also there is a somewhat related question what is the semantics of subtree
> watches in presence of mounts - do subtree watches "see through" mount
> points? Probably not but then with bind mounts this can be sometimes
> inconvenient / confusing - e.g. if I have /tmp bind-mounted to /var/tmp and
> I'm watching subtree of /var, I would not get events for what's in
> /var/tmp... Which is logical if you spell it out like this but applications
> often don't care how the mount hierarchy looks like, they just care about
> locally visible directory structure.

Those are hard questions.
I think that userns/mountns developers needed to address them a while ago
and I think there are some helpers that help with checking visibility of paths.

>
> > <hand waving>
> > I think what we need here (thinking out loud) is to account the sb marks
> > to the user that mounted the filesystem or to the user mapped to admin using
> > idmapped mount, maybe to both(?), probably using a separate ucount entry
> > (e.g. max_fanotify_filesystem_marks).
>
> I'm somewhat lost here. Are these two users different? We have /home/foo
> which is a mounted filesystem. AFAIU it will be mounted in a special user
> namespace for user 'foo' - let's call is 'foo-ns'. /home/foo has idmapping
> attached so system [ug]ids and non-trivially mapped to on-disk [ug]ids. Now
> we have a user - let's call it 'foo-usr' that has enough capabilities
> (whatever they are) in 'foo-ns' to place fanotify subtree marks in
> /home/foo. So these marks are naturally accounted towards 'foo-usr'. To
> whom else you'd like to also account these marks and why?
>

I would like the system admin to be able to limit 100 sb marks on /home
(filtered or not) because that impacts the send_to_group iteration.
I would also like systemd to be able to grant a smaller quota of filtered
sb marks per user when creating and mapping the idmapped mounts
at /home/foo$N

I *think* we can achieve that, by accounting the sb marks to uid 0
(who mounted /home) in ucounts entry "fanotify_sb_marks".
If /home would have been a FS_USERNS_MOUNT mounted inside
some userns, then all its sb marks would be accounted to uid 0 of
that userns.

I have no ideas if this all adds up.
My head explodes even from trying to express these rules :-/

Thanks,
Amir.
