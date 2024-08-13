Return-Path: <linux-fsdevel+bounces-25790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D269506DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A111DB21FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5219CCE7;
	Tue, 13 Aug 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBzJvi4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE819B589
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556542; cv=none; b=F/IXR6oJWp/ndPRW+3Dz4PnUe+gcKFIclKnuCdpp64ZGrDIuTHmNkZjvdsSLux1GU1uOmhEnEvA+NEqNHoES1LucrHLCF2tODNBjJKLD1FmzG3soWga/oFgt1S4O4R1wcXbcGVb+j4c/YZmU9RzgDmfdC5PAK6zNzll/tEFltfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556542; c=relaxed/simple;
	bh=V9eP1Cb1a8JpWz8kJUhYYooobmzWSiOrZ3r5ZsrdYXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNNe/URrweonpeHtp+Heov+NoNuYNcKd9SIgtaNlxtHad3O0G9xHPPSghNaKoBqOkY+f5kFdlylpIy5HJcqkGQJnm8/ogU24spiHFc9wzLA0p+Mzr/Cr65zMzud32KJ2NqgzsIqSFbo+EUO/3R1x1JCNInE0fMrZJz0f8rN/HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBzJvi4/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so56157961fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723556539; x=1724161339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ieWLBLziqnDogtP5zRk/pF+iGfgXnNJWbk05SsSbM=;
        b=ZBzJvi4/uHme6xAUtZ0e+vcdZv6mD2FNPqdHUfxJYIquDUaQzEBcWDOgmaXscQDIPK
         P5NJvvqzhrEqv8SjKFCyBJy9TIZc1FGHQMsgHYPfQ4FAmA6QmsuE6gSFIeiaSm/RAqyT
         1qJYrSs3+hEFtvIAER29qLbD1BKJQ6hFxe59EiV0D23sQ0c0iwlbk0cZ66CkG/cv8QeK
         0TJkcYj7UCsBEPAa1RiTYOFaVdC3HJ9Sy7p/qGdMkuKclGdlbzUfIo60a+rBR+SaOlYL
         BImHvEncksYXNtwKk/iAnV0q6tGjrN9+igle+yUNYo1VXz7YJBDsE2T7awql0QdQ6x8r
         HVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556539; x=1724161339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ieWLBLziqnDogtP5zRk/pF+iGfgXnNJWbk05SsSbM=;
        b=Ld8WKlvo3Rwy2vlMWcTQMUcLRDFjtSpNcwM0OttwDFfWhidROSW0oAsk1xu7gre1oL
         lrUnaY6m+DZX6Gdb4png0zmM+YJ2+/053PQCTbgW3uvKjsvCxwxqrDN+j1Mspjx0RoAg
         /OxCbaEJhaP6BtIlIgcAP5aF5/13m4fmpnB7O84WyXUqVRtrLpk+77CuvQhDRwoqUMni
         cPFtQuNdfddLMChE7Yhm6SDrYjRDDVh3bPmKAs9V4BPIAbtu9PjzXJ5oY+ySMKkPx+fE
         bUZMw1LfcEkfGO7dNVnXTyPyR8rGYPg8q71v/r65IE5ZyxUmRTmV0e7l9Fu31Ure6/sO
         4RdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZ4vzLJttl9E3dChbg5ckca5rMykMX4+ySvP8SqZNH+eQWtbDb68qPkkLHa3c8BhW1LvBiXXbpTLIAnlx0hRVC3YkKJDz8kzqbJXayA==
X-Gm-Message-State: AOJu0Yx/iFun2FtzVotSDW6GcMv21a/03sRD8o3hsS3lxqWpCRYr1yqN
	H1jz3vBDRgRnbNLECTk2JZiKem1hv3bDNQNcSfNKc1rZHJGM8BpOThTLLCcwwy4jQppRDMJtSVS
	wX2KTt4nMeeKYNdQEA23KAR9JLDxevp2o
X-Google-Smtp-Source: AGHT+IGiY2h4OS/nDVNNrAh09yfH6792u2DK+l8ga7rCMOqoUbswN5aImBAujUhQ0EFx3mT8QqlPmgF0tkXIgZh89OA=
X-Received: by 2002:a2e:4e0a:0:b0:2eb:d816:7a67 with SMTP id
 38308e7fff4ca-2f2b714a615mr21574621fa.16.1723556538376; Tue, 13 Aug 2024
 06:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org> <99445ca03b6b3edc4b4943add498e2b29c367dec.camel@kernel.org>
In-Reply-To: <99445ca03b6b3edc4b4943add498e2b29c367dec.camel@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 13 Aug 2024 15:42:06 +0200
Message-ID: <CAGudoHGUocqSF=pFy4+ZcPMt9FC_F2E7p6cUXx61DA_ZFME=Mw@mail.gmail.com>
Subject: Re: [PATCH v2] file: reclaim 24 bytes from f_owner
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2024-08-13 at 14:30 +0200, Christian Brauner wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index fd34b5755c0b..319c566a9e98 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -947,6 +947,7 @@ static inline unsigned imajor(const struct inode *i=
node)
> >  }
> >
> >  struct fown_struct {
> > +     struct file *file;      /* backpointer for security modules */
>
> This struct was 32 bytes before (on x86_64). Now it'll be 40. That's
> fine, but it may be worthwhile to create a dedicated slabcache for this
> now, since it's no longer a power-of-2 size.
>

creating a dedicated slab would be a waste imo

If someone is concerned with memory usage here, I note that plausibly
the file pointer can be plumbed through sigio code, eliding any use of
the newly added ->file

However, a real daredevil would check if the thing to do is perhaps to
add a 48-byte malloc slab. But that would require quite a bit of
looking at allocations elsewhere, collecting stats and whatnot. Noting
this just in case, I have negative interest in looking at this.

--=20
Mateusz Guzik <mjguzik gmail.com>

