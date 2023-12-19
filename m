Return-Path: <linux-fsdevel+bounces-6490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98408188B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412A31F24F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9711BDDB;
	Tue, 19 Dec 2023 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJahvToR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF51BDC2;
	Tue, 19 Dec 2023 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F83C433C8;
	Tue, 19 Dec 2023 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702992932;
	bh=EkP6rQawRzc+I0zIElqB8wPi+VlBMezxM20ZUIcMsK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJahvToRpRabZqJtd82MofTR50IfY+Fp+NhFlyHnhik+CUzKgsO1EMMQejAZrzjdu
	 nG/dwj8EYmGddCFFko9jLjFQFzuBBT57iCa7H992F+FHlzRTHRufd/nkr01bZcPhUc
	 Ws0vdX/EGqbFXxPAw2AsnBHFfhDVF5RKQos7nIPDBvBxffGs4z4stcRqVSGrCk1JRz
	 6nGP1KWR1kTDwMuW0J/F9AQalUUw7si2/aqCTxvaqMSSHKCMXox4W72tNc7t1+bU/x
	 jxsE9+WmHczSurU0fiJ67rLlu77TvN+APU6RFqEdoGpkRKyW/gpgfpkXLnxqlag0pV
	 pPFQS4gEiRA4g==
Date: Tue, 19 Dec 2023 14:35:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, hu1.chen@intel.com,
	miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
	mikko.ylinen@intel.com, lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
Message-ID: <20231219-marken-pochen-26d888fb9bb9@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
 <875y0vp41g.fsf@intel.com>
 <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>

On Tue, Dec 19, 2023 at 09:15:52AM +0200, Amir Goldstein wrote:
> On Mon, Dec 18, 2023 at 11:57 PM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
> >
> > Christian Brauner <brauner@kernel.org> writes:
> >
> > >> > Yes, the important thing is that an object cannot change
> > >> > its non_refcount property during its lifetime -
> > >>
> > >> ... which means that put_creds_ref() should assert that
> > >> there is only a single refcount - the one handed out by
> > >> prepare_creds_ref() before removing non_refcount or
> > >> directly freeing the cred object.
> > >>
> > >> I must say that the semantics of making a non-refcounted copy
> > >> to an object whose lifetime is managed by the caller sounds a lot
> > >> less confusing to me.
> > >
> > > So can't we do an override_creds() variant that is effectively just:
> 
> Yes, I think that we can....
> 
> > >
> > > /* caller guarantees lifetime of @new */
> > > const struct cred *foo_override_cred(const struct cred *new)
> > > {
> > >       const struct cred *old = current->cred;
> > >       rcu_assign_pointer(current->cred, new);
> > >       return old;
> > > }
> > >
> > > /* caller guarantees lifetime of @old */
> > > void foo_revert_creds(const struct cred *old)
> > > {
> > >       const struct cred *override = current->cred;
> > >       rcu_assign_pointer(current->cred, old);
> > > }
> > >
> 
> Even better(?), we can do this in the actual guard helpers to
> discourage use without a guard:
> 
> struct override_cred {
>         struct cred *cred;
> };
> 
> DEFINE_GUARD(override_cred, struct override_cred *,
>             override_cred_save(_T),
>             override_cred_restore(_T));
> 
> ...
> 
> void override_cred_save(struct override_cred *new)
> {
>         new->cred = rcu_replace_pointer(current->cred, new->cred, true);
> }
> 
> void override_cred_restore(struct override_cred *old)
> {
>         rcu_assign_pointer(current->cred, old->cred);
> }

The main thing we want is that it's somewhat clear that it's special
purpose interface (Sometimes I jokingly feel we should have
include/linux/quirky_overlayfs_helpers.h or actually working module
specific exports so we can export a helper to only a single module.
Whatever happened to that?).

If you do the cred guard thing then maybe name it:

{override,revert}_cred_light()

and then use them to implement the replace portion for:

{override,revert}_cred().

Yes, the {override,revert}_cred() naming isn't optimal but unless we
rename them as well to *_{save,restore} I don't see the point in making
the new helpers deviate from that pattern. They basically do the same
thing.

So my point is to just let them mirror the naming in __fget_light().
To a regular VFS developer the *_light() will give away that it probably
doesn't take a reference.

But I'm not married to that.

So I'd probably just do something like the following COMPLETELY UNTESTED
AND UNCOMPILED thing:

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..c975eb47e691 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -165,6 +165,24 @@ extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
 extern int set_cred_ucounts(struct cred *);

+/*
+ * Override creds without bumping reference count. Caller must ensure
+ * reference remains valid or has taken reference. Almost always not the
+ * interface you want. Use override_creds()/revert_creds() instead.
+ */
+#define override_creds_light(override_cred)                       \
+       ({                                                        \
+               const struct cred *__old_cred = current->cred;    \
+               rcu_assign_pointer(current->cred, override_cred); \
+               __old_cred;                                       \
+       })
+
+#define revert_creds_light(revert_cred) \
+       rcu_assign_pointer(current->cred, revert_cred);
+
+DEFINE_GUARD(cred, struct cred *, override_creds_light(_T),
+            revert_creds_light(_T));
+
 static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 {
        return cap_issubset(cred->cap_ambient,
diff --git a/kernel/cred.c b/kernel/cred.c
index c033a201c808..d6713edaee37 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -485,7 +485,7 @@ EXPORT_SYMBOL(abort_creds);
  */
 const struct cred *override_creds(const struct cred *new)
 {
-       const struct cred *old = current->cred;
+       const struct cred *old;

        kdebug("override_creds(%p{%ld})", new,
               atomic_long_read(&new->usage));
@@ -499,8 +499,7 @@ const struct cred *override_creds(const struct cred *new)
         * visible to other threads under RCU.
         */
        get_new_cred((struct cred *)new);
-       rcu_assign_pointer(current->cred, new);
-
+       old = override_creds_light(new);
        kdebug("override_creds() = %p{%ld}", old,
               atomic_long_read(&old->usage));
        return old;
@@ -521,7 +520,7 @@ void revert_creds(const struct cred *old)
        kdebug("revert_creds(%p{%ld})", old,
               atomic_long_read(&old->usage));

-       rcu_assign_pointer(current->cred, old);
+       revert_creds_light(old);
        put_cred(override);
 }
 EXPORT_SYMBOL(revert_creds);

> 
> > > Maybe I really fail to understand this problem or the proposed solution:
> > > the single reference that overlayfs keeps in ovl->creator_cred is tied
> > > to the lifetime of the overlayfs superblock, no? And anyone who needs a
> > > long term cred reference e.g, file->f_cred will take it's own reference
> > > anyway. So it should be safe to just keep that reference alive until
> > > overlayfs is unmounted, no? I'm sure it's something quite obvious why
> > > that doesn't work but I'm just not seeing it currently.
> >
> > My read of the code says that what you are proposing should work. (what
> > I am seeing is that in the "optimized" cases, the only practical effect
> > of override/revert is the rcu_assign_pointer() dance)
> >
> > I guess that the question becomes: Do we want this property (that the
> > 'cred' associated with a subperblock/similar is long lived and the
> > "inner" refcount can be omitted) to be encoded in the constructor? Or do
> > we want it to be "encoded" in a call by call basis?
> >
> 
> Neither.
> 
> Christian's proposal does not involve marking the cred object as
> long lived, which looks a much better idea to me.
> 
> The performance issues you observed are (probably) due to get/put
> of cred refcount in the helpers {override,revert}_creds().

Most likely they are. I don't see what else would be expensive. But I
may lack details.

> 
> Christian suggested lightweight variants of {override,revert}_creds()
> that do not change refcount. Combining those with a guard and
> I don't see what can go wrong (TM).

Place a nice comment explaining lifetime expectations in the commit
message. Then someone can always tell us why we're wrong.

