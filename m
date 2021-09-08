Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF611403594
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 09:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbhIHHim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350495AbhIHHig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:38:36 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD4C061757
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 00:37:29 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id bb10so439413vkb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxByYRg2XXqbg48iaJnwshxIX8ARRbQbbWyTDrsMpDg=;
        b=JtC8vxGN7eRYHrK74+0gnNKbyBQ6ygwCoAYMm88H5oYJZgf0QTejxJoGm/EWBYMNI2
         u74hLHaovlTxOuAO53GNWUjTNPZS1gCwm0TDI/ZJUB4HeCswQastk9SHPqMEB61BUjNC
         DierBZIFFkUSg8nBXL8zZskDsijYbJLqKYVig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxByYRg2XXqbg48iaJnwshxIX8ARRbQbbWyTDrsMpDg=;
        b=Ux8DVvzT+B7Ul5wO7rDMeAzzE7+UpxcQXj99XSnJNfI7SYXoj+XJB/qEVmWJliXEY4
         7g83RsEPySoeXFvtK8Hf+wqBhJCDA3pzJTCajwusSc6Ixb6eX7STt/BsQdvr/5XyT376
         EyVdGmpOResHPvFfdyi06+kgQlhB22bExhFQ8jhgafWIZplvAswDjY0xz4p+OHHjet+2
         llq8UNcAq3O1kjdspL/2ymYRygU0gDX+TK+OeC3gr6EaPQDvt8L1XNkgsGy8MTomG3ap
         bOHSjVTIaiReRs/OUIoPFp4y2hnlJHZ2wQNLnOfX1PjpOqKN8ED8RzhZr3rUF6teptOg
         FIkQ==
X-Gm-Message-State: AOAM532nPLuUIQebhPdbVPZHuPWDB9wBvq8ZrbUBC+VVRXzlO9dnF3pn
        NvR+B6aHpYvldH/NZ671Zq9UJ+kB7krkXx+lbtV0gA==
X-Google-Smtp-Source: ABdhPJzIbNRikobIOOunmSW5bp+DYjiJjzAzKNlWichoE9SwXSEqDDtjTORr8+/U3/M9/5256zkNoLf4zkFpLQ7XPiI=
X-Received: by 2002:a1f:a348:: with SMTP id m69mr216744vke.10.1631086648497;
 Wed, 08 Sep 2021 00:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
 <YTYoEDT+YOtCHXW0@work-vm> <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
 <YTfcT1JUactPhwSA@redhat.com>
In-Reply-To: <YTfcT1JUactPhwSA@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Sep 2021 09:37:17 +0200
Message-ID: <CAJfpegumUMsQ1Zk4MjnSXhrcnX_RJfM5LJ2oL6W3Um_wFNPRFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Fields, Bruce" <bfields@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Sept 2021 at 23:40, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Sep 06, 2021 at 04:56:44PM +0200, Miklos Szeredi wrote:
> > On Mon, 6 Sept 2021 at 16:39, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> >
> > > IMHO the real problem here is that the user/trusted/system/security
> > > 'namespaces' are arbitrary hacks rather than a proper namespacing
> > > mechanism that allows you to create new (nested) namespaces and associate
> > > permissions with each one.
> >
> > Indeed.
> >
> > This is what Eric Biederman suggested at some point for supporting
> > trusted xattrs within a user namespace:
> >
> > | For trusted xattrs I think it makes sense in principle.   The namespace
> > | would probably become something like "trusted<ns-root-uid>.".
> >
> > Theory sounds simple enough.  Anyone interested in looking at the details?
>
> So this namespaced trusted.* xattr domain will basically avoid the need
> to have CAP_SYS_ADMIN in init_user_ns, IIUC.  I guess this is better
> than giving CAP_SYS_ADMIN in init_user_ns.

That's the objective, yes.  I think the trick is getting filesystems
to store yet another xattr type.

Thanks,
Miklos
