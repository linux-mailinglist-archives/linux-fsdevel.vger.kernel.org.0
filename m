Return-Path: <linux-fsdevel+bounces-53737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08722AF64AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAD64E61A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF08242D84;
	Wed,  2 Jul 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKm5OWmJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A51940A2;
	Wed,  2 Jul 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493658; cv=none; b=hWNi1PxknlZWtKWeLJ2Ovwr6z6PY2CRh3UGI89KeOuIN8cxnY+8NFzqn7+HzqwMncEPrQOfNlywR698FIxMFK/2PN3D1rkywNHfIMcm2fGEm4fNoXs4CvbMfZ7yBMpJeg9LXjVuuE6wvFCYPsrKxSEEFMARykh1JjKnq4YBr0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493658; c=relaxed/simple;
	bh=I2HXhl9/BOzIBeeYz0x5dYvcHignO7fdSMD8M+8Zvhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opkkaoZ6BJoXk8KvS7Ig2SQHs2NaWRcMVDA/fM780e0YCh2zj7vC/kIG4RJ9LNbX0quFZSi06A21Uc/L8wwaxXLCUKKfZf0zUbyGZr9f1sQVNVfR6bEKxqAZtHdCEVH83obNN6zpCReqTJ4tqDOBSabIOfiWT+kWHoxc5H6zf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKm5OWmJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a752944794so83493531cf.3;
        Wed, 02 Jul 2025 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751493653; x=1752098453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THoCMbnlktwyHzz2kQcX/L8gGaM+8iyGu2w9om/iuLU=;
        b=dKm5OWmJQsF6k/C0FYYDGXAkFYXfu1u9RCVcsdSM/xSqSFH0evMElFMd1XWDg0ZIiz
         a4uBOgyvYIpnsiLDMqlpaDsJl7hAuAnTxea451EieslBgRgVtLVd6cU9/kUaE+aLzAHB
         bDtmOV5MpE0ahMXG4zmjAbIRWw/5meLtNDhVsGf0WkHF3sh/6gJ4rLcP1Xec9X2ccXI3
         CGq+mIvJ40Gx0HMuAYZGLxcrSSuksO9MZWjB0Nymi1FJZbw4ZHsNRVRk3dlR1WJat3IN
         XN6ba5YhM53fC/nZ8bgKZoxNicanpdP+I8tnkzIYwoO9w9m6ctTWId4gaB5WmqnsJR40
         fn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493653; x=1752098453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THoCMbnlktwyHzz2kQcX/L8gGaM+8iyGu2w9om/iuLU=;
        b=ZwERqYGAWVz5RtBifYSI5VrERM+RPQW/jXkudPvOHcv2H+laGMUFnP+KmKOm0lZqUR
         ekSGtUMxYQsezQTRk6mLyMr1dJaYGHnTVv6Fcw6qJa8/j5Xy+IYVlrwV5kZRuAj89g7z
         TuXSHIEbpSEa3nmmQLPAG9KcXHh/E+itcq6ZVKGxoEzRNh4AhgVgCfFn+HK6uJbrFcVH
         OELlDgmrO5oNakJVYlQz2VwFytLDAtsAi1lhQWvBmDHurM+0FkskxyavDJ6ApAENWjMt
         3FotEtxGYnTTgz91FQ4B4d/pSHQgGjj88qoPv1Qko8IGmXpAm1Iq1IJQnQlggzcyCRFD
         eTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6IgJIjEGJmiNq/GbkkX/eDOuRrfyD73xl7Hujk2JoepbNXEvFqmMd2V/yfrfEE3CNyiOTwZm9qFiD@vger.kernel.org, AJvYcCU8XLgP4/HPIzWnJLUZQq1qeGV1SuAZQo4QngQI/NdqQvV4B+dcuitcSOaOK10nNft9G6ucr13Y4uf0oe/xNg==@vger.kernel.org, AJvYcCU9jWCzCqdg/XNq8qt6ccuu4XxPCZoO3qFUE2gEKJA1S/5kw66T4U7DhW9WQgzZmhg/5nKehV1a3CS8@vger.kernel.org, AJvYcCXm7zYHhktbUbFR5JGTcYlDt3UdZs2Qdpgi5W8o9emrRh0y5ZJccgc+1p9WcyM4uc7bKZxx4vsM5vUpmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7nI7b66FvFi/3Whu7CW5Jgnxgh5hYESO1wTPnBVvsJFT5USI
	mmMGjp9io59eOcsEpiBWoWN6XhX4lvcQPlKkQqDVUsau1tOPhnmgEZUXlJ4Kkxa1948Z9mMqfVw
	833Rk4zMka0uPU0b243z0a+cNnUkYHP/vSPlZ8jU=
X-Gm-Gg: ASbGncvMQNhNLDGN+d2/g6XyABUzz63ViGg0LHnu5rD2+buDte2Z1C/eDpbp3hxuFVU
	klEy5vnBO+5gnZumygjmPzemR9UgDQKnJpzbuZMnhTbbY7WkVPfbN/IfjMBmTXvR4somRpVKftS
	qMo92W8NgG9oghhU1AiQ+RG68kSY8hvTjVySqrhHgrT/CX+3KP9Fir2IeQjwt01osqSuVN4Q==
X-Google-Smtp-Source: AGHT+IGzkbGoHx67gm7//UOl9sXu9mntq0NbD7/FRK8AZGQcb3YRbyxMFYTrfA3GEzYiBVHJ4SFBTIK7amTWCmVYjGc=
X-Received: by 2002:a05:622a:4c14:b0:48e:5cda:d04e with SMTP id
 d75a77b69052e-4a976a53cb0mr67294621cf.36.1751493653206; Wed, 02 Jul 2025
 15:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-2-hch@lst.de>
 <aF601H1HVkw-g_Gk@bfoster> <20250630054407.GC28532@lst.de>
 <aGKF6Tfg4M94U3iA@bfoster> <20250702181847.GL10009@frogsfrogsfrogs>
In-Reply-To: <20250702181847.GL10009@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Jul 2025 15:00:42 -0700
X-Gm-Features: Ac12FXyiBAM5F056BsVQ_D-n0BsEnWC_2Lt1EQ3hTmWssFKMH3Kv25uDtBPegLc
Message-ID: <CAJnrk1YWjSO-FmnzHGRerBP6r6rPSAAm3MgUKfkr_AYjDJjUxA@mail.gmail.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jun 30, 2025 at 08:41:13AM -0400, Brian Foster wrote:
> > On Mon, Jun 30, 2025 at 07:44:07AM +0200, Christoph Hellwig wrote:
> > > On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> > > > I find it slightly annoying that the struct name now implies 'wbc,'
> > > > which is obviously used by the writeback_control inside it. It woul=
d be
> > > > nice to eventually rename wpc to something more useful, but that's =
for
> > > > another patch:
> > >
> > > True, but wbc is already taken by the writeback_control structure.
> > > Maybe I should just drop the renaming for now?
> > >
> >
> > Yeah, that's what makes it confusing IMO. writeback_ctx looks like it
> > would be wbc, but it's actually wpc and wbc is something internal. But =
I
> > dunno.. it's not like the original struct name is great either.
> >
> > I was thinking maybe rename the wpc variable name to something like
> > wbctx (or maybe wbctx and wbctl? *shrug*). Not to say that is elegant b=
y
> > any stretch, but just to better differentiate from wbc/wpc and make the
> > code a little easier to read going forward. I don't really have a stron=
g
> > opinion wrt this series so I don't want to bikeshed too much. Whatever
> > you want to go with is fine by me.
>
> I'd have gone with iwc or iwbc, but I don't really care that much. :)
>
> Now I'm confused because I've now seen the same patch from joanne and
> hch and don't know which one is going forward.  Maybe I should just wait
> for a combined megaseries...

Christoph's is the main source of truth and mine is just pulling his
patches and putting the fuse changes on top of that :) For the v3 fuse
iomap patchset [1], the iomap patches in that were taken verbatim from
his "refactor the iomap writeback code v2" patchset [2].


[1] https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.=
de/

>
> --D
>
> > Brian
> >
> >

