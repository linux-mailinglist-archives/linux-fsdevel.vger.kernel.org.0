Return-Path: <linux-fsdevel+bounces-18825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CDD8BCC35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A4C1C21684
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650D142E63;
	Mon,  6 May 2024 10:42:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B8757EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992167; cv=none; b=bzHd8Ln2ADXKkS5ytaA6Uu0cJpYlssUCkw3mb/oGs3ke0s+Dz3WJoCsZ5At9gL2OvQgEmzcAHI4qn0aBdpRh/+4Mu24pxKIQVOz0t7/mvNGGiqyEgGWc9ZkPOiAlepHpiAx4o23fg7/4l1JnQG3hLAP5vWmNHNjLQdukqqvsL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992167; c=relaxed/simple;
	bh=FOkc0F168y7Hb3+T+9xBbpPteMZGo/OxA02Dyz4/hj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGt2ID0l1VTWaY1ehKI1QwM5vGJU8j/nM/rMYo+zMP8kcqnD8u1a3Huw8mx6aRt5MX1FriqwYSF1QpAsx682XAEkUH5FLJOeZCgPAKpPYpLteIpriy5XQsPr0SfzoOgUhiWUuLYoDTPYQrIxzUj6u7u73TQUbKL+7EG/z6gQd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.0])
	by sina.com (10.75.12.45) with ESMTP
	id 6638B3F30000281D; Mon, 6 May 2024 18:41:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 73643631457703
X-SMAIL-UIID: 3117179399554E659D0FA43F880B37D2-20240506-184157-1
From: Hillf Danton <hdanton@sina.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: Do not allow get_file() to resurrect 0 f_count
Date: Mon,  6 May 2024 18:41:47 +0800
Message-Id: <20240506104147.2139-1-hdanton@sina.com>
In-Reply-To: <20240503-mitmachen-redakteur-2707ab0cacc3@brauner>
References: <20240502222252.work.690-kees@kernel.org> <20240502223341.1835070-1-keescook@chromium.org> <CAG48ez0d81xbOHqTUbWcBFWx5WY=RM8MM++ug79wXe0O-NKLig@mail.gmail.com> <202405021600.F5C68084D@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 3 May 2024 11:02:57 +0200 Christian Brauner <brauner@kernel.org>
> On Thu, May 02, 2024 at 04:03:24PM -0700, Kees Cook wrote:
> > On Fri, May 03, 2024 at 12:53:56AM +0200, Jann Horn wrote:
> > > On Fri, May 3, 2024 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> > > > If f_count reaches 0, calling get_file() should be a failure. Adjust to
> > > > use atomic_long_inc_not_zero() and return NULL on failure. In the future
> > > > get_file() can be annotated with __must_check, though that is not
> > > > currently possible.
> > > [...]
> > > >  static inline struct file *get_file(struct file *f)
> > > >  {
> > > > -       atomic_long_inc(&f->f_count);
> > > > +       if (unlikely(!atomic_long_inc_not_zero(&f->f_count)))
> > > > +               return NULL;
> > > >         return f;
> > > >  }
> > > 
> > > Oh, I really don't like this...
> > > 
> > > In most code, if you call get_file() on a file and see refcount zero,
> > > that basically means you're in a UAF write situation, or that you
> > > could be in such a situation if you had raced differently. It's
> > > basically just like refcount_inc() in that regard.
> > 
> > Shouldn't the system attempt to not make things worse if it encounters
> > an inc-from-0 condition? Yes, we've already lost the race for a UaF
> > condition, but maybe don't continue on.
> > 
> > > And get_file() has semantics just like refcount_inc(): The caller
> > > guarantees that it is already holding a reference to the file; and if
> > 
> > Yes, but if that guarantee is violated, we should do something about it.
> > 
> > > the caller is wrong about that, their subsequent attempt to clean up
> > > the reference that they think they were already holding will likely
> > > lead to UAF too. If get_file() sees a zero refcount, there is no safe
> > > way to continue. And all existing callers of get_file() expect the
> > > return value to be the same as the non-NULL pointer they passed in, so
> > > they'll either ignore the result of this check and barrel on, or oops
> > > with a NULL deref.
> > > 
> > > For callers that want to actually try incrementing file refcounts that
> > > could be zero, which is only possible under specific circumstances, we
> > > have helpers like get_file_rcu() and get_file_active().
> > 
> > So what's going on in here:
> > https://lore.kernel.org/linux-hardening/20240502223341.1835070-2-keescook@chromium.org/
> 
> Afaict, there's dma_buf_export() that allocates a new file and sets:
> 
> file->private_data = dmabuf;
> dmabuf->file = file;
> 
> The file has f_op->release::dma_buf_file_release() as it's f_op->release
> method. When that's called the file's refcount is already zero but the
> file has not been freed yet. This will remove the dmabuf from some
> public list but it won't free it.
> 
> Then we see that any dentry allocated for such a dmabuf file will have
> dma_buf_dentry_ops which in turn has
> dentry->d_release::dma_buf_release() which is where the actual release
> of the dma buffer happens taken from dentry->d_fsdata.
> 
> That whole thing calls allocate_file_pseudo() which allocates a new
> dentry specific to that struct file. That dentry is unhashed (no lookup)
> and thus isn't retained so when dput() is called and it's the last
> reference it's immediately followed by
> dentry->d_release::dma_buf_release() which wipes the dmabuf itself.
> 
> The lifetime of the dmabuf is managed via fget()/fput(). So the lifetime
> of the dmabuf and the lifetime of the file are almost identical afaict:
> 
> __fput()
> -> f_op->release::dma_buf_file_release() // handles file specific freeing
> -> dput()
>    -> d_op->d_release::dma_buf_release() // handles dmabuf freeing
>                                          // including the driver specific stuff.
> 
> If you fput() the file then the dmabuf will be freed as well immediately
> after it when the dput() happens in __fput() (I struggle to come up with
> an explanation why the freeing of the dmabuf is moved to
> dentry->d_release instead of f_op->release itself but that's a separate
> matter.).
> 
> So on the face of it without looking a little closer
> 
> static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
> {
>         return atomic_long_inc_not_zero(&dmabuf->file->f_count) != 0L;
> }
> 
> looks wrong or broken. Because if dmabuf->file->f_count is 0 it implies
> that @dmabuf should have already been freed. So the bug would be in
> accessing @dmabuf. And if @dmabuf is valid then it automatically means
> that dmabuf->file->f_count isn't 0. So it looks like it could just use
> get_file().
> 
> _But_ the interesting bits are in ttm_object_device_init(). This steals
> the dma_buf_ops into tdev->ops. It then takes dma_buf_ops->release and
> stores it away into tdev->dma_buf_release. Then it overrides the
> dma_buf_ops->release with ttm_prime_dmabuf_release(). And that's where
> the very questionable magic happens.
> 
> So now let's say the dmabuf is freed because of lat fput(). We now get
> f_op->release::dma_buf_file_release(). Then it's followed by dput() and
> ultimately dentry->d_release::dma_buf_release() as mentioned above.
> 
> But now when we get:
> 
> dentry->d_release::dma_buf_release()
> -> dmabuf->ops->release::ttm_prime_dmabuf_release()
> 
> instead of the original dmabuf->ops->release method that was stolen into
> tdev->dmabuf_release. And ttm_prime_dmabuf_release() now calls
> tdev->dma_buf_release() which just frees the data associated with the
> dmabuf not the dmabuf itself.
> 
> ttm_prime_dmabuf_release() then takes prime->mutex_lock replacing
> prime->dma_buf with NULL.
> 
> The same lock is taken in ttm_prime_handle_to_fd() which is picking that
> dmabuf from prime->dmabuf. So the interesting case is when
> ttm_prime_dma_buf_release() has called tdev->dmabuf_release() and but
> someone else maanged to grab prime->mutex_lock before
> ttm_prime_dma_buf_release() could grab it to NULL prime->dma_buf.
> 
> So at that point @dmabuf hasn't been freed yet and is still valid. So
> dereferencing prime->dma_buf is still valid and by extension
> dma_buf->file as their lifetimes are tied.
> 
> IOW, that should just use get_file_active() which handles that just
> fine.
> 
> And while that get_dma_buf_unless_doomed() thing is safe that whole code
> reeks of a level of complexity that's asking for trouble.
> 
> But that has zero to do with get_file() and it is absolutely not a
> reason to mess with it's semantics impacting every caller in the tree.
> 
> > 
> > > Can't you throw a CHECK_DATA_CORRUPTION() or something like that in
> > > there instead?
> > 
> > I'm open to suggestions, but given what's happening with struct dma_buf
> > above, it seems like this is a state worth checking for?
> 
> No, it's really not. If you use get_file() you better know that you're
> already holding a valid reference that's no reason to make it suddenly
> fail.
> 
But the simple question is, why are you asking dma_buf to poll a 0 f_count
file? All fine if you are not.

