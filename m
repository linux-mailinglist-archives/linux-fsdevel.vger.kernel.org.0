Return-Path: <linux-fsdevel+bounces-77965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HrzBgNvnGmcGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:15:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC421789AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B659330B408F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A92366823;
	Mon, 23 Feb 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG74L8zp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B32376FD;
	Mon, 23 Feb 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858874; cv=none; b=TQ3UzwBp0xaKl9bp2ihIHS+gagjsLwGP1WmwS2JDpw7JBGwvDndDLErAZbJ/9r8x6zTkKoeMaCx28lqWlZaEDlwpHUq5Eb0sgYm51l/tc0LS0fqPw6klqEk4VvvBbq8OFRXIulmmnHVbSf1t0kl6eqHd/7dliiKCMZEgwCNYtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858874; c=relaxed/simple;
	bh=+OkF4cSWCJNdiF5CsX7iTxYUaQeVg6kTwnJIj8pgz8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jR8XPFVuQRuq4ZgGpwX6RVxxDQRpgN+RoOEnh4q39cTWybXiypBfevK487FZETGpZ48AZ3vzr5cUO2Ybjr3r38hjdZReOIbbns1u0G32h0yw4DUqGgsKPHLhj/89zhrrpAlEW4OaUgb9AXNCD5i05cqOLzz+DKF/vTiZ3liM/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG74L8zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9F1C4AF09;
	Mon, 23 Feb 2026 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771858873;
	bh=+OkF4cSWCJNdiF5CsX7iTxYUaQeVg6kTwnJIj8pgz8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jG74L8zp/FnnR1Lf0m+mAJDrbPcsT++9hRX0XGunvt9GvdsjJh+bfbNJOa+uIit1K
	 X0KhxukpE06IrB9eKeOnjxrVHQTVmftx9RNS7STt7RshsqdiKRtVOuf4G9NEV4tJz3
	 PujNQxbv93TPYnYYhE3n1F5oqJKG4vmMXRC1nRD04BI1KV1s6uJhcB6AJ0TkBKkxbW
	 ePQEkUdkwobo8EKqTuxmEu4Ww3QF9zongUPIdlG+oEg4S44x4LDuj5TM7LPEb1psux
	 kirnfscubPKNmJaYqynAdub+KM2YIhojSYzldFuc8o/bqHXb+CbNo2U6bkgKwFuMKN
	 AecqPLLUaWu3A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin.linux@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 Asahi Lina <lina+kernel@asahilina.net>, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
In-Reply-To: <aZg44EmMWKK-z5KP@google.com>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org>
 <aZg44EmMWKK-z5KP@google.com>
Date: Mon, 23 Feb 2026 15:59:22 +0100
Message-ID: <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[types.rs:url];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77965-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org,asahilina.net,pm.me];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.021];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,types.rs:url,asahilina.net:email,t14s.mail-host-address-is-not-set:mid,garyguo.net:email]
X-Rspamd-Queue-Id: BAC421789AA
X-Rspamd-Action: add header
X-Spam: Yes

Alice Ryhl <aliceryhl@google.com> writes:

> On Fri, Feb 20, 2026 at 10:51:10AM +0100, Andreas Hindborg wrote:
>> From: Asahi Lina <lina+kernel@asahilina.net>
>> 
>> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
>> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>> within Rust, and does not allow cloning.
>> 
>> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>> resource management to the `T` instead of using a generic allocator.
>> 
>> [ om:
>>   - Split code into separate file and `pub use` it from types.rs.
>>   - Make from_raw() and into_raw() public.
>>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>>   - Usage example/doctest for Ownable/Owned.
>>   - Fixes to documentation and commit message.
>> ]
>> 
>> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> [ Andreas: Updated documentation, examples, and formatting ]
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>> +///         let result = NonNull::new(KBox::into_raw(result))
>> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
>
> KBox should probably have an into_raw_nonnull().

I can add that.

>
>> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
>> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
>
> Use ? here.

Ok.

>
>> +/// }
>> +/// // `foo` is out of scope now, so we expect no live allocations.
>> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
>> +/// ```
>> +pub unsafe trait Ownable {
>> +    /// Releases the object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that:
>> +    /// - `this` points to a valid `Self`.
>> +    /// - `*this` is no longer used after this call.
>> +    unsafe fn release(this: NonNull<Self>);
>
> Honestly, not using it after this call may be too strong. I can imagine
> wanting a value where I have both an ARef<_> and Owned<_> reference to
> something similar to the existing Arc<_>/ListArc<_> pattern, and in that
> case the value may in fact be accessed after this call if you still have
> an ARef<_>.

I do not understand your use case.

You are not supposed to have both an `ARef` and an `Owned` at the same
time. The `Owned` is to `ARef` what `UniqueArc` is to `Arc`. It is
supposed to be unique and no `ARef` can be live while the `Owned` is
live.

A `ListArc` is "at most one per list link" and it takes a refcount on
the object by owning an `Arc`. As far as I recall, it does not provide
mutable access to anything but the list link. To me, that is a very
different situation.

>
> If you modify Owned<_> invariants and Owned::from_raw() safety
> requirements along the lines of what I say below, then this could just
> say that the caller must have permission to call this function. The
> concrete implementer can specify what that means more directly, but here
> all it means is that a prior call to Owned::from_raw() promised to give
> you permission to call it.

I don't think we need the "permission" wording. How about this:


/// A mutable reference to an owned `T`.
///
/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
/// dropped.
///
/// # Invariants
///
/// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
/// - The `T` value is pinned.
pub struct Owned<T: Ownable> {...}


impl<T: Ownable> Owned<T> {
    /// Creates a new instance of [`Owned`].
    ///
    /// This function takes over ownership of the underlying object.
    ///
    /// # Safety
    ///
    /// Callers must ensure that:
    /// - `ptr` points to a valid instance of `T`.
    /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {...}
}

pub trait Ownable {
    /// Tear down this `Ownable`.
    ///
    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
    /// include freeing the underlying object.
    ///
    /// # Safety
    ///
    /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
    /// be transferred to the `release` method.
    unsafe fn release(&mut self);
}


Note `Ownable` not being an unsafe trait.

>
>> +/// A mutable reference to an owned `T`.
>> +///
>> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
>> +/// dropped.
>> +///
>> +/// # Invariants
>> +///
>> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
>> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
>> +pub struct Owned<T: Ownable> {
>> +    ptr: NonNull<T>,
>> +}
>
> I think some more direct and less fuzzy invariants would be:
>
> - This `Owned<T>` holds permissions to call `T::release()` on the value once.
> - Until `T::release()` is called, this `Owned<T>` may perform mutable access on the `T`.

I do not like the wording for mutable access. Formulating safety
requirements for `from_raw` and safety comments for that function
becomes convoluted like this. I'd rather formulate the
access capability in terms of ownership;

 - Until `T::release()` is called, this `Owned<T>` exclusively owns the
   underlying `T`.

How is that?

> - The `T` value is pinned.

I am unsure about the pinning terminology. If we say that `T` is pinned,
does this mean that it will never move, even if `T: Unpin`? Or is it
implied that `T` may move if it is `Unpin`?

>
>> +    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
>> +    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
>> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> +        // return a mutable reference to it.
>> +        let unpinned = unsafe { self.ptr.as_mut() };
>> +
>> +        // SAFETY: We never hand out unpinned mutable references to the data in
>> +        // `Self`, unless the contained type is `Unpin`.
>> +        unsafe { Pin::new_unchecked(unpinned) }
>
> I'd prefer if "pinned" was a type invariant, rather than make an
> argument about what kind of APIs exist.

Ok.

>
>> +impl<T: Ownable + Unpin> DerefMut for Owned<T> {
>> +    fn deref_mut(&mut self) -> &mut Self::Target {
>> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> +        // return a mutable reference to it.
>> +        unsafe { self.ptr.as_mut() }
>
> Surely this safety comment should say something about pinning.

Yes.


Best regards,
Andreas Hindborg



