Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9212B04E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfL0Bff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:35:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35865 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfL0Bfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:35:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so24087690edp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 17:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=awumovmJVECZ0Nk/zD/7/Ex5YMktKw7NhFajPm4bgFTiF2ETfkapjS8VlX3uLqpIRv
         6JofoXtruG/OJh5ZP2aFM8aE1WMGWcpoQpgjKTLp/hJjiPjkBlvWQnp7nh8qDj+Uuo+X
         qMEtfHNJZv98S6kmQcWJMShyoywEiEEU28hTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2hkxx6EdZesk3LyhW8Bjdi5OF7N5XgZx/OPo6iWL4k=;
        b=BOz652FHO1XrHuoTO1q9PytmxOuJ7LcfdPa0HMcDd42AXzQZU443DHw9SMAOd13e1w
         8p2P4OsFFRXrPv0lZx6Gj/vCkapOEe0hu52OcXjHJ92TNNvQIgYTb3dmcNqmyrdP/P3E
         oQGadj5K11wiyYJLAHEH5ZuwFWu3dvgY2NWlF5kXIWFb8WVaRw9ehLM9/tEZbgOIvteg
         D9aQgKgW2+lMxYa/oNC1Xhq8b0+RYCgwKey3pMU9RsHt5oa22UQhnPrF22aLF57wrEBx
         H37Cxxuv9bvrf75Y/r3BSi6cVX/dbaFLp2FVdoKQUg+V4pVJqnkKW2KWrXkwNdOt8kkG
         Xhdw==
X-Gm-Message-State: APjAAAXaWaOIpPY4s5O7xbTjRE6bTIaGQo6vZGr30q04xx7vgkjyAibK
        XClpEDpbE+XhUov12b1j1yEntVbyqCSZh1AFmk+R/g==
X-Google-Smtp-Source: APXvYqziVcuWKxoTC5z2LyoMJWVCIQfGh0OJGrspzG1O5SgJ6+Lq/NGsxHbojw3SUweZkNqEh948ArUOFWHF6ZSqFe8=
X-Received: by 2002:aa7:d714:: with SMTP id t20mr53554307edq.93.1577410526273;
 Thu, 26 Dec 2019 17:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20191226180334.GA29409@ircssh-2.c.rugged-nimbus-611.internal> <201912270545.TQnRs9kG%lkp@intel.com>
In-Reply-To: <201912270545.TQnRs9kG%lkp@intel.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 26 Dec 2019 20:35:00 -0500
Message-ID: <CAMp4zn94deUbkXBrnX=Omw9-FmoZDANApqYUVsaV+VsXCX4Q-w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] pid: Introduce pidfd_getfd syscall
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Thu, Dec 26, 2019 at 5:20 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Sargun,
>
> Thank you for the patch! Yet something to improve:
>
> All errors (new ones prefixed by >>):
>
>    arch/alpha/kernel/systbls.o: In function `sys_call_table':
> >> (.data+0x1120): undefined reference to `sys_pidfd'
This is a small typo. I'll fix this in the next respin.


>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
