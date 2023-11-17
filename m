Return-Path: <linux-fsdevel+bounces-3104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC37EFAE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FBD280DFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F543AD9;
	Fri, 17 Nov 2023 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dY0g61TI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E063C3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:22:25 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-daf26d84100so2428341276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700256136; x=1700860936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VlTgLQgobFGG9PZZStnDlmcBu7nmiBF+q+s3UJ3hXY=;
        b=dY0g61TIlRN+hRurbcp/9nn1mUxdFaB+a/xJadYgi4t8eIYBYVIAz/Ru5FfvpS0cja
         2BUtKjga6tWLZGA2I4PBeEaOu5MWt9UwyrWFRSYTCY7sTtZV2RzRVwFkhqqA+O8OOsIy
         JPeHLrHYuEJ8RL8U93ZQT18EvbHiTz5PCjWjbL3q7JfKiQdHoGzBvLNJDfNFE7mvHze9
         sqqomks9/Mn7bOSHMfXsAZP738FRG5j5BHmBkTZ/1HB0nTisVNQ2xjKlLslMIgUyV4I5
         wWiuBIK5GgAJjZpBK0+rlOlXQtrM2f8g5ue3QtlPuk12dYGh7Zujx4+wQP9y+yI7FtNQ
         qG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256136; x=1700860936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VlTgLQgobFGG9PZZStnDlmcBu7nmiBF+q+s3UJ3hXY=;
        b=qBS2jBEQ8M/9Sx5C3q/VEb0jNxL4J1ek9wSNnuEmATfIwM5WPsiToc6ZO+jvcHLdpa
         al1qDUQJCSRsRJMNeeI51uM1gndwGPAEUYgpq5tqMm8SV0hNVsV9wF+j9nXF/iD+0chz
         mm7DD+vyDAM2HEh41airrircrhatwx2Ql+2wtCzw1xz0VurY1mKDnxIPtRKkaX0uzbS1
         TRfvrmOZ9tY602Zyk6Pm8+llVC26v6ok7vYg3EZKFNOAcpZwm7TydPcY/DNAPNC+Iqnm
         UOs2JAbvftQ4bVvK9rOv2vbrGsHlUwsPpn9sVcwiR5AYQl/ILuo9iV1wG/qCVQPWT5RX
         0reA==
X-Gm-Message-State: AOJu0YzWUIwmZOE8rfHE36VPUrefjjl4YNOmr7H963vvcEp6QXeZUNJM
	NZASZWgs5pQZ4+Sk8q2kpMl/UB5e8JtFbaFVWF+P
X-Google-Smtp-Source: AGHT+IH5POWzxfJUHKpYri9R+UVG+Wr3w1T0ws/aAxZr3RWyKZUULPlBJx6xRvviFDadIjnVfDAi37L7P8ExDxDrolc=
X-Received: by 2002:a25:2693:0:b0:da0:86e8:aea4 with SMTP id
 m141-20020a252693000000b00da086e8aea4mr790094ybm.57.1700256136343; Fri, 17
 Nov 2023 13:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
 <f529266a02533411e72d706b908924e8.paul@paul-moore.com> <49a7fd0a1f89188fa92f258e88c50eaeca0f4ac9.camel@huaweicloud.com>
In-Reply-To: <49a7fd0a1f89188fa92f258e88c50eaeca0f4ac9.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Nov 2023 16:22:05 -0500
Message-ID: <CAHC9VhRpG3wFbu6-EZw3t1TeKxBzYX86YzizE6x9JGeWmyxixA@mail.gmail.com>
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM infrastructure
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 5:08=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

...

> > > +/*
> > > + * Perform the initialization of the 'integrity', 'ima' and 'evm' LS=
Ms to
> > > + * ensure that the management of integrity metadata is working at th=
e time
> > > + * IMA and EVM hooks are registered to the LSM infrastructure, and t=
o keep
> > > + * the original ordering of IMA and EVM functions as when they were =
hardcoded.
> > > + */
> > >  static int __init integrity_lsm_init(void)
> > >  {
> > > +   const struct lsm_id *lsmid;
> > > +
> > >     iint_cache =3D
> > >         kmem_cache_create("iint_cache", sizeof(struct integrity_iint_=
cache),
> > >                           0, SLAB_PANIC, iint_init_once);
> > > +   /*
> > > +    * Obtain either the IMA or EVM LSM ID to register integrity-spec=
ific
> > > +    * hooks under that LSM, since there is no LSM ID assigned to the
> > > +    * 'integrity' LSM.
> > > +    */
> > > +   lsmid =3D ima_get_lsm_id();
> > > +   if (!lsmid)
> > > +           lsmid =3D evm_get_lsm_id();
> > > +   /* No point in continuing, since both IMA and EVM are disabled. *=
/
> > > +   if (!lsmid)
> > > +           return 0;
> > > +
> > > +   security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks), =
lsmid);
> >
> > Ooof.  I understand, or at least I think I understand, why the above
> > hack is needed, but I really don't like the idea of @integrity_hooks
> > jumping between IMA and EVM depending on how the kernel is configured.
> >
> > Just to make sure I'm understanding things correctly, the "integrity"
> > LSM exists to ensure the proper hook ordering between IMA/EVM, shared
> > metadata management for IMA/EVM, and a little bit of a hack to solve
> > some kernel module loading issues with signatures.  Is that correct?
> >
> > I see that patch 23/23 makes some nice improvements to the metadata
> > management, moving them into LSM security blobs, but it appears that
> > they are still shared, and thus the requirement is still there for
> > an "integrity" LSM to manage the shared blobs.
>
> Yes, all is correct.

Thanks for the clarification, more on this below.

> > I'd like to hear everyone's honest opinion on this next question: do
> > we have any hope of separating IMA and EVM so they are independent
> > (ignore the ordering issues for a moment), or are we always going to
> > need to have the "integrity" LSM to manage shared resources, hooks,
> > etc.?
>
> I think it should not be technically difficult to do it. But, it would
> be very important to understand all the implications of doing those
> changes.
>
> Sorry, for now I don't see an immediate need to do that, other than
> solving this LSM naming issue. I tried to find the best solution I
> could.

I first want to say that I think you've done a great job thus far, and
I'm very grateful for the work you've done.  We can always use more
help in the kernel security space and I'm very happy to see your
contributions - thank you :)

I'm concerned about the integrity LSM because it isn't really a LSM,
it is simply an implementation artifact from a time when only one LSM
was enabled.  Now that we have basic support for stacking LSMs, as we
promote integrity/IMA/EVM I think this is the perfect time to move
away from the "integrity" portion and integrate the necessary
functionality into the IMA and EVM LSMs.  This is even more important
now that we are looking at making the LSMs more visible to userspace
via syscalls; how would you explain to a developer or user the need
for an "integrity" LSM along with the IMA and EVM LSMs?

Let's look at the three things the the integrity code provides in this patc=
hset:

* IMA/EVM hook ordering

For better or worse, we have requirements on LSM ordering today that
are enforced only by convention, the BPF LSM being the perfect
example.  As long as we document this in Kconfig I think we are okay.

* Shared metadata

Looking at the integrity_iint_cache struct at the end of your patchset
I see the following:

  struct integrity_iint_cache {
    struct mutex mutex;
    struct inode *inode;
    u64 version;
    unsigned long flags;
    unsigned long measured_pcrs;
    unsigned long atomic_flags;
    enum integrity_status ima_file_status:4;
    enum integrity_status ima_mmap_status:4;
    enum integrity_status ima_bprm_status:4;
    enum integrity_status ima_read_status:4;
    enum integrity_status ima_creds_status:4;
    enum integrity_status evm_status:4;
    struct ima_digest_data *ima_hash;
  };

Now that we are stashing the metadata in the inode, we should be able
to remove the @inode field back pointer.  It seems like we could
duplicate @mutex and @version without problem.

I only see the @measured_pcrs, @atomic_flags used in the IMA code.

I only see the @ima_XXX_status fields using in the IMA code, and the
@evm_status used in the EVM code.

I only see the @ima_hash field used by the IMA code.

I do see both IMA and EVM using the @flags field, but only one case
(IMA_NEW_FILE) where one LSM (EVM) looks for another flags (IMA).  I'm
not sure how difficult that would be to untangle, but I imagine we
could do something here; if we had to, we could make EVM be dependent
on IMA in Kconfig and add a function call to check on the inode
status.  Although I hope we could find a better solution.

* Kernel module loading hook (integrity_kernel_module_request(...))

My guess is that this is really an IMA hook, but I can't say for
certain.  If it is needed for EVM we could always duplicate it across
the IMA and EVM LSMs, it is trivially small and one extra strcmp() at
kernel module load time doesn't seem awful to me.

--=20
paul-moore.com

