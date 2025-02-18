Return-Path: <linux-fsdevel+bounces-41965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7DAA39650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE28D7A161B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAD22F3AB;
	Tue, 18 Feb 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwVvkqKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99C22B5AB;
	Tue, 18 Feb 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869207; cv=none; b=o0ph3VZTx9Y0iukUZiQZD7fTS6DPSQ+JlI+vgbkf96bm6zo0wBukp6FujHT8oLfkG/tvlkE2BEn+fVOL5ed4uzox79yb3MwsdbNKrm3qtAt8+YHUnwJsHc97HvxMbA+kj/6mfc/Y7piuh3VsOHBACLZkpCpRvAMePof8hyydmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869207; c=relaxed/simple;
	bh=H/v7Fskhbm2aFw2aebMkkvyoEe1vUWaWSgGks+kLW88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EA1ksJZFWzP8d2LiJA1aXymmvbFw2pfnZS9FhhfHHdRKR7zkjcK6/WjLtteY1Bq+v6wOs7bR9+2ViWURLu1Na7Zkc4DUkE0bH+b13qLIR14s7HDED1s/KlDBoU/nnriy+yAxawaKwR2pS+8BYpAc04DwgCrJHqieoTmTTMDoXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwVvkqKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F67AC4CEE2;
	Tue, 18 Feb 2025 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739869207;
	bh=H/v7Fskhbm2aFw2aebMkkvyoEe1vUWaWSgGks+kLW88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XwVvkqKX8kUTYZcBIV3jWudd9dj/gZFpKdPS3y8aY/3dN4IQm29++sn+39O3aTHYJ
	 tsEFP3bbudhRL4BxujQVuhkZVMHElEOJHD6EG2MiK12Dh43l00ozIigGiW46VDgYYF
	 60tY4OVNJh6RlsGlAmPDggn3lO5Q0q3DRWoERkhfmrpjYvAdfaqpBtPlDNYhJyVlJR
	 dzTq5ja+3nmfHpHtmtIloNQKdtjDPM3oarJ6K9cSQQ20UuB2mGOgTsU0+FCANacFhI
	 DhZDdphz8WbZ2DM/KWPAN7lnVXvHT5xZhipE5vR7ulFDu7dGYL0rNjWh40ike9ICos
	 //2uYoiv4S53Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Tamir Duberstein" <tamird@gmail.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Matthew Wilcox" <willy@infradead.org>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>,  "Rob Herring (Arm)" <robh@kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,  "Fiona
 Behrens" <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <Z7MnxKSSNY7IyExt@cassiopeiae> (Danilo Krummrich's message of
	"Mon, 17 Feb 2025 13:12:52 +0100")
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
	<20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
	<8jX_IItQHwgOxPXY0A1Dv0p49eCTrRu8RSushmbMOVMHDrJrQdARRmV_sDrioN4y_4YlDdS9ghrUKy0bO6l7bw==@protonmail.internalid>
	<Z7MnxKSSNY7IyExt@cassiopeiae>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 09:59:55 +0100
Message-ID: <878qq3hblg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Fri, Feb 07, 2025 at 08:58:25AM -0500, Tamir Duberstein wrote:
>> Allow implementors to specify the foreign pointer type; this exposes
>> information about the pointed-to type such as its alignment.
>>
>> This requires the trait to be `unsafe` since it is now possible for
>> implementors to break soundness by returning a misaligned pointer.
>>
>> Encoding the pointer type in the trait (and avoiding pointer casts)
>> allows the compiler to check that implementors return the correct
>> pointer type. This is preferable to directly encoding the alignment in
>> the trait using a constant as the compiler would be unable to check it.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>
> I know that Andreas also asked you to pick up the RBs from [1], but - without
> speaking for any of the people above - given that you changed this commit after
> you received all those RBs you should also consider dropping them. Especially,
> since you do not mention the changes you did for this commit in the version
> history.
>
> Just to be clear, often it is also fine to keep tags for minor changes, but then
> you should make people aware of them in the version history, such that they get
> the chance to double check.
>
> [1] https://lore.kernel.org/rust-for-linux/20250131-configfs-v1-1-87947611401c@kernel.org/
>

As long as the commit was not radically changed, I see no point in
dropping the commit trailers. Same policy as for dropping review tags
when issuing a new version of a series should be applied.


Best regards,
Andreas Hindborg



