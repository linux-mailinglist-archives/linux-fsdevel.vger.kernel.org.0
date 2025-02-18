Return-Path: <linux-fsdevel+bounces-41998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B637FA39F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E600F18969BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4726B2AA;
	Tue, 18 Feb 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="adisqPGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8A26B0B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888798; cv=none; b=kri57JSzhGRJsN6/QguPg8lTzJPbsG7qqPekwzuZaH+Noreo8Vy+OQ+jSs/kNhiU4e3sfPexNsMjhTxBa508lBFwQRXFe/OJYies2kL7+Vl2av9F3ydYhiQOXqU5bYRUDpJFur8bzvoYCiXm8MIpHSDREbCZa7NUswROvFC5PJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888798; c=relaxed/simple;
	bh=sS36fJX8Vbth94UBPCAo0LFNfvI4rCKWV8qYzF0ZOPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehNI1L93L5Q28ylIeGDNrydiOGwjz3ymg9HQbFzIeSndrBcaMDSUl6TwN7KK9F4y1e8CfYfvV39lrS6xs0u5sCk7YLM4Rz1yiLBxW8iXpbw8oiUS/rN1yo3WeJX7SRQW8e+Pr9pnCmH+o3emF7gDxl6o4Mg0vXspR9SqrmY5J4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=adisqPGE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f686642cso14546001cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739888795; x=1740493595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/EmbDSl+l5HXRvJiyRxM4EbJGeupWnXKptfCU5Nq4k=;
        b=adisqPGEX6vQCq4dkLfAUSAd24zrAldAXaDhjB+5olCkvWnEkLtUPvSz1a4NR+N+sx
         4qWZVc+KLFVczKkU6lNn6ojfLCEBm6oQ4X8blfIgxaN+Rbpwr2hajiKUMFfgmjCSP9gM
         f8Ckzqf0sDHuEXbJtug+XhHjdITP3UwR+M0nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888795; x=1740493595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/EmbDSl+l5HXRvJiyRxM4EbJGeupWnXKptfCU5Nq4k=;
        b=VdGXp9S+53Krhwwz1uo2HqpXLrspnRswjY6wdf3YwCn0+TdNMkBAp8erm4TJUBdMZd
         qJI+jIg8bFWBllB8A4exmq2cv8H9eactJTSp4qN3o4Io7K/l43EUJVfk1m2nSRKuMCSQ
         rX+kLneHvr7TOuJvlNQ8DWHN4MmNpZJs4CYx9MUai9ygG/Slf4pX19o9SbZ+OlipgDG0
         bfnZHiHVS6ytKXhd7R9gM0zQr7XfRO6f8q8RfqKLselB3r2XmsNVrPbjFv6qgICF1UXO
         XhiKPK2xTBvulMcVsCJ/38y6Y76x+TDG4L2gLV1N9uEJrBvVILfy5EU4Epax/afl/qTg
         cOmg==
X-Forwarded-Encrypted: i=1; AJvYcCVU4sCTaxE9CvrejngSsT7BsN+PXlDzVnk8d/u1EsH/7abgPq9NvHpOc+dIif8IdkcO5CypgTk7dittvNWE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9o89dzb2IVnb1kiDs+HPiU9QOB53UkcjZHkHOAv178ZNV1GaY
	aQmxNyV99cYVoqf3XNcnZDw5vSzyH9hTNec7wgQxZNiyj9foQpJutX8q9AK4rdj39auFpSbNmrE
	1EKM6h3M/S1TEhj6XbCFeLVBDaobqoSsmgp1e+g==
X-Gm-Gg: ASbGncuNBCUhuJTVc6sTfQWRyJfL1+qSLy3J1ltq54b464f8vvV3cizoA8wOsCGHpKd
	MhV7HKZDgyD8Cl2yC0ShjfjjB++QVko09S5lPAZ2NjShUggAE278PL/wxePQmjqXiV/aj3OY=
X-Google-Smtp-Source: AGHT+IGET3EbYLamjGGt8dSMpL8Nkri+TYxZim1J3IHFlr3O5sraAFYYOQ2HRKm+Tx9aTfNhy4qqarSD/WPsGZTxgfQ=
X-Received: by 2002:a05:622a:15c6:b0:471:fc9e:8de8 with SMTP id
 d75a77b69052e-471fc9e905fmr67186901cf.4.1739888795313; Tue, 18 Feb 2025
 06:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area> <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com> <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
 <87frkb8o94.fsf@igalia.com>
In-Reply-To: <87frkb8o94.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 15:26:24 +0100
X-Gm-Features: AWEUYZlBOOIIaYs34OYy_0E3-HRJyLG5kCRwuFnjQlWeGTg0omw4orTEC-iLSMc
Message-ID: <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Dave Chinner <david@fromorbit.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Valentin Volkl <valentin.volkl@cern.ch>, 
	Laura Promberger <laura.promberger@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 12:51, Luis Henriques <luis@igalia.com> wrote:
>
> On Tue, Feb 18 2025, Miklos Szeredi wrote:
>
> > On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:
> >
> >> The problem I'm trying to solve is that, if a filesystem wants to ask the
> >> kernel to get rid of all inodes, it has to request the kernel to forget
> >> each one, individually.  The specific filesystem I'm looking at is CVMFS,
> >> which is a read-only filesystem that needs to be able to update the full
> >> set of filesystem objects when a new generation snapshot becomes
> >> available.
> >
> > Yeah, we talked about this use case.  As I remember there was a
> > proposal to set an epoch, marking all objects for "revalidate needed",
> > which I think is a better solution to the CVMFS problem, than just
> > getting rid of unused objects.
>
> OK, so I think I'm missing some context here.  And, obviously, I also miss
> some more knowledge on the filesystem itself.  But, if I understand it
> correctly, the concept of 'inode' in CVMFS is very loose: when a new
> snapshot generation is available (you mentioned 'epoch', which is, I
> guess, the same thing) the inodes are all renewed -- the inode numbers
> aren't kept between generations/epochs.
>
> Do you have any links for such discussions, or any details on how this
> proposal is being implemented?  This would probably be done mostly in
> user-space I guess, but it would still need a way to get rid of the unused
> inodes from old snapshots, right?  (inodes from old snapshots still in use
> would obvious be kept aroud).

I don't have links.  Adding Valentin Volkl and Laura Promberger to the
Cc list, maybe they can help with clarification.

As far as I understand it would work by incrementing fc->epoch on
FUSE_INVALIDATE_ALL. When an object is looked up/created the current
epoch is copied to e.g. dentry->d_time.  fuse_dentry_revalidate() then
compares d_time with fc->epoch and forces an invalidate on mismatch.

Only problem with this is that it seems very CVMFS specific, but I
guess so is your proposal.

Implementing the LRU purge is more generally useful, but I'm not sure
if that helps CVMFS, since it would only get rid of unused objects.

Thanks,
Miklos

