Return-Path: <linux-fsdevel+bounces-78240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOXNHsuDnWlsQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:56:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E02185B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7413730D3E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C5379996;
	Tue, 24 Feb 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAU2pdQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327A378D8D;
	Tue, 24 Feb 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929741; cv=none; b=T8vY59VbCBAaIxVwFZBX7UhmbdWc8ypiaw4M9GNcvPyKw8wtkEf74ttFct5+v0wCbdwLPwvP3nc/EKZ3+7Anxw0rPG1zOYIksmqhpri2rGF3m2XQ3R2Dic+pw2jzee6TocttOVew1U6XIGlotzBtz20QUh4Yqw7itcEvUPnbFAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929741; c=relaxed/simple;
	bh=EdYMSneYGYWOu2MY/gnpVM4ln8olb1RiXGDKI2avrXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSthP+NnFq7VbL49MUl8+sx8aA8HHXdF9zCaO5LinPf30IjPb9l/QN8QfAeHwwrcksaE468/gnLBf4bwy/BRXD84TBXqWOgPnonKFJyMV3KY46ymy6cHop84LrL5H/ne1bUQQgUjqu8KFE3gTNI5+UL8aJ0H8NsXmULbJ+wwlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAU2pdQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158D2C116D0;
	Tue, 24 Feb 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929740;
	bh=EdYMSneYGYWOu2MY/gnpVM4ln8olb1RiXGDKI2avrXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GAU2pdQXeucHDr93YOJlBQA+9WyQyiqX3XUv0GPdy5+63ewH++MkxyrNYQumwLA4W
	 YPvSJkU9bCvwg0PQISCbL7pQ53LDJwxCiV6mlupfv3XGnYbITTh1piGzZ+A4mlBMuk
	 4BLlREPZdKFZhle5va0yKY3MgMD1Ru8Hzm9tCf+z8+JaypVhehj82iMeu/g36i61cS
	 LOK6GF96u2rd6HmI4kigzcpkbtJ/Mu3uUKlP3KL6U4B3ccmjM1712HCHbTYCUdiqco
	 kxP5N90jQc3VZcobz2Hi+vK6uI3CzGRjwp0bzDuDcBOAuwMIDp5V4VWUl94VWRudG1
	 gdUVkzkXXqWYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave
 Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun
 Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Asahi Lina
 <lina+kernel@asahilina.net>, Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
In-Reply-To: <aZ1VQmtapuoerpVo@google.com>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org>
 <aZg44EmMWKK-z5KP@google.com>
 <87wm0333qt.fsf@t14s.mail-host-address-is-not-set>
 <IFU05rWmgywK-tzaInc7eF2Kmy1zf-BDkCrQZfRI_2JN6E0-p3zFaUMu3V6T1YTeQG9xC1hHzXThLCORJqpoWA==@protonmail.internalid>
 <aZ1VQmtapuoerpVo@google.com>
Date: Tue, 24 Feb 2026 11:41:45 +0100
Message-ID: <87a4wy2zkm.fsf@t14s.mail-host-address-is-not-set>
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
	TAGGED_FROM(0.00)[bounces-78240-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_SPAM(0.00)[1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,types.rs:url,garyguo.net:email,asahilina.net:email,t14s.mail-host-address-is-not-set:mid,collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6E02185B8B
X-Rspamd-Action: add header
X-Spam: Yes

<aliceryhl@google.com> writes:

> On Mon, Feb 23, 2026 at 03:59:22PM +0100, Andreas Hindborg wrote:
>> Alice Ryhl <aliceryhl@google.com> writes:
>>
>> > On Fri, Feb 20, 2026 at 10:51:10AM +0100, Andreas Hindborg wrote:
>> >> From: Asahi Lina <lina+kernel@asahilina.net>
>> >>
>> >> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>> >> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
>> >> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>> >> within Rust, and does not allow cloning.
>> >>
>> >> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>> >> resource management to the `T` instead of using a generic allocator.
>> >>
>> >> [ om:
>> >>   - Split code into separate file and `pub use` it from types.rs.
>> >>   - Make from_raw() and into_raw() public.
>> >>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>> >>   - Usage example/doctest for Ownable/Owned.
>> >>   - Fixes to documentation and commit message.
>> >> ]
>> >>
>> >> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
>> >> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>> >> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
>> >> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> >> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> >> [ Andreas: Updated documentation, examples, and formatting ]
>> >> Reviewed-by: Gary Guo <gary@garyguo.net>
>> >> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> >
>> >> +///         let result = NonNull::new(KBox::into_raw(result))
>> >> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
>> >
>> > KBox should probably have an into_raw_nonnull().
>>
>> I can add that.
>>
>> >
>> >> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
>> >> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
>> >
>> > Use ? here.
>>
>> Ok.
>>
>> >
>> >> +/// }
>> >> +/// // `foo` is out of scope now, so we expect no live allocations.
>> >> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
>> >> +/// ```
>> >> +pub unsafe trait Ownable {
>> >> +    /// Releases the object.
>> >> +    ///
>> >> +    /// # Safety
>> >> +    ///
>> >> +    /// Callers must ensure that:
>> >> +    /// - `this` points to a valid `Self`.
>> >> +    /// - `*this` is no longer used after this call.
>> >> +    unsafe fn release(this: NonNull<Self>);
>> >
>> > Honestly, not using it after this call may be too strong. I can imagine
>> > wanting a value where I have both an ARef<_> and Owned<_> reference to
>> > something similar to the existing Arc<_>/ListArc<_> pattern, and in that
>> > case the value may in fact be accessed after this call if you still have
>> > an ARef<_>.
>>
>> I do not understand your use case.
>>
>> You are not supposed to have both an `ARef` and an `Owned` at the same
>> time. The `Owned` is to `ARef` what `UniqueArc` is to `Arc`. It is
>> supposed to be unique and no `ARef` can be live while the `Owned` is
>> live.
>>
>> A `ListArc` is "at most one per list link" and it takes a refcount on
>> the object by owning an `Arc`. As far as I recall, it does not provide
>> mutable access to anything but the list link. To me, that is a very
>> different situation.
>
> I mean, even Page is kind of an example like that.
>
> Pages are refcounted, but when you have a higher-order page, the
> __free_pages() call does something special beyond what put_page(). For
> example, if you have an order-2 page, which consists of 4 pages, then
> the refcount only keeps the first page alive, and __free_pages() frees
> the 3 extra pages right away even if refcount is still non-zero. The
> first page then stays alive until the last put_page() is called.

I see. We currently only support order 0 pages. I think we can handle
this situation later, if we need to handle higher order pages.

In that case, we could hand out `Owned<Page>` for the head page and then
provide some way of getting a `&Page` for the tail pages. Obtaining
`Owned<Page>` for a tail page does not make sense.

More likely we will build an abstraction for `struct folio`. We can
still hand some kind of page reference for tail pages from an `Owned<Folio>`.

Best regards,
Andreas Hindborg



