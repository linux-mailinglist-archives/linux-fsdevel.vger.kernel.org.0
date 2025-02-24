Return-Path: <linux-fsdevel+bounces-42418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABECDA42366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020CF163AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89017B50B;
	Mon, 24 Feb 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E5dXUkLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618B38DD8;
	Mon, 24 Feb 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407424; cv=none; b=VfPiBjnIFsaNfcSrQFxw28Vs6Hu5Rr5bwlM82RF85HTy13StWXRO0lOi/1RYoJkqd++qp3ipV4uZtiM8GvwaL19nLTyky4VKNhEyC+mYIQ9pfKrWwDjcc96JCGUoaHEkcI6Glih0D47owTyEpGbuWGs6P+9gfVsr9rjMufK3yOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407424; c=relaxed/simple;
	bh=0L2xAsvVVRbTsUTxN8derVBM3NqEBH5Z60DKE25jHMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fARPQNDuZesfVqpBnPURr78h2hVw3CcVsH7NzLKW77JaBCrEL0sYyGkWXk6IjPLezWdUyIHP/dwndHdeSQGvwUAA4RC+DMDhl8ETtKfVihXG4qG0LnC2wqbIy9XrJ4acfzy+lpzij5CaV7+LW8E2ttBTj6bTY489JgkP2Kv2YM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E5dXUkLK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7r/0UJ56xWdyCv0sVv0fAdY7UGltG2jPpHRHjIoMvRg=; b=E5dXUkLKX4Xnogld1YciQ1fLSV
	eFHfXRr6JXqJWWZlWYT565qZ14oV6s1UBFH6F8JgPpfw36YyQ650LnOz4st6JhrbzOExzmY65Mxgp
	7SHuTsY4A18SJebP4f/flrekUOiEFZhJDCDER/XGut+c/TLKAvdlDoFK72sY8y8DhL0cAcYErNgI4
	yueQdwm9FgFVm69ma3usSepLh7coFgwAfqWBPBI/Rd4xfV3OwGtECi5Kl26qOAtWAyh7Uo0ABdbSU
	SoFUsMuQOnd6VDItPJDyMYQM0i/+W9N4PSAPwZjEU6Wi4qXfeQIb/3L45iVVyZ4Jt0K68eV0y+9Uy
	Fdi9m5ug==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmZTI-00HXFb-3D; Mon, 24 Feb 2025 15:30:17 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Bernd
 Schubert <bernd@bsbernd.com>,  Teng Qin <tqin@jumptrading.com>,
    Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
In-Reply-To: <CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 24 Feb 2025 14:36:17 +0100")
References: <20250130101607.21756-1-luis@igalia.com>
	<CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
Date: Mon, 24 Feb 2025 14:30:17 +0000
Message-ID: <87tt8j4dqe.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24 2025, Miklos Szeredi wrote:

> On Thu, 30 Jan 2025 at 11:16, Luis Henriques <luis@igalia.com> wrote:
>>
>> Userspace filesystems can push data for a specific inode without it being
>> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
>> However, this may race against another process performing different
>> operations on the same inode.
>>
>> If, for example, there is a process reading from it, it may happen that =
it
>> will block waiting for data to be available (locking the folio), while t=
he
>> FUSE server will also block trying to lock the same folio to update it w=
ith
>> the inode data.
>>
>> The easiest solution, as suggested by Miklos, is to allow the userspace
>> filesystem to skip locked folios.
>
> Not sure.
>
> The easiest solution is to make the server perform the two operations
> independently.  I.e. never trigger a notification from a request.
>
> This is true of other notifications, e.g. doing FUSE_NOTIFY_DELETE
> during e.g. FUSE_RMDIR will deadlock on i_mutex.

Hmmm... OK, the NOTIFY_DELETE and NOTIFY_INVAL_ENTRY deadlocks are
documented (in libfuse, at least).  So, maybe this one could be added to
the list of notifications that could deadlock.  However, IMHO, it would be
great if this could be fixed instead.

> Or am I misunderstanding the problem?

I believe the initial report[1] actually adds a specific use-case where
the deadlock can happen when the server performs the two operations
independently.  For example:

  - An application reads 4K of data at offset 0
  - The server gets a read request.  It performs the read, and gets more
    data than the data requested (say 4M)
  - It caches this data in userspace and replies to VFS with 4K of data
  - The server does a notify_store with the reminder data
  - In the meantime the userspace application reads more 4K at offset 4K

The last 2 operations can race and the server may deadlock if the
application already has locked the page where data will be read into.

Does it make sense?

[1] https://lore.kernel.org/CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14M=
B4104.namprd14.prod.outlook.com

Cheers,
--=20
Lu=C3=ADs

