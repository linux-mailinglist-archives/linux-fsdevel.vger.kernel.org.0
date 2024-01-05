Return-Path: <linux-fsdevel+bounces-7479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D209F825735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8275A1F21E54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1172E824;
	Fri,  5 Jan 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQvtxDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D332E652;
	Fri,  5 Jan 2024 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A840C433C8;
	Fri,  5 Jan 2024 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704470070;
	bh=9dtpNH9SkjfJPBOUmb+lWjvPc63pPm4rgfSeh1Udxck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuQvtxDX+wBAeq93lAoCdn44oX174LU78jsX4TiJUnIDJCxZe4MQxMxTBaCxVULZt
	 4zeUAHrxdrTDx1l7BF97gkMDTzBxVu19pg6U/iY+qldQybwZ4/V7tdSPHFlFr4EOaA
	 PCxv0TaMjXXPJd9HUNPFjs5RnhQL6FnKnYFZlPwszeK3d1FCnYooHTo3ZnotgkloBD
	 QUlIWfCPbdCVwuS7ycWjZvExFkd7ZaswMAXg2p56jKRSFWTVeMT7XaFXaspEiLhgPr
	 NQ/Ro6VwmJ0p8+UTwfRk60enc4Pp5V4l+FIv9cAXaPGBrpiK1v9sHFvyjKJugq7Mol
	 +s+iUYrLsOirA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jan 2024 17:54:26 +0200
Message-Id: <CY6W7MLYLYEI.1DX1F6OL9IIDV@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Howells" <dhowells@redhat.com>, "Kent Overstreet"
 <kent.overstreet@linux.dev>
Cc: "Matthew Wilcox" <willy@infradead.org>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Kent Overstreet"
 <kent.overstreet@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Wedson Almeida Filho"
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
X-Mailer: aerc 0.15.2
References: <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5> <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org> <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com> <ZZWhQGkl0xPiBD5/@casper.infradead.org> <1080086.1704413050@warthog.procyon.org.uk>
In-Reply-To: <1080086.1704413050@warthog.procyon.org.uk>

On Fri Jan 5, 2024 at 2:04 AM EET, David Howells wrote:
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> > So instead, it would seem easier to me to do the cleaner version on the
> > Rust side, and then once we know what that looks like, maybe we update
> > the C version to match - or maybe we light it all on fire and continue
> > with rewriting everything in Rust... *shrug*
>
> Please, no.  Please keep Rust separate and out of the core of the kernel =
and
> subsystems.
>
> David

Yeah, if we ignore that code is field-tested in some cases literally
decades, is infrastructure critical in global scale and similar QA
metrics, any major Rust update to the core code would be pretty hard
to manage for stable kernels...

Using Rust in core would probably require decisions at least that are
not in the scope of a single patch set.

BR, Jarkko

