Return-Path: <linux-fsdevel+bounces-78223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK+0LRRYnWk2OgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:49:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B5183415
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93BC312EF24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E9364059;
	Tue, 24 Feb 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWdRoK+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19E364E80
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918663; cv=none; b=EwjXUiqKV6/xJEkXN5foQRq28Ql6b0EmqAh895TJO4QfVjvEObiQIj/IBybU6odmllxVZgIAYzcRqdwatVHf/j23h1gMjmdBlXg9Lrjfu7Pg1Y7slhDQKXqGQIyo+3bGTaXx6wufWwpMOXHG4iyGRa86PVsL9QeNAXjjp3CGidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918663; c=relaxed/simple;
	bh=rdtI/eBapYxisnhkJe8WgbchqvYRdF1p2iiYViIA4sA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UU88ToUahNKbeTb17wDMcIDr4BSX3NY9p+wcULVdDkl01unNdkQPOzBWVQgIzw7s3S7Xt0t2+zSl1JfW4G1AmSgoW6DRRdLBI+XKllOmvM7Iga0y8pG5ulue7w9d11zHyk4l/wy22Co2UwN7/k3JMwDYpRhBI/CxpGXK7yLbXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWdRoK+K; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so51534575e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771918660; x=1772523460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :f2079rom:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccaw3Qp4EtXU0xb2rrWk95YgoDmXX+bj8GIv5SpCaTk=;
        b=SWdRoK+KhzJadfTvadCRAPVuKb0sl8vOFEf8WLcK11pL2IwUxnCQdNoc/JD+m/GGSv
         HOXKA26IhZsphuq3ASrefnsrga6VaBIVqaDzDmSWj+KVhzXjmlpTnINzrdAk09yHyODl
         mcm9g8FsIefz5Y4s87s6li5kmGVsh9vAgUhREzI0lzQg3wAOSD2jDRH3O1ZLhoMvMJfF
         cghnpmgcIsjwJ//GjYxWryxt5tsS7ADSeL4Q29LnOEOG4qDtt/e+rZwbtWXkmPYsrGWd
         XOOd74xD/13110wH9rovGcjfGe3HXgQH2a2Gt2vE3e/DXTCTucX/WO9TNN+QSs/GEiLD
         y+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918660; x=1772523460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :f2079rom:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ccaw3Qp4EtXU0xb2rrWk95YgoDmXX+bj8GIv5SpCaTk=;
        b=mNukOYzEeM0Yg0Okv1dKNcllNA/KfceZRie74ZebxHYx9Mm+JDEXa4/w+PPOqM64KU
         lM+ngGtgSCSWUD6Njiitl8emHiuwBJTQrUTf6vsW8YKnRANj6AbwNLMxO8LnmCdCsdPm
         hloXV94aLwCU3fUrn0hja6tCAm26+yLdi+n0BlPHjxjB9Q62IPHahI3kQFOkDLCRuXBs
         LFuz77jO0ntdSDqTi9g9zMc8kCL/kFzayRBtq9GyKA6Avx37P+3XZMY6Ov21yS5KW6DJ
         cjooUKBnz05RdvcHR5VIjzqemvYfLN619XHWP6YRkbgN+F0kMzthYampFCQx4seASpDQ
         7whQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWP5VH+U9xUEGVIBJwuRKNCgK3kYEHwJOOiEe95U/Zjl0UR+WES//eP8bb4brvL8mZRYcSu6MHjfCP5wq9@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRwHR8Z8/kS8akHgRoB6zHk9qlpa+0lOugeMyANvisBYzey/7
	a+wOaqesMtNW4zz9dmMdroJbdF95yAbeQYlrWri+LMw2VeXlRa5+faCLCzyYzoCApghiP+umw0T
	ynxClJuXCEHtHZnsloA==
X-Received: from wmxb5-n2.prod.google.com ([2002:a05:600d:8445:20b0:483:43dc:999f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:674f:b0:483:6ff1:18b with SMTP id 5b1f17b1804b1-483a9555bafmr189459985e9.0.1771918659820;
 Mon, 23 Feb 2026 23:37:39 -0800 (PST)
Date: Tue, 24 Feb 2026 07:37:38 +0000
F2079rom: Alice Ryhl <aliceryhl@google.com>
In-Reply-To: <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org> <aZg44EmMWKK-z5KP@google.com>
 <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
Message-ID: <aZ1VQmtapuoerpVo@google.com>
Subject: Re: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
From: <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[types.rs:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78223-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[google.com:s=20230601];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org,asahilina.net,pm.me];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.755];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,pm.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asahilina.net:email,types.rs:url,collabora.com:email]
X-Rspamd-Queue-Id: 162B5183415
X-Rspamd-Action: add header
X-Spam: Yes

On Mon, Feb 23, 2026 at 03:59:22PM +0100, Andreas Hindborg wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > On Fri, Feb 20, 2026 at 10:51:10AM +0100, Andreas Hindborg wrote:
> >> From: Asahi Lina <lina+kernel@asahilina.net>
> >> 
> >> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> >> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> >> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> >> within Rust, and does not allow cloning.
> >> 
> >> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> >> resource management to the `T` instead of using a generic allocator.
> >> 
> >> [ om:
> >>   - Split code into separate file and `pub use` it from types.rs.
> >>   - Make from_raw() and into_raw() public.
> >>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
> >>   - Usage example/doctest for Ownable/Owned.
> >>   - Fixes to documentation and commit message.
> >> ]
> >> 
> >> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> >> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> >> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> >> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> >> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> >> [ Andreas: Updated documentation, examples, and formatting ]
> >> Reviewed-by: Gary Guo <gary@garyguo.net>
> >> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> >> +///         let result = NonNull::new(KBox::into_raw(result))
> >> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
> >
> > KBox should probably have an into_raw_nonnull().
> 
> I can add that.
> 
> >
> >> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
> >> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
> >
> > Use ? here.
> 
> Ok.
> 
> >
> >> +/// }
> >> +/// // `foo` is out of scope now, so we expect no live allocations.
> >> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
> >> +/// ```
> >> +pub unsafe trait Ownable {
> >> +    /// Releases the object.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// Callers must ensure that:
> >> +    /// - `this` points to a valid `Self`.
> >> +    /// - `*this` is no longer used after this call.
> >> +    unsafe fn release(this: NonNull<Self>);
> >
> > Honestly, not using it after this call may be too strong. I can imagine
> > wanting a value where I have both an ARef<_> and Owned<_> reference to
> > something similar to the existing Arc<_>/ListArc<_> pattern, and in that
> > case the value may in fact be accessed after this call if you still have
> > an ARef<_>.
> 
> I do not understand your use case.
> 
> You are not supposed to have both an `ARef` and an `Owned` at the same
> time. The `Owned` is to `ARef` what `UniqueArc` is to `Arc`. It is
> supposed to be unique and no `ARef` can be live while the `Owned` is
> live.
> 
> A `ListArc` is "at most one per list link" and it takes a refcount on
> the object by owning an `Arc`. As far as I recall, it does not provide
> mutable access to anything but the list link. To me, that is a very
> different situation.

I mean, even Page is kind of an example like that.

Pages are refcounted, but when you have a higher-order page, the
__free_pages() call does something special beyond what put_page(). For
example, if you have an order-2 page, which consists of 4 pages, then
the refcount only keeps the first page alive, and __free_pages() frees
the 3 extra pages right away even if refcount is still non-zero. The
first page then stays alive until the last put_page() is called.

> > If you modify Owned<_> invariants and Owned::from_raw() safety
> > requirements along the lines of what I say below, then this could just
> > say that the caller must have permission to call this function. The
> > concrete implementer can specify what that means more directly, but here
> > all it means is that a prior call to Owned::from_raw() promised to give
> > you permission to call it.
> 
> I don't think we need the "permission" wording. How about this:
> 
> 
> /// A mutable reference to an owned `T`.
> ///
> /// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> /// dropped.
> ///
> /// # Invariants
> ///
> /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
> /// - The `T` value is pinned.
> pub struct Owned<T: Ownable> {...}
> 
> 
> impl<T: Ownable> Owned<T> {
>     /// Creates a new instance of [`Owned`].
>     ///
>     /// This function takes over ownership of the underlying object.
>     ///
>     /// # Safety
>     ///
>     /// Callers must ensure that:
>     /// - `ptr` points to a valid instance of `T`.
>     /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
>     pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {...}
> }
> 
> pub trait Ownable {
>     /// Tear down this `Ownable`.
>     ///
>     /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
>     /// include freeing the underlying object.
>     ///
>     /// # Safety
>     ///
>     /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
>     /// be transferred to the `release` method.
>     unsafe fn release(&mut self);
> }
> 
> 
> Note `Ownable` not being an unsafe trait.

It looks ok but see my above reply.

> >> +/// A mutable reference to an owned `T`.
> >> +///
> >> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
> >> +/// dropped.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
> >> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
> >> +pub struct Owned<T: Ownable> {
> >> +    ptr: NonNull<T>,
> >> +}
> >
> > I think some more direct and less fuzzy invariants would be:
> >
> > - This `Owned<T>` holds permissions to call `T::release()` on the value once.
> > - Until `T::release()` is called, this `Owned<T>` may perform mutable access on the `T`.
> 
> I do not like the wording for mutable access. Formulating safety
> requirements for `from_raw` and safety comments for that function
> becomes convoluted like this. I'd rather formulate the
> access capability in terms of ownership;
> 
>  - Until `T::release()` is called, this `Owned<T>` exclusively owns the
>    underlying `T`.
> 
> How is that?
> 
> > - The `T` value is pinned.
> 
> I am unsure about the pinning terminology. If we say that `T` is pinned,
> does this mean that it will never move, even if `T: Unpin`? Or is it
> implied that `T` may move if it is `Unpin`?

Values that are `Unpin` can always move - pinning is a no-op for them.

Alice

