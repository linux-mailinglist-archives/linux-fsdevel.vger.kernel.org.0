Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D14D62C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbiCKOCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349029AbiCKOCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D02A1C57D0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647007299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+nWv4ywDxtdW2kAMKWAd/9h8AiRGVEXkvqyetpKnWc=;
        b=dWQFvdLKw//Dc84MFg9J4h3vnUbZ87VC6gRC0/Y90m7Kk90HSYH1+yxZdInEGp19iCvG0z
        5Cnvw7Erx3fmuKMtQnGObTJSSavMcnjZV5cG5CY13eo6mTQktzWQBDgjAvZnR7c7SWG/Mv
        ed6n7kd7Q2CDqa2pAqwdFXllfVmyhM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-sly5me0lPe6uMFhCLHqmOA-1; Fri, 11 Mar 2022 09:01:36 -0500
X-MC-Unique: sly5me0lPe6uMFhCLHqmOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64741854E21;
        Fri, 11 Mar 2022 14:01:31 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06A257AD1B;
        Fri, 11 Mar 2022 14:01:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 58049223A46; Fri, 11 Mar 2022 09:01:30 -0500 (EST)
Date:   Fri, 11 Mar 2022 09:01:30 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr
 fix
Message-ID: <YitWOqzIRjnP1lok@redhat.com>
References: <20211117015806.2192263-1-dvander@google.com>
 <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com>
 <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com>
 <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
 <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
 <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:09:56AM +0200, Amir Goldstein wrote:
> On Fri, Mar 11, 2022 at 12:11 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Mar 9, 2022 at 4:13 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Mar 1, 2022 at 12:05 AM David Anderson <dvander@google.com> wrote:
> > > > On Mon, Feb 28, 2022 at 5:09 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > ...
> >
> > > >> This patchset may not have been The Answer, but surely there is
> > > >> something we can do to support this use-case.
> > > >
> > > > Yup exactly, and we still need patches 3 & 4 to deal with this. My current plan is to try and rework our sepolicy (we have some ideas on how it could be made compatible with how overlayfs works). If that doesn't pan out we'll revisit these patches and think harder about how to deal with the coherency issues.
> > >
> > > Can you elaborate a bit more on the coherency issues?  Is this the dir
> > > cache issue that is alluded to in the patchset?  Anything else that
> > > has come up on review?
> > >
> > > Before I start looking at the dir cache in any detail, did you have
> > > any thoughts on how to resolve the problems that have arisen?
> >
> > David, Vivek, Amir, Miklos, or anyone for that matter, can you please
> > go into more detail on the cache issues?  I *think* I may have found a
> > potential solution for an issue that could arise when the credential
> > override is not in place, but I'm not certain it's the only issue :)
> >
> 
> Hi Paul,
> 
> In this thread I claimed that the authors of the patches did not present
> a security model for overlayfs, such as the one currently in overlayfs.rst.
> If we had a model we could have debated its correctness and review its
> implementation.

Agreed. After going through the patch set, I was wondering what's the
overall security model and how to visualize that.

So probably there needs to be a documentation patch which explains
what's the new security model and how does it work.

Also think both in terms of DAC and MAC. (Instead of just focussing too
hard on SELinux).

My understanding is that in current model, some of the overlayfs
operations require priviliges. So mounter is supposed to be priviliged
and does the operation on underlying layers.

Now in this new model, there will be two levels of check. Both overlay
level and underlying layer checks will happen in the context of task
which is doing the operation. So first of all, all tasks will need
to have enough priviliges to be able to perform various operations
on lower layer. 

If we do checks at both the levels in with the creds of calling task,
I guess that probably is fine. (But will require a closer code inspection
to make sure there is no privilege escalation both for mounter as well
calling task).

> 
> As a proof that there is no solid model, I gave an *example* regarding
> the overlay readdir cache.
> 
> When listing a merged dir, meaning, a directory containing entries from
> several overlay layers, ovl_permission() is called to check user's permission,
> but ovl_permission() does not currently check permissions to read all layers,
> because that is not the current overlayfs model.
> 
> Overlayfs has a readdir cache, so without override_cred, a user with high
> credentials can populate the readdir cache and then a user will fewer
> credentials, not enough to access the lower layers, but enough to access
> the upper most layer, will pass ovl_permission() check and be allowed to
> read from readdir cache.

I am not very familiar with dir caching code. When I read through the
overlayfs.rst, it gave the impression that caching is per "struct file".

"This merged name list is cached in the
'struct file' and so remains as long as the file is kept open."

And I was wondering if that's the case, then one user should not be able
to access the cache built by another priviliged user (until and unless
privileged user passed fd).

But looks like we build this cache and store in ovl inode and that's
why this issue of cache built by higher privileged process will be
accessible to lower privileged process.

With current model this is not an issue because "mounter" is providing
those privileges to unprivileged process. So while unprivileged process
can't do "readdir" on an underlying lower dir, it might still be able
to do that through an overlay mount. But if we don't switch to mounter's
creds, then we probably can't rely on this dir caching. Agreed that
disabling dir caching seems simplest solution if we were to do
override_creds=off.

Thanks
Vivek

> 
> This specific problem can be solved in several ways - disable readdir
> cache with override_cred=off, check all layers in ovl_permission().
> That's not my point. My point is that I provided a proof that the current
> model of override_cred=off is flawed and it is up to the authors of the
> patch to fix the model and provide the analysis of overlayfs code to
> prove the model's correctness.
> 
> The core of the matter is there is no easy way to "merge" the permissions
> from all layers into a single permission blob that could be checked once.
> 
> Maybe the example I gave is the only flaw in the model, maybe not
> I am not sure. I will be happy to help you in review of a model and the
> solution that you may have found.
> 
> Thanks,
> Amir.
> 

