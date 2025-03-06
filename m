Return-Path: <linux-fsdevel+bounces-43359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5FA54CC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BF5188CC14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9314A4F0;
	Thu,  6 Mar 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4fRJfx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A313D52B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269569; cv=none; b=pzA+Nab3m3zGL12N3XSzciwdymL8eiPou5oUHvto093inWHs+kYAsbK4MOGNN7OsW6CYn5wpw1tZVD5pUsYyDW3/bkMpXRvFS3VfcUDAWY782M1dCR6qp2eU4iAJiA/5O8xR6aNxoCLwOLe/N+ump8SqlbB6WGAh/mVEJ8rt8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269569; c=relaxed/simple;
	bh=WrqtzWC0xwvi6F9AT2fXYa95OcNU+FznHVE/qmwTd54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o44JqGty4B0F249z/2vpEzAsg3COqwQvP0z8eA8biEGIgdH8ew+cdjdqTLXFk77k1njAidJTqDyzMWuGNduCRzWzy+kYNNiEc28BFH7+XXLJOifsOsTb3scWZvOJXCD+BfBv3xLP1R+RBHCWMpwZ57k/0rRb3Dh4UvorcwRdP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4fRJfx6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741269566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZooRQX1BKvmOK4sDMN2bxn8s21u0gT4SA35hpx5Jgms=;
	b=K4fRJfx6Y07Tp1F/xn7L7G/mjXRnmD6bDOfYXd1YPof34DL6zhwrGp254Q4aXfy321faCJ
	MMp3YDs7fRzbBC5tlTJke7jp1sutJU2Twm9zS41j5d7rlYPgMJ9TE566+N7MDlLB3Cv/uH
	/RK50VeZsglgwrADqduE6m5gjchvBgY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-FTXOUhRDOo-BOHMyo8-nlQ-1; Thu, 06 Mar 2025 08:59:25 -0500
X-MC-Unique: FTXOUhRDOo-BOHMyo8-nlQ-1
X-Mimecast-MFC-AGG-ID: FTXOUhRDOo-BOHMyo8-nlQ_1741269564
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac20d538688so63415666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 05:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269564; x=1741874364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZooRQX1BKvmOK4sDMN2bxn8s21u0gT4SA35hpx5Jgms=;
        b=WacbLzgDnssI9TSTsteAGNNBVP2hKDMHEyhVLnKwlb2Ys08HfdCjJvdAMXsToxrWfd
         l/YgdzJ1HKtpbrnfoKcQ8XpSKh0tjIrMTVZzlgPcNaHYtEAlMAAjkz77UWEv7fwp6GrD
         e/zdyFVK75Q+5+6tT2BQp3xP9uKd0Ed2DUpNEmGG6BgCwESlbm1lkrzm4nrfcHNKOqIO
         KmJGPs3QqL49VElc5QBHD3v3JYMbd5f2/mrytElY+bA6LDnUA0Oc5EaPPoiStmNZvGVV
         6gEE5FHPNaIFT7/fmWzNR3s85NziEgIaCt1MPyldspwwGqRDa027hvN+7E30DKzO3H7p
         v8UA==
X-Forwarded-Encrypted: i=1; AJvYcCVJOAOQfWPsDdfbzl6ZJY+D+mZeLvyNzcXQWUf564pg9ZDzj8Oz7+P/XEzyzDIjTk38yjrEdYGaNuoIJmwB@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWsecUrsBISYRlP9XElMTkrTWmbJlQc+jpChQkSfRbOtlzpvz
	QCn7APUoBJw+kwXULByPUKXk26g7fkjTmZ3bQ+eORyHZdxs9tFTXfOAgkyk7Ajvl64If4X0SEUr
	5uv7tgNLHnwUwASR1E0oOmbhdTUGPSPncYDywFjmMeI+tdQv39RLMa4LODmVBIFZCfX833FVR4K
	dgW2XSrJd8W1K+lhyYKPW9tT97ukJtRVnrg281cA==
X-Gm-Gg: ASbGncs8ytbToYOCv5Rns6b23bUcHY1GzY03I8h4gDl4L881nwfsZ4OC3QOuO8eZDER
	/J4zsflM0aQNDP60kF2nD+8Ziw5kvVSd6QpECm8cVZXuOoMijfqDfLFa9Fyw3xwLX1gRCUq0=
X-Received: by 2002:a17:907:3e1a:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac20da87c3fmr775576166b.39.1741269563830;
        Thu, 06 Mar 2025 05:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/M8v+9xzTHPmLpQ75OAihzQ6mzPMwQ9pLsX1TWkjNDEi6t39DvU097jtsd97RK2Ju6JSIYApTxIBWuz8YYMc=
X-Received: by 2002:a17:907:3e1a:b0:abf:4e8b:73e with SMTP id
 a640c23a62f3a-ac20da87c3fmr775572766b.39.1741269563390; Thu, 06 Mar 2025
 05:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
In-Reply-To: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
From: Venky Shankar <vshankar@redhat.com>
Date: Thu, 6 Mar 2025 19:28:44 +0530
X-Gm-Features: AQ5f1JoxybOFaeQfOnAFb2qT6vfHxfb4ypSveZZzWheKw-_E5068fWRJzQnFOfM
Message-ID: <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Gregory Farnum <gfarnum@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:54=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> That's a good point, though there is no code on the client that can
> generate this error, I'm not convinced that this error can't be
> received from the OSD or the MDS. I would rather some MDS experts
> chime in, before taking any drastic measures.

The OSDs could possibly return this to the client, so I don't think it
can be done away with.

>
> + Greg, Venky, Patrik
>
> On Wed, Mar 5, 2025 at 6:34=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
> >
> > Hi Alex, Slava,
> >
> > I'm looking at making a ceph_netfs_write_iter() to handle writing to ce=
ph
> > files through netfs.  One thing I'm wondering about is the way
> > ceph_write_iter() handles EOLDSNAPC.  In this case, it goes back to
> > retry_snap and renegotiates the caps (amongst other things).  Firstly, =
does it
> > actually need to do this?  And, secondly, I can't seem to find anything=
 that
> > actually generates EOLDSNAPC (or anything relevant that generates EREST=
ART).
> >
> > Is it possible that we could get rid of the code that handles EOLDSNAPC=
?
> >
> > David
> >
>


--=20
Cheers,
Venky


