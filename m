Return-Path: <linux-fsdevel+bounces-49312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9347ABA69F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888FE4E561B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEE0280A20;
	Fri, 16 May 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwFZp2jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7B15A864
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438696; cv=none; b=rCqScBJ5A90lnFodluF4pIntS3yfrx/mRKmH9WUJcx7f55TuxFon7gMqGRB/48b82Dw1avBr9ootEZoeaYbQtIxjoeRtfIbYOYS+PBqbbu8AbNzkP9J1oSb2gbsZjmCvifQIihV7v4FmcFihqLNEta0EAbpWFR5tHwfSesFFGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438696; c=relaxed/simple;
	bh=KMq6BUukZo0kAoMgt5w4V65oLgoQi3P3KnsCUAAzak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOUgHvcqtWDJGQKbJBHZq3/0eaW090ms2P3gIW4BZ8KIBypfqJBaE2JRQVlW39JsAJPtUWRi9l0IsOFOsU9wHQB6u8vIP/I+DwM/Idhr2dbykNgNFPwfUkAJXx8Z/YkAyDDiCUSdZNIDSd99bIw8f7CxdoTQfLTfK0Bmcx83KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwFZp2jf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47698757053so35838181cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747438694; x=1748043494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDBtN3cZgNhIjrSXN0+rBz1jOVzhGU78XDvl2kYwklc=;
        b=UwFZp2jf59+Jm27b4xNjuzRyjTnMnsVJwBHjMxPjgyw+gafJg+IgMLIrCLB/SIbjlZ
         MWHVRI3c2YsTmF5URJ7PHifiLqK285GhupKVhgOSrzf2I0Tht2GkjKVM5Btn83tlBIXT
         +C3TPdElS+73ahZJnW7EoWXdRZ0INvmdZ9zWsqXPWBYgHZPwGTXC//AMhsJH2PqpXpyj
         85RnAcifo3BfKG4NNnXmmyFAEXxRAPN0w5O0Jh0ASBCl5bjQ+Mno5kryl7+Zp9iYUxzQ
         OFjKXgheYap+cVuCj2JY7XvEpuelzyr8Nu8oRWianpvB8j2GIu1cnkY22cr8g0qnB2cQ
         3m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747438694; x=1748043494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDBtN3cZgNhIjrSXN0+rBz1jOVzhGU78XDvl2kYwklc=;
        b=C1ALF+AFH3KKTSPBgNk/qQ5WCOO3XURhblaS+o0PKDgI0EV87pO34kCfKajGSFehrp
         4XMwYxjc9EfVRgnRVvhqkVPuz1f3nTFgdLg8syZmWMMa6i2qKiWWEnkFcwfe+VB4ZdwM
         sqS0iVpPprAQCam6mE+YN+b4mMDeDIawnUo5osjFvhJ3n8F8V9SlV5QyDij5UucmBJV5
         gSe6SsGnJnv4CHj0SLcdjcAFGX4FmGjnfMQ0MoNssqlWhKvWZaZrzEtqaRRRZJ3ehcsK
         8bNFf1Gpxm67JZ8OLECXe07ZjB6/vTinZMeSt0b1SJbkposHZ8heIXQx4SLA+PuQD4Mw
         J80Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc2P2MdmumkZvhFw0GBASwcKIlSxRDRZdfYgAj2U98drZcEPZigdgY3F9FnwPiRONqevwRyVVLpUFjkDQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RVuTfQ7BTZ/4ScqJ0S0x6bLYTouHYfIFJ+d9oSpzCFoc4HNo
	Rt3IlaSdvCzuysqNQ+11uaX1DUapWflcqfQCkEZaH0LaT82AOKiV1IvaoNTksDNlM7G3/5xxMnz
	wqOYUhuSlUj5Qw26FZ1KxUXClL45Sg6vhaA==
X-Gm-Gg: ASbGnct/o+16hcRz6BTSDLByccLmGwmFWeKbsSPCQ/GEpOooQHTLAUewYwGoFUtkEoX
	yAHxp0OLh4+kKf4VLUzu/ktUZ6CbQac0P6DXc9AghfccJpgrpl98G5Qnm8tFhQcabUBDhHrBMjg
	aLEpH/uC3aRwE+ic+VZspM1FgixHSdXz6f
X-Google-Smtp-Source: AGHT+IGRJ6eXwgJFU9jwMJ3mii55WI6phDHu247zUqzUz9bI9NNF/qVYv1EC66cahpzqBYBo31ftGYId0hCBQd0VZe8=
X-Received: by 2002:a05:622a:4c14:b0:494:993d:ec30 with SMTP id
 d75a77b69052e-494ae394332mr98197951cf.16.1747438694060; Fri, 16 May 2025
 16:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
 <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
 <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
 <CAJfpegvayjALR9F2mYxPiM2JKuJuvDdzS3gH4WvV12AdM0vU7w@mail.gmail.com>
 <CAJnrk1bibc9Zj-Khtb4si1-8v3-X-1nX1Jgxc_whLt_SOxuS0Q@mail.gmail.com>
 <CAJfpegtFKC=SmYg7w3KDJgON5O3GFaLaUYuGu4VA2yv=aebeOg@mail.gmail.com> <da219671-099c-49e9-afbe-9a6d803cf46f@fastmail.fm>
In-Reply-To: <da219671-099c-49e9-afbe-9a6d803cf46f@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 16 May 2025 16:38:03 -0700
X-Gm-Features: AX0GCFt8LNbVWE22IWbYrf1F2TiggpdoEOuZPS4VwftgCc1NHRKEOZbfzAM-YQo
Message-ID: <CAJnrk1Z+TK2rtA0TWDN57YM5YDm-gB8m0DJ9YxVtjgmV-8HGLA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, jlayton@kernel.org, 
	kernel-team@meta.com, Keith Busch <kbusch@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:15=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 5/16/25 09:58, Miklos Szeredi wrote:
> > On Thu, 15 May 2025 at 21:16, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> >> As I understand it, the zero copy uring api (I think the one you're
> >> talking about is the one discussed here [1]?) requires client-side
> >> changes in order to utilize it.
> >>
> >> [1] https://lore.kernel.org/linux-fsdevel/dc3a5c7d-b254-48ea-9749-2c46=
4bfd3931@davidwei.uk/
> >
> > No, that's not what I was thinking.  That sort of thing is out of
> > scope for fuse, I think.
>
> Yeah, I don't think that is what Keith had done for ublk either and what =
is
> planned for fuse. Added in Keith.
>
> >
> > Hmm, so you actually need "single copy" direct write.
> >
> >   - there's the buffer that write(2) gets from application
> >   - it's copied into server's own buffer, at which point the write(2) c=
an return
> >   - at some point this buffer is sent to the network and freed/reused
> >
> > Currently this is not possible:
> >
> >   - there's the buffer that write(2) gets from application
> >   - it's copied into libfuse's buffer, which is passed to the write cal=
lback
> >   - the server's write callback copies this to its own buffer, ...
> >
> > What's preventing libfuse to allow the server to keep the buffer?  It
> > seems just a logistic problem, not some fundamental API issue.  Adding
> > a fuse_buf_clone() that just transfers ownership of the underlying
> > buffer is all that's needed on the API side.  As for the
> > implementation: libfuse would then need to handle the case of a buffer
> > that has been transferred.

The issue is that there's no good way to transfer ownership of the
buffer. The buffer belongs to the "struct fuse_buf" it's encapsulated
inside. Libfuse passes to the server's write handler a pointer to the
write payload inside the buffer. If the handler steals ownership of
the buffer, the struct fuse_buf that buffer is in needs to set its
->mem to point to null. The only way I can think of to do this, which
is hacky, is to add some "bool buffer_stolen : 1;" field to "struct
fuse_file_info" since we pass "struct fuse_file_info *fi" to the write
handler as an arg, and then in  fuse_session_process_buf(), set
"fuse_buf->mem =3D NULL" if fi->buffer_stolen was set by the handler.
This changes the semantics of the fuse_session_process_buf() public
API, which I don't believe is backwards compatible. The caller may
supply its own buffer to fuse_session_{receive_process}_buf() and then
do whatever it'd like with that buffer afterwards (eg reuse it for
other data or dereference into it), but now that is not true anymore.

>
> With io-uring the buffer belongs to the request and not to the
> thread anymore - no need to copy from libfuse to the server.

I don't see how io-uring helps here. With io-uring, the ent payload is
now the buffer, no? If a thread still needs that payload to process
that data, it can't still utilize the pointer to that payload while
allowing that ent to be used again for another request, no?


Thanks,
Joanne
>
> AFAIK, mergerfs also uses a modified libfuse that also allows to keep
> the server the buffer without io-uring. I just don't see much of
> a point to work on these things when we have io-uring now.
>
>
> Thanks,
> Bernd

