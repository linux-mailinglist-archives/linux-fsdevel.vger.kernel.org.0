Return-Path: <linux-fsdevel+bounces-51022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89CAD1E35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A6E3AA21A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE4256C7E;
	Mon,  9 Jun 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9HrEXt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269D219EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473821; cv=none; b=BasSHxq4MDvRnftWuTDJk5mwu82USSqYc+ngqUOYnYWYCqoKjT0+FvnVxoLVJHOAs/aXnh52MwIRFOGgYkDhhuqumK7ErBY8xgTbajgj9RGOxmp91gvmQ9rvLov7dY6m/Y8bkP14RblZ3edLoyWl5+UDUnG2XNffJ1df5LHJoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473821; c=relaxed/simple;
	bh=isO2jMs/4okLVwzv7EBFcIFtPGUXMpykw2TzGvbjL7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etaD+q/pLwzdbkWY3NQiX10UFyj+G9yKQhJpDPboO2HvcTpMe2XpPn1QtEjTm0k9dOnAXbT1pME3EaLVRR4vvqJ6ocsSn5PDO91Dxc1kX0/FWLluVaj0yCkI/mLlRnQldzH+TQplsVxULVItihS4rYD+ZNm2ve6q2KX14CsYegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9HrEXt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2330AC4CEEB;
	Mon,  9 Jun 2025 12:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749473821;
	bh=isO2jMs/4okLVwzv7EBFcIFtPGUXMpykw2TzGvbjL7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T9HrEXt3tAAonInje2GlRTa8GClt7MLovLWvZsb/DttcQeW0MNwbqNesZI5OlxCzn
	 W8FUEpkvljliGVctxuOiqmjk0A1YoNAeVPvqH96qiijtsUtrn6wDB5CZ9i9ypwol29
	 GdFhHyeVsZrJA5asOhCF2Gf9vCW9F/X4h08R5k9xL09t/G8IPGCILvzuljI/YoR7tR
	 Amac1tClUrGneclw3SZJ8J2XEAckciva6t2msTEqGPNSNE5RI4KZ5KBurs9rcauCBV
	 kFQXN8WuNHsmlFES87Hv41/NsB7VEOhwgqc9KR0/txCcz+R8bBF9+f8M6R0yrnN2MC
	 zESad44JZ4wUA==
Message-ID: <e5072f6cb5f91b60ffc90b60fe7e8417b858cc58.camel@kernel.org>
Subject: Re: [PATCH v2 0/5] coredump: allow for flexible coredump handling
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Daan De Meyer <daan.j.demeyer@gmail.com>, Jan
 Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>,  Mike
 Yuan <me@yhndnzj.com>, Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>,  Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 09 Jun 2025 08:56:58 -0400
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
References: 
	<20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-03 at 15:31 +0200, Christian Brauner wrote:
> In addition to the extensive selftests I've already written a
> (non-production ready) simple Rust coredump server for this in
> userspace:
>=20
> https://github.com/brauner/dumdum.git
>
> Extend the coredump socket to allow the coredump server to tell the
> kernel how to process individual coredumps. This allows for fine-grained
> coredump management. Userspace can decide to just let the kernel write
> out the coredump, or generate the coredump itself, or just reject it.
>
> When the crashing task connects to the coredump socket the kernel will
> send a struct coredump_req to the coredump server. The kernel will set
> the size member of struct coredump_req allowing the coredump server how
> much data can be read.
>=20
> The coredump server uses MSG_PEEK to peek the size of struct
> coredump_req. If the kernel uses a newer struct coredump_req the
> coredump server just reads the size it knows and discard any remaining
> bytes in the buffer. If the kernel uses an older struct coredump_req
> the coredump server just reads the size the kernel knows.
>=20
> The returned struct coredump_req will inform the coredump server what
> features the kernel supports. The coredump_req->mask member is set to
> the currently know features.
>=20
> The coredump server may only use features whose bits were raised by the
> kernel in coredump_req->mask.
>=20
> In response to a coredump_req from the kernel the coredump server sends
> a struct coredump_ack to the kernel. The kernel informs the coredump
> server what version of struct coredump_ack it supports by setting struct
> coredump_req->size_ack to the size it knows about. The coredump server
> may only send as many bytes as coredump_req->size_ack indicates (a
> smaller size is fine of course). The coredump server must set
> coredump_ack->size accordingly.
>=20
> The coredump server sets the features it wants to use in struct
> coredump_ack->mask. Only bits returned in struct coredump_req->mask may
> be used.
>=20
> In case an invalid struct coredump_ack is sent to the kernel an
> out-of-band byte will be sent by the kernel indicating the reason why
> the coredump_ack was rejected.
>=20
> The out-of-band markers allow advanced userspace to infer failure. They
> are optional and can be ignored by not listening for POLLPRI events and
> aren't necessary for the coredump server to function correctly.
>=20
> In the initial version the following features are supported in
> coredump_{req,ack}->mask:
>=20
> * COREDUMP_KERNEL
>   The kernel will write the coredump data to the socket.
>=20
> * COREDUMP_USERSPACE
>   The kernel will not write coredump data but will indicate to the
>   parent that a coredump has been generated. This is used when userspace
>   generates its own coredumps.
>=20
> * COREDUMP_REJECT
>   The kernel will skip generating a coredump for this task.
>=20
> * COREDUMP_WAIT
>   The kernel will prevent the task from exiting until the coredump
>   server has shutdown the socket connection.
>=20

How do you envision COREDUMP_WAIT being used? I took a look at the
trivial server, but it wasn't clear to me why you'd want to block the
task from exiting.

> The flexible coredump socket can be enabled by using the "@@" prefix
> instead of the single "@" prefix for the regular coredump socket:
>=20
>   @@/run/systemd/coredump.socket
>=20
> will enable flexible coredump handling. Current kernels already enforce
> that "@" must be followed by "/" and will reject anything else. So
> extending this is backward and forward compatible.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v2:
> - Add epoll-based concurrent coredump handling selftests.
> - Improve cover letter.
> - Ensure that enum coredump_oob is packed aka a single byte and add a
>   static_assert() verifying that.
> - Simplify helper functions making the patch even smaller.
> - Link to v1: https://lore.kernel.org/20250530-work-coredump-socket-proto=
col-v1-0-20bde1cd4faa@kernel.org
>=20
> ---
> Christian Brauner (5):
>       coredump: allow for flexible coredump handling
>       selftests/coredump: fix build
>       selftests/coredump: cleanup coredump tests
>       tools: add coredump.h header
>       selftests/coredump: add coredump server selftests
>=20
>  fs/coredump.c                                     |  130 +-
>  include/uapi/linux/coredump.h                     |  104 ++
>  tools/include/uapi/linux/coredump.h               |  104 ++
>  tools/testing/selftests/coredump/Makefile         |    2 +-
>  tools/testing/selftests/coredump/config           |    4 +
>  tools/testing/selftests/coredump/stackdump_test.c | 1705 +++++++++++++++=
+++---
>  6 files changed, 1799 insertions(+), 250 deletions(-)
> ---
> base-commit: 3e406741b19890c3d8a2ed126aa7c23b106ca9e1
> change-id: 20250520-work-coredump-socket-protocol-6980d1f54c2f

--=20
Jeff Layton <jlayton@kernel.org>

