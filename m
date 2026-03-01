Return-Path: <linux-fsdevel+bounces-78852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBBzJr1qpGnwgAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 17:35:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE11D0A76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E186C301C3E7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B78335BA8;
	Sun,  1 Mar 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKgzX0hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D2430BB5;
	Sun,  1 Mar 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382883; cv=none; b=k4DwpMcwBGola/2RCSTJgaofnBo275c4aaDUAl1306dlVrtOtexxgACISjcYaQ1OtuFmDqvb2kDm13fEO1CHNu+6dxG3CA7Ve6jTl7hhKFWEzP0Yi6iPFRcxRQ/G7iNdFzy6iEil2gnJqU9wG2a4BQfuRMco/BHJRpvr1gMdL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382883; c=relaxed/simple;
	bh=je5mLoR2Jxu2IjLDAPypnbsm91i4Kuu9GRu6352moZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcIinGqutMH4jAj/WjLH85L/ZWt5bmXJkmzPSCNtkxD/RqmYzGHoKI/Ei68XgfXI8YcdtsyALTtWwsTrEoErJPhSXwnyt2jJ5k1XUqZ9/uL/z97ldP9aNm52ddSXODjGpDXP2gX2vCQUh9VnQVhWeK5eWRYUx4ZvCu3XGVSnmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKgzX0hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC44C116C6;
	Sun,  1 Mar 2026 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772382883;
	bh=je5mLoR2Jxu2IjLDAPypnbsm91i4Kuu9GRu6352moZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TKgzX0hf3d0lhMQetjAEiiWCOKnFnzvXZWHgmPaqhbewdN3fJRosoCZCc9qBvc/po
	 evHx93y+6jGFm1MG3XNqYQsOr8ddGPjYTtni3MBr4+Wfeg0Bdp7DgyJtpeSaRoBKsq
	 /8EmI4goKRcWrT+Ty8VXffQn9jZgFIq3COzQDhZXz+v1zP/sZmvi7J3/9qpNTmJlXX
	 dvga5zyWNUWjv9DVOk3rU4gbLyOte0fKmobQCF487i0iZ6UJJpeiE7pdPHIoBrDEge
	 JZG83Fy8G1/GE+0kCzgow04ihq31SX509/egQfJwEahHcltsBfRDzs14I3kQCC0Q4D
	 NTYljGVX/IW5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
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
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Uladzislau
 Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
In-Reply-To: <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net>
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
 <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net>
Date: Sun, 01 Mar 2026 17:34:26 +0100
Message-ID: <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78852-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.940];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Queue-Id: 05AE11D0A76
X-Rspamd-Action: no action

"Gary Guo" <gary@garyguo.net> writes:

> On Tue Feb 24, 2026 at 11:17 AM GMT, Andreas Hindborg wrote:
>> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
>> is a convenience wrapper around `Self::into_raw` for callers that need
>> a `NonNull` pointer rather than a raw pointer.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/alloc/kbox.rs | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> index 622b3529edfcb..e6efdd572aeea 100644
>> --- a/rust/kernel/alloc/kbox.rs
>> +++ b/rust/kernel/alloc/kbox.rs
>> @@ -213,6 +213,14 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>>          // which points to an initialized instance of `T`.
>>          unsafe { &mut *Box::into_raw(b) }
>>      }
>> +
>> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
>> +    ///
>> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
>> +    pub fn into_nonnull(b: Self) -> NonNull<T> {
>> +        // SAFETY: `KBox::into_raw` returns a valid pointer.
>> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
>> +    }
>
> Hi Andreas,
>
> It looks like this patch and many others in the series are missing `#[inline]`
> for quite a few very simple functions. Could you go through the series and mark
> small functions as such?

Sure.

Could you remind me why we need this directive? Would the compiler not
be able to decide?

I know we have an issue when we have call to C function in short
functions, but not in the general case?


Best regards,
Andreas Hindborg




