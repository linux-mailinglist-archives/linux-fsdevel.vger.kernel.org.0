Return-Path: <linux-fsdevel+bounces-26723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957795B638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0B41F26CA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441391CB15A;
	Thu, 22 Aug 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HpkN4Nia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF481C9EC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332508; cv=none; b=bH30+o8JPyLEZD3QpjJr+dmKRCSV+sah+H4wynlGqogr8PReSWMjkCBS9xW7xZFMSbYOlN9MlUXOoG+N7uPRJdgjZNwNMBojT14F/bJEWtPpOlFQ8Mpf1Fv/iwyCLO7ci2AWlgV2nSR1/RaY5JQ92OIonZTF0tpXs4PESvv8oVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332508; c=relaxed/simple;
	bh=JLR5XN8uPapW+jGPHfnnP6iSyGSSHrWe2Q3eKtDUGUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s84jI4J8nANCIUM5nKnHBBa2obhLJIwEoETlSmjKog9Qb6nePQ+aMbwHBzPNTjJLl7AL6xAaXAcQEUnF1D7ehd5IRl31D/hwaHE823dglpmIP7b0jmED7PoPmopTQX5D6/PhwcFzNbU1iBlWdceCcbOHMpAUxQAPUdT5xxFRdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HpkN4Nia; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533463f6b16so1040356e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724332505; x=1724937305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9KRMSVPaqZO1TNrx4pIrSfA8dcRqpzS+a6vGuAD6mU=;
        b=HpkN4NiatB42lMYMHPTzufIfnTaIN7UAUykMYnDzsur81/oiEc8DqTysC8sk3ZN7eu
         EIXNaMU/o8VlUKM8Bj52KwWbAf824KsvrD0oirW9szWRV9UK6nc0PX2qAz2sYmLsAuOp
         mw/7GPlJaXYdgxnPTyNFH6cObDzZ5GLJ/Z07Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724332505; x=1724937305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9KRMSVPaqZO1TNrx4pIrSfA8dcRqpzS+a6vGuAD6mU=;
        b=B+z+xzZm0JztdnQjjHY7ufiMwbNkuro4bsMPlppjT8Lsig7PzlOlPptUe2q4LHFiuW
         tB+MDFHP2vY7/7JcE2jzj809DfViyMsHem/JLOI6eOOgmVH4q9ZhYNfMchgbxUCfvOkz
         F2SH0bmsRJ5dz7r1WbiPEn67T7D3od5BIect1cTjiYbrFkYfBAKMQZudSHzwY1umNriE
         OpbWquI08H6L1fKEWyCpbQnkW/jSg+kKyfpZwNMEB6n79aKsLOuN1ae0yvL6NkcgjZKp
         kEYWeM0fQT8IMwYqscnKpoAKnjbOBGKs0lWNNqLOrLE3xOgtf8QNc6TRS/Ocvhm2Oilx
         XRpw==
X-Forwarded-Encrypted: i=1; AJvYcCUONKPrWAe3YNJ31/pawvnUSEWesp0Kxp9BKrLiEQd65/A9OJD9JlN9hosn/ViDH1JPKrNNubtveDSxZKfM@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhHg7N+UO7Ay2+0vl3VdI2q9XrBp3m0YuaE3iXso8AtRcAN3k
	8z4NBUzo5abmgLaWkmVdGPxVQgfQp4LO5Zm7CH0Hy7LRmGGtVQ/6cZbtlpKmDhGDy8wg6nnjEED
	VH7BLFSj9DnHoYw1Y4M0yxy56RfN9PLma5uenUg==
X-Google-Smtp-Source: AGHT+IFQu2aJ42dHK1Z1+2uPmeklOwGyLwUpaqn5jLGSzisWf/Jt2pe/jwo3NJQ6UOHcAFDcAl4kEdNp94Hdh3Dj/Xk=
X-Received: by 2002:a05:6512:3e10:b0:52c:80f6:d384 with SMTP id
 2adb3069b0e04-5334854a39cmr3726537e87.3.1724332504893; Thu, 22 Aug 2024
 06:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
 <ZrY97Pq9xM-fFhU2@casper.infradead.org> <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
 <ZreDcghI8t_1iXzQ@casper.infradead.org> <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
 <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch>
In-Reply-To: <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 15:14:53 +0200
Message-ID: <CAJfpegsvQLtxk-2zEqa_ZsY5J_sLd0m4XhWXn1nVoLoSs8tjrw@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
To: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 at 15:12, J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> On Thu, 2024-08-22 at 15:04 +0200, Miklos Szeredi wrote:
> > On Sat, 10 Aug 2024 at 17:12, Matthew Wilcox <willy@infradead.org> wrot=
e:
> > > That's what I suspected was going wrong -- we're trying to end a read=
 on
> > > a folio that is already uptodate.  Miklos, what the hell is FUSE doin=
g
> > > here?
> >
> > Ah, this is the fancy page cache replacement done in
> > fuse_try_move_page().
> >
> > I understand how this triggers VM_BUG_ON_FOLIO() in folio_end_read().
> >
> > What I don't understand is how this results in the -EIO that J=C3=BCrg
> > reported.
>
> I'm not really familiar with this code but it seems `folio_end_read()`
> uses xor to update the `PG_uptodate` flag. So if it was already set, it
> will incorrectly clear the `PG_uptodate` set, which I guess triggers
> the issue.

Indeed, that would explain this.

Thanks,
Miklos

