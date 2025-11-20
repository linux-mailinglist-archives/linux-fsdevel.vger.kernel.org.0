Return-Path: <linux-fsdevel+bounces-69166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAFC71909
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCC4E371E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6F1DC9B5;
	Thu, 20 Nov 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyy/xC3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6B1D5ABA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599154; cv=none; b=IeOGJWGJWpi/tLzqi//jYgTx01DNmRVBIidVgbfLZ1dBD4y6WE05I+LltzRlQuXTupTtHLDXT6DPIgFMGwqF+9obiFl+Ujv2R1pxL+Zy5pgmJGvRpu+61yskTzeSxnmSm2STYX3qRw1s4PBUTE1E7dZXCh5XZ0QtEKA2PfDzhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599154; c=relaxed/simple;
	bh=GTjlNKiRb0xenJ8TIK43XN5We6wrEUBM0bmh6Bdro7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfsyT1Q4g7VYV21N/qk+1HBahc83VKxIp88Sl5VWGWoNGspWFgmgoSU72zkeMt4bFVEhp2sNzM5MtHQoqs7yP62tzl7I6K0hYdZ4V97vcQT5y4KE8MU0iMoCQVnlJgGMgzpr3sDXGLAfPKeFaI2/hF5CulIzXplEemisvHEekvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyy/xC3i; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so2095181fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763599151; x=1764203951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhIncEPfEr6p8pOvPSfTpAzxtAlq/GojJTlp/S9poU=;
        b=Dyy/xC3ixPPt5eFlILi3ZbXk8k/S2u5ythMDoYHMWl5kLYsOZnpW8fv+WdckTMEouc
         3EtGT3hNYNRWQC3P7Qb2X9MnOaNWKy+aNWNkTIbpfa4uytBmJ6PKphGIP8iBTaCVlKYF
         BAob64ITUpFT4qH/oqryXkqy4KQkuJfi6psnMyaIS8MYRGF8nAZeBa885bySj6g2CPv/
         alDAQQTQgQTkxzE6oq87Q7Q8J1botBfibmGXlNtWLKJXXutTETwwPthYfaZLsqge3CJ/
         GOE9BJHj3VMY96yvps7FsqXbiR2nEhcbtPZfhqgti11BU8tHRYpGflHcfAewMXhXBXR+
         G4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599151; x=1764203951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxhIncEPfEr6p8pOvPSfTpAzxtAlq/GojJTlp/S9poU=;
        b=tIauBh+ePzksJI53Jqnqb/rqHgmDk4JOZ6+zTfDRo6wCJ/u7Fxxb/lvoUx1UEPCJ46
         fM5wXyX3nNoMXN/QmPALnpLelNTmEfwEdUtucV0wGkhBXitAjgUfPfPWGOeOb+OU4W24
         FpAGkqGNVyjxvUotTq7v4q2H4+nvbhki/xEWnpK2hAwMtxLhNOaVvo2JggKdjUsJErv5
         NrC7Mj2HZv7dBsaSLKA4Ofww1oE4lHNyb/Oq+0P1Vnsb4CjMHuGquHJdtMe6+Xx8gBnZ
         t6OOvmVokpebxthk/tBxHPCPRx+tI9uXB9BRXKEfXVtuoRbAUcRIPFy6mpyw2hA2dPHC
         pAnA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+DW9ULgCMWidolchv2RB6XYK2Ldll1AzSU3Qv8T47Rzp2GG6kDzFXTiJUEIDsAXPvbjaXjriPNgMC6uE@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSna+QkVFR6outsGpTNzxBpGMHUuubNJeKdlDGOhD9vrslwqX
	V8KN92DwxpS1UUEU5fPXs2ckhCa25lJAQd87EuFZcqMMAbMXCDBHB3+4a/7ak7WDm05+5PtXJkM
	3UDEY0Nif7nrbYhrqtnINyc9gP76oqhr8tYFUqE0=
X-Gm-Gg: ASbGnctvdPzb6XUCZguP9puHbDXOIrp0JhAkvHcTE4PWdxRypxvYzSmIQBJTM48ux2s
	oQSNHve0f3eYCWkq3dDsk9aBAZ6IWsaZGjeI59FGduaEA6TgiKQw8+6i77w0WayoGTncDvp7YBv
	hpil4FfnPVNkpxy58mI8NN213eoaJON+HbsjVZl4S/QvXnigqre4E8MHkTH70RJJk/mUbFrj/e2
	WgXI+XpzZh+S3CSWy6S93TfgPmCh2GgnULsbaNFWjfwGtBKIavI5w/6ZLZwmcRV3PL02w==
X-Google-Smtp-Source: AGHT+IEAKCR3y3nf5w1iA/7f9nxqNJ7uIvS3FeD5KgG5FgI/v48TFJhdt7U3fklLP6XcNCEEOz+bcZSkgNsY2cPgKDI=
X-Received: by 2002:a05:651c:31cd:b0:37b:9615:e43a with SMTP id
 38308e7fff4ca-37cc7fe7fd9mr1442491fa.1.1763599150702; Wed, 19 Nov 2025
 16:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com> <aR08JNZt4e8DNFwb@casper.infradead.org>
 <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>
 <20251119182750.GD196391@frogsfrogsfrogs> <CAJnrk1apaZmNyMGQ5ixfH8-10VL_aQAG8--3m-rUmB6-e-dtVQ@mail.gmail.com>
 <aR4cHCv0eabXywYU@casper.infradead.org>
In-Reply-To: <aR4cHCv0eabXywYU@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 19 Nov 2025 16:38:57 -0800
X-Gm-Features: AWmQ_bnUgS5LBwK6d1wM4Asg8sfRKMK2ezAo0CtzbnUYKxXMiD8KkiZYhnqRkFk
Message-ID: <CAJnrk1b+CEugwVReRqFBW91zGRzt0_LcF-Xw1AAdm1uEZAQqqg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:35=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Nov 19, 2025 at 11:17:41AM -0800, Joanne Koong wrote:
> > On Wed, Nov 19, 2025 at 10:27=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > > xfs supports 9223372036854775807-byte files, so 0x7FFFFFFFFFFFF000
> > > is a valid location for a folio.
> >
> > Is 9223372036854775807 the last valid file position supported on xfs
> > or does xfs also support positions beyond that?
>
> #if BITS_PER_LONG=3D=3D32
> #define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX << PAGE_SHIFT)
> #elif BITS_PER_LONG=3D=3D64
> #define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
> #endif
>
> Linux declines to support files beyond 2^63-1.  Today, anyway.

Ah I see, thanks.

I was wrong then - it's not an xfs specific thing, 9223372036854775807
is a valid file position on other filesystems as well.

I think it's best to drop this patch. If we were to keep it,
accounting for the loff_t overflow in "end_pos" and "end_aligned"
makes the whole thing look worse and more confusing.

Christian, could you please drop this patch from your iomap vfs tree?

Thanks,
Joanne

