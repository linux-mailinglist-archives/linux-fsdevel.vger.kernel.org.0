Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9F7749D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfGZWrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 18:47:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41152 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfGZWrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:47:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so33248405lfa.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvhl+E3GJ0wX7WnV445XNNKydMDFA46thWrGIj1mIFA=;
        b=GOxLXfdpuhlLftPoWnZrvMRblqxWbQ3er1hFgs/arKDDsdl194FVlQdatc/si9hxFr
         kVxHfT4tQQ31sJ21+3oANtmv33rMWfwJ2ONRNADmAJDyNwWi3M7uM/4KN6bZUIr7BHkT
         1PE4jlh7jdUrQ17riWCjMBVCrRw1oLxWmBTCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvhl+E3GJ0wX7WnV445XNNKydMDFA46thWrGIj1mIFA=;
        b=ZVt31KSpWs8M0yCgcnXbtQoXEArslvTxOgoW/zD83dIgPs0TQAV8L+p5SlK1kNQHW2
         IV2Xn7qxUOkbhhK/qmpK8C/uDQ0Lifp+Be/+VsED7SKmigQhpNbKrbLvHPei+9ji/OO8
         fUyO5YyjZ17eGdHZ9mFpYnne/b+9ntonXx+BFIaCk5KMUxpaQ/JiAqTTKawQvJVEF+hq
         nfFqEd5XyO8Q7I0k64l7eqbMj2c+TuFMN+uI6S+gtd//7qzTjBKC+OQ/KuKmboXHnBMT
         M7uKt1oehRsb2sZdUMmiNbTm+Pfr1VAxx51XWGUHoM1hBxGMKVEAO2HXO8a2VRH9RoOI
         xsRA==
X-Gm-Message-State: APjAAAWcFwVET7XnG2TnPpxMsJes2P4bU5kAasyiSin++FuGnJYxhhk8
        Z3tTwNWqvUCdlhEUtOSlzKQ3kKarZAs=
X-Google-Smtp-Source: APXvYqxmZuxwPGz4b/2iyI87NN0uln7v1eiVkEkwE8yWx2vnCg+/ODGfHiuv10hvnq7YwhITHgLxYg==
X-Received: by 2002:ac2:43d0:: with SMTP id u16mr14803339lfl.38.1564181239653;
        Fri, 26 Jul 2019 15:47:19 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j23sm8762239lfb.93.2019.07.26.15.47.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id d24so52918133ljg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr52379784ljj.156.1564181238239;
 Fri, 26 Jul 2019 15:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
In-Reply-To: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 15:47:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
Message-ID: <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 5:00 AM Christian Brauner <christian@brauner.io> wrote:
>
> The commit that introduced the regression is:
>
> commit 0ce0cf12fc4c6a089717ff613d76457052cf4303
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun May 12 15:42:48 2019 -0400
>
>     consolidate the capability checks in sget_{fc,userns}()
>
>     ... into a common helper - mount_capable(type, userns)

The commit message there tries to imply that it's just consolidating
existing checks, but you're right - that's not at all the case.

In sget_fc(), the tests are all the exact same tests, but it uses a
different 'user_ns' after the commit. It *used* to use fc->user_ns,
now it uses 'user_ns' which depends on that 'global' bit.

And in sget_userns(), the userns is the same, but the tests are
different. Before that commit, it *always* checked for capability in
user_ns, and then (for non-FS_USERNS_MOUNT) it checked for capability
in the init namespace.

I guess the semantic change in sget_userns() is immaterial - if you
have CAP_SYS_ADMIN in the init namespace, you will have it in user_ns
too.

But the sget_fc() semantic change is a more serious change. Maybe that
was just unintentional, and Al _meant_ to pass in "fc->user_ns", but
didn't?

Of course, then later on, commit 20284ab7427f ("switch mount_capable()
to fs_context") drops that argument entirely, and hardcodes the
decision to look at fc->global.

But that fc->global decision wasn't there originally, and is incorrect
since it breaks existing users.

What gets much more confusing about this is that the two different
users then moved around. The sget_userns() case got moved to
legacy_get_tree(), and then joined together in vfs_get_tree(), and
then split and moved out to do_new_mount() and vfs_fsconfig_locked().

And that "joined together into vfs_get_tree()" must be wrong, because
the two cases used two different namespace rules. The sget_userns()
case *did* have that "global" flag check, while the sget_fc() did not.

Messy. Al?

               Linus
