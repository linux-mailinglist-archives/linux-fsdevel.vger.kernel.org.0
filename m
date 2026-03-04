Return-Path: <linux-fsdevel+bounces-79322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGALHpvmp2mrlAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:00:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD041FC168
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 09:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80FB7303180E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0A388E6C;
	Wed,  4 Mar 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ns/eaXK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0393845D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611207; cv=none; b=MCaGVcSlrhuYHKXmFpKPfSPvPxQPZmm9UDTOFgpP2JVltEULr8QBkbbtlHZH7SpYspc44a03Ons0c4AWBlfH6Zk0wv1R6qY+aABgH1hDrB8n3/Fu8r7yW6lM4pZ5dl1ucq74kNWihJlCzu0A8crpbkNZs0BnG3uAEZUuJkQJgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611207; c=relaxed/simple;
	bh=mnWuCX8+sSkjwcqYo9JqnziSgy2H0ljhlqP4ueLb/qQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kTmOuFHlRUSM4nZgay5QKWgNtKp1uSz0EwMpLQjvEsG7/ogqXckNIbnanawdm52Xp44gS2+HR482zi1bD1cL2ajz+Ha/yIv+vU/HdAONn+0ENOScpOYvFLsusgU45i31oQ3VglNwMq4rbJoozDgjqaQzWFLncZPa6eqCZejm9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ns/eaXK7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48379489438so62161815e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772611200; x=1773216000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yr4CzJIxCtlElo+LPMhI9rocYF8ProN0VOp5lS2yk4=;
        b=Ns/eaXK7dcZ4+4yx9VmDhmrMSZO83d00Kjwb/1yfdQuJbTvQbMWJt9zHkfS8mgFiT4
         rcRoEdips+b/iJtq56cQnmL99VkDtGxCl2o8jqLD6VAfBGHly0o3cv4ynbMkr5c4fIvb
         HgubOEG3psxmz4i1g1X7L1UaaxpaU/UoBj4j4V22b+jKJ4fC6r8+LX3VFc7RdKEm2ZIH
         8FItKMJ1pdVdkbel2wx/JsZEoP0V/dCIxF0QVFjMDH9h356SFXuyp7AbWGbJtNH6g0qC
         EQpAjiPCxBlxqLdQGUS+hpM1qPk1YdFuHOptIZHn7g8ohMw1UUZVGDrj9lvh9GDlQeAj
         gozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611200; x=1773216000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yr4CzJIxCtlElo+LPMhI9rocYF8ProN0VOp5lS2yk4=;
        b=SQhAmfrm9HuVyK5Mg6O5/fyd7Ap3EhgL71pXH07tXgTppHeX1F/b0YDaSzky2Nl0bK
         gFytrC6lY983K34jSxBY7dTh055kho/cl5hH4+6WCbIftsch4b26pdTo8ESNV9YhTTnK
         whgomIPKQZfY/F2kKFU8zDpLrT6BHYgtvOrnr3rbZk6zAaeMotDiRXFythZTb08CCI0o
         XuxFdG/2Tgi4ZbNjsGMZExfjqlqbCobRyLOSrJyBCDQGK1fMovWsZviYeL0WzMelc/Gd
         RkZKys0+BO9wdkWVaZGgW/JWGL4wxechzt7INzo3L4j69gqC1WcGMWA4ZDiYJtN58TSS
         AkDA==
X-Forwarded-Encrypted: i=1; AJvYcCWyruyXPrhsfPEOgjnLQg4frO2fNyztb1vJyWl51jkubXRO6zWIEMn8I1WxuODGUWJGn2OngLjIoKEHQ8TQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+FXVhGpL5/s3dXJ3+5WwlIexGpRBUHC6jiXdlsuZe4p3yMHt
	/G1+YbomvBZpcYEOI3cDkSAjNHlcXcCOQ+gv+F1Xtj1vutnVGngFsYQLg0dDR2VTOvppDwTZ3Mp
	Apgme3RZfOFEyJgEHeg==
X-Received: from wmxa3-n1.prod.google.com ([2002:a05:600d:6443:10b0:477:988a:7675])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed0:b0:483:6bb1:117 with SMTP id 5b1f17b1804b1-485198a5a49mr13217865e9.32.1772611200239;
 Wed, 04 Mar 2026 00:00:00 -0800 (PST)
Date: Wed, 4 Mar 2026 07:59:59 +0000
In-Reply-To: <aadbyBmaV8zCYiog@tardis.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
 <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com> <aadbyBmaV8zCYiog@tardis.local>
Message-ID: <aafmf5icyPIFcwf_@google.com>
Subject: Re: [PATCH v2 1/2] rust: poll: make PollCondVar upgradable
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 0BD041FC168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79322-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,linuxfoundation.org,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:08:08PM -0800, Boqun Feng wrote:
> On Fri, Feb 13, 2026 at 11:29:41AM +0000, Alice Ryhl wrote:
> > Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
> > in the destructor, which we would like to avoid. Add a variation of
> > PollCondVar, which uses kfree_rcu() instead.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/sync/poll.rs | 160 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 159 insertions(+), 1 deletion(-)
> > 
> > diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> > index 0ec985d560c8d3405c08dbd86e48b14c7c34484d..9555f818a24d777dd908fca849015c3490ce38d3 100644
> > --- a/rust/kernel/sync/poll.rs
> > +++ b/rust/kernel/sync/poll.rs
> > @@ -5,12 +5,21 @@
> >  //! Utilities for working with `struct poll_table`.
> >  
> >  use crate::{
> > +    alloc::AllocError,
> >      bindings,
> > +    container_of,
> >      fs::File,
> >      prelude::*,
> > +    sync::atomic::{Acquire, Atomic, Relaxed, Release},
> > +    sync::lock::{Backend, Lock},
> >      sync::{CondVar, LockClassKey},
> > +    types::Opaque, //
> > +};
> > +use core::{
> > +    marker::{PhantomData, PhantomPinned},
> > +    ops::Deref,
> > +    ptr,
> >  };
> > -use core::{marker::PhantomData, ops::Deref};
> >  
> >  /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
> >  #[macro_export]
> > @@ -66,6 +75,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
> >  ///
> >  /// [`CondVar`]: crate::sync::CondVar
> >  #[pin_data(PinnedDrop)]
> > +#[repr(transparent)]
> >  pub struct PollCondVar {
> >      #[pin]
> >      inner: CondVar,
> > @@ -78,6 +88,17 @@ pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit
> >              inner <- CondVar::new(name, key),
> >          })
> >      }
> > +
> > +    /// Use this `CondVar` as a `PollCondVar`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// After the last use of the returned `&PollCondVar`, `__wake_up_pollfree` must be called on
> > +    /// the `wait_queue_head` at least one grace period before the `CondVar` is destroyed.
> > +    unsafe fn from_non_poll(c: &CondVar) -> &PollCondVar {
> > +        // SAFETY: Layout is the same. Caller ensures that PollTables are cleared in time.
> > +        unsafe { &*ptr::from_ref(c).cast() }
> > +    }
> >  }
> >  
> >  // Make the `CondVar` methods callable on `PollCondVar`.
> > @@ -104,3 +125,140 @@ fn drop(self: Pin<&mut Self>) {
> >          unsafe { bindings::synchronize_rcu() };
> >      }
> >  }
> > +
> > +/// Wrapper around [`CondVar`] that can be upgraded to [`PollCondVar`].
> > +///
> > +/// By using this wrapper, you can avoid rcu for cases that don't use [`PollTable`], and in all
> > +/// cases you can avoid `synchronize_rcu()`.
> > +///
> > +/// # Invariants
> > +///
> > +/// `active` either references `simple`, or a `kmalloc` allocation holding an
> > +/// `UpgradePollCondVarInner`. In the latter case, the allocation remains valid until
> > +/// `Self::drop()` plus one grace period.
> > +#[pin_data(PinnedDrop)]
> > +pub struct UpgradePollCondVar {
> > +    #[pin]
> > +    simple: CondVar,
> > +    active: Atomic<*const CondVar>,
> > +    #[pin]
> > +    _pin: PhantomPinned,
> > +}
> > +
> > +#[pin_data]
> > +#[repr(C)]
> > +struct UpgradePollCondVarInner {
> > +    #[pin]
> > +    upgraded: CondVar,
> > +    #[pin]
> > +    rcu: Opaque<bindings::callback_head>,
> > +}
> > +
> > +impl UpgradePollCondVar {
> > +    /// Constructs a new upgradable condvar initialiser.
> > +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
> > +        pin_init!(&this in Self {
> > +            simple <- CondVar::new(name, key),
> > +            // SAFETY: `this->simple` is in-bounds. Pointer remains valid since this type is
> > +            // pinned.
> > +            active: Atomic::new(unsafe { &raw const (*this.as_ptr()).simple }),
> > +            _pin: PhantomPinned,
> > +        })
> > +    }
> > +
> > +    /// Obtain a [`PollCondVar`], upgrading if necessary.
> > +    ///
> > +    /// You should use the same lock as what is passed to the `wait_*` methods. Otherwise wakeups
> > +    /// may be missed.
> > +    pub fn poll<T: ?Sized, B: Backend>(
> > +        &self,
> > +        lock: &Lock<T, B>,
> > +        name: &'static CStr,
> > +        key: Pin<&'static LockClassKey>,
> > +    ) -> Result<&PollCondVar, AllocError> {
> > +        let mut ptr = self.active.load(Acquire);
> > +        if ptr::eq(ptr, &self.simple) {
> > +            self.upgrade(lock, name, key)?;
> > +            ptr = self.active.load(Acquire);
> > +            debug_assert_ne!(ptr, ptr::from_ref(&self.simple));
> > +        }
> > +        // SAFETY: Signature ensures that last use of returned `&PollCondVar` is before drop(), and
> > +        // drop() calls `__wake_up_pollfree` followed by waiting a grace period before the
> > +        // `CondVar` is destroyed.
> > +        Ok(unsafe { PollCondVar::from_non_poll(&*ptr) })
> > +    }
> > +
> > +    fn upgrade<T: ?Sized, B: Backend>(
> > +        &self,
> > +        lock: &Lock<T, B>,
> > +        name: &'static CStr,
> > +        key: Pin<&'static LockClassKey>,
> > +    ) -> Result<(), AllocError> {
> > +        let upgraded = KBox::pin_init(
> > +            pin_init!(UpgradePollCondVarInner {
> > +                upgraded <- CondVar::new(name, key),
> > +                rcu: Opaque::uninit(),
> > +            }),
> > +            GFP_KERNEL,
> > +        )
> > +        .map_err(|_| AllocError)?;
> > +
> > +        // SAFETY: The value is treated as pinned.
> > +        let upgraded = KBox::into_raw(unsafe { Pin::into_inner_unchecked(upgraded) });
> > +
> > +        let res = self.active.cmpxchg(
> > +            ptr::from_ref(&self.simple),
> > +            // SAFETY: This operation stays in-bounds of the above allocation.
> > +            unsafe { &raw mut (*upgraded).upgraded },
> > +            Release,
> > +        );
> > +
> > +        if res.is_err() {
> > +            // Already upgraded, so still succeess.
> > +            // SAFETY: The cmpxchg failed, so take back ownership of the box.
> > +            drop(unsafe { KBox::from_raw(upgraded) });
> > +            return Ok(());
> > +        }
> > +
> > +        // If a normal waiter registers in parallel with us, then either:
> > +        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
> > +        // * They took the lock first. In that case, we wake them up below.
> > +        drop(lock.lock());
> > +        self.simple.notify_all();
> 
> Hmm.. what if the waiter gets its `&CondVar` before `upgrade()` and use
> that directly?
> 
> 	<waiter>				<in upgrade()>
> 	let poll_cv: &UpgradePollCondVar = ...;
> 	let cv = poll_cv.deref();
> 						cmpxchg();
> 						drop(lock.lock());
> 						self.simple.notify_all();
> 	let mut guard = lock.lock();
> 	cv.wait(&mut guard);
> 
> we still miss the wake-up, right?
> 
> It's creative, but I particularly hate we use an empty lock critical
> section to synchronize ;-)

I guess instead of exposing Deref, I can just implement `wait` directly
on `UpgradePollCondVar`. Then this API misuse is not possible.

> Do you think the complexity of a dynamic upgrading is worthwhile, or we
> should just use the box-allocated PollCondVar unconditionally?
> 
> I think if the current users won't benefit from the dynamic upgrading
> then we can avoid the complexity. We can always add it back later.
> Thoughts?

I do actually think it's worthwhile to consider:

I started an Android device running this. It created 3961 instances of
`UpgradePollCondVar` during the hour it ran, but only 5 were upgraded.

Alice

