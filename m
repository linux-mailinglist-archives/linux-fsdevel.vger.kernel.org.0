Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6921D3574
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENPpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENPpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 11:45:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8FC061A0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 08:45:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so1318381plr.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C14dFYivD8qv8BpAvB7kTDBgmObt0Bwj81tS0Zc4/E8=;
        b=WeBSVMSYQ4gtB5dULeEkKU/Ya0fz/EW/RpuUt7D8OeJEBKAKV2pF5kPidP02iOR39J
         G1MttEPeItqlTkRXkO6DaVmCrP7nH7+PO7my0CuD5d86lDI5xv46HrYCZiFQuNjdOnTz
         5lq27uwgV1aYUO8FPK6JNzqOwNdl1+mzKbYGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C14dFYivD8qv8BpAvB7kTDBgmObt0Bwj81tS0Zc4/E8=;
        b=kIAQaxPRV4RydYlf5SOljRqN4/KKJ3c6I8+ZtDJH+sjua5+h/bJOCG8RZfjy8df2mW
         oGeXEwuLdAevFfB74yo1jTLpxRjd88JK1+DElx+8NkvOZQfpzVw63GS07fSAcSumj1R1
         Cv8329eHu+30bSZpJ5Atp/aGSqX1ly7CbSTpt7PPA7RRW8UOdDXI0CC+i9CRsWjrYjea
         giujWuAePiRbmAehMKMBnB+Gj5shmxtfI3pDruGeUNCVOj5WFLMWYVTj4LvOnuzW8SkB
         +4NcmxXtxV34+duGJU2bkRgp+qKl1o8ZpgBXjMC45yuHdAFDSGbj7QmDvYuUz9MEvJvx
         sQzw==
X-Gm-Message-State: AOAM533KLSEIF40OrbU4c6ml6ats3sITfMm12BStoS5TXuLpXlT9QVAi
        ZJSMIMDK77Gh00zaOzwHiqfHsA==
X-Google-Smtp-Source: ABdhPJyhzYoT7OtYhHCXKJ4eWD6sNRzKX5qxh8oQ2rT3RB19/hswKImd/xT2ezGyqupFNS8qGCcfOg==
X-Received: by 2002:a17:902:c113:: with SMTP id 19mr4514772pli.95.1589471115414;
        Thu, 14 May 2020 08:45:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e15sm1909094pfh.23.2020.05.14.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:45:14 -0700 (PDT)
Date:   Thu, 14 May 2020 08:45:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
Message-ID: <202005140830.2475344F86@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
 <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 08:22:01AM -0400, Stephen Smalley wrote:
> On Wed, May 13, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, May 13, 2020 at 04:27:39PM -0700, Kees Cook wrote:
> > > Like, couldn't just the entire thing just be:
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index a320371899cf..0ab18e19f5da 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -2849,6 +2849,13 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> > >               break;
> > >       }
> > >
> > > +     if (unlikely(mask & MAY_OPENEXEC)) {
> > > +             if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT &&
> > > +                 path_noexec(path))
> > > +                     return -EACCES;
> > > +             if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
> > > +                     acc_mode |= MAY_EXEC;
> > > +     }
> > >       error = inode_permission(inode, MAY_OPEN | acc_mode);
> > >       if (error)
> > >               return error;
> > >
> >
> > FYI, I've confirmed this now. Effectively with patch 2 dropped, patch 3
> > reduced to this plus the Kconfig and sysctl changes, the self tests
> > pass.
> >
> > I think this makes things much cleaner and correct.
> 
> I think that covers inode-based security modules but not path-based
> ones (they don't implement the inode_permission hook).  For those, I
> would tentatively guess that we need to make sure FMODE_EXEC is set on
> the open file and then they need to check for that in their file_open
> hooks.

I kept confusing myself about what order things happened in, so I made
these handy notes about the call graph:

openat2(dfd, char * filename, open_how)
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            do_open(nameidata, file, open_flags) 
                may_open(path, acc_mode, open_flag)
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) ...
                        security_file_open(f)
                        open()

So, it looks like adding FMODE_EXEC into f_flags in do_open() is needed in
addition to injecting MAY_EXEC into acc_mode in do_open()? Hmmm

-- 
Kees Cook
