Return-Path: <linux-fsdevel+bounces-78867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AznEh49pWm36gUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 08:32:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28731D3F6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB40304AADD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC5383C66;
	Mon,  2 Mar 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ZaeF4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E501D0DEE;
	Mon,  2 Mar 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435943; cv=none; b=FSpihM9W3L0zhZNpk4UicboUqYGQJzQm2hMR8ENjmw16t1hdo/wq28OmSzCcm6CbEjgNzYrLm+UGS8BvyjnKYsnsgptVefU1ZrHMaLCn/KVU4mmj5Ag9qWJRKQ9xowjR6Xx5yX6xe9ziLN0JJ3XFsppdj2+d1eQ/HAgJi44uTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435943; c=relaxed/simple;
	bh=IWFUYHylqRFZaRm5r8RrLRDa3YLgSmjWVVLiN7LHGy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5b/g0CzCTvCFTaHqUrg3lyz6k0fGNA3sK3tLcVfj7t3oXVdAg1MWxOlk91xsC4Cl6sX7fr/GHhnA0beONPhLYzs5PTieyRkvJueYTHR3hjYqZYpJ5Ui5OwtijYoaqGfoo0bFxHgeYG80WLRjes2Bnhnz4cxInFFy+lv4TSxxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ZaeF4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D3EC19423;
	Mon,  2 Mar 2026 07:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772435943;
	bh=IWFUYHylqRFZaRm5r8RrLRDa3YLgSmjWVVLiN7LHGy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l9ZaeF4aPU2R5rFFz1KzYT2AzZwYDAcXSFOWGleyGX4IJCSYh3ey9X9MFaec25Jvt
	 R41n5ogriJLHLbTnbAhRUlTENuE8zHqJZ4hmXfIoI14lQa1CZ833Zh2NufwlrmebRa
	 uRquDMiQ7euErjNofmy94n80bTQAgtr9fYExYWtiCa7u6OSqVRwgJZtiI9fbt0Id5d
	 X42If6KFdaneLbuS8GYtRtOBZ+FwIRmVTq7yyXCkl7+v+oM/ByWo3UXqtNZIjzLubr
	 CxI1q1dwT1MHjvxnZsz6xERpo7UqyUz5qw5zjzCMpgHhrhI/5JG2NlqgMLZulaFmBF
	 wrN8cEwrndjoQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, Gary Guo
 <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
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
In-Reply-To: <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net>
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
 <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid>
 <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net>
 <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
 <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net>
 <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
 <p7rsBPaYxHKSMFCYVUFY5hdI1H6jxHK0s7lxLQkqH4rylM6yS03Yt52SCjiTO5qBVUmc41ZHZ7XZ0_3w_U-O0g==@protonmail.internalid>
 <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net>
Date: Mon, 02 Mar 2026 08:18:47 +0100
Message-ID: <87ikbebsx4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78867-lists,linux-fsdevel=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,rust-lang.github.io:url]
X-Rspamd-Queue-Id: D28731D3F6D
X-Rspamd-Action: add header
X-Spam: Yes

"Gary Guo" <gary@garyguo.net> writes:

> On Sun Mar 1, 2026 at 7:59 PM GMT, Benno Lossin wrote:
>> On Sun Mar 1, 2026 at 8:25 PM CET, Gary Guo wrote:
>>> `#[inline]` is a hint to make it more likely for compilers to inline. Without
>>> them, you're relying on compiler heurstics only. There're cases (especially with
>>> abstractions) where the function may look complex as it contains lots of
>>> function calls (so compiler heurstics avoid inlining them), but they're all
>>> zero-cost abstractions so eventually things get optimized away.
>>>
>>> For non-generic functions, there is additional issue where only very small
>>> functions get automatically inlined, otherwise a single copy is generated at the
>>> defining crate and compiler run on a dependant crate has no chance to even peek
>>> what's in the function.
>>>
>>> If you know a function should be inlined, it's better to just mark them as such,
>>> so there're no surprises.
>>
>> Should we set clippy::missing_inline_in_public_items [1] to "warn"?
>>
>> [1]: https://rust-lang.github.io/rust-clippy/master/index.html?search=missing_inline_in_public_items
>
> That requires *all* public items to be `#[inline]` regardless the size, which is
> excessive.

I was thinking something similar, in clippy or checkpatch.pl. If we
should always have this attribute for small functions, we need to have a
check.


Best regards,
Andreas Hindborg




