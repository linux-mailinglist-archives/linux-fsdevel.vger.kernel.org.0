Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE53518AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhDARrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhDARnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA62C0613A5
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 04:29:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm8so1566144edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrgKRkZYxFNex51lY/7IkQoDvk2RVxf595mFeDjlSSk=;
        b=It1nN049vO8qoKGytT57Bzw9sa/r3Pv/xlCJLx3ig+mQnMe7MEgLfREujCPK90SIz0
         dY/AmgRDX78A15gaor9ADa+gvbRioeNKdS0/kwEz7FKoxblW4r5w6QkYU2wrqESuqEAe
         Q7skCfPvReyh0hsteVWaNQ+XpwUnVgIQmBjelZyblqVELmPtHNXIt5Rvf4Q84yFck01G
         p/aEfOgdlebHzSjri2DDE/a49W6VCnFW3F67M7vMic5Mjw9B2mJx70B8L1aKOroKXIou
         eIYCTGVohhJOMnFFSIZH67LYq08gSsVRV1UYxLqLpz5qNpj5Qi1p74HuTJKhq+1ou2oT
         y0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrgKRkZYxFNex51lY/7IkQoDvk2RVxf595mFeDjlSSk=;
        b=L7RAo+sgMijyMPFtlAwPDkdpruZJqksAvHr/5nmO24l7Qew+2or111oL+i9a87qTRA
         /mVzBXaoodzgPM8I7V9rg3IUzw4oMZN2MHsUpzJMvN/wbmNOeYB2O/EXlKLpA5V+sasA
         HghZSbkeQjd5I5/z8Vsi3W6cQ9tY4tFazZeQBurIH/hL5Tgw3uqle2dPOB6eZozaN6QS
         /wV8aI6hwsBr4hUH73MqvLlWoiKWrvAFBnRAhIwcT2pr9oNmyIEzTRpLRdYhhdXMEM65
         ynaJudAxDafutCKhemcag4/NN2dIub2JJueGqfaSPNbF8i6jSMvLM2V6Gp+SLFIZQkQr
         hokw==
X-Gm-Message-State: AOAM530WcIUgEPSxzrIGpdbgFRPBHHW8XxUJrnaT2JuPOStg0jfwfaoX
        Fz9OzK71vt0PRJoThsX01AW76DLqKQVgIuvVrbLr
X-Google-Smtp-Source: ABdhPJzcG2XeyO60BBYSsZF3AhUM8DnQovMPTEIG7GN/jazIXBFqX4wJSUG5FZ70qiHR5t+ckR8AItD/g8/l+vvFmII=
X-Received: by 2002:a05:6402:4314:: with SMTP id m20mr9082474edc.5.1617276596692;
 Thu, 01 Apr 2021 04:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com> <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
 <YGWjh7qCJ8HJpFxv@kroah.com>
In-Reply-To: <YGWjh7qCJ8HJpFxv@kroah.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 19:29:45 +0800
Message-ID: <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Wang <jasowang@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        maco@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 6:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> > On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > > Use receive_fd() to receive file from another process instead of
> > > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > > the logic and also makes sure we don't miss any security stuff.
> > >
> > > But no logic is simplified here, and nothing is "missed", so I do not
> > > understand this change at all.
> > >
> >
> > I noticed that we have security_binder_transfer_file() when we
> > transfer some fds. I'm not sure whether we need something like
> > security_file_receive() here?
>
> Why would you?  And where is "here"?
>
> still confused,
>

I mean do we need to go through the file_receive seccomp notifier when
we receive fd (use get_unused_fd_flags() + fd_install now) from
another process in binder_apply_fd_fixups().

Thanks,
Yongji
