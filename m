Return-Path: <linux-fsdevel+bounces-63621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7982CBC6D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD37406B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE2277C9B;
	Wed,  8 Oct 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKbQjfER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024672C031E
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965285; cv=none; b=Lx8oqywDREA+ForG7uAURLNaPCMQIlTD4m90HzkIIVz33QgNDqgJtuuk+Nv5981/UfKf6qVoHnGXCc8RbCSyQk6vfNwlebWZyDtIcPKXhCPeeyi1rzcP1BuaQ1GwtsRjh6zrYnQQozntMHklLd7Bg6huEBBliQmXAth7Tpeaxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965285; c=relaxed/simple;
	bh=jVLivBl7pCfYDlt8EIUEeHcqHw9OvdE5U9UTtxMzJsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3NMP6RGE/b4N2kAOXuPNCD2kc5FN0F12WGDgoGA5ZTjKWRToQaZNz6PTDtFaMfIHKdFCDXdZnKlnt1W85rqemTCJegqk40rpbpAc3KmACBn7Q+BA6rWKevxeF0nfW6ldV6E0jewGHr6+1mXxmQgn4FqZFSmwqCrOQh7R9hdcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKbQjfER; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-635401a8f5aso506154d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759965283; x=1760570083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFbI6yfd+yg4dKJ49IX+g9zgZu5r7fNCwf9LHJwcps4=;
        b=lKbQjfER508S9eSw/VL2PHKa7VZzMa42jRWBQKUz2/IEgvOUwm3IglyJrsTXSnvw5w
         HCtYoIXpBBer1vj7G+gmohqwEARI6kkpZ9HoAvjTQByuIYeFuAZ+L9mlcce0moM/F6bx
         i8bS73QJ5/N5Vwv7KgtjsHW4g8nNqt90vwB2QzUojDijryQP58mzTSAsgiMn72Y+Q+K2
         EdyXygStc5ZmXdUaG9x2DLvzCBIDr0qBR2WKanRmoj1qbj0QDb/ztdq6E28t5QMSAaEp
         0r/DuSmVt3366ULvNeJTblh7cCJcmpCHBahRb9PM9F0w1OlbagIreu/4uNvqZoly9AM6
         LkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759965283; x=1760570083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFbI6yfd+yg4dKJ49IX+g9zgZu5r7fNCwf9LHJwcps4=;
        b=C5IzkRtAjAYQeQpbA5J9NCgWe/1BuQvPEuW9eCfv0bTtb+G0LEyu/0jseNkxsuxfDU
         Vk05lP8ec+dyd2mCop24PrTKTro//PZRn1aS97JfIQJftyc7kECKI6w8b9+Zm/fVe3Ol
         wFe/iy8VJDU4d7/qT31JiqqPPqmMF6wqT3ag3wxu8xgX6iFGhHl/meDnvpjHfoDIr+8m
         VE0PGDEn50xhXpgUxDbeRC6sEsbmPS6UYWs2ya2FR61zsIJz18mb//xVN3XBNE3ec0iH
         kRqM7fK5lQyZ/NL05WVws6PQNmjiK548wuVELRU/DCzWrH5rc98g4vpmWv+oeWuBdx7C
         C+xg==
X-Forwarded-Encrypted: i=1; AJvYcCWS0fI/EWlUZlAm03BlJooFqyqZVFlzl1wC04ua7ryi4NrXXJbwLdIpLft/cyiosa9Rm1cVkzoh5KHgjlSJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLhxuxlLc1pMqb8XPTcY+aOtweJsVfuBLEv/JtsPFVO3eiyp1
	UbTjbrh9alqNPO2ZMrHLRzFqvqFPpgy010jcdJFCnlP1XSNQ9a9YVikG9uKstenknVzXQ0qxuqW
	5ntpRohTVQYXmo3D5jliNN6BFoXUJfis=
X-Gm-Gg: ASbGncu2EjDRX6q7KlgV/mZWxAAufJGmoH8JoJeh9dap0/+cbpUesC1GNcWQz4JNOpf
	bKNBSsS3C08v4t3glwi1zm0biAtcxwRWvz7MXccA6cWn0CeAUhKcqulNIecZw3iDGmjv5sx9dk2
	UIzTijNE9+ymT+eyR8Gb1uLQ4iVL745fNbE5t90whlEMjpfbyzIlkMA4TGhXFDgo2res0AQqAa2
	vwUde4vnq/RpZAbWvQ9o4/zr5EKBVuUks25k8aXwZCtI/F6f4ssbhbs57XDHRUoHeU=
X-Google-Smtp-Source: AGHT+IFCEYGN+m/q1FKnlQZmsAbbOkqHlLXzoklzuXn/5KxWd8KUCLsi/0JemznMrYIDBz4LiBajWdwhGS2HtwHJwdw=
X-Received: by 2002:a05:690e:5ce:b0:62a:38ab:fc31 with SMTP id
 956f58d0204a3-63ccb884e07mr3868762d50.14.1759965282757; Wed, 08 Oct 2025
 16:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121100539.605818-1-jimzhao.ai@gmail.com> <20251007161711.468149-1-JPEWhacker@gmail.com>
 <ywwhwyc4el6vikghnd5yoejteld6dudemta7lsrtacvecshst5@avvpac27felp> <CAJdd5GY1mmi83V8DyiUJSZoLRVhUz_hY=qR-SjZ8Ss9bxQ002w@mail.gmail.com>
In-Reply-To: <CAJdd5GY1mmi83V8DyiUJSZoLRVhUz_hY=qR-SjZ8Ss9bxQ002w@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 8 Oct 2025 17:14:31 -0600
X-Gm-Features: AS18NWAhRXVS4bQVIwtYDJ5b-jz2OHqNOhjsxYSwMfqqDJlxC7ftCg-fC_O8rrU
Message-ID: <CAJdd5GaQ1LdS=n52AWQwZ=Q9woSjFYiVD9E_1SkEeDPoT=bmjw@mail.gmail.com>
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
To: Jan Kara <jack@suse.cz>
Cc: jimzhao.ai@gmail.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:49=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> w=
rote:
>
> On Wed, Oct 8, 2025 at 5:14=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > On Tue 07-10-25 10:17:11, Joshua Watt wrote:
> > > From: Joshua Watt <jpewhacker@gmail.com>
> > >
> > > This patch strangely breaks NFS 4 clients for me. The behavior is tha=
t a
> > > client will start getting an I/O error which in turn is caused by the=
 client
> > > getting a NFS3ERR_BADSESSION when attempting to write data to the ser=
ver. I
> > > bisected the kernel from the latest master
> > > (9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below)=
. Also,
> > > when I revert this commit on master the bug disappears.
> > >
> > > The server is running kernel 5.4.161, and the client that exhibits th=
e
> > > behavior is running in qemux86, and has mounted the server with the o=
ptions
> > > rw,relatime,vers=3D4.1,rsize=3D1048576,wsize=3D1048576,namlen=3D255,s=
oft,proto=3Dtcp,port=3D52049,timeo=3D600,retrans=3D2,sec=3Dnull,clientaddr=
=3D172.16.6.90,local_lock=3Dnone,addr=3D172.16.6.0
> > >
> > > The program that I wrote to reproduce this is pretty simple; it does =
a file
> > > lock over NFS, then writes data to the file once per second. After ab=
out 32
> > > seconds, it receives the I/O error, and this reproduced every time. I=
 can
> > > provide the sample program if necessary.
> >
> > This is indeed rather curious.
> >
> > > I also captured the NFS traffic both in the passing case and the fail=
ure case,
> > > and can provide them if useful.
> > >
> > > I did look at the two dumps and I'm not exactly sure what the differe=
nce is,
> > > other than with this patch the client tries to write every 30 seconds=
 (and
> > > fails), where as without it attempts to write back every 5 seconds. I=
 have no
> > > idea why this patch would cause this problem.
> >
> > So the change in writeback behavior is not surprising. The commit does
> > modify the logic computing dirty limits in some corner cases and your
> > description matches the fact that previously the computed limits were l=
ower
> > so we've started writeback after 5s (dirty_writeback_interval) while wi=
th
> > the patch we didn't cross the threshold and thus started writeback only
> > once the dirty data was old enough, which is 30s (dirty_expire_interval=
).
> >
> > But that's all, you should be able to observe exactly the same writebac=
k
> > behavior if you write less even without this patch. So I suspect that t=
he
> > different writeback behavior is just triggering some bug in the NFS (ei=
ther
> > on the client or the server side). The NFS3ERR_BADSESSION error you're
> > getting back sounds like something times out somewhere, falls out of ca=
che
> > and reports this error (which doesn't happen if we writeback after 5s
> > instead of 30s). NFS guys maybe have better idea what's going on here.
> >
> > You could possibly workaround this problem (and verify my theory) by tu=
ning
> > /proc/sys/vm/dirty_expire_centisecs to a lower value (say 500). This wi=
ll
> > make inode writeback start earlier and thus should effectively mask the
> > problem again.
>
> Changing /proc/sys/vm/dirty_expire_centisecs did indeed prevent the
> issue from occurring. As an experiment, I tried to see what the lowest
> value I could use that worked, and it was also 500. Even setting it to
> 600 would cause it to error out eventually. This would indicate to me
> a server problem (which is unfortunate because that's much harder for
> me to debug), but perhaps the NFS folks could weigh in.

I figured out the problem. There was a bug in the NFS client where it
would not send state renewals within the first 5 minutes after
booting; prior to this change, that was masked in my test case because
the 5 second dirty writeback interval would keep the connection alive
without needing the state renewals (and my test always did a reboot).
I've submitted a patch to fix the NFS client to the mailing list [1].

Sorry for the noise, and thanks for your help.

[1]: https://lore.kernel.org/linux-nfs/20251008230935.738405-1-JPEWhacker@g=
mail.com/T/#u
>
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

