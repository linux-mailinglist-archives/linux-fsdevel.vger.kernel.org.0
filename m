Return-Path: <linux-fsdevel+bounces-3200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAF7F145C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009331C215BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EB1A727;
	Mon, 20 Nov 2023 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3928D51;
	Mon, 20 Nov 2023 05:24:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYnqV4VwGz9xFr4;
	Mon, 20 Nov 2023 21:07:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHtXXkXVtlxasHAQ--.12528S2;
	Mon, 20 Nov 2023 14:24:02 +0100 (CET)
Message-ID: <6f8fb47a73fe27c6f77ac9280c3f8b63ce57ba27.camel@huaweicloud.com>
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM
 infrastructure
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com,  mic@digikod.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  selinux@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Mon, 20 Nov 2023 14:23:45 +0100
In-Reply-To: <CAHC9VhRpG3wFbu6-EZw3t1TeKxBzYX86YzizE6x9JGeWmyxixA@mail.gmail.com>
References: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
	 <f529266a02533411e72d706b908924e8.paul@paul-moore.com>
	 <49a7fd0a1f89188fa92f258e88c50eaeca0f4ac9.camel@huaweicloud.com>
	 <CAHC9VhRpG3wFbu6-EZw3t1TeKxBzYX86YzizE6x9JGeWmyxixA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHtXXkXVtlxasHAQ--.12528S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1kGFWkWFWkJF43trW5Jrb_yoW7tF43pa
	yUKay5Cr4kAr1Fk3Wvy3Wrua1S9rZ7XFW7WrnxJry8A34UZFySvF48Kay5uFWDCryrtw10
	qa1jkr9xC3Z0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5KmQgAAsG
X-CFilter-Loop: Reflected

On Fri, 2023-11-17 at 16:22 -0500, Paul Moore wrote:
> On Thu, Nov 16, 2023 at 5:08=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Wed, 2023-11-15 at 23:33 -0500, Paul Moore wrote:
> > > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>=20
> ...
>=20
> > > > +/*
> > > > + * Perform the initialization of the 'integrity', 'ima' and 'evm' =
LSMs to
> > > > + * ensure that the management of integrity metadata is working at =
the time
> > > > + * IMA and EVM hooks are registered to the LSM infrastructure, and=
 to keep
> > > > + * the original ordering of IMA and EVM functions as when they wer=
e hardcoded.
> > > > + */
> > > >  static int __init integrity_lsm_init(void)
> > > >  {
> > > > +   const struct lsm_id *lsmid;
> > > > +
> > > >     iint_cache =3D
> > > >         kmem_cache_create("iint_cache", sizeof(struct integrity_iin=
t_cache),
> > > >                           0, SLAB_PANIC, iint_init_once);
> > > > +   /*
> > > > +    * Obtain either the IMA or EVM LSM ID to register integrity-sp=
ecific
> > > > +    * hooks under that LSM, since there is no LSM ID assigned to t=
he
> > > > +    * 'integrity' LSM.
> > > > +    */
> > > > +   lsmid =3D ima_get_lsm_id();
> > > > +   if (!lsmid)
> > > > +           lsmid =3D evm_get_lsm_id();
> > > > +   /* No point in continuing, since both IMA and EVM are disabled.=
 */
> > > > +   if (!lsmid)
> > > > +           return 0;
> > > > +
> > > > +   security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks)=
, lsmid);
> > >=20
> > > Ooof.  I understand, or at least I think I understand, why the above
> > > hack is needed, but I really don't like the idea of @integrity_hooks
> > > jumping between IMA and EVM depending on how the kernel is configured=
.
> > >=20
> > > Just to make sure I'm understanding things correctly, the "integrity"
> > > LSM exists to ensure the proper hook ordering between IMA/EVM, shared
> > > metadata management for IMA/EVM, and a little bit of a hack to solve
> > > some kernel module loading issues with signatures.  Is that correct?
> > >=20
> > > I see that patch 23/23 makes some nice improvements to the metadata
> > > management, moving them into LSM security blobs, but it appears that
> > > they are still shared, and thus the requirement is still there for
> > > an "integrity" LSM to manage the shared blobs.
> >=20
> > Yes, all is correct.
>=20
> Thanks for the clarification, more on this below.
>=20
> > > I'd like to hear everyone's honest opinion on this next question: do
> > > we have any hope of separating IMA and EVM so they are independent
> > > (ignore the ordering issues for a moment), or are we always going to
> > > need to have the "integrity" LSM to manage shared resources, hooks,
> > > etc.?
> >=20
> > I think it should not be technically difficult to do it. But, it would
> > be very important to understand all the implications of doing those
> > changes.
> >=20
> > Sorry, for now I don't see an immediate need to do that, other than
> > solving this LSM naming issue. I tried to find the best solution I
> > could.
>=20
> I first want to say that I think you've done a great job thus far, and
> I'm very grateful for the work you've done.  We can always use more
> help in the kernel security space and I'm very happy to see your
> contributions - thank you :)

Thank you!

> I'm concerned about the integrity LSM because it isn't really a LSM,
> it is simply an implementation artifact from a time when only one LSM
> was enabled.  Now that we have basic support for stacking LSMs, as we
> promote integrity/IMA/EVM I think this is the perfect time to move
> away from the "integrity" portion and integrate the necessary
> functionality into the IMA and EVM LSMs.  This is even more important
> now that we are looking at making the LSMs more visible to userspace
> via syscalls; how would you explain to a developer or user the need
> for an "integrity" LSM along with the IMA and EVM LSMs?
>=20
> Let's look at the three things the the integrity code provides in this pa=
tchset:
>=20
> * IMA/EVM hook ordering
>=20
> For better or worse, we have requirements on LSM ordering today that
> are enforced only by convention, the BPF LSM being the perfect
> example.  As long as we document this in Kconfig I think we are okay.
>=20
> * Shared metadata
>=20
> Looking at the integrity_iint_cache struct at the end of your patchset
> I see the following:
>=20
>   struct integrity_iint_cache {
>     struct mutex mutex;
>     struct inode *inode;
>     u64 version;
>     unsigned long flags;
>     unsigned long measured_pcrs;
>     unsigned long atomic_flags;
>     enum integrity_status ima_file_status:4;
>     enum integrity_status ima_mmap_status:4;
>     enum integrity_status ima_bprm_status:4;
>     enum integrity_status ima_read_status:4;
>     enum integrity_status ima_creds_status:4;
>     enum integrity_status evm_status:4;
>     struct ima_digest_data *ima_hash;
>   };
>=20
> Now that we are stashing the metadata in the inode, we should be able
> to remove the @inode field back pointer.  It seems like we could
> duplicate @mutex and @version without problem.
>=20
> I only see the @measured_pcrs, @atomic_flags used in the IMA code.
>=20
> I only see the @ima_XXX_status fields using in the IMA code, and the
> @evm_status used in the EVM code.
>=20
> I only see the @ima_hash field used by the IMA code.
>=20
> I do see both IMA and EVM using the @flags field, but only one case
> (IMA_NEW_FILE) where one LSM (EVM) looks for another flags (IMA).  I'm
> not sure how difficult that would be to untangle, but I imagine we
> could do something here; if we had to, we could make EVM be dependent
> on IMA in Kconfig and add a function call to check on the inode
> status.  Although I hope we could find a better solution.
>=20
> * Kernel module loading hook (integrity_kernel_module_request(...))
>=20
> My guess is that this is really an IMA hook, but I can't say for
> certain.  If it is needed for EVM we could always duplicate it across
> the IMA and EVM LSMs, it is trivially small and one extra strcmp() at
> kernel module load time doesn't seem awful to me.

Ok... so, for now I'm trying to separate them just to see if it is
possible. Will send just the integrity-related patches shortly.

Thanks

Roberto


