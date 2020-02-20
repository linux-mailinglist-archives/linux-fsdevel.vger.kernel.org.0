Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A98166697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 19:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgBTSux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 13:50:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37314 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgBTSuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:50:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id q23so5357212ljm.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qT0+tJ3JfMm/Au3fd6jXh7TStZpW/jP0WQ11tC4BoO0=;
        b=QSbi426XGCNQQMRZ6i9wp2Hxt1rja/L/DmV64pQlAZ/xexjWOLYpyMkZcTtHbV2RTj
         boUMY9a0RzdRBTzrdsifBJ0B2eba3N31tLklsMXFXu40xW+SLB0sh63csfs0l7Pq6TQw
         8Y39T/oAj/FZSyrExUPgGcQiPy763ExfZ40o78eNKqrwWokvsfH2BLJQRI9egP3gqaF7
         ZNpq+u1zDdOG6KaeTGDil/ZKOY3lyIStYyNcDZvIZsvNOZbkZezrkmUH8nVvS4HQS7j2
         +TgkCh/8WDvP/c9Fn+ktQ2uyzzQnAmOn9JkRC7NaW/t/XmSQFYuHjt7yGggX5MzF2cZJ
         dmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qT0+tJ3JfMm/Au3fd6jXh7TStZpW/jP0WQ11tC4BoO0=;
        b=P8k+hK5zOsSA/fTm0doqk0+EXHAlVkvjLhQaIyC2s/NPMsAG4IoJ3EPnAL+SsjISl4
         DYrovpMa6jxhtkFWuQwFtJfuQCNnggJ0oE7gt4HJj9+37xnyXb4bnI9PyVOMhgr2IZQc
         ANGBFUKStu2F5URm4TzCS6jtMFhEGxvE6ADZcJg1fjHvLhdwYwY4XIDk0DBWo2mM+lL1
         ckRABAjfPdnCwiL5hXwoeDZcqZ9i5jJ73BMTBdV4k3s0smgGqaXXFu4Y+GmQHksv4wDy
         B30z1yS6kAaYVNudxruYB93t9uWc1eQUsrF/3BFPZY/oSfHL84cu39YuaMdydXFAy9/b
         t+fA==
X-Gm-Message-State: APjAAAUZjSs6FEp1luTYB11HTAs+4ZWnC4He91+1KzHGvTI+CB1uUO7b
        h08PVX4Y2rs9njZrKZ8QoAeeAVALf/hb64Fx3UnqHN8c
X-Google-Smtp-Source: APXvYqzsRgrvQVx3QKNJYHllLg9vf16d6MXdzUk6Ci3jAbHoIgsX8JWZFkYTVZcMNn0E/OKk18FpGWonj/U+Lm67ni0=
X-Received: by 2002:a2e:9284:: with SMTP id d4mr19204328ljh.226.1582224649152;
 Thu, 20 Feb 2020 10:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov> <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
 <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com>
In-Reply-To: <eb2dbe22-91af-17c6-3dfb-d9ec619a4d7a@schaufler-ca.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 20 Feb 2020 10:50:12 -0800
Message-ID: <CAKOZueuus6fVqrKsfNgSYGo-kXJ3f6Mv_NJZStY1Uo934=SjDw@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        SElinux list <selinux@vger.kernel.org>, kvm@vger.kernel.org,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:11 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/17/2020 4:14 PM, Paul Moore wrote:
> > On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> Add support for labeling and controlling access to files attached to anon
> >> inodes. Introduce extended interfaces for creating such files to permit
> >> passing a related file as an input to decide how to label the anon
> >> inode. Define a security hook for initializing the anon inode security
> >> attributes. Security attributes are either inherited from a related file
> >> or determined based on some combination of the creating task and policy
> >> (in the case of SELinux, using type_transition rules).  As an
> >> example user of the inheritance support, convert kvm to use the new
> >> interface for passing the related file so that the anon inode can inherit
> >> the security attributes of /dev/kvm and provide consistent access control
> >> for subsequent ioctl operations.  Other users of anon inodes, including
> >> userfaultfd, will default to the transition-based mechanism instead.
> >>
> >> Compared to the series in
> >> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> >> this approach differs in that it does not require creation of a separate
> >> anonymous inode for each file (instead storing the per-instance security
> >> information in the file security blob), it applies labeling and control
> >> to all users of anonymous inodes rather than requiring opt-in via a new
> >> flag, it supports labeling based on a related inode if provided,
> >> it relies on type transitions to compute the label of the anon inode
> >> when there is no related inode, and it does not require introducing a new
> >> security class for each user of anonymous inodes.
> >>
> >> On the other hand, the approach in this patch does expose the name passed
> >> by the creator of the anon inode to the policy (an indirect mapping could
> >> be provided within SELinux if these names aren't considered to be stable),
> >> requires the definition of type_transition rules to distinguish userfaultfd
> >> inodes from proc inodes based on type since they share the same class,
> >> doesn't support denying the creation of anonymous inodes (making the hook
> >> added by this patch return something other than void is problematic due to
> >> it being called after the file is already allocated and error handling in
> >> the callers can't presently account for this scenario and end up calling
> >> release methods multiple times), and may be more expensive
> >> (security_transition_sid overhead on each anon inode allocation).
> >>
> >> We are primarily posting this RFC patch now so that the two different
> >> approaches can be concretely compared.  We anticipate a hybrid of the
> >> two approaches being the likely outcome in the end.  In particular
> >> if support for allocating a separate inode for each of these files
> >> is acceptable, then we would favor storing the security information
> >> in the inode security blob and using it instead of the file security
> >> blob.
> > Bringing this back up in hopes of attracting some attention from the
> > fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
> > perspective we would prefer to attach the security blob to the inode
> > as opposed to the file struct; does anyone have any objections to
> > that?
>
> Sorry for the delay - been sick the past few days.
>
> I agree that the inode is a better place than the file for information
> about the inode. This is especially true for Smack, which uses
> multiple extended attributes in some cases. I don't believe that any
> except the access label will be relevant to anonymous inodes, but
> I can imagine security modules with policies that would.
>
> I am always an advocate of full xattr support. It goes a long
> way in reducing the number and complexity of special case interfaces.

It sounds like we have broad consensus on using the inode to hold
security information, implying that anon_inodes should create new
inodes. Do any of the VFS people want to object?
