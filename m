Return-Path: <linux-fsdevel+bounces-45014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F7A7029C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC75E1890633
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846C25A341;
	Tue, 25 Mar 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1K15xv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C125A333
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909697; cv=none; b=noYnE+yQcClwJXguuwSebDGjIGf/DTHTyqFD7Dn2vW4TehweAYkueTYV8SGgUe5C5FYufLKXmZ0+lfcXFtpwGmMh01z4LSWMBPfIJigw5pVhSm0vzPoR4jMj0DFTe94Rkz9Q69lBVeVWB+0kthGsvh9nQkORB74C/IxAwy0mHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909697; c=relaxed/simple;
	bh=AIrZ+t0ZPF/CJpRsjSGj2FJa/nkqq8a7+rS02E6cQ5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K0zGpcY2PUjhy9i6hbnGHZ7+dxqMpvEjDrllv8Pp0oiTqce74ieUBDIn+LwKLDc3pxQbzMJKjJpawEr5plOHJoPR8DmY681uydNA2fIHnoNwZqKSqz+hz3t1PNLc82TM2zwNClgJplDmAdzLmSntFtxaf7secSVL8zFLO2wup+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1K15xv+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742909694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMT9dqnUN+LvjvaX1meRRVuIurP6ODEE69dehAYE8vY=;
	b=e1K15xv+r1oo6xsd3lO6OZTQY7YSqwr/oIbu7NV/zz/QtNkFjv4UZwckfHEZEebRn7M9L0
	jY+QzfTo78KW3ZEeucbmZWjmy8j6v8h8u7xFzDkW5iMkKQe4kiGyl1SI8tAbG2RCXNGdpX
	NRDeMIPk5vt6ydLajzxJZk7cV3xaOFk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-ycbvDG2_NJe2jpxIei4lZg-1; Tue,
 25 Mar 2025 09:34:52 -0400
X-MC-Unique: ycbvDG2_NJe2jpxIei4lZg-1
X-Mimecast-MFC-AGG-ID: ycbvDG2_NJe2jpxIei4lZg_1742909691
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 691ED18EBE8A;
	Tue, 25 Mar 2025 13:34:51 +0000 (UTC)
Received: from localhost (unknown [10.45.226.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79B7119560AB;
	Tue, 25 Mar 2025 13:34:50 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Miklos Szeredi <mszeredi@redhat.com>,
  linux-unionfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  Colin
 Walters <walters@redhat.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
In-Reply-To: <1b196080679851d7731c0f4662d07640d483be4e.camel@redhat.com>
	(Alexander Larsson's message of "Tue, 25 Mar 2025 12:18:32 +0100")
References: <20250210194512.417339-1-mszeredi@redhat.com>
	<20250210194512.417339-3-mszeredi@redhat.com>
	<CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
	<CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
	<CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
	<CAJfpegs1hKDGne7c3q4zs+O5Z4p=X3PK8yFXhyCY2iAjs4orig@mail.gmail.com>
	<1b196080679851d7731c0f4662d07640d483be4e.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 25 Mar 2025 14:34:48 +0100
Message-ID: <87frj1fd3b.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Alexander Larsson <alexl@redhat.com> writes:

> On Tue, 2025-03-25 at 11:57 +0100, Miklos Szeredi wrote:
>> On Tue, 11 Feb 2025 at 13:01, Amir Goldstein <amir73il@gmail.com>
>> wrote:
>> > Looking closer at ovl_maybe_validate_verity(), it's actually
>> > worse - if you create an upper without metacopy above
>> > a lower with metacopy, ovl_validate_verity() will only check
>> > the metacopy xattr on metapath, which is the uppermost
>> > and find no md5digest, so create an upper above a metacopy
>> > lower is a way to avert verity check.
>> >=20
>> > So I think lookup code needs to disallow finding metacopy
>> > in middle layer and need to enforce that also when upper is found
>> > via index.
>>=20
>> So I think the next patch does this: only allow following a metacopy
>> redirect from lower to data.
>>=20
>> It's confusing to call this metacopy, as no copy is performed.=C2=A0 We
>> could call it data-redirect.=C2=A0 Mixing data-redirect with real meta-
>> copy
>> is of dubious value, and we might be better to disable it even in the
>> privileged scenario.
>>=20
>> Giuseppe, Alexander, AFAICS the composefs use case employs
>> data-redirect only and not metacopy, right?
>
> The most common usecase is to get a read-only image, say for
> /usr.=C2=A0However, sometimes (for example with containers) we have a
> writable upper layer too. I'm not sure how important metacopy is for
> that though, it is more commonly used to avoid duplicating things
> between e.g. the container image layers. Giuseppe?

for the composefs use case we don't need metacopy, but if it is possible
it would be nice to have metacopy since idmapped mounts do not work yet
in a user namespace.  So each time we run a container in a different
mapping we need a fully copy of the image which would be faster with
metacopy.

Regards,
Giuseppe


