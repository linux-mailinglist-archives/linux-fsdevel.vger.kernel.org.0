Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38359F3F74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 06:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHFHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 00:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfKHFHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:07:08 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E67222CD
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2019 05:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573189626;
        bh=Nml6ZqPGIxeHePwEoMl3uFywnf+kk1nTeP99Kndi+gU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bAdWTsYRTkqedcC/+Z5sINwapybfyle+SAfQCYzh0EWS5bFnoTWCp8gEp5sb9cWnI
         O5bF/n5f1DTs5DQ85rVVTZbzCY3ybfp9Rs/y1P5HNCiBgUd2Nw3kHKIgcB9HugJvZn
         vVLMDAwji8m5eynkuo8EBnTeCAjeGmxaYmxlk+Hs=
Received: by mail-wm1-f47.google.com with SMTP id 8so4878967wmo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 21:07:06 -0800 (PST)
X-Gm-Message-State: APjAAAUOcVTEEF+01SWs+ixriD1ho/oPkLh2i4vaK/kYIMSHun1CkKhD
        zYq2TFFPQcF3S5bg5HdesPl4U5mZEiZ2E3AINBMrTg==
X-Google-Smtp-Source: APXvYqx08Mv0U8UmADt1yPzJqTiWQTH/61DB5ak1MBLcnJribE7k+KhLlnxirQA97U78di+ySNLiALLNE6nRtXo4CT0=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr6805119wmj.161.1573189624926;
 Thu, 07 Nov 2019 21:07:04 -0800 (PST)
MIME-Version: 1.0
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
 <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
 <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com> <6964.1573152517@warthog.procyon.org.uk>
In-Reply-To: <6964.1573152517@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Nov 2019 21:06:53 -0800
X-Gmail-Original-Message-ID: <CALCETrWeN9CGJHz0dzG1uH5Qjbr+xG3OKZuEd33eBY_rAzVkqQ@mail.gmail.com>
Message-ID: <CALCETrWeN9CGJHz0dzG1uH5Qjbr+xG3OKZuEd33eBY_rAzVkqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/14] pipe: Add O_NOTIFICATION_PIPE [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 7, 2019 at 10:48 AM David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > > Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indicate
> > > that the pipe being created is going to be used for notifications.  This
> > > suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
> > > pipe as calling iov_iter_revert() on a pipe when a kernel notification
> > > message has been inserted into the middle of a multi-buffer splice will be
> > > messy.
> >
> > How messy?
>
> Well, iov_iter_revert() on a pipe iterator simply walks backwards along the
> ring discarding the last N contiguous slots (where N is normally the number of
> slots that were filled by whatever operation is being reverted).
>
> However, unless the code that transfers stuff into the pipe takes the spinlock
> spinlock and disables softirqs for the duration of its ring filling, what were
> N contiguous slots may now have kernel notifications interspersed - even if it
> has been holding the pipe mutex.
>
> So, now what do you do?  You have to free up just the buffers relevant to the
> iterator and then you can either compact down the ring to free up the space or
> you can leave null slots and let the read side clean them up, thereby
> reducing the capacity of the pipe temporarily.
>
> Either way, iov_iter_revert() gets more complex and has to hold the spinlock.

I feel like I'm missing something fundamental here.

I can open a normal pipe from userspace (with pipe() or pipe2()), and
I can have two threads.  One thread writes to the pipe with write().
The other thread writes with splice().  Everything works fine.  What's
special about notifications?
