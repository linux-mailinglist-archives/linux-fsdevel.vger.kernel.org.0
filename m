Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB5361B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 10:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbhDPII5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhDPIIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8EC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 01:08:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w8so11220001plg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHtko9A1w5ItkCMsikB/Jidz4iY+US+hA5ckCUbtBv8=;
        b=QkopcUpaVEsr5CNBtp5KEs31/JVwi0iu5gnJZzDKW+Yhw85I6JvukaMqSqDpR/nOUq
         M9U0fzCpRlXv418ZWv9ndg9wN7JrgQMonB5aCoR2KIeqNi8dl9F+LjjdM1B1BY6y2/7A
         R/8BEz4B2ZnCUETdZ5IoVuN3n7BZWy8R4qzi2nWP4Ti5B7nS9F1v0p83OhppjyWKFEPF
         E5TVyNQqHUWo27tqDF6HzZ8+rwgMA/D4oMSEIRs4M5Tg7scV7VmHLUTeCaenZho8ko9Z
         cRId+yQfm1HeuovyZF85nu+RUEjDVK/KMefF5Yb2GPcTlITe17vJKnoUFBrm4Dv9f/kN
         rs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHtko9A1w5ItkCMsikB/Jidz4iY+US+hA5ckCUbtBv8=;
        b=kqpEKRq/ZZd8pQrYJgYeoRUDSR3ACWd9UQuPmmmzg3UY/fERXKQFCpwOZwEd3as+uD
         QUDjN3x3sGF/shHOfaP59xgz4RfHF7XIJJlTLhnC8dCCXpsrTewy4+apOm5tQP5n9sfl
         k30JghsBcU9Qci9N81vfM9xzav+ILfkLETS5/FVQoHSH7oDc/zVp4HhGOjkr+BHYIL++
         1MChMANUnCtBT7jrSgh8uyIGWx7O33meW1xvOeq8B9r/kzGgX91CTJcvTeD48YRFJ+F1
         DCOSz0EZ1O0O2PfcOIQ+rwC/m0V/StNXz+BhnE9BvNPcW2PYIgt6tucOBGnZlZDN7PkV
         Txjg==
X-Gm-Message-State: AOAM530MdOKZSjzHcg8oKMdCATROZQMXmfj2+/M41QqAVrtvckCc1QTP
        G11fekN9Cgqu9uMl0dvMf3MwmA==
X-Google-Smtp-Source: ABdhPJxShQR6wk5ovKanYVIfqAE4NjoGjxsd910y0/ndnhpJLWURNrUgDWjoHbe762JlfmjFRzyM4w==
X-Received: by 2002:a17:90a:4a8e:: with SMTP id f14mr8639578pjh.20.1618560509122;
        Fri, 16 Apr 2021 01:08:29 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c78c:fbb:2641:bc93])
        by smtp.gmail.com with ESMTPSA id q3sm4321423pgb.80.2021.04.16.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:08:28 -0700 (PDT)
Date:   Fri, 16 Apr 2021 18:08:16 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YHlF8El4lcsHNYtR@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <CAOQ4uxhWicqpKQxvuN5=WiULwNRozFvxQKgTDMOL-UxKpnk-WQ@mail.gmail.com>
 <YHk3Uko0feh3ud/X@google.com>
 <CAOQ4uxjQi4dV0XoU2WDKG+3R81Xam6giee9hhkvXb13tQB+Tdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjQi4dV0XoU2WDKG+3R81Xam6giee9hhkvXb13tQB+Tdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:53:48AM +0300, Amir Goldstein wrote:
> On Fri, Apr 16, 2021 at 10:06 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > > +               pidfd = pidfd_create(event->pid, 0);
> > > > +               if (unlikely(pidfd < 0))
> > > > +                       metadata.pid = FAN_NOPIDFD;
> > > > +               else
> > > > +                       metadata.pid = pidfd;
> > > > +       } else {
> > > > +               metadata.pid = pid_vnr(event->pid);
> > > > +       }
> > >
> > > You should rebase your work on:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> > > and resolve conflicts with "unprivileged listener" code.
> >
> > ACK.
> >
> > > Need to make sure that pidfd is not reported to an unprivileged
> > > listener even if group was initialized by a privileged process.
> > > This is a conscious conservative choice that we made for reporting
> > > pid info to unprivileged listener that can be revisited in the future.
> >
> > OK, I see. In that case, I guess I can add the FAN_REPORT_PIDFD check
> > above the current conditional [0]:
> >
> > ...
> > if (!capable(CAP_SYS_ADMIN) && task_tgid(current) != event->pid)
> >         metadata.pid = 0;
> > ...
> >
> > That way, AFAIK even if it is an unprivileged listener the pid info
> > will be overwritten as intended.
> >
> 
> Situation is a bit more subtle than that.
> If you override event->pid with zero and zero is interpreted as pidfd
> that would not be consistent with uapi documentation.

Ah, yes, of course! I had totally overlooked this. Also, speaking of
UAPI documentation, I'll have it prepared along with the LTP tests
once I get the ACK for this particular concept from Jan and Christian.

> You need to make sure that event->pid is FAN_NOPIDFD in case
> (!capable(CAP_SYS_ADMIN) &&
>  FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD))
> Hopefully, you can do that while keeping the special cases to minimum...

I don't foresee any issues with doing this at all.

/M
