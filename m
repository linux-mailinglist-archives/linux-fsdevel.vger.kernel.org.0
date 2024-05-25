Return-Path: <linux-fsdevel+bounces-20155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB18CEFDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80842817A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9D7A140;
	Sat, 25 May 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA1HnLIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62929CE5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651645; cv=none; b=AtSdu3X7iBu/JgS+MWpGt9Sydvmb6Fg0Tr3D5Sbx/s8ILVXnOww169z9NUptZELig9zXpbakol6z75H4/0RXpy5cXKyaQm2NsphNMBAr5RDHsgZg6wqw00zt+u63vF5Omuf4INgeDBZf5FcuYR0ooKFJB5FEYWDzOYnK4RevnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651645; c=relaxed/simple;
	bh=xitpxPg77sLDaKJ9P0zvkscrUaSdGZoxYINEkWEHzXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9zGOKCFACrLGTgIEVGj+b9l6vhcu8s25B63tviOKHK1iczRro2oQ5EzPj0z/iIpxWWoJEvau0Oq5m3na4V8lAQXw6RRVTKRTY0dEPI1iLGy7OZNVhXcaTq3HEthaDdIeBfM0gtc3yDUtejUwIch+LPlwkotyAgdb2doxB4Fxs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA1HnLIS; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f630e51so911661fac.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716651643; x=1717256443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37ZkYGhlJeNGlO+ddGdnC0OiTaHWh9QVLtvxW8CoJqA=;
        b=CA1HnLISrlmihkkcQReo79DcEQRijIiFnZNFCJG2wV7rBmtPyxEkIr8V/W1z5ic/Fw
         yVZ8X83uH81hskWDyDauzekFUpw/nEF8OBL8+JFwxnjXR5np+QL4fRDH8iPMxsn7YFB2
         uLTSowJItD6L7K0CTXx7mvSyKSYS93XyB5OVU4jnuJhAO3gFB/GBd6SY6qBsn6sCGddh
         JVZeAoF1/3CcYRHUzUef7wSfKcFf6qmsuH2FDAdvPL8Brl3fMHfISnYt68aTiePMTKpJ
         043gnkVZSkQSzVCKKYEmuZwrSPegoP2IeBvlYorfsYRpr9KWIDbNt1VlVKMj+WuGcBfA
         ocCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716651643; x=1717256443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37ZkYGhlJeNGlO+ddGdnC0OiTaHWh9QVLtvxW8CoJqA=;
        b=FWmjRI14IOKivwoAukSJ1PJN8zixiXMPht2IAQ4AGT7EXEXlds278gAuwUBeeVPuvu
         uU+jM80Y7ujZXu9k6YdUu9wtHXuyKyUuaY3inJeefs+nmtr0JdC36r+2cBwpHq4bKxF4
         891KpUg7x9j8FRvra19Yhd46mTMdasGvTLWTg5jXMdWssElhxPS33b9FP4E1kYphyaoB
         MiPVI5tNpR7HanR9J6ehNe17aq/P7wvNNSF4tkb0edtteMtCErgDc3veimgj6u6Fpn5s
         UpmyBrc/CZDh+AMSt+IebPYEi+4fHM0tc/JlfMWAxHo3Qfp6jQGby8H3sRjFQrD1Gw/U
         btjA==
X-Gm-Message-State: AOJu0YwboPFn6Jrt5daFwNv2GQGm/Me2vRq48flUMkKebvjgng4oZvT+
	g1htrmH+2LZ7mRSP7LRZMSK10RlwzKLgNJ1l3Jb+J2nFW1nRFgiDiNpSY+mORlpUo+bmzfHDbS9
	Qjn1psogiQASPrw6/VbI+9fGz9VzwUeZJ
X-Google-Smtp-Source: AGHT+IGv/G9risVzruzaXl5doB6x7poGTEnjI387qX+REVFtr2ordGWMlNifrTx6fLKV9tcJzeh7LGf94lVyCda6oaw=
X-Received: by 2002:a05:6871:1d4:b0:245:10ac:afc4 with SMTP id
 586e51a60fabf-24ca1471d80mr5624587fac.40.1716651642667; Sat, 25 May 2024
 08:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e67b7351-1739-437c-bea4-bb9373463339@fastmail.fm>
In-Reply-To: <e67b7351-1739-437c-bea4-bb9373463339@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 25 May 2024 18:40:31 +0300
Message-ID: <CAOQ4uxiObdGjKoNx2o2kXzbBKPc9EKRa6K7cQ0ny0P4LN_UuWw@mail.gmail.com>
Subject: Re: fuse passthrough related circular locking dependency
To: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:59=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Amir, Miklos,
>
> I'm preparing fuse-over-io-uring RFC2 and running xfstests on
> 6.9. First run is without io-uring (patches applied, though) and
> generic/095 reports a circular lock dependency.
>
> (I probably should disable passthrough in my uring patches
> or add an iteration without it).
>
> iter_file_splice_write
>     pipe_lock(pipe)                    --> pipe first
>     ...
>     call_write_iter / fuse_file_write_iter
>     fuse_file_write_iter
>         fuse_direct_write_iter
>            fuse_dio_lock
>               inode_lock_shared        --> then inode lock
>
>
> and
>
> do_splice
>    fuse_passthrough_splice_write       --> inode lock first
>        backing_file_splice_write
>            iter_file_splice_write
>                pipe_lock(pipe);        --> then pipe lock
>
>

Not sure, but this looks like the reason that ovl_splice_write() was added
(see comment above it).

I think that fuse_passthrough_splice_write() and
fuse_passthrough_write_iter() are probably deadlock safe against each other=
,
so I guess we could teach lockdep that passthrough inodes are a different c=
lass
than non-passthrough inodes, but I think that is not easy to change
mid inode lifetime.

Also, I think that mixed passthrough/dio mode may be breaking this
order for a given
inode - I cannot wrap my head around it. Will need Miklos here.

Question:
mmap+dio does not make sense so we let passthrough overrule dio for
mmap in mixed mode.
Does splice+dio make sense? or can we also force passthrough splice
when inode has a backing file?

Another thing that we will need to do is annotate different lockdep class
for nested fuse passthrough as we did in ovl_lockdep_annotate_inode_mutex_k=
ey().
Lots of fun...

Thanks,
Amir.

