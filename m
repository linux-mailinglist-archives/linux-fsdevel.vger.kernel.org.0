Return-Path: <linux-fsdevel+bounces-17507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 111508AE804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA35B2675D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3260135A4D;
	Tue, 23 Apr 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="2T7Le/2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638E135403
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878678; cv=none; b=WoGg+fdJW9mz7fySNdL9wr+LUtrWToWCWRTPP1KCxMWazO/Vr7iPvvY7roXQXYCUxmrdsxlr4m1z6DQFVoufw+5SZt/IOcd5gGXlBiqEm7TaOf6bicckZi3VWA/oIW5r8e1AeOm1/hJKK5lF+7xGOEH6DX4CY3PO7Vvlgirdlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878678; c=relaxed/simple;
	bh=aadGFMTxQQqOojUyHsIb18QL71Y6heNSckLB50I+m+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKOzbhHuB3YK1hBel6h3NQK3nHlqjZPGr9XrXWYomxsyrog6BYvm7YOTMnAF+DWmAxO7YVVY1AI0R4PL7UXvVSzPIKwz6MNK7b94/oCw8wfrJ1+8zD7YwD1qVglre1ovkXPpiAJQL8a0g3mFspgZgckSPO738035cTbNgReApw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=2T7Le/2X; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713878667; x=1714137867;
	bh=6dJjTH74N9XLJTYjisx3SbPvyzJ3e7sIYbHKqgQYjvk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=2T7Le/2XpNlw9TbTRidbFrz8u+VtoAE874E8ixMW9JJQKkBQk9BM2x1ICDRqZ+0vn
	 xuaR1pZDmTiV6DTRtznHKr3tSqZ0KsI1+vNikbzEvkd04UwJrCYYyKCdoy5Rtthmom
	 Ij1j8n+27h+hGQiHmnjnga2MJa4G8Rcn3gE7BTSWC+/mpzOfsbSnC11xZGJqAm2avY
	 6aT7IZE4veEDzvBM3iQ/fJi45zoE0NCCJrwo3ee3vbGjwoagOaZGjzdoqC5R9OpETu
	 KrhJztp6opzY70UFmFcYfKM2Azebso66Ak2RoQiaIpSWXvroX+Wcg7TsFY8jqVQfYS
	 87QEF28HrPKXg==
Date: Tue, 23 Apr 2024 13:24:22 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, The 8472 <kernel@infinite-source.de>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: EBADF returned from close() by FUSE
Message-ID: <9f991dcc-8921-434c-90f2-30dd0e5ec5bc@spawn.link>
In-Reply-To: <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de> <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de> <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link> <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de> <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link> <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de> <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link> <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de> <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: 0a8cf370dcc74214d50393345affcdb4f7b614b1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/23/24 07:46, Miklos Szeredi wrote:
> On Sat, 20 Apr 2024 at 01:04, The 8472 <kernel@infinite-source.de> wrote:
>
>> If it is the official position that the whims of FUSE servers have
>> primacy over current kernel API guarantees then please update
>> the documentation of all affected syscalls and relax those
>> guarantees, similar to the note on the write(2) manpage.
> Which note are you referring to?
>
> I can see some merit to both sides.
>
> If it's an issue that can be fixed in the fuse server ("Doctor, it
> hurts when I do this." "Then don't do that!=E2=80=9D) adding complexity t=
o the
> fuse client is not warranted.
>
> Obviously most fuse servers don't want to actively confuse caller, but
> if such behavior can be used to exploit a weakness in an application,
> then it becomes more than just a correctness issue.  If you came up
> with such a scenario, then this would turn into a serious bug.
>
> Thanks,
> Miklos

 From the write(2) manpage (at least on Ubuntu):

"Other errors may occur, depending on the object connected to fd."

My argument has been that this note is defacto true generally.

The specifics of this thread stem from close() returning EBADF to the=20
client app while talking to a FUSE server after the open() succeeded=20
and, from the point of view of the client app, returned a valid file=20
descriptor. Sounds like a bug in the FUSE server rather than something=20
FUSE itself needs to worry about. Besides removing some classes of usage=20
of FUSE it would be rather complicated, if not impossible, to assume the=20
meaning of returned errors from the server and translate them into=20
"approved" values for the client. It will mask server bugs and/or=20
confuse server authors at best IMO. Error handling in FUSE is already a=20
bit difficult to manage.

This is not unlike a recent complaint that when link() is not=20
implemented libfuse returns ENOSYS rather than EPERM. As I pointed out=20
in that situation EPERM is not universally defined as meaning "not=20
implemented by filesystem" like used in Linux. Doesn't mean it isn't=20
used (I didn't check) but it isn't defined as such in docs.



