Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99AA164BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSRTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 12:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBSRTF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:19:05 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507C524685
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582132744;
        bh=pdkNY2hNSnY9gfk2NzrHjgF6xJM4H9Y/ewvIWmreT30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vnO2O4ARZ57+m2WKOUb7GhddjqaoDXVsuMXfiNZeEGx2CUEhSrcOLwk7vQ6jehuVY
         7ZAQf5jzJfdbS7ByhaI5MGieQG5Akj0KliXYRwXHNlnQNEhGb87pr//Tw8tqFq6uyH
         kyfrK/detgBoqWdOmwxa2BWw5+K7YNOlQZ/t1UXw=
Received: by mail-wm1-f45.google.com with SMTP id c84so1514526wme.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 09:19:04 -0800 (PST)
X-Gm-Message-State: APjAAAXcV9pzZRWmCo29C+Tzm37cTa/4bq4ZWVdyG8shUUtwiRCKWzsR
        OxWBAqgTdE9EJAy8WAd+q8vQFP7jdZokGvi/iuGfJw==
X-Google-Smtp-Source: APXvYqzBqeT3cBwt5QLq0QxxbNo0Ff+khHeTRw3LvaqWbB7JAMELbBnkX4mD5JEjB+jVyyVW16JjTf+gEg/eDtdINSk=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr10898715wme.36.1582132742597;
 Wed, 19 Feb 2020 09:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-10-christian.brauner@ubuntu.com> <20200219024233.GA19334@mail.hallyn.com>
 <20200219120604.vqudwaeppebvisco@wittgenstein>
In-Reply-To: <20200219120604.vqudwaeppebvisco@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Feb 2020 09:18:51 -0800
X-Gmail-Original-Message-ID: <CALCETrW-XPkBMs30vk+Aiv+jA5i7TjHOYCgz0Ud6d0geaYte=g@mail.gmail.com>
Message-ID: <CALCETrW-XPkBMs30vk+Aiv+jA5i7TjHOYCgz0Ud6d0geaYte=g@mail.gmail.com>
Subject: Re: [PATCH v3 09/25] fs: add is_userns_visible() helper
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 4:06 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Feb 18, 2020 at 08:42:33PM -0600, Serge Hallyn wrote:
> > On Tue, Feb 18, 2020 at 03:33:55PM +0100, Christian Brauner wrote:
> > > Introduce a helper which makes it possible to detect fileystems whose
> > > superblock is visible in multiple user namespace. This currently only
> > > means proc and sys. Such filesystems usually have special semantics so their
> > > behavior will not be changed with the introduction of fsid mappings.
> >
> > Hi,
> >
> > I'm afraid I've got a bit of a hangup about the terminology here.  I
> > *think* what you mean is that SB_I_USERNS_VISIBLE is an fs whose uids are
> > always translated per the id mappings, not fsid mappings.  But when I see
>
> Correct!
>
> > the name it seems to imply that !SB_I_USERNS_VISIBLE filesystems can't
> > be seen by other namespaces at all.
> >
> > Am I right in my first interpretation?  If so, can we talk about the
> > naming?
>
> Yep, your first interpretation is right. What about: wants_idmaps()

Maybe fsidmap_exempt()?

I still haven't convinced myself that any of the above is actually
correct behavior, especially when people do things like creating
setuid binaries.
