Return-Path: <linux-fsdevel+bounces-35985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20619DA7F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556C2B23958
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8E1FC0F5;
	Wed, 27 Nov 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtvdPsZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0001F942A;
	Wed, 27 Nov 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710505; cv=none; b=XyUFK7lhuyjhcs1l5ICaNLZJf+qtpehZctlpLR0YtYRChxuFDLQJ+ODqoDAmmy8pVxsGFIOUJt9F0s9DNnwS33Tx2dIXocRm5oP1PlQQX297LFiuD75tuWPhMFZqNyQTshYB5+W8U52sTijZSfmMEuYcZb4WgcgYJoDNWggkLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710505; c=relaxed/simple;
	bh=KVD/TsdewKb1nlukCbKQ6+3n6lWyBMCj2A20pATrmHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRFNWomb8KOfrx4OxF2UnxjouchBxTL0p90Z6c91X3fUcW6KFuvRH09SSpozNSP4s+bE6dta2dkoCRw14TEtK9uVLq2pRfHPrEtnxNFriyDek0zhmRypp4dijKRADuk3xkSPLIV8av7CSlQ7AT/mt4qwHIy96CDZosnCTaDH47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtvdPsZf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df1e063d8so544762e87.3;
        Wed, 27 Nov 2024 04:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732710501; x=1733315301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBuQtBr/HHW+O2FRD8SKWaOAbKa/8acp/47kK7p0Iao=;
        b=AtvdPsZfW3sNW4u+pz/9dP8+WzIz0QMKwvvGtI7drBEm4jshEYizOCc/awYtYs6kP4
         TKsIE8jxM8NN40He7xMPmmItprEUkNlRvpJCH61EnXq/9GuxFwC9ewTCgCGZLQMLezRh
         P8dP2Tk9k3XdHAmMRoFbkdK6CTUEVJcfpHy6GxF7V5KQUpuhIx9YZ6KbibOml2SrgWKQ
         kGN2ut458IFv8JdJlTeNtw9JbeuXHs2gh62jzYcb8y53vBHCO5CDn0bBRSTvV+h84x0J
         urHqDMehRh6wWL5m3OaY8aPPZQ+9tV7T9ga8YVWYW3ok9MQGwZHr0lnPxjvXHo0XiN/w
         pkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710501; x=1733315301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBuQtBr/HHW+O2FRD8SKWaOAbKa/8acp/47kK7p0Iao=;
        b=C0Q9D6MuNeOpDQas3vnluuNDOS7ypvIhCaNejUXcWl0ddc+c6y/avn3H5gJbAd4GSO
         3YeUiuo94XGD/zURe+fK9e45+CvPo9S383C9ZCnNWGsigo70PUcGYq8raTCijuWtww+e
         f87XAExV330Kmea+poeG2XBAV3g4dBvvvBSi1Tck/1hA+xijAgucd8fP+jsgsCO6w8Lq
         ZbQEYTNtLycHd8E0nJz8SPmKESgCOpr+fyvY4v4dA7UJvtgeJzz4o8P4F/dlkGTPfWWX
         m8kQuWtqPhbcXfwVrX7k5odvpt4FXK7x7zPXhJGBxXE1D2QClb7ORKkBSotalYY4Vime
         COnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXcVTL0yCVOdZcXpvG0Bb7/oH1+b/On0NByTnw4zuDrrWc9qABdz7QqVrTmVVMSVk02Mkj9McCy5832PBT@vger.kernel.org, AJvYcCXa3A1RDn2iLeLdduHTws7N4157DCIZd9yKlwKFAtXFvJMsonqoT4Ssmgur41oDdgLi4Tgk+XM/tGKvBOu3@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRGm7ShpEPJkUJhS2GOjl4Ipy0e8y8Vr+8MKpr8jjY6AGGgMt
	0dGvZXs59Pmh59s6c1Bq72/pebHiB+NoBjtDPEH7OIE9IG7zlTnRkEYMIAHYWmMbsgsyUx/nemF
	ekGqSMJp+GxNzluGUa7SoGtlEcmg=
X-Gm-Gg: ASbGncsINfxuokF/9bUzlCR3n/823UylAYCJLRRZd+ogR3F9eV3CoOX9e3n6jCVzFjw
	J3i+L3bufUBFr/+r6coK9qiFxttShKrw=
X-Google-Smtp-Source: AGHT+IFwXubr7l0qYqnlgg97c6fsQlp+ICrOK0lCiQm2f0xBjXBzgLLDsS1wWMXHOIEQyFZAm6o1MSrETC7yopqdYTY=
X-Received: by 2002:a05:6512:b98:b0:53d:ede3:3d5 with SMTP id
 2adb3069b0e04-53df00d11c8mr1532012e87.22.1732710501089; Wed, 27 Nov 2024
 04:28:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com> <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
In-Reply-To: <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 27 Nov 2024 13:28:09 +0100
Message-ID: <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, 
	willy@infradead.org, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:18=E2=80=AFPM Bharata B Rao <bharata@amd.com> wro=
te:
>
> On 27-Nov-24 11:49 AM, Mateusz Guzik wrote:
> > That is to say bare minimum this needs to be benchmarked before/after
> > with the lock removed from the picture, like so:
> >
> > diff --git a/block/fops.c b/block/fops.c
> > index 2d01c9007681..7f9e9e2f9081 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -534,12 +534,8 @@ const struct address_space_operations def_blk_aops=
 =3D {
> >   static loff_t blkdev_llseek(struct file *file, loff_t offset, int whe=
nce)
> >   {
> >          struct inode *bd_inode =3D bdev_file_inode(file);
> > -       loff_t retval;
> >
> > -       inode_lock(bd_inode);
> > -       retval =3D fixed_size_llseek(file, offset, whence, i_size_read(=
bd_inode));
> > -       inode_unlock(bd_inode);
> > -       return retval;
> > +       return fixed_size_llseek(file, offset, whence, i_size_read(bd_i=
node));
> >   }
> >
> >   static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
> >
> > To be aborted if it blows up (but I don't see why it would).
>
> Thanks for this fix, will try and get back with results.
>

Please make sure to have results just with this change, no messing
with folio sizes so that I have something for the patch submission.

--=20
Mateusz Guzik <mjguzik gmail.com>

