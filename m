Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0671127E806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgI3L6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgI3L6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:58:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284FC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 04:58:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q5so1348475ilj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuRMI2dEbW7qdVyqJr4Dp9XK546nDs8UHDfV++8fh6o=;
        b=WdYfVz9XvAYja6V+uU/flmg7Tzv7KdXyhWt4mlGjsjZW71CHBTA8ggwk/LrKV3Uqum
         YpybTHXhAsT/C0FWeRaFHGN23XEvuHeX3MQv8RL+b/D9vR7DN82aMn8dgtLzm46NNpmt
         tTxL0uArHNkW3CFSxm7PPKBTx9yKAwcTzCC6NCu48iowbceXYrU+3WOMKKsEmoV0O4EH
         T0GxaUz2KjsYZs6S8bselpH/VzKRZGHjJ0tlPmapjQb1hM4qUHAePmxtnjPLJFtqqN79
         eRScaW5lBRep+xRYClOTz4HWPiPXG9dy40AcHizr1LaJGby86y4PB6Vef+of/pJPZ7RQ
         6beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuRMI2dEbW7qdVyqJr4Dp9XK546nDs8UHDfV++8fh6o=;
        b=IzBjtfKMl2M0GZg1JzAOxqivg8bm2Rvou4M8nYTslW0HPkFfSGgLMPbtPsTfp0dWNu
         YNEUGbnvdDgquqL2JU7YUfkMi4Xe0UDpZ4Zmby/+/W0BP31PypQu/Neb4BCzxQoYba/J
         0m4duDbS4yozmSDeld9ulXtFnr9/eJcdasGB5MdoiEsy6l37M39Ci8n4kzRBlmEhYw4+
         8Y3W91hL/m3pdb70liUfg9SshLh5VNfcRNjEn3Wj0ZhXrVSTW44Gol4BZznfVKlBs3cQ
         8oQ3u4uxaV/9p/KCm2KtyhTFyKfTgsTRRLGIfllDfXUM5l6p0Bss9ww8W2+SonSb90Hu
         48Qw==
X-Gm-Message-State: AOAM53317A2WMAixxRD4E4R9jy7zBf4nVGF23IY4Gw1bP0Zo8V8t8a1a
        2pP1D7T7CXJUgmjqW8dhO2dOt2S0q7eWLRsAmYolX27dSCc=
X-Google-Smtp-Source: ABdhPJwPLlAg7n3NiQlbyv1Y37KBn0IkAvIJ/3NLyU5VPyMzkRoPS4M574QcOMoq0c82I9PIpwBChtL/o5kYnkl1P8Q=
X-Received: by 2002:a92:6403:: with SMTP id y3mr1705190ilb.72.1601467084449;
 Wed, 30 Sep 2020 04:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185015.GG220516@redhat.com> <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
 <CAJfpegtH0TruLCnG_YJ8aUBHh7k5sqN_wVEegvDPJOoDcmwLSQ@mail.gmail.com>
In-Reply-To: <CAJfpegtH0TruLCnG_YJ8aUBHh7k5sqN_wVEegvDPJOoDcmwLSQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Sep 2020 14:57:53 +0300
Message-ID: <CAOQ4uxiity6zAW__Y+T=o+GHkzxo=fnVj+21Z8cRjdvFWbauRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Zhi Zhang <zhang.david2011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 9:40 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Sep 30, 2020 at 6:36 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I wonder out loud if this change of behavior you proposed is a good opportunity
> > to introduce some of the verbs from SMB oplocks / NFS delegations into the
> > FUSE protocol in order to allow finer grained control over per-file
> > (and later also per-directory) caching behavior.
>
> That would be really nice.  Let me find a recent discussion on this...
> ah it was private.   Copying the thread below.  Thoughts?
>
> Thanks,
> Miklos
>
> On Tue, Aug 11, 2020 at 8:56 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Aug 5, 2020 at 5:53 AM Zhi Zhang <zhang.david2011@gmail.com> wrote:
> > > On Tue, Aug 4, 2020 at 11:36 AM Zhi Zhang <zhang.david2011@gmail.com> wrote:
> > > > On Mon, Aug 3, 2020 at 6:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Thu, Jul 23, 2020 at 12:40 PM Zhi Zhang <zhang.david2011@gmail.com> wrote:
> >
> > > > > > We are using distributed filesystem ceph-fuse and we enabled writeback
> > > > > > cache on fuse which improves the write performance, but the file's
> > > > > > size attribute can't be updated on another client even if the users on
> > > > > > this client only read this file.
> > > > > >
> > > > > > From my understanding, if the file is not opened in write mode and
> > > > > > already writes its buffered data to userspace filesystem like
> > > > > > ceph-fuse, then its state should be clean. The upper userspace and
> > > > > > remote server should be responsible for the data and consistency. So
> > > > > > at this moment fuse could trust the attributes from the server which
> > > > > > has the most authoritative information about this file.
> > > > > >
> > > > > > Please let me know your thoughts, then I can work on this patch. Thanks.
> > > > >
> > > > > Hi,
> > > > >
> > > > > Something like this makes sense, but I think we should be adding an
> > > > > explicit state (a lease to read/write the data) to the fuse inode.
> > > > >
> > > > > Opening for write would automatically acquire the WRITE lease,
> > > > > similarly opening for read would acquire the READ lease.  Then we need
> > > > > a new notification for revoking a lease (FUSE_NOTIFY_REVOKE).  And we
> > > > > need a new request for re-acquiring a lease (FUSE_REACQUIRE).
> > > > >
> > > > > Does that make sense?

Sounds right.

Linking to MS docs for reference, because I find their documentation
most comprehensive and SMBv3.1 semantics is much richer than NFSv4,
so maybe useful examples can be found there:
https://docs.microsoft.com/en-us/windows/win32/fileio/breaking-opportunistic-locks

I would consider adopting the downgrade/upgrade terminology, because
REVOKE/REACQUIRE sounds like losing the old any taking a new lease
when in fact downgrade from WRITE to READ and vice versa is a common
case. But the name is not what matters, it's to get the functionality right.

Thanks,
Amir.

> > > > >
> > > > > Would you mind discussing this on the linux-fsdevel mailing lists?
> > > > >
> > > > > Thanks,
> > > > > Miklos>
> > > Hi Miklos,
> > >
> > > Thanks for the comments. I thought about it but I still have a couple
> > > of questions about the lease.
> > >
> > > 1. After acquiring a WRITE lease, when should we release(revoke) it?
> > > Before I assumed the file would be clean once we wrote buffered data
> > > to the userspace file system. Now if we introduce the lease, should we
> > > release the WRITE lease once we write the buffered data or we need to
> > > wait for the revoking notification from userspace file system?
> >
> > I think it's easier to wait for the notification, instead of trying to
> > guess.   When the file is closed (released) then the lease is also
> > implicitly released.
> >
> > > 2. What is the purpose of READ lease?
> > > Once we hold the READ lease, we could trust cached attributes and data
> > > until revoking notification from userspace file system?
> >
> > Yes.
> >
> > > 3. What is the purpose of re-acquiring a lease and why do we need a new request?
> > > From my understanding, the lease mechanism is only known by kernel
> > > fuse, not for libfuse.
> >
> > We don't necessarily need a new request, it could be implicit in the
> > first uncached write.
> >
> > > To re-acquire a lease here is actually for READ
> > > lease by sending a sync getattr request.
> >
> > Yes.
> >
> > Thanks,
> > Miklos
