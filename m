Return-Path: <linux-fsdevel+bounces-66486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E383CC20C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F2C189B9E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017327FD7D;
	Thu, 30 Oct 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQk1KEPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333522773F9;
	Thu, 30 Oct 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835913; cv=none; b=eAWSo8Xv0PV/xgGVFZzKrCZF3o6uGBDotSNMBscJ5aMQ0tAZVKhVbSN4vNhZ70pX7TUdd2MrxNGztVadJVQn1dXn09JBGPxumyJxIjPnrjWtdLC4xYQ0eEjSjED82r0il5epMHmsZuY/IzN+yUZzdcE08PbtPLiMQr1qNJMngck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835913; c=relaxed/simple;
	bh=WKwjBQEqXFPKO+WzYJAtU397ptDKk7qO+md5aDf4qeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+lImkSjRg8fBNcIP8qM82K+9mGVlSGppCxwkE4CF3mUanGenAw5nvcjRnk4wEcldle+q6ctZ3RBFQgM/sKEtSVJGVaf/d8PkM/MpIoGcMSTl/H+ZfrqwiHqRGLiMLMUaxeT+orle5NrxPtznXLI5Y8S4iEtyrS672Q+UByCSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQk1KEPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A797C4CEF1;
	Thu, 30 Oct 2025 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835912;
	bh=WKwjBQEqXFPKO+WzYJAtU397ptDKk7qO+md5aDf4qeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eQk1KEPLZSr8AEWd/EU8u+Rrrky9aVBOpC7OJb24MtNAy8lk0RV3tvhMD4m4ACHgr
	 fMlATft9Er2BS36a8xMX9gPc8K4bBTSuSpOK5p3EBHonicaJ4mGIeI7f3kztqcEmTe
	 SRD8UsdgXC55zByvBL2GPf9BGZR+5Z6bCWvWJ48Guof+RmgX8uZh/na2+7gRavwx5/
	 5rqNlDqOvtDtHZ7DFY/4iS63rM4nUKvfa0DBlZL9xCA/LxOOXy0Wuh1dST1pH8CTe/
	 Ds9vTfVN/js3WH8pZd2wSp+qSUJy5qicslENSC1jFjvj8vnfDDjb5Z40aSUNg9UkYL
	 AfUfkjCtX7Bqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno
 Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Oliver Mangold
 <oliver.mangold@pm.me>
Subject: Re: [PATCH v12 0/4] New trait OwnableRefCounted for ARef<->Owned
 conversion.
In-Reply-To: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me>
Date: Thu, 30 Oct 2025 15:51:38 +0100
Message-ID: <87v7jw8mth.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Oliver,
Oliver Mangold <oliver.mangold@pm.me> writes:

> This allows to convert between ARef<T> and Owned<T> by
> implementing the new trait OwnedRefCounted.
>
> This way we will have a shared/unique reference counting scheme
> for types with built-in refcounts in analogy to Arc/UniqueArc.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

I rebased your series on top of v6.18-rc3 and pushed it here [1]. I also
added some commits with review feedback.

Best regards,
Andreas Hindborg

[1] https://github.com/metaspace/linux/tree/ownable-v12


