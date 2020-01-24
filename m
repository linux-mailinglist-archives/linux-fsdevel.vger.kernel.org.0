Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143D2148F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 21:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgAXUKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 15:10:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43500 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgAXUKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:10:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so3784292edb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EW6Y/EZHZi/ttUxTUSXyYBrJLM6UmlUPE/P/09OJMp8=;
        b=D57LaX6fPIH9yUp1n9+Oi2UloLj6giH8ArlR4WpiryOjEWH0YZzmHpB7st9eYWD7TS
         3j+v+LFsCXuf38Ry79+XOYI8bX8rWiHVP83p0KFyhcNBtyplhPLMBFeQgyCznZeNhu4d
         bnUnov6ftmIi4qUTGqr5SEUrcbtZUY6nZZ2nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW6Y/EZHZi/ttUxTUSXyYBrJLM6UmlUPE/P/09OJMp8=;
        b=T7h0ofa3u43sZuqs/POsN6qjloiCUEpYmkwLd6fivw8L6yiWSIEnuFtHWa4srlGmRv
         Ea/B72X5iBdA6IKwV1mNx6lQk/M4mb75iOu2I7UEHnADyimQ1It6jRhCnOYUfszdAFVP
         LJijAtuhWQZdVXCSRJBOn3KS17OMvjQSEHh2vyvJIKauD+FmCtHXPBw/pSDzu8JOEpdw
         Gi0NozaWZ8ZChlSQ6ISd33q9FMMqQxrLvY1r6r3+cKbvJ1DQW3YkD/ifvT8D2oDXyk2I
         hiKm0lZF1NDCU2+WKIh1kV/NbgbK+eszk1vJkVSEHnWU1Sr87iVr3D9GHL+u8YzNPKvS
         XlRA==
X-Gm-Message-State: APjAAAWO8MtEdoj/5JyM7E7siG/Yjwo8vaxbRXE9HVdTS3qnFl6iHP+D
        Ep5xH1Ih+hqcoAeE5UyybtG9u2NYwOT3PjQhGMlrMAzX+kw=
X-Google-Smtp-Source: APXvYqwWJyOj8lNCsez+rW7XtOC4RGJBUgl+VpwoBouyvHuLrvQ3yPoOq7ALyHD46F67pPGbj4kMWn5TGsuAHVWCMdo=
X-Received: by 2002:a17:906:680b:: with SMTP id k11mr4160436ejr.0.1579896613104;
 Fri, 24 Jan 2020 12:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20200124091743.3357-1-sargun@sargun.me> <20200124091743.3357-4-sargun@sargun.me>
 <20200124180332.GA4151@cisco>
In-Reply-To: <20200124180332.GA4151@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 24 Jan 2020 12:09:37 -0800
Message-ID: <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:03 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> > Currently, this just opens the group leader of the thread that triggere
> > the event, as pidfds (currently) are limited to group leaders.
>
> I don't love the semantics of this; when they're not limited to thread
> group leaders any more, we won't be able to change this. Is that work
> far off?
>
> Tycho

We would be able to change this in the future if we introduced a flag like
SECCOMP_USER_NOTIF_FLAG_PIDFD_THREAD which would send a
pidfd that's for the thread, and not just the group leader. The flag could
either be XOR with SECCOMP_USER_NOTIF_FLAG_PIDFD, or
could require both. Alternatively, we can rename
SECCOMP_USER_NOTIF_FLAG_PIDFD to
SECCOMP_USER_NOTIF_FLAG_GROUP_LEADER_PIDFD.
