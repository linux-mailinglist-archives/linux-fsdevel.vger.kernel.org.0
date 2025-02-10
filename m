Return-Path: <linux-fsdevel+bounces-41429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283EDA2F638
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B2A16258D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28D243945;
	Mon, 10 Feb 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="EMoPI71J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjlzsF6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72C25B66C;
	Mon, 10 Feb 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210370; cv=none; b=Qh/pnw7VZG35KcVTqoNUjMVEVgxys4T5tOyVo8G2+Gu2DVhdI6d0phFlo6ruvyNrhuoYaH/sxuY4pLijOZOQCdczq9gdcjFeu42qUmi0Tl0UNIwM2JRpQZd6y5j5CPiEDJAW0pwqMcKxlq0TfW1EL/Y9dSbCf2tsBV/U/GwB7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210370; c=relaxed/simple;
	bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk1hMohsY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcCY8pC61Jxz5hbTnFgylzZNecLYDwehUzmQ5yYqOdCM0dQGoKYk7ryY+TTv/RMEpiLWC780jp1T6cxnp63NhcuY9ZFTg1QA/g3cC75XFyhgHFbWr2nWvbD+YvH8Hztc3Y9f/WUpJuJN7q5jKxfCQW5iHxPyrhCpVdygeiN5+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=EMoPI71J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjlzsF6u; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F43F1140181;
	Mon, 10 Feb 2025 12:59:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 10 Feb 2025 12:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739210367; x=
	1739296767; bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk1hMohsY8=; b=E
	MoPI71JsKi0L0suLHYCwmMPyfFF5vT+tA+zdNDm1DI1MgXtqjYzNsFZfbcbXRmys
	Xh4QD9SKGWgXuGpZJsZY5IsEowIq5UDw8PYrdPT6aWBV6jajvmesfZ6ApM0ugq9H
	a7shKWw1+L0qCjsolEb+1LcKX+AuGbHgfSjUB/b9yngdScR8qp+SGmlrQOASvcWL
	WqvJTuHRF2xx1VcgnZ33yFcnY2a7f8fy3SMtB5zTu+gzXu8owAi++z02vSECF+rw
	bde32Juk6RWYDlZZGqynkpuZD7OG18tuaaqnJa503elLqtTS/+H3xm6sC9umSL/Q
	QdI/oDyjOKUK7060BP/6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739210367; x=1739296767; bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk
	1hMohsY8=; b=mjlzsF6uF9om03EU2kE3gtAG20uUa2vHnl+XbFOHmGjQi7XgV3r
	KFIj7QbWeIIGVlT6lpuZtxfzcgkIe6AI19lgGNBmKNcqfW7w7JTMZrLj9Bg+7FAc
	000Qmcen6FGwE891/Uz/gLR/YBivQzicGZbeX41Brmpx+Uk0ER/z3Yr6SuU6r0ti
	TbKdGtDeV5lz7SdiLZmqyjjl3CaFGmSJV038SeOwMGx8qA36KegvXT18zzKox9R1
	I8YVE/XMtGOlgKukuPi8ipEIEXrVOHCnzC2JqMy4m0QLPrNT6lDBLee3UxS5W+ae
	CvnLfITbMF2FVyzX6nI8EYiJjrT95Th5XSQ==
X-ME-Sender: <xms:fj6qZ7WhUp9AMc2RQkPVa6I8IF-BvPyIf4mjoqGAqXta6wabyJyvnQ>
    <xme:fj6qZzmUSWROoyF_LEEIUIJ4lHWmJoKqtw87p8_I_Q-5vrOoGAXG6qRDS-qFIdQXp
    6LpFAWrOtJgqDTNXwQ>
X-ME-Received: <xmr:fj6qZ3aqa9i1ASu55emdnHRiybA6hy99e8PdShDphZ9uJj_4sLS5KGxd6XD7KOPFfG3pBPOu9r_tOmAAay2xrrzy63AJ_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehi
    nhhrihgrrdhfrhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:fj6qZ2UEqZ5MJ3eutGBKyJ2riIHJsf_mjtkNJS6raicpGP5VV6Bncg>
    <xmx:fj6qZ1lhSUevRqU24X2knacWjm4hQgVWUf8ikeuR9bsPiSnUf6LGYw>
    <xmx:fj6qZzcFp7Rx5PuFeKYtuWa1xdjjZR7JH54aYNC_gPkPNAP1GuHUvw>
    <xmx:fj6qZ_EzHu3RoeHgoHOC9h3V0-TZdiB3sFuD5BWqfbC9LYFBn8Cs2Q>
    <xmx:fz6qZ2gIzJWL_zVP73DvZEBMBzzGhWmS1JmHRIt5VHJBib0gZMOb6QFD>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 12:59:25 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle
 in debugfs API
In-Reply-To: <20250210115313.69299472@gandalf.local.home> (Steven Rostedt's
	message of "Mon, 10 Feb 2025 11:53:13 -0500")
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 09:59:24 -0800
Message-ID: <867c5x3clf.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

>
> No it will not be fine. You should not be using dentry at all. I thought
> this was going to convert debugfs over to kernfs. The debugfs_node should
> be using kernfs and completely eliminate the use of dentry.
>
> <snip>
>
> What caller should ever touch a dentry? What I got from my "conversation"
> with Linus, is that dentry is an internal caching descriptor of the VFS
> layer, and should only be used by the VFS layer. Nothing outside of VFS
> should ever need a dentry.
>
> -- Steve

I agree that just wrapping a dentry shouldn't be the final state for
debugfs_node, but this patch series is _only_ trying to introduce
debugfs_node as an opaque wrapper/handle.

It isn't clear to me that there is consensus on even using kernfs for
debugfs. Even if there was consensus, a full conversion to kernfs would
take 10x as much code and be extremely difficult to automate. For
example, using kernfs would require migrating all of the debugfs users'
file_operations to use the kernfs equivalent.

I figure any change away from persistent dentry handles for debugfs
requires introducing something akin to debugfs_node, so we could get
that out of the way first.

Thanks,
David Reaver

