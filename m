Return-Path: <linux-fsdevel+bounces-69370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C9C78507
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7EAD72D844
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C50313269;
	Fri, 21 Nov 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JT+VfaOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BD26F476;
	Fri, 21 Nov 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719271; cv=none; b=aCNMKArib23gSsIQQMSqsDE98nbot1m7G6qEk5KcYAASpKG5uLlfH344YXnakSwgC5BXw5m+PQwrl9Sbj0z/f7GQfUW1PoOUP/stxyn7CuhxGd8OgSNi9Q90F7dBxiKT2LuwLbkoeAZTQJIVPSX/uC9P+aiA4+cJ+P2xYEAEKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719271; c=relaxed/simple;
	bh=SjoUlAw2ukcXyZ8NNf2rTO3brvJiVAhcx7Rh0Mx77iU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXVjwdpB+40pVRZAS19iN8kg0vSDDLRzUMS1iKPP+v7kjenX5TMn8mUR2FgWxmCroq7cdDmZcLMuqaZy553GL8sjY3DJuK/bo0ih40b/Hz2lXlUVv5kH0id8Xoo6yK4Esr0qC7j2G+lwJvr3mgr4PsLcVFJX52G9S9AHFYuCWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JT+VfaOe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hyf31XcQR3ynpTH3x2l2y6J5zQWbB6VJts3/4lJi4q8=; b=JT+VfaOe6+dzMlJJoSzQCpWD2H
	dxwJVSdGvJJJ67e3PkL5mvjN5Z+lhbwNiCgthix187t9d8aIbVXIGam84/B5y8AMxpehOA9EfPxdo
	RfmYwfUX6T+jMk6b8jAU/+wPDjvEfYOpboBY8eUEQjTRDqPUMH6XcNhi6c6xnSp8MuAPi9zpjKOYz
	JEYD3naZ0/cZ45HFhF/7Zbv6RR6JH/HqiFk+2CMa9fjSU8IuwnSPLrN63bN8Q/kUavlRN9VgyFnhR
	fIw0DuzupHiTw/3z31pflgMUktrJj/YIDqNNBXcSyOm+1drWMrhf4GexhouX8E4JZu5hVZwfnURvT
	uITzYvAA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMNwq-003bry-CR; Fri, 21 Nov 2025 11:01:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Matt
 Harvey <mharvey@jumptrading.com>,  "kernel-dev@igalia.com"
 <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v1 3/3] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <6e561ea7-f7dd-4c94-854e-83c2fb9b0133@ddn.com> (Bernd Schubert's
	message of "Fri, 21 Nov 2025 09:06:42 +0000")
References: <20251120105535.13374-1-luis@igalia.com>
	<20251120105535.13374-4-luis@igalia.com>
	<CAOQ4uxgN5du9ukfYLBPh88+NMLt6AzSSgx4F+UJmugZ86CvB1g@mail.gmail.com>
	<6e561ea7-f7dd-4c94-854e-83c2fb9b0133@ddn.com>
Date: Fri, 21 Nov 2025 10:00:59 +0000
Message-ID: <878qfzn1r8.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21 2025, Bernd Schubert wrote:

> Thanks a lot for this Luis!
>
> On 11/21/25 08:49, Amir Goldstein wrote:
>> On Thu, Nov 20, 2025 at 11:55=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
>>>
>>> The implementation of LOOKUP_HANDLE simply modifies the LOOKUP operatio=
n to
>>> include an extra inarg: the file handle for the parent directory (if it=
 is
>>> available).  Also, because fuse_entry_out now has a extra variable size
>>> struct (the actual handle), it also sets the out_argvar flag to true.
>>>
>>> Most of the other modifications in this patch are a fallout from these
>>> changes: because fuse_entry_out has been modified to include a variable=
 size
>>> struct, every operation that receives such a parameter have to take this
>>> into account:
>>>
>>>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>>>
>>=20
>> Overall, this is exactly what I had in mind.
>> Maybe it's utter garbage but that's what I was aiming for ;)
>>=20
>> I'd like to get feedback from Miklos and Bernd on the details of the
>> protocol extension, especially w.r.t backward compat aspects.
>
> I will look into it in the late afternoon

That'd be awesome, thanks a lot Bernd!

Cheers,
--=20
Lu=C3=ADs

