Return-Path: <linux-fsdevel+bounces-48223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FD1AAC222
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32451C23B2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A293279917;
	Tue,  6 May 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h6jP9vzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575338F66
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529803; cv=none; b=igh1qxaA07MR+N25ue2dAeL/sLtJtDEziGVmRKb4WBRiXbhghS8ynvH0V/Vz+kT0PD02gWqD2ORoladAm2+gwffMSIq3cSBYSuwwKpE2/veGoNSCDpcLgAA65chDTnKrr3cV8k6yFmKWQkwtvYhZYUevRBTukfNDrTOw3fjvaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529803; c=relaxed/simple;
	bh=pmpUpsckhEO/UeMgtLsnsOPOzXIkuappRrv3THXjIFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZP9YHcmlOho1Avv6FI/IcJoi0wHaUkYhW3BQQV/JevjPkYiRKQbnnznyoDd3xEV4vmNLMp8OfD2FCvRKRgofSoDvCgSSuQF2Ahrg1H8eHSseaR8F1GiD0USQVSNJJKM4RjsQf1sLfviDf2tIqejxKoVI3yFcwxVkve4aF4dZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h6jP9vzW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4774193fdffso552601cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746529799; x=1747134599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7Ik8tH+SBiT7xEm20BRBMsZ14XVomfxmQFpb9PhpTk=;
        b=h6jP9vzWEs4gKYFswQkI13n+UIlxly6XP9kzYaAnLK/LkTPxL/YBw9IuWjttWGqzdM
         Vd7uxHVrD7rPRpg1t8o6UwLxtV+je3JCd8Lwb5w7kSnz8WXALQ4ewZ2Y8xNnHHm0dGF5
         osH7Ub3SU49GDE+kx5uAvddlw4GYi4pwRgBi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529799; x=1747134599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7Ik8tH+SBiT7xEm20BRBMsZ14XVomfxmQFpb9PhpTk=;
        b=iONRY3JbHeAdYrdfNQWf2p8qH0VX3xu0cPoqpWTuRlUWhus5P5wVHUZDonfds5nmHt
         ihNFPR+kvikaNgZ4PkGpQJai1yjfY1C5K/SKPdQEiX1hv5e7fgH1OHuv2A3HB1sbo1xi
         BWJtj08Cp8DwaJMTnSTQeXr3OM6Ddcv6qi/VDIyaq3gB6lkSg4EzsJwXTSvR/OyuhG/z
         hrxuFSPjJnwNmJ5fgcP60i/NojmPzHWqfxVBNUEeq2pMvtxKx+e1ec8sR8yIr/pn0IsG
         vNUxYHJRxBScSNX+VLZCLS+xQ4AxVEzs9mm0PysuKomPdiqp17cPvotuhW2XRQblwQbD
         NRHA==
X-Gm-Message-State: AOJu0YzDV8GTWwjg0smX4oqLB3Nr6SMLGbF+HMVPkP64KerAOw80ECOu
	cJOd0+NT53cbwksTmSnCG8LaMq46l0o1alkfq0OyreE1tqAqCnUd8GVJOmvsPVbWnYp9Pp58AjI
	OCWctftzWDuU25xEdW32DGBCW3GsZJyhAI9UKaQ==
X-Gm-Gg: ASbGnct4aSjnz9/DChJmpkvRyEQd0gKnJB+vyg6WATsw+nAu/YkdEyNdQ184GDlIPMz
	l/vtLGOERqYe8aYupb6Hk6gGFMvy9isBX/4FKNd47xNm1vG63Qe1MrpIIEiFpO0A/+qcoNdyBbR
	TsqBYAAq2YCImklS1QPe1sls32Ft7Y+w==
X-Google-Smtp-Source: AGHT+IFSQGpIW7n1dJ6mMxxBI8uE+Vrc5S+xjZJTZzrLmqlbnbyBRCwe0CYs1b1mtBOROOYOQrndLmcCrREknn0kYMs=
X-Received: by 2002:a05:622a:418e:b0:48d:5749:e116 with SMTP id
 d75a77b69052e-490f149dd8amr56967761cf.4.1746529799013; Tue, 06 May 2025
 04:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418210617.734152-1-joannelkoong@gmail.com>
In-Reply-To: <20250418210617.734152-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 May 2025 13:09:48 +0200
X-Gm-Features: ATxdqUG09GxRvQ91ISRDpEQxmbXnzOYWH-MzU2nS-LjpyexUvp2WwW426HPJQEA
Message-ID: <CAJfpegsMLhgp7i+KAeU828brziGPN4OB3td+kwhidQ3ywPNytA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 23:06, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Use a bitfield for tracking initialized, blocked, aborted, and io_uring
> state of the fuse connection. Track connected state using a bool instead
> of an unsigned.
>
> On a 64-bit system, this shaves off 16 bytes from the size of struct
> fuse_conn.
>
> No functional changes.

Not sure about that.

AFAIK aligned int or long is supposed to be independent from
neighboring fields on all architectures.  But that's definitely not
true of bitfields and I'm not sure about bool.  Maybe
READ_ONCE()/WRITE_ONCE() make accessing bool safe, but I haven't found
any documentation about that.

Previous rule about bitfields in fuse_conn have been that they are either

 - only set at INIT reply time, or
 - losing a setting due to a race is a non-issue

The new ones are not so clear cut, so it definitely needs some more
explanation why they are safe (if they are safe).

Thanks,
Miklos

