Return-Path: <linux-fsdevel+bounces-58324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A987B2C987
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30D83B52DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD6258EDD;
	Tue, 19 Aug 2025 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwb1rpT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779825742C;
	Tue, 19 Aug 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620553; cv=none; b=lh3g6LNdIzFMkpowSAcdu8AdCC+K7aHCueLACx4qO8pEN7kVNlpiOZ8mL4cVLcpZqI0ZQXfTVKIIM94zAkE6YU7pUeQ60sEum//S+uGMXIkkCDuoLwrHR8lcKdrRszLLEuMSxzhze5fRa1R5dWvkijln+Zpn/J0vVSsvkaU44G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620553; c=relaxed/simple;
	bh=DK+G00MTC6IEA0l14sAqCIguKVjz1FSApDz4hMHCrRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIBtFxuNXcZmD6jKurwKR0lXQJZAKjATDAEB+w5KR/wx0mHxgjyx7icvEohGZ14Ax+OdGI0Hhj1BgyX3v4Yn9j5rEjyvbqyfN60HSbCM1s0g6uXL9Ei43cvn/eSTufYoaLoH9YZ2VfKzVAhafnH7r+hB7oO0PDUoNYpNF2Vky14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwb1rpT4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a9f556d65so43160106d6.2;
        Tue, 19 Aug 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755620550; x=1756225350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phTspbikDXoNyfPxHuBq2N0+fGYwriMvgatS5/gXfiI=;
        b=Xwb1rpT41zlevZMKb3VBUFe0YgGZ53y1uW6mMqR7kX2rarFZTZWgdP28NV6ZnLGR+8
         oc3kApkpMC9IF2D34iju/vw0v2sKWcrQlKvjpZ7+2p5baoKPwqHyWp+SCsiUBA+kXCb8
         8aULyAaQzgvcdqzkZXtEULnbrY8eGcUmplUJioFhiwBnXmhucn3OZULMT6TV6+ujAvZB
         IbOliVpxvz7aA3N7hteUYbVLs3hBLmMWOApjN0sRgFdy9wYIMrVeuOgKDU132l+pS7P8
         9c8VdsirMeuzmTgnNhwouwaPbJ2B5RXS7sbMDaB+Cts8SlVwyEIURsgc6JwLoWYMcf0B
         IB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755620550; x=1756225350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phTspbikDXoNyfPxHuBq2N0+fGYwriMvgatS5/gXfiI=;
        b=ZyeOu0N7xxdZEcBP9xGrqPpIMPtl8ES3qXsjrIwvurPyLCf9GhMH4txAOzocyVji7I
         CAgM8Rh9YYIJqWaaHzKj3r3roZcaGS0IoCwCFhfW+WY3yzBwuYI+CHWTIP7nAotMFk1O
         MLzjTjIKKmK0DdKKb7JJkk3SmkaEtWYjAoRVFvC+uWmpdJTsKO0JWeUU38eORd2SBR1x
         sTnzdu+ifGbDucWinfVDBNkFc/DZP/4g49rbgg9IHmRlA+2s5WDb390bxz0htD1IOB5x
         uraUfGRvHLb4A4P+kvSSNaKdSUAMghsjPFBpp7AvutJBjdE4G84JC1aBWX6jZuTGrQAK
         aTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkEWvMbiH8UJO2S/+C2BI2RCzu8Whkz9srjPBHVPlaeRJcJJOMvzxyBFrgrq+3RXDDrHanajYh@vger.kernel.org, AJvYcCV6O0bvoJqgxSg5mpij70p38nh+YQZYqhv6y8Jha4iieR4R75BQWfEK0RX72Zv7uVkg4+eLVc2fjV63UTU7@vger.kernel.org, AJvYcCVyNybhSBKWblx+nzPfuPi7N42OnkIAw7Aq9tDzaxPO8LtgwzsDjidpl7alWV3OtIIrEvc+75Ne5LIbDafMbQ==@vger.kernel.org, AJvYcCWHLnhuLjNV3KLRaFViIcm1zw7jbNzcrLsHdsufwyIyxFe2AqnqMj9Sc2bjnuLBV1+BsbTOsY0HGlfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyz7oJPiNYIK0DH8dYCo0FU9ENY7zx7L/rovLWOeMci9BmHxD5
	KG/k4tZhGCdL+FnLEHOOrSX5A876ucdImImGFugVnqxBq3m+qeiAAmOzFlk3m1gnHE4ZdllMbcZ
	HMY6Ut1TUaXDIzKSCRPkkjQx0LtplmQ4=
X-Gm-Gg: ASbGncsWVPFUaKzcvV5A6SJudMm2RU+UUn9wvaNLigUE7l7ZR8yybNW4SKxFStdtfFG
	2t/ysgtT6rJAVX1MDYFZIi002YV501jiF/B4ncz3U39G3AecigiL3/axS272Ad3JA7HdUCNq4bj
	W8tINsXTD3c8srOMzBbLy/CJKJLlQAspOzaLjtMemVV1YUEiOD+SpwvwSILRW5z/1XkTNyIwNmh
	u4CfZIDqfwjRTdVzM4/kG6CSSpVJKcy90ixj42ZjJxRN3+niJU=
X-Google-Smtp-Source: AGHT+IE5gDw665mp62jMJfp1L2Q9tLdJaFXr4f6/P9JWF9HBc/OxhbBB+bGeSjIntXuGiItqxA4ZmCiHgjWs4ESpHDA=
X-Received: by 2002:a05:6214:20e7:b0:709:d70e:adcc with SMTP id
 6a1803df08f44-70c2b67205fmr32393756d6.15.1755620549650; Tue, 19 Aug 2025
 09:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1977959.1755617256@warthog.procyon.org.uk>
In-Reply-To: <1977959.1755617256@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Tue, 19 Aug 2025 11:22:18 -0500
X-Gm-Features: Ac12FXxwk1pb1bwCRB51KO_sGuoA0z2A_s1GsLC0-6GsbrD-TooPyfXCaTpQPGQ
Message-ID: <CAH2r5mubYwUSF-JjRyb-zdLJjDQqKG+nAz6sqjF_RHdBWXBNRA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix oops due to uninitialised variable
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Tue, Aug 19, 2025 at 10:28=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Fix smb3_init_transform_rq() to initialise buffer to NULL before calling
> netfs_alloc_folioq_buffer() as netfs assumes it can append to the buffer =
it
> is given.  Setting it to NULL means it should start a fresh buffer, but t=
he
> value is currently undefined.
>
> Fixes: a2906d3316fc ("cifs: Switch crypto buffer to use a folio_queue rat=
her than an xarray")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/smb2ops.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index ad8947434b71..cd0c9b5a35c3 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -4487,7 +4487,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *serv=
er, int num_rqst,
>         for (int i =3D 1; i < num_rqst; i++) {
>                 struct smb_rqst *old =3D &old_rq[i - 1];
>                 struct smb_rqst *new =3D &new_rq[i];
> -               struct folio_queue *buffer;
> +               struct folio_queue *buffer =3D NULL;
>                 size_t size =3D iov_iter_count(&old->rq_iter);
>
>                 orig_len +=3D smb_rqst_len(server, old);
>
>


--=20
Thanks,

Steve

