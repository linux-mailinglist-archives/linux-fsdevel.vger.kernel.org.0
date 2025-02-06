Return-Path: <linux-fsdevel+bounces-41112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D0A2B16B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83CA3A310B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99023957D;
	Thu,  6 Feb 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbohuD/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA8239594;
	Thu,  6 Feb 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867248; cv=none; b=eP8hAXH05a772I1EW1+8i5CGpoXXvgw/EZt3pXr631rDGNnX3tv1Zq14q1LsJqmgTs8aSwYocsS5CDrGTtpfDYzqYlRdu4X1KHFwOTshTdZyiyJCEHhtJFWRhdFM6n8LRp3jGIAQu34AIxAcCkTWwKKXOYKFzsx+tcJInnAExSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867248; c=relaxed/simple;
	bh=AqE1pMuvm0gESLExRIZmP8zVnIsTt0cmfWsmOCAj6TA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvov/ob9GKU+LtePZElC5qNwJOhzWOuCMvkN2Sm8n0XDDg6f7noEeqxu7mjMrQBrmdgwv4WpjUI4cZgntojnRomI/9YkjFkdZdLOMLIoDLB7OCNqmyl5+KvxG2E0KDdBqtvMejhtTC+bM+5Fmk7IwBk5ps7c0Rxtw1lJihu9bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbohuD/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5D1C4CEDD;
	Thu,  6 Feb 2025 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738867247;
	bh=AqE1pMuvm0gESLExRIZmP8zVnIsTt0cmfWsmOCAj6TA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mbohuD/VJ/t/Zgib2GTSD+yxl8/n70CkryJz1kSuJclS+XuOlzjtlw9Lg4yYXWiIL
	 rvXEvXYkbgsy8QYqyKbQaC8EoElvG2b3rILCOzGuahrUrAFAqOYiwTIHkXY0as9s42
	 rsGIoOf2yy3WmToCPnAN0/CC+fEJ3e4niXaTwmzB69Eo6e+EuSUuYz/A9IyhPf24Pu
	 A4tavTPcxaU5s/ae7HQRR0kzzDerFl1nOCd7Z8sTnvrGMOsOs2s/CKpxPmcWOuyyKT
	 oUxe3tvqWj21ykRRN4pTnO0XVHHPar2Rvjch1Sb2WMBgFXD0ny4o8Dz1hh3xBbH+Yp
	 jeisqjQ1MtWeA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Matthew Wilcox" <willy@infradead.org>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>,  "Asahi Lina" <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v15 3/3] MAINTAINERS: add entry for Rust XArray API
In-Reply-To: <20250206-rust-xarray-bindings-v15-3-a22b5dcacab3@gmail.com>
	(Tamir Duberstein's message of "Thu, 06 Feb 2025 11:24:45 -0500")
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
	<Su-WCT_IvK3MO6cqVnUUFoYn7m83NT79YSQSxPiBjoEGRYfsY-a2QDn3EBxPBHKludpMZTM4L3KqME_vzDkDXw==@protonmail.internalid>
	<20250206-rust-xarray-bindings-v15-3-a22b5dcacab3@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Feb 2025 19:40:32 +0100
Message-ID: <87y0yij4rj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Add an entry for the Rust xarray abstractions.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




