Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C3D1272F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 02:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfLTBne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 20:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfLTBnb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:43:31 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4598E24686
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576806210;
        bh=9ejuSSpwcIgoC1vtIrf1QW8XeawMCi6i1EBo5T44lto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JfMhr7V0wOAkVFs2SKNvA7dd8/uf8OvCUvrPu/E+fvrZWV1YEq9FzyAehZ+V7GmVI
         UlDMYIVSnn+r6U8JIGwm7D889lEyw6cFQYiyhDwj9OfXz1LegMVJfzUMzMjhhP/AVL
         ASF5a8ihUb8caQAHihcy7CgZW+qF+n8kOPLeWFds=
Received: by mail-wr1-f41.google.com with SMTP id b6so7894416wrq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 17:43:30 -0800 (PST)
X-Gm-Message-State: APjAAAVuDKPPwniIpTxSbRW/N/RYrgZWroTMDwGU5eqo8xo/3CCASpaz
        6oEIFz5XTW2rNiN+u1mFdJ7r56isvbTrvTB5nQd5Hw==
X-Google-Smtp-Source: APXvYqw3HP/VhP6dKqWKDMvRB9Y+Ln/rjo5DtmsDHh8oLRC1zCVOr/TQ6d9paG0FxgM7qE2ND0+e7f4/JMUkGjTDBL4=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr12892287wrn.61.1576806208779;
 Thu, 19 Dec 2019 17:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Dec 2019 17:43:17 -0800
X-Gmail-Original-Message-ID: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
Message-ID: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 3:55 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> +
> +       if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> +               file = ERR_PTR(-EPERM);
> +               goto out;
> +       }

I don't think this is MODE_READ.  By copying an fd from the task, you
can easily change its state.

IMO it would be really nice if pidfd could act more like a capability
here and carry a ptrace mode, for example.  But I guess it doesn't
right now.


--Andy
