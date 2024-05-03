Return-Path: <linux-fsdevel+bounces-18577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350438BA951
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B188C1F221F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCE14EC6F;
	Fri,  3 May 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB969JDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4231367;
	Fri,  3 May 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726990; cv=none; b=Z+iTWtlM73HJpCif/CGp9AfKEWxpWne3kJ+fDR1m9irZgwanwzNuW3BuDLfoftZaEGxt7VYM7s2qKy7S/8nh+qfnfvL66eukwpC3qPstBQB3lzUxBb/ZI9qDP20LtleV7vjlwCDfi1ixInNdO2MDtejkuzIaKXDG70HyZBgK+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726990; c=relaxed/simple;
	bh=Pa9ms/rBsNJu3pSJcnarFZ5cEol78sMnDDgBVhFC6xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvv+VT5XgnUNJXwYr3Ndk9k45p2HimzZKHVudDekE+CRSebDCdixWzo32HIc6tMAcQ33LhlBbOe8swzLb+9yR/rIPBH0PjIta9g9B7MBT1dTrZLLgP4sGcVPdKIFjUWh5Jz6GHH9dbAJMz7M1X/TtS7ArY+6QFIe88rdNPVW4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB969JDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BB2C116B1;
	Fri,  3 May 2024 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714726988;
	bh=Pa9ms/rBsNJu3pSJcnarFZ5cEol78sMnDDgBVhFC6xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB969JDna8vdDAAup8xKrh+zFSQBwBslcunfOcEOyavNcEJ8bK4lvjj5bUDsNG76O
	 wZeC5qbvxPfxCzkLem/9IHPFfqzZFZS0+KhJVYiTbAHtDJvmCqTy+HeFPvmCE+Rgm+
	 5E5Vm6mMHAiSNcFsr3k/9nGy5QquIdnPbWESP8djFxDbIiRe/Iz2l7gEZVFCxn2I3c
	 /LP+fQqbFZPF8CtcwkbqPYGn0eBgQYGIB0X8n6npBWvvhqocA7MruMF1ttlcwHszgL
	 +ykGN9tWpVmG8+BagsMenh/9QElipmDT7qPD2WQAkMo2k/IyN6/n39gNCjU0Oc/bjY
	 0XQ74oBsuGowQ==
Date: Fri, 3 May 2024 11:02:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Matt Atwood <matthew.s.atwood@intel.com>, Matthew Auld <matthew.auld@intel.com>, 
	Nirmoy Das <nirmoy.das@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: Do not allow get_file() to resurrect 0 f_count
Message-ID: <20240503-mitmachen-redakteur-2707ab0cacc3@brauner>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-1-keescook@chromium.org>
 <CAG48ez0d81xbOHqTUbWcBFWx5WY=RM8MM++ug79wXe0O-NKLig@mail.gmail.com>
 <202405021600.F5C68084D@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202405021600.F5C68084D@keescook>

On Thu, May 02, 2024 at 04:03:24PM -0700, Kees Cook wrote:
> On Fri, May 03, 2024 at 12:53:56AM +0200, Jann Horn wrote:
> > On Fri, May 3, 2024 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> > > If f_count reaches 0, calling get_file() should be a failure. Adjust to
> > > use atomic_long_inc_not_zero() and return NULL on failure. In the future
> > > get_file() can be annotated with __must_check, though that is not
> > > currently possible.
> > [...]
> > >  static inline struct file *get_file(struct file *f)
> > >  {
> > > -       atomic_long_inc(&f->f_count);
> > > +       if (unlikely(!atomic_long_inc_not_zero(&f->f_count)))
> > > +               return NULL;
> > >         return f;
> > >  }
> > 
> > Oh, I really don't like this...
> > 
> > In most code, if you call get_file() on a file and see refcount zero,
> > that basically means you're in a UAF write situation, or that you
> > could be in such a situation if you had raced differently. It's
> > basically just like refcount_inc() in that regard.
> 
> Shouldn't the system attempt to not make things worse if it encounters
> an inc-from-0 condition? Yes, we've already lost the race for a UaF
> condition, but maybe don't continue on.
> 
> > And get_file() has semantics just like refcount_inc(): The caller
> > guarantees that it is already holding a reference to the file; and if
> 
> Yes, but if that guarantee is violated, we should do something about it.
> 
> > the caller is wrong about that, their subsequent attempt to clean up
> > the reference that they think they were already holding will likely
> > lead to UAF too. If get_file() sees a zero refcount, there is no safe
> > way to continue. And all existing callers of get_file() expect the
> > return value to be the same as the non-NULL pointer they passed in, so
> > they'll either ignore the result of this check and barrel on, or oops
> > with a NULL deref.
> > 
> > For callers that want to actually try incrementing file refcounts that
> > could be zero, which is only possible under specific circumstances, we
> > have helpers like get_file_rcu() and get_file_active().
> 
> So what's going on in here:
> https://lore.kernel.org/linux-hardening/20240502223341.1835070-2-keescook@chromium.org/

Afaict, there's dma_buf_export() that allocates a new file and sets:

file->private_data = dmabuf;
dmabuf->file = file;

The file has f_op->release::dma_buf_file_release() as it's f_op->release
method. When that's called the file's refcount is already zero but the
file has not been freed yet. This will remove the dmabuf from some
public list but it won't free it.

Then we see that any dentry allocated for such a dmabuf file will have
dma_buf_dentry_ops which in turn has
dentry->d_release::dma_buf_release() which is where the actual release
of the dma buffer happens taken from dentry->d_fsdata.

That whole thing calls allocate_file_pseudo() which allocates a new
dentry specific to that struct file. That dentry is unhashed (no lookup)
and thus isn't retained so when dput() is called and it's the last
reference it's immediately followed by
dentry->d_release::dma_buf_release() which wipes the dmabuf itself.

The lifetime of the dmabuf is managed via fget()/fput(). So the lifetime
of the dmabuf and the lifetime of the file are almost identical afaict:

__fput()
-> f_op->release::dma_buf_file_release() // handles file specific freeing
-> dput()
   -> d_op->d_release::dma_buf_release() // handles dmabuf freeing
                                         // including the driver specific stuff.

If you fput() the file then the dmabuf will be freed as well immediately
after it when the dput() happens in __fput() (I struggle to come up with
an explanation why the freeing of the dmabuf is moved to
dentry->d_release instead of f_op->release itself but that's a separate
matter.).

So on the face of it without looking a little closer

static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
{
        return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
}

looks wrong or broken. Because if dmabuf->file->f_count is 0 it implies
that @dmabuf should have already been freed. So the bug would be in
accessing @dmabuf. And if @dmabuf is valid then it automatically means
that dmabuf->file->f_count isn't 0. So it looks like it could just use
get_file().

_But_ the interesting bits are in ttm_object_device_init(). This steals
the dma_buf_ops into tdev->ops. It then takes dma_buf_ops->release and
stores it away into tdev->dma_buf_release. Then it overrides the
dma_buf_ops->release with ttm_prime_dmabuf_release(). And that's where
the very questionable magic happens.

So now let's say the dmabuf is freed because of lat fput(). We now get
f_op->release::dma_buf_file_release(). Then it's followed by dput() and
ultimately dentry->d_release::dma_buf_release() as mentioned above.

But now when we get:

dentry->d_release::dma_buf_release()
-> dmabuf->ops->release::ttm_prime_dmabuf_release()

instead of the original dmabuf->ops->release method that was stolen into
tdev->dmabuf_release. And ttm_prime_dmabuf_release() now calls
tdev->dma_buf_release() which just frees the data associated with the
dmabuf not the dmabuf itself.

ttm_prime_dmabuf_release() then takes prime->mutex_lock replacing
prime->dma_buf with NULL.

The same lock is taken in ttm_prime_handle_to_fd() which is picking that
dmabuf from prime->dmabuf. So the interesting case is when
ttm_prime_dma_buf_release() has called tdev->dmabuf_release() and but
someone else maanged to grab prime->mutex_lock before
ttm_prime_dma_buf_release() could grab it to NULL prime->dma_buf.

So at that point @dmabuf hasn't been freed yet and is still valid. So
dereferencing prime->dma_buf is still valid and by extension
dma_buf->file as their lifetimes are tied.

IOW, that should just use get_file_active() which handles that just
fine.

And while that get_dma_buf_unless_doomed() thing is safe that whole code
reeks of a level of complexity that's asking for trouble.

But that has zero to do with get_file() and it is absolutely not a
reason to mess with it's semantics impacting every caller in the tree.

> 
> > Can't you throw a CHECK_DATA_CORRUPTION() or something like that in
> > there instead?
> 
> I'm open to suggestions, but given what's happening with struct dma_buf
> above, it seems like this is a state worth checking for?

No, it's really not. If you use get_file() you better know that you're
already holding a valid reference that's no reason to make it suddenly
fail.

