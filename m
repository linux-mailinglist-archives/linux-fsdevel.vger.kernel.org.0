Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD76512751F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 06:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfLTFWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 00:22:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34690 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLTFWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:22:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so7101007edw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=WNGXalv6wGknAwomwUwaovAuPTvIQk7Xl9TqqlQvmj1rGqrkoFkmOPGli//9tqbPOv
         bC0y5Bs/3eANQWEqTALhW5Dku73NB5ieBnYuYxc1jUL3Zr8Uqy/gnWwYBGWtxLUJLsqD
         Tp7EfFzYyAQ8cd9J2+BJ9gPXs0uV9dWqQzzK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2KTmXeXeXMiud96l6nUg2edTQgCxfxouifxscVRf0g=;
        b=l6WIrhEsvj4tREDO9NYQUwGBTHnFErl3y4RQmSBDYo9bnCDWhsoNlTrgOj0uLDAYut
         ZqhM8grQfVO7S86VWXuMYu3fgrGrjDT8ilpSQP+X2aglSojC0yYpGd3K6jC+M+e0uKXs
         0+ZOmw4WQFcM0Cmx2o8gsRxJFkEBRLiZsBzl6Oj9tkIPaXaPiiELwMx+ItjzJpka3HJn
         FWkfQ6t7xkxqSbrp5PZCOIv46H0FxtWVgDKfnl9gACkQTg+T25f9m/fPqYPvUojK8Hop
         r+8Ho6F+QEyOhs4RLdwURN2lV8NxnANpE9fA89wjfi9O+6YnCOz8/yHRaoPKLHgb0Rd2
         LDKQ==
X-Gm-Message-State: APjAAAVfQng2I0MWGBa3tGK8fKBRvubWSUG8nHDxJi6HJTJNA3kdkux5
        HNRxKYsUyAZMjxHjWcLvdn3RzAb4ISGECGwHXllQPQ==
X-Google-Smtp-Source: APXvYqzEMj7wR7jQmLsuZlyg4/9OOkLUmtqWJIdzbQ1FdkEnv81xGqzaY4T0ckwcnUBu1qoHgE7EBOXhUrhFb4u6MaM=
X-Received: by 2002:a17:906:4f93:: with SMTP id o19mr13905879eju.52.1576819319133;
 Thu, 19 Dec 2019 21:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal> <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
In-Reply-To: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 19 Dec 2019 21:21:23 -0800
Message-ID: <CAMp4zn9R3XoV=xLi9y0vn-DotUQGRFA8Cp14aYYvkVYEUuW48w@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jed Davis <jld@mozilla.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:43 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
> I don't think this is MODE_READ.  By copying an fd from the task, you
> can easily change its state.
Would PTRACE_MODE_ATTACH_REALCREDS  work? I'm curious what
kind of state change you can cause by borrowing an FD?


>
> IMO it would be really nice if pidfd could act more like a capability
> here and carry a ptrace mode, for example.  But I guess it doesn't
> right now.
>
>
> --Andy
