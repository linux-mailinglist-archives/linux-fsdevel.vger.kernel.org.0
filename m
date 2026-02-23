Return-Path: <linux-fsdevel+bounces-77966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LMIAz9snGlNGQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:03:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6A17866B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB2A730398DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D600366DB2;
	Mon, 23 Feb 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaigYStr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C00366073;
	Mon, 23 Feb 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858882; cv=none; b=MOqA2rFbzl7rRw/wblHE5t7rP7gQ/fwOUpm6gFrzgwM28drGXX5xeY1AfTGHT0F9Lh482H+eB73/UooGhVDLZo/UtzvCa+wgzjNJPhhSAjeYkkyrCdlVK1EF+SuGfFus8lLYvBXSMlEjvnr+ooqPvPEwH8AJRzy1q1HhBEzoDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858882; c=relaxed/simple;
	bh=e5c5b74M3vTmffrZkxVqf33SIGqWmbbti+5cabgqU30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gz8/753a2iz7qFu0d/omKoqsYaK06rOR8TLZyh+7KhDoAHolPozHU/XnMq9FwIwXtkscrw9nsxkIdRUyBHm/3rEIZFAE6Ol2W28eD+2jokog2lTzggVFUF0rfMMjLKNTjDxArZC8PowuOtOP2pJVayO0OaT7aWW/pQHhHMI95e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaigYStr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40292C2BCB2;
	Mon, 23 Feb 2026 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771858882;
	bh=e5c5b74M3vTmffrZkxVqf33SIGqWmbbti+5cabgqU30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OaigYStrS0H58RnK9jYWZCcHDiqSEdAX7xgm52ZiTIH2hOr6lFz0pfIeHqnXSx22c
	 fPLAmdIje8wpwT3qgmVJaXPsnkaS7NB7FwbUnfh6uL4pw4ZkNksgkgpQj1U9soOJP3
	 I8zQ06tXZJNH9bmYxdwifxd2hS8ZyCjhPsUEDM0WvensrAB7wgg+ERxBdKJP20LcBg
	 JyDzx8ODMtCb6QkuTBbIFDF1X1wLOYFev6Eyzhc0eMwdUu/PVzCaS4BJW214un6Gfw
	 oem2r/xcNVnvVt1I21kKCGINo2ZynGSWPrRf7980RO65Ev+qkS2YfdT/tsiM9Vv5jR
	 s31T8kd8QKH0w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Tamir Duberstein
 <tamird@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
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
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
In-Reply-To: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
 <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Date: Mon, 23 Feb 2026 16:00:02 +0100
Message-ID: <87sear33pp.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77966-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,t14s.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 97C6A17866B
X-Rspamd-Action: no action

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>
>> +    /// Create a `&Page` from a raw `struct page` pointer
>
> Please end sentences with a period.

Ok.

>
>> +        // SAFETY: By function safety requirements, ptr is not null and=
 is
>
> Please use Markdown in comments: `ptr`.

Ok.

>
>> +    /// `ptr` must be valid for use as a reference for the duration of =
`'a`.
>
> Since we will likely try to starting introducing at least a subset of
> the Safety Standard soon, we should try to use standard terms.
>
> So I think this "valid for use as a reference" is not an established
> one, no? Isn't "convertible to a shared reference" the official term?
>
>   https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conve=
rsion
>
> In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
> stabilized for 1.95.0, so we should probably starting using those were
> applicable as we bump the minimum, but we should probably use already
> a similar wording as the standard library for the safety section and
> the comment:
>
>   "`ptr` must be [convertible to a reference](...)."

I'll change the wording to the "convertible" one.


Best regards,
Andreas Hindborg



