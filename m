Return-Path: <linux-fsdevel+bounces-64726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE8BF2919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2006E46070D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165233030D;
	Mon, 20 Oct 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeKcGWor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48432AAD6
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979537; cv=none; b=QRFfS0aNkSNXXIeA33x5MLKq1gAwEjYUdY/Tbdh/mjs2piXqLQUY0Ot88pjPVco3Jw7/FsmOvPx71baH2uDODMvpDrSBKO9qkP0uVFYHsgjSnYJmC/HmWD9nyjDI3LJ+ZX9+9iihVXxUgHmzC6DThgqpRVDkAD4oiVPRAQiPN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979537; c=relaxed/simple;
	bh=4bQ5dGdI37+mKtm3nyfRFem5GeQNndtwmqJv6QZC4X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9PWi9uz+qmx+qbNhecAfStfFHh08FT0GcxjSV+vH3ciZhU+h7ugzkVNwQw0wkngnp7i/6v+i404LWfH+Efd6zA7wcW1lP3NJcAH2N5VubYnQYPc5C1fr+Z1Jgz6K7OzbO2NQUWFE3UwtLnqW4M3E9fM56eT7e/UwspgCKhoe18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeKcGWor; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87c167c0389so74437746d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979535; x=1761584335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgsdylpKUJQfQkBSHP7xg/RD79zsocybv4Uh09OP8R0=;
        b=MeKcGWoro02/4Eg8K9LVgB9EI6XZMMdkvBezzHR9H/bq9oKo86d4lpqZvjhBJ4YivJ
         NxtjUsp/enHfGZ84xtDNbbxfwcKknwJn5Io2fXOOnH0rQEegINY/LgyoufTcPT/0xokX
         0GG2Xwx4aHoFNuKl4RjCSkjLMjxLPsafu7+uuLzGA2Mnqq5V1gODvnaZm7eAg4CSn92h
         d1V6kLk1YSbTQ3dGYsWAyGgkfgscH+9/izwj+XbtiwbeCp93/VZj0FOQVlqfghWzBp8/
         Brv5Mq9fdgx7dRk67pWdFRh4Z64J1UTKhYhxNP1DBy7iRKGWRItJQnbawzA5fE6IZw/e
         A3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979535; x=1761584335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgsdylpKUJQfQkBSHP7xg/RD79zsocybv4Uh09OP8R0=;
        b=u5oTYfw5eUSlAvJ4irODneHmn6ZImvVR3tL8COJXPRZOyQj5qfquuQ0ezxq/CJKXag
         O4RZTGM8/RQxIKfsX4QYGGKvq2wQPo8Q4cf36QIEsDngjpgnEZqEMABvej5th3rEShdy
         l50+PjbDyWUqEYdjjC5QLOGMH60tvIv99CoGNqamNmrTzWGqWFOR8eFZHhbO/FyUyyDP
         2qmVvakxM/QrwKbCxzQZpg60LMdn5TbYS9tGXpAuY6VXYMr70MUdqW3IRydbbFfAFao1
         TrR8NmSJ7TA4zbHp5L7iUJ9SydEGy+noPolk6HGE73IfDB+UWGhxTATbXs8/ozsFd4rc
         iQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVogk2YFlX+Mb67DEErAX6e4kGtVk8q6NA5Dm/zzZKNZnY57FMkUe5oG74etgKLSGbfIbyKakmYV5721Hu1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyco1aAyiPvPDtSqqHWfWUNljnSm1kwjBVlZOUWeyT5Ncf3RX8f
	JcjSIhaK267vxNwiGUTpS6rIZKiEy8dyi4n3FwZ3op3tDlSNxMSIrf5hwpE1mQjc56/2jBqKZPX
	CdZ6k+40t8Gq4B1JQsrJjaaD11N7JMog=
X-Gm-Gg: ASbGncuN36x5Tbzf5GD7iLv2v3gD+uT2KjIaZCMdq1kjHRqfUVhS+p/Jr4ZpSlJeW19
	lTV4+/FSZAxA6DzD9ywjtzZIJ9cQxR2c2nk1hBCGvKgk4ZxOiB4Z8lEW3xxTnuYeqfykC7z0pxt
	hE2mu0gsUJ+LqHypeaCyjLDnE1HakZflVjS1rq3OdFctMFwgIQwUdNRtVmUXJ2jivf1RaPLhUPm
	fCWtZS6Hjog1naQ0Pza7VsKKJ6d9dIp1vr8EJR49fVbHcTg3hZX0VNUg0dZE3kFMC4MGEN05Iu9
	2dUboXKemj2HCp0zpd1p+PuujpB8ej8YVuI5IcLVP9Q7K1Y5f4v+9B938NUogCfkGHRVyy0k0pi
	CYhwCClyw10cAvw3lOIFSX3z2RmrCUkXvOJTC8++aY6Au06l7b5HtWMrmnEDlvz6QPNfqXISlCK
	XhjlcDeoX2aNu9sO2SC3n1
X-Google-Smtp-Source: AGHT+IHbXFlV0wP4FY/uwKW9bu6aO+4kvfoixtYtWRosnhokGbPU8PEqiSlE80WY+IOyu6/479D4KFoQCxyPQIW+q5g=
X-Received: by 2002:a05:6214:1c09:b0:87c:dffa:3291 with SMTP id
 6a1803df08f44-87cdffa3562mr107155826d6.43.1760979534432; Mon, 20 Oct 2025
 09:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1006942.1760950016@warthog.procyon.org.uk> <vmbhu5djhw2fovzwpa6dptuthwocmjc5oh6vsi4aolodstmqix@4jv64tzfe3qp>
 <1158747.1760969306@warthog.procyon.org.uk>
In-Reply-To: <1158747.1760969306@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 11:58:42 -0500
X-Gm-Features: AS18NWCQzB81UKEefQM5CmQBxxIlIJnyDPWcumyA1Qwmkt85JWSyfbkHNlFn7yQ
Message-ID: <CAH2r5mvOwmdcP_5kjC+ENgtooi06AuPvwBXrMnZrfy7_poAoFQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix TCP_Server_Info::credits to be signed
To: David Howells <dhowells@redhat.com>
Cc: Enzo Matsumiya <ematsumiya@suse.de>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pavel Shilovsky <piastryyy@gmail.com>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	Bharath S M <bharathsm@microsoft.com>, Shyam Prasad <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:08=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
> > Both semantically and technically, credits shouldn't go negative.
> > Shouldn't those other fields/functions become unsigned instead?
>
> That's really a question for Steve, but it makes it easier to handle
> underflow, and I'm guessing that the maximum credits isn't likely to exce=
ed
> 2G.
>
> David

Interesting question - I do like the idea of keeping signed if it
makes it easier to check
for underflows but IIRC that hasn't been a problem in a long time (adding P=
avel
and Ronnie in case they remember) but more important than the signed
vs. unsigned
in my opinion is at least keeping the field consistent.

I have seen a few stress related xfstests that often generate
reconnects, so we may want
to run with the tracepoint enabled
(smb3_reconnect_with_invalid_credits) to see if that
is actually happening (the underflow of credits)

I also was thinking that we should doublecheck that lease break acks
will never run out credits
(since that can deadlock servers for more than 30 seconds as they wait
for timeouts), even if
"lease break storms" are rare.   Maybe we should allow e.g. lease
break acks to borrow echo
credits e.g. as minor improvement?

--=20
Thanks,

Steve

