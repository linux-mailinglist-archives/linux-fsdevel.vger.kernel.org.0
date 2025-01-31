Return-Path: <linux-fsdevel+bounces-40522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BDDA2450D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 23:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769A5166488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22551F3D52;
	Fri, 31 Jan 2025 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJabvOlu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BA1487E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361511; cv=none; b=lq4lBRvj2cVs108fKSw9i3lzqQhtr/rCLMe7dM8ZZ53c2MJmTZUd4OcFIRtf1pL5EObwRwaxyrav7i+DQGy3Kx9yyxQUa59unVKRqySGenDj9a5FMPCmcYAJcw7d//pyctfrYj+hISgtNHVSINfRc7LJ5s9zDdHGwtVGJ7aqUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361511; c=relaxed/simple;
	bh=HFspG/FfH0gyRgotcU5j8/R5Gxbta8Ka6uvsD1QHQrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEIRD9OoKE4UgPrj41tQ6Hoignbou/6IU3E6qLuYvb1SsWWRYhhFKm7faYwZZVX+V5Lx/R5+EnsLA3MFNwjbEog4ghIW3vv39VhnZ8PB6sPfFX1+jSWmcQSNagMvVbDM9I2u6FWB/1hG4jsZKNi8rwpLz3PJJfKeHvh8k6xSz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJabvOlu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso4534902a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 14:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738361508; x=1738966308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFrmIwqnzaGdvuMM/GXQLA7YL+T3/WV4iSpECqbewyI=;
        b=aJabvOlutEF9jozwF5vh7RF5ERoNYdYGTey14AgcPOho9Ej6b0gYm8UfdIuC7BUMzF
         tO40BoJ/6v5DgRhzTfTQCnXJQWJV6V+H3s/fKSyJRsMshG7ZaG0V2ex3i5W+dWO3wtWt
         NlZckfWFZDji02QAp7YqpTauDTqgPaKLEm7DfQiaX8rjBfDVRczAVKBF48jAXIPX6ovE
         URzHvvhJVOWWYz4M9MGcliwYrV5f5UqmblTwY8DQqrWppn+Z5fncg1b8ILQhzH+J7K2Y
         tG9cESYWDybbg2SzXR5aflj+KmnDs5KuVYrRURl4GmAF3I7rlxY/TGJm1j/cr8uHU3g1
         nxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361508; x=1738966308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrmIwqnzaGdvuMM/GXQLA7YL+T3/WV4iSpECqbewyI=;
        b=GJGmHg18b1rhjeptX5Rd+ckQvaI0P8Ma+ran/CUQtjbEJ7+qfr1M7Vfcm+t0xg17XZ
         1dMXEvIm8Xm30C1td5Cw1colbYs1Ss0t6utSFerF7Cgci76SgY604jytpzabqXyBouva
         dnUGwsMYh3MdthO3n2DRCJNFr1/aBvRGZkGklvt0G5ZCrCLLL2UOkiLQB9FfXaaNDKYH
         IxgaZYurd3ElnP/l1UXjFfe/sXh3ba880dY/ibwENU8uEcl7HANzQkl5OHZnEpBnvn0L
         Of6afrL8UV1i3gQe38c2zTJNJ/pDlDWQx9/fVNmXFNZgfRpSphQIfD5BTdRsaq2ul2XL
         Yg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXug77bs72nDRHo95Pi9LjDrcLKmgIlk0NsYk4cYRF76GQh4zmJ3LEivcxK131YMg+w5KxD2mP61EsQsn0L@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfxeVjYo5luL89j9aomPk8w7Q5G+eM/o1Bz5Dsg4srTb8M9OM
	jctJIeSh2Oy8gKQpAxtGanpdB6rEeAMmTSezGz+DSkkR55SFxBekWyCH5afR6OMMSaLy3CwDR9n
	c4rlNzw707r9iP21NP/ScrhWxrPM=
X-Gm-Gg: ASbGnctfkWN5lZORNANSoYvdTa6XPCGm5AtYrc2uPdWxa78bWRmTN2JBnK1QEfzEij1
	j78enL+ZU0n34GFwS5IOU/kszihtGgjkOBkR4jz3WjzF9EphEjTml1nKdHtV04s9gChh5wiSG
X-Google-Smtp-Source: AGHT+IGkZKe7sdjC1Z9iPegkIDSkpaXqVxXPLlu7e2uIKNBtaqLFmbKOh4Kl/hPbsiamCLRpKiZYRm3XrxcbAsqcjjk=
X-Received: by 2002:a05:6402:440d:b0:5d0:d9e6:fea1 with SMTP id
 4fb4d7f45d1cf-5dc5efc4d3cmr14890948a12.19.1738361507554; Fri, 31 Jan 2025
 14:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
 <Z5h1wmTawx6P8lfK@infradead.org> <DD162239-D4B3-433C-A7C1-2DBEBFA881EC@amazon.com>
 <20250130142820.GA401886@mit.edu> <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
In-Reply-To: <4044F3FF-D0CE-4823-B104-0544A986DF7B@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 Jan 2025 23:11:36 +0100
X-Gm-Features: AWEUYZmZSSnv3zqk2FRwdACxiFqpk7gzgeE5y87xoJUTStLQdu0Tp7QKIwsLhpA
Message-ID: <CAOQ4uxgpDy-WFJgpha38SQxSYZDVSaACexJ5ZMr2hN7XkzsBqQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
To: Andreas Dilger <adilger@ddn.com>, "Day, Timothy" <timday@amazon.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"jsimmons@infradead.org" <jsimmons@infradead.org>, "neilb@suse.de" <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 3:35=E2=80=AFAM Andreas Dilger via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
>
> As Tim mentioned, it is possible to mount a Lustre client (or two) plus o=
ne or
> more MDT/OST on a single ~3GB VM with loopback files in /tmp and run test=
ing.
> There is a simple script we use to format and mount 4 MDTs and 4 OSTs on
> temporary loop files and mount a client from the Lustre build tree.
>
> There haven't been any VFS patches needed for years for Lustre to be run,
> though there are a number patches needed against a copied ext4 tree to
> export some of the functions and add some filesystem features.  Until the
> ext4 patches are merged, it would also be possible to run light testing w=
ith
> Tim's RAM-based OSD without any loopback devices at all (though with a
> hard limitation on the size of the filesystem).
>

Recommendation: if it is easy to setup loopback lustre server, then the bes=
t
practice would be to add lustre fstests support, same as nfs/afs/cifs can b=
e
tested with fstests.

Adding fstests support will not guarantee that vfs developers will run fste=
st
with your filesystem, but if you make is super easy for vfs developers to
test your filesystem with a the de-facto standard for fs testing, then at l=
east
they have an option to verify that their vfs changes are not breaking your
filesystem, which is what upstreaming is supposed to provide.

Thanks,
Amir.

