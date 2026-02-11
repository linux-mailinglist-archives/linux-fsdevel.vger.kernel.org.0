Return-Path: <linux-fsdevel+bounces-76919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E9JXK2Dei2nKcQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:41:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE411207C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C10373002F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4E29ACD7;
	Wed, 11 Feb 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFF2+nv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CB27815E;
	Wed, 11 Feb 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774104; cv=none; b=oAIFns+hFusFTP9/uxrDxof9lcDLWA/JsnzgBiX2z5n8C8xMgm5/XaUKQlXoWuOgtw7Vj4k1l5JM42BlqN6gAb2xx2yo9ywv5EUtc3TBY2MdU/dhd7OeZo5VDjC1c6BsvaJuR3SHrvvdRwLXCbeSOz37guu0TB0vV3dVAWrmVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774104; c=relaxed/simple;
	bh=RHA8Ov2M102yN4iQ2T8h34WWw1tnpDSMl83Ze2PM6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DecLCkG2oiL/hDeWwoLAJ6X9DbWief1ViNWYnVGIKaEfFKB40R0AmUMb8fOqZXFq8Od/fmR2UnNr+m24ex/J7D5MfTaB1cUJ2WDdKQiLKcvH3Yra+OLLoEnzg0RnFBzozv/dNvcbybqrK9JKdonGgcUhqx4XeTmnfoBstaqb02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFF2+nv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C2C116C6;
	Wed, 11 Feb 2026 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770774104;
	bh=RHA8Ov2M102yN4iQ2T8h34WWw1tnpDSMl83Ze2PM6Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFF2+nv9a/uE8Ue++fofMfIEIFV40zqfpIEkQ5UqfYYGFq34ZoX48NyRjlBflw1Gk
	 8xuFI/yHXDjlLUzTkZsn/TEHPipakNHOKJSBsDXsshE+3msVxC32RfybpdM0QzT1y7
	 klpTwTR8BObEvdzrTKsiYUznFz+H9FzmqhgLaEaJaiTaZnr0sqtYOAMm0NQBRGm64H
	 kJKIxhSMJqmdEChRhNrjfc6wky+asuuFe7D9nwOzXAlpHjMVY2TnvmEESP+1DOh8MR
	 UEO6oipX8nDdB1XftpPcg94eECgqTnbe0k2dMcmq6Wdt3ez1kAMKI2stawjRVh+afV
	 p6uE3BJ+TUqlg==
Date: Tue, 10 Feb 2026 17:41:43 -0800
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
Message-ID: <202602101736.80F1783@keescook>
References: <20260211004811.work.981-kees@kernel.org>
 <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76919-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: CAE411207C6
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:28:53AM +0100, Jann Horn wrote:
> On Wed, Feb 11, 2026 at 1:48 AM Kees Cook <kees@kernel.org> wrote:
> > A building block of Use-After-Free heap memory corruption attacks is
> > using userspace controllable kernel allocations to fill specifically sized
> > kmalloc regions with specific contents. The most powerful of these kinds
> > of primitives is arbitrarily controllable contents with arbitrary size.
> > Keeping these kinds of allocations out of the general kmalloc buckets is
> > needed to harden the kernel against such manipulations, so this is why
> > these sorts of "copy data from userspace into kernel heap" situations are
> > expected to use things like memdup_user(), which keeps the allocations
> > in their own set of slab buckets. However, using memdup_user() is not
> > always appropriate, so in those cases, kmem_buckets can used directly.
> >
> > Filenames used to be isolated in their own (fixed size) slab cache so
> > they would not end up in the general kmalloc buckets (which made them
> > unusable for the heap grooming method described above). After commit
> > 8c888b31903c ("struct filename: saner handling of long names"), filenames
> > were being copied into arbitrarily sized kmalloc regions in the general
> > kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
> > kmem buckets for long filenames so we do not introduce a new way for
> > attackers to place arbitrary contents into the general kmalloc buckets.
> >
> > Fixes: 8c888b31903c ("struct filename: saner handling of long names")
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PANIC
> > for filename allocations relavant at all? It could be added back for
> > these buckets if desired, but I left it default in this patch.
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > ---
> >  fs/namei.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 8e7792de0000..a901733380cd 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -128,6 +128,8 @@
> >  /* SLAB cache for struct filename instances */
> >  static struct kmem_cache *__names_cache __ro_after_init;
> >  #define names_cache    runtime_const_ptr(__names_cache)
> > +/* SLAB buckets for long names */
> > +static kmem_buckets *names_buckets __ro_after_init;
> >
> >  void __init filename_init(void)
> >  {
> > @@ -135,6 +137,8 @@ void __init filename_init(void)
> >                          SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct filename, iname),
> >                          EMBEDDED_NAME_MAX, NULL);
> >         runtime_const_init(ptr, __names_cache);
> > +
> > +       names_buckets = kmem_buckets_create("names_bucket", 0, 0, PATH_MAX, NULL);
> >  }
> >
> >  static inline struct filename *alloc_filename(void)
> > @@ -156,7 +160,7 @@ static inline void initname(struct filename *name)
> >  static int getname_long(struct filename *name, const char __user *filename)
> >  {
> >         int len;
> > -       char *p __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
> > +       char *p __free(kfree) = kmem_buckets_alloc(names_buckets, PATH_MAX, GFP_KERNEL);
> >         if (unlikely(!p))
> >                 return -ENOMEM;
> 
> I think this path, where we always do maximally-sized allocations, is
> the normal case where we're handling paths coming from userspace...

Actually, is there any reason we can't use strnlen_user() in
do_getname(), and then just use strndup_user() in the long case?

> > @@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const char *filename, bool incomplete)
> >
> >         if (len <= EMBEDDED_NAME_MAX) {
> >                 p = (char *)result->iname;
> > -               memcpy(p, filename, len);
> >         } else {
> > -               p = kmemdup(filename, len, GFP_KERNEL);
> > +               p = kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);
> 
> ... while this is kind of the exceptional case, where paths are coming
> from kernelspace.
> 
> So you might want to get rid of the bucketing and instead just create
> a single kmem_cache for long paths.

I wasn't sure if there was a controllable way to reach this case or not.

> By the way, did you know that "struct filename" is only used for
> storing fairly-temporary stuff like paths supplied to open(), but not
> for storing the names of directory entries in the dentry cache (which
> are more long-lived)? My understanding is that this is also why the
> kernel doesn't really try to optimize the size of "struct filename" -
> almost all instances of it only exist for the duration of a syscall or
> something like that.

Right, but it was enough of a location change that I felt like it was
worth fixing it up.

> The dentry cache allocates long names as "struct external_name" in
> reclaimable kmalloc slabs, see __d_alloc().

Oh hey, look at that!

                struct external_name *p = kmalloc(size + name->len,
                                                  GFP_KERNEL_ACCOUNT |
                                                  __GFP_RECLAIMABLE);

Yeah, let's put that into dedicated buckets instead?

-Kees

-- 
Kees Cook

