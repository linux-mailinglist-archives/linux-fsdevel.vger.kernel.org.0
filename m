Return-Path: <linux-fsdevel+bounces-42438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB8A426F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA1A3B3112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00725EFBD;
	Mon, 24 Feb 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="Yugd5ZV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A525EFAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411940; cv=none; b=qiC2Hx27TuH+Q0AE1Trb3UChKchv4xjNvRPGYuXU5pj0bBYs8sp9qPsopRaBM0v5gSkhRLE5hOKodvy2/JohDSSF2W0s6BPEu+yDLbv7o8LZ828mZCZoB8A1G+PVMZ9POAR7WLFq78LM2HA1Q9oddW3uHYSlaB8GsyQXCpcgxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411940; c=relaxed/simple;
	bh=QR8PQ2mLsQpUR1F0fq8t6LeA0WbrKQ2TFmOHo4xz3F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAcdKLmOBnPqvhnBvbOL45PonVgaByoHsZZrToV5d2sf3iG24WiSFS0iykQXWqfaoRD2TtFe+zqqxu/UptDkJs5JSxbKNCRdMdEnuSAhRzOc1lFhd63VyR6tZiSzWl1ZtE4SveYrcoFWelivIUw598Py9SN0PbGvKjsGrDRjZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=Yugd5ZV7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc6272259cso7372530a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740411938; x=1741016738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vpFPjAJvV1xY/hqE7tYkEGP8ugx8Y4/2E/Q9/wCmV8=;
        b=Yugd5ZV79CI63ZzMcsB6uxbKKBpJC60ivCFpRse/Xso+Y0KDYMfDVDp4lAh/ZRSJTT
         YpBJgCS6qpdr1y7g9yZZwYPPhLyKFK7Vi7njJIJfdm6DQPJEliuwBKqMLKtIftTAAg7v
         rQWfMy6i+kecNIUhnWet+GYCx8a2pcngGD0lmvD5iqebmITIm9+MK5O+AnInaQuqQHIS
         t1KjUdDIPYto8hFfRHZdtoLJhHnomPwDUbFHZXKa9uHR6W7NP+TueShtMpTX8xEg2Qkw
         oK9uxHX7xKAD+2IPX46ruh1GZAtTBLtUuD8sI+KT0P/jMWnwQrVbuY+3R8wrW+RMVDMK
         cIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411938; x=1741016738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vpFPjAJvV1xY/hqE7tYkEGP8ugx8Y4/2E/Q9/wCmV8=;
        b=gOrahU8PxI8LcIAW1ahhVjsAjW51AsrAbq2X+Q6qMZYacKTRVHcDDQYqB7WKFkrJR7
         VIVcIrKmmAud0sqent54ISqWDOQJiIHgQrmd8zTU1QbHPrvB0jFW4tvOJLil3DeA5Gxt
         h3jO2eaz07gsd4LlhjNGM6DxqfA3WaI1KkdUjUpngQnWgSJD6y2gWXRysbG7fKbT2X0z
         f49RENfMfdGSCXwQ3/AWa+9mLh5vUHV8/oOs1vr2NDbsXIkDYEEZJzVXtfO9zaA3hm4g
         AR/gNLh6oINQTrHvMj4UGkHeQYBo67esy3fbYzPeqmlgVwmJBPiJBSLXXv8nHsC4yP4P
         +a7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFXMaMKVNuWdnpBV5Idg/2bnbB6XQ5KnJygmr3FE8ge32lRupqwKjz9hqnKZweHHI8CniNRxwiFSbHqBF/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PYTsgT/3zGGjzMuDdr3UUgbUSbCekwZT1IPp2lAs9YsWwl3x
	RrTg72GoVMSDpLU798AwcV/zfFgfrW/O+io1j5Zq0JcF4KGixFunGWk4VfYMMjPXsm+dgALKFFE
	43THmJfQmXA/lFvx9cUO208QzH5j1/Ga+1zLuf1I6noYtJmpx66TubBjA7cS5PlQUrii0nKB2hv
	Dn1OTE/8vJLE+ciuzriy8aALOpus/SYZQAxK/eVhkjPJzl09M2iXH2fS8jBvEtG8VZjkNMByHow
	/CEP5nevjpnIz2OIp3EP3I0oyZMUkxN7O4Wapq+vuIRIEv87Jychfo/M7KxTkFty770N19mkiwk
	N0gKClRCGfAwfwH3fzqSvm6EvbbotsdjvyXGOdCKkyHcVyez0AwIfQGjtxFmVyFfEBDaRneTrKH
	MX8wtsdldnWdkz985hzKYx5W6
X-Gm-Gg: ASbGnctP+8DLkCcz3xzkrkyv9uPazXsFjoZwOgOA3LrkOMlBPPdOYwG9papjRpVuPY0
	RRpKHjkK/1NSgYYGlmtuLfq5j9uYjiDy9I06pLTiCDTZ2NQFC3eYmEEFCC6U67E3MNboOKtBHKX
	EtFvZ3/9dPjo5izO0Wx3v9zA==
X-Google-Smtp-Source: AGHT+IEcQNiAKMUbPh0M58vsweOlxgosMhBo5YTURrJtkfwHfEjps5PLHRpPddIOGjzbuxIf2pQa9/eWZhn97IwVteY=
X-Received: by 2002:a17:90a:d60b:b0:2fa:e9b:33b3 with SMTP id
 98e67ed59e1d1-2fce77a646dmr21092693a91.6.1740411938036; Mon, 24 Feb 2025
 07:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org>
In-Reply-To: <Z7yRSe-nkfMz4TS2@casper.infradead.org>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 12:45:21 -0300
X-Gm-Features: AWEUYZl1jANUANFo8W3Lf3P8R8iIFWcreRO9Y0ZcM5Jd0irI990vkN6P7vCMcpk
Message-ID: <CAKhLTr1s9t5xThJ10N9Wgd_M0RLTiy5gecvd1W6gok3q1m4Fiw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, djwong@kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 12:33=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> > On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote:
> > > +           if (err) {
> > > +                   /* Prevents -ENOMEM from escaping to user space w=
ith FGP_NOWAIT */
> > > +                   if ((fgp_flags & FGP_NOWAIT) && err =3D=3D -ENOME=
M)
> > > +                           err =3D -EAGAIN;
> > >                     return ERR_PTR(err);
> >
> > I don't think the comment is all that useful.  It's also overly long.
> >
> > I'd suggest this instead:
> >
> >                       /*
> >                        * When NOWAIT I/O fails to allocate folios this =
could
> >                        * be due to a nonblocking memory allocation and =
not
> >                        * because the system actually is out of memory.
> >                        * Return -EAGAIN so that there caller retries in=
 a
> >                        * blocking fashion instead of propagating -ENOME=
M
> >                        * to the application.
> >                        */
>
> I don't think it needs a comment at all, but the memory allocation
> might be for something other than folios, so your suggested comment
> is misleading.

Isn't it all in the context of allocating or adding folio? The reason
behind a comment is to prevent movements in the future that could
cause a similar regression, and also to inform the poor reader that
might be left wondering why we're converting -ENOMEM into -EAGAIN with
FGP_NOWAIT. Can it be slightly adjusted to make it more correct? Or
you really think it's better to remove it completely?

