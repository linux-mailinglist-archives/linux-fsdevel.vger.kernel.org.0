Return-Path: <linux-fsdevel+bounces-76042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LyIZAVGhgGkHAAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:06:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA4CC972
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 397633048B22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280EE36680B;
	Mon,  2 Feb 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdM2WSOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C41B983F;
	Mon,  2 Feb 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037514; cv=none; b=droSrRzpMh2Sr0yL0CImf6d0ZSCKMCAdMSBnLr75h7xHU8oyY0i63ITInyd2h7kSUoMNMT9rqMeVert5ILbV+BHPpeMQofrToR3nSJBuOwT5rsqudb9h6X9uB/RaPcgHtOh5+jC3Jf65ml8s9NKIP/nOeN1AegxQlhe5HasjVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037514; c=relaxed/simple;
	bh=EA8qmHxvlMjKBeqgsh6FoAR2kX5IcYCMu3Q/fDbz/zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/7/S3k7phNfyeUz5YQsqtcL4LrlEBn4t7N4Bqk2BpGlNRGcWtD0Q55LydG2XPvxEknSvOCiNo40MNeVc1Q+oh7NBKvbh2zQjyRVUdb+5JAhWNIeVgGeaSNjtn+pixOq4qhlMcFgxkI8rPMqhJ1LFtgV6m15ek7yN9a4wTuOsOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdM2WSOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5443BC116C6;
	Mon,  2 Feb 2026 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770037514;
	bh=EA8qmHxvlMjKBeqgsh6FoAR2kX5IcYCMu3Q/fDbz/zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FdM2WSOEpeVQ0G9EyU21z1S0Lc0i5nKom3jrdf4XT0vgxVkmSvVv01d7Bbqzor4Fr
	 CKetcy6KuujlK1hofUqZhdONhdECK3R68Fs7v//6QJguXupZST0CUs8zTOP9DioDPT
	 IUnmq8kMggsi9hM/2sWsGOulgfdLPcK393LWYJkIgu+PxzntGjJR8JkaKZmODhjqMr
	 4Ea8+agyrb3fZaidYMXZ95Vvnc/vkji4291P5tmXEeFMR/upeh++8DYO0R1c5Phm5z
	 UTz1+AHlfwlF8f9Wzh344oXZckqGRPiIKrhA4666Jd7Zkj638nJsu/G51PO4f0Yq98
	 RRwcBhArrCJpQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Gary Guo <gary@garyguo.net>, Oliver Mangold
 <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Paul
 Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi
 Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <DG4H66NZ5ME0.3M9CQY1ER4Q0X@garyguo.net>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
 <20251201155135.2b9c4084.gary@garyguo.net>
 <87343jqydo.fsf@t14s.mail-host-address-is-not-set>
 <rHWhMe7C5fnwgGCnKS4N7G90SrX0Ao8332cwKPH2o-Em_lCBG3lm_erDn9dtg55SpjMFQQoJ_hhDU3bKOdYfAQ==@protonmail.internalid>
 <DG4H66NZ5ME0.3M9CQY1ER4Q0X@garyguo.net>
Date: Mon, 02 Feb 2026 14:04:56 +0100
Message-ID: <87o6m7pa87.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-76042-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.mail-host-address-is-not-set:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pm.me:email]
X-Rspamd-Queue-Id: 6BEA4CC972
X-Rspamd-Action: no action

"Gary Guo" <gary@garyguo.net> writes:

> On Mon Feb 2, 2026 at 9:37 AM GMT, Andreas Hindborg wrote:
>> Gary Guo <gary@garyguo.net> writes:
>>
>>> On Mon, 17 Nov 2025 10:07:40 +0000
>>> Oliver Mangold <oliver.mangold@pm.me> wrote:
>>>
>>>> From: Asahi Lina <lina+kernel@asahilina.net>

<cut>

>>>> +impl<T: Ownable> Owned<T> {
>>>> +    /// Creates a new instance of [`Owned`].
>>>> +    ///
>>>> +    /// It takes over ownership of the underlying object.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// Callers must ensure that:
>>>> +    /// - `ptr` points to a valid instance of `T`.
>>>> +    /// - Ownership of the underlying `T` can be transferred to the `Self<T>` (i.e. operations
>>>> +    ///   which require ownership will be safe).
>>>> +    /// - No other Rust references to the underlying object exist. This implies that the underlying
>>>> +    ///   object is not accessed through `ptr` anymore after the function call (at least until the
>>>> +    ///   the `Self<T>` is dropped.
>>>
>>> Is this correct? If `Self<T>` is dropped then `T::release` is called so
>>> the pointer should also not be accessed further?
>>
>> I can't follow you point here. Are you saying that the requirement is
>> wrong because `T::release` will access the object by reference? If so,
>> that is part of `Owned<_>::drop`, which is explicitly mentioned in the
>> comment (until .. dropped).
>
> I meant that the `Self<T>` is dropped, the object is destroyed so it should also
> not be accessed further. Perhaps just remove the "(at least ...)" part from
> comment.

Right, got it. The "until.." is in place to allow reuse of the
allocation. There is no requirement here to drop `T` via the `release`
method when an `Owned<T>` is dropped. Implementers are free to implement
schemes that reuse the object without drop and re-init. This can be used
in object caches such as for the block request cache.

>
>>
>>>
>>>> +    /// - The C code follows the usual shared reference requirements. That is, the kernel will never
>>>> +    ///   mutate or free the underlying object (excluding interior mutability that follows the usual
>>>> +    ///   rules) while Rust owns it.
>>>
>>> The concept "interior mutability" doesn't really exist on the C side.
>>> Also, use of interior mutability (by UnsafeCell) would be incorrect if
>>> the type is implemented in the rust side (as this requires a
>>> UnsafePinned).
>>>
>>> Interior mutability means things can be mutated behind a shared
>>> reference -- however in this case, we have a mutable reference (either
>>> `Pin<&mut Self>` or `&mut Self`)!
>>>
>>> Perhaps together with the next line, they could be just phrased like
>>> this?
>>>
>>> - The underlying object must not be accessed (read or mutated) through
>>>   any pointer other than the created `Owned<T>`.
>>>   Opt-out is still possbile similar to a mutable reference (e.g. by
>>>   using p`Opaque`]).
>>>
>>> I think we should just tell the user "this is just a unique reference
>>> similar to &mut". They should be able to deduce that all the `!Unpin`
>>> that opts out from uniqueness of mutable reference applies here too.
>>
>> I agree. I would suggest updating the struct documentation:
>>
>>     @@ -108,7 +108,7 @@ pub unsafe trait Ownable {
>>         unsafe fn release(this: NonNull<Self>);
>>     }
>>
>>     -/// An owned reference to an owned `T`.
>>     +/// An mutable reference to an owned `T`.
>>     ///
>>     /// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
>>     /// dropped.
>>
>> And then the safety requirement as
>>
>>  An `Owned<T>` is a mutable reference to the underlying object. As such,
>>  the object must not be accessed (read or mutated) through any pointer
>>  other than the created `Owned<T>`. Opt-out is still possbile similar to
>>  a mutable reference (e.g. by using [`Opaque`]).
>
> Sounds good to me.

OK.

>
>>
>>
>>>> +    /// - In case `T` implements [`Unpin`] the previous requirement is extended from shared to
>>>> +    ///   mutable reference requirements. That is, the kernel will not mutate or free the underlying
>>>> +    ///   object and is okay with it being modified by Rust code.
>>>
>>> - If `T` implements [`Unpin`], the structure must not be mutated for
>>>   the entire lifetime of `Owned<T>`.
>>
>> Would it be OK to just write "If `T: Unpin`, the ..."?
>>
>> Again, opt out is possible, right?
>>
>
> When the "mutable reference" framing above I think you can just drop this part.

Agreed.

>
>>>
>>>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>>
>>> This needs a (rather trivial) INVARIANT comment.
>>
>> OK.
>>
>>>
>>>> +        Self {
>>>> +            ptr,
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /// Consumes the [`Owned`], returning a raw pointer.
>>>> +    ///
>>>> +    /// This function does not actually relinquish ownership of the object. After calling this
>>>
>>> Perhaps "relinquish" isn't the best word here? In my mental model
>>> this function is pretty much relinquishing ownership as `Owned<T>` no
>>> longer exists. It just doesn't release the object.
>>
>> How about this:
>>
>>
>>     /// Consumes the [`Owned`], returning a raw pointer.
>>     ///
>>     /// This function does not drop the underlying `T`. When this function returns, ownership of the
>>     /// underlying `T` is with the caller.
>
> SGTM.

OK.


Best regards,
Andreas Hindborg



