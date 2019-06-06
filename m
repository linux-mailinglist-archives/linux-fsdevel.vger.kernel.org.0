Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5737DB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 21:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfFFTyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 15:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfFFTyx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:54:53 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8971A21473
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2019 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850891;
        bh=CwGMuE+WEe/QCirkYuKg8095g413T6AAKaG29fZ0SGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eQwvwcju3KjnhZ83Kd4AaOrth9m4z53DeQp6LenCs72nKfO38LO/vJA0nqcu6QMbU
         IyPfe96L/vuzq7/JfV6upFI4P0etLFkwpz5qGPi/yaOXQubr8y2/C6sq3/jpxnxEym
         ChcrDS8gGZxAFu/JAu4djfMGvCRA3Sr95xzJmlqw=
Received: by mail-wr1-f47.google.com with SMTP id r18so3653482wrm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 12:54:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXvt4R+IF0N5bz7FcIH11eSm1OvEbjfcC+soRCVMQrBT3IOF92u
        icj70uf3UEMaa4HNXI1IJGDo+Uje0UFF5gWvh8ryhg==
X-Google-Smtp-Source: APXvYqyekhKavJMx5MB3Z2AxY4A/CobI1nxE7fayLLS4V4kYzZ+R4ThNtJeafKr4gLEMwMxes/0kV7JtVkKhH1VwAnQ=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr12434458wru.265.1559850890024;
 Thu, 06 Jun 2019 12:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
 <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <c82052e5-ca11-67b5-965e-8f828081f31c@tycho.nsa.gov>
 <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com>
In-Reply-To: <07e92045-2d80-8573-4d36-643deeaff9ec@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 12:54:38 -0700
X-Gmail-Original-Message-ID: <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com>
Message-ID: <CALCETrVuNRPgEzv-XY4M9m6sEsCiRHxPenN_MpcMYc1h26vVwQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 11:56 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/6/2019 10:16 AM, Stephen Smalley wrote:
> > On 6/6/19 12:43 PM, Casey Schaufler wrote:
> >> ...
> >> I don't agree. That is, I don't believe it is sufficient.
> >> There is no guarantee that being able to set a watch on an
> >> object implies that every process that can trigger the event
> >> can send it to you.
> >>
> >>     Watcher has Smack label W
> >>     Triggerer has Smack label T
> >>     Watched object has Smack label O
> >>
> >>     Relevant Smack rules are
> >>
> >>     W O rw
> >>     T O rw
> >>
> >> The watcher will be able to set the watch,
> >> the triggerer will be able to trigger the event,
> >> but there is nothing that would allow the watcher
> >> to receive the event. This is not a case of watcher
> >> reading the watched object, as the event is delivered
> >> without any action by watcher.
> >
> > You are allowing arbitrary information flow between T and W above.  Who cares about notifications?
>
> I do. If Watched object is /dev/null no data flow is possible.
> There are many objects on a modern Linux system for which this
> is true. Even if it's "just a file" the existence of one path
> for data to flow does not justify ignoring the rules for other
> data paths.

Aha!

Even ignoring security, writes to things like /dev/null should
probably not trigger notifications to people who are watching
/dev/null.  (There are probably lots of things like this: /dev/zero,
/dev/urandom, etc.)  David, are there any notification types that have
this issue in your patchset?  If so, is there a straightforward way to
fix it?  Generically, it seems like maybe writes to device nodes
shouldn't trigger notifications since, despite the fact that different
openers of a device node share an inode, there isn't necessarily any
connection between them.

Casey, if this is fixed in general, do you have another case where the
right to write and the right to read do not imply the right to
communicate?

> An analogy is that two processes with different UIDs can open a file,
> but still can't signal each other.

What do you mean "signal"?  If two processes with different UIDs can
open the same file for read and write, then they can communicate with
each other in many ways.  For example, one can write to the file and
the other can read it.  One can take locks and the other can read the
lock state.  They can both map it and use any number of memory access
side channels to communicate.  But, of course, they can't send each
other signals with kill().

If, however, one of these processes is using some fancy mechanism
(inotify, dnotify, kqueue, fanotify, whatever) to watch the file, and
the other one writes it, then it seems inconsistent to lie to the
watching process and say that the file wasn't written because some
security policy has decided to allow the write, allow the read, but
suppress this particular notification.  Hence my request for a real
example: when would it make sense to do this?
