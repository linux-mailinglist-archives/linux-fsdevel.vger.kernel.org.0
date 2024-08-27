Return-Path: <linux-fsdevel+bounces-27355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB88960844
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C347C1C22983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C619F485;
	Tue, 27 Aug 2024 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9mG0ew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F77155CBD;
	Tue, 27 Aug 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757244; cv=none; b=IBuo0Xj9wtznnV+/93CkLPBiFJlUneoldQBun3dtfnWUJ58ROeqq6JysnW3Gsd5P0MPJz0flbJDr1d57+eg/zPVRJJPU3fQ8ifpdQq7IWSm6MUhBa8IgF3Fs4W80XtWXZlmQu7KZbcWBpSm6KArkHfitPYjSSUN6wbF/58Nz1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757244; c=relaxed/simple;
	bh=sJB6BWfeo6L2k2FVR6KRU+TF3NDH+eFLGAGCx52AgpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ob0LBjqKiJgDScse+jU5DdoGkKrOUwrym7sbnIMti1N7ktXMbgrOSw80wcWsy5NPL/r6SaZKb670G+oHsTiZ3G3VQ0zGhsHQUvAfOyTYK9HwAQ8NOqca52Ky7z4i4y1PdWUpACOKYo4EBY/EYCt16sYFvSAX3p3q+/DdpMEcdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG9mG0ew; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so4158330a91.0;
        Tue, 27 Aug 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724757242; x=1725362042; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJB6BWfeo6L2k2FVR6KRU+TF3NDH+eFLGAGCx52AgpM=;
        b=UG9mG0ewNni3FG+f5iAV4N+6KSOwWg0f22nU3r1rZufNV4myMBnWHWmt5lvxywTjcJ
         wXGjRH7miXSu1T4oGCtaZIyhgHnzX8kRW4d7IK4x2G/KLuqV7SArQ3gziJ/SrlqQIds9
         b71iL83J4k3BkdfP8rivSzclhnXFsLMS8EiZixkMaops37/GuVcTxyxVp/gz2yW8D/cU
         u/aSs8Ml4YrlDqiJYxBM+bgGdirC4kFYkRHqIFQL8qjDswJVN3LIhGW/8XV27F45G82s
         duPAFdbwdsVtocn/zm0n/YELhBuMwjKZpraPHW+LBKHToCH0MhCdG/eXXpZ84i25dvfl
         JWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724757242; x=1725362042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJB6BWfeo6L2k2FVR6KRU+TF3NDH+eFLGAGCx52AgpM=;
        b=ryKEj1Xl9aEZeVLRss0FkrVZZqleX3pcmF3mrAl712ptG0+IUUAgnddG7N+Jj8Nr9F
         /Vu+8I5YTIJ5Du4tg5nlEAmksvPdQ17/Al1ooC4i7DLFPhOGSWkYorXoqJmKb7uGm1op
         V+3fjN0i/vTRV8l0naLmfNU+3/s23ZT6FY6uW+xC91sTV5YCVGDyv+c16lSRyE/ZrlS5
         2rrpLKtRDfh/e30lCUfjPOsJQoBd8aTUCcX4HiyHR13aAvy53n8cr6e9NTZam8rsqcy4
         3XXpQR6Jr8Q7zozR35b93yd1Xd7lCPfG9ilB8Bo5GCdULbE0ANC1/gwn0pQzHy2W9rDk
         bibQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2uVeEMDtMLrcaB/ilAJ5tdJ9+9giWZ5NfS6SHSS61tra9JwRymZaj34tzcTNidmX4o5vbuDTrxqk7@vger.kernel.org, AJvYcCURvEO3DLotTjICthPUt/gQ6shK4XKMZGqAn2T9WvPvPo0DRCt6ETOTto7CNZEOZD8KlO7rINJ3x+fMcko2@vger.kernel.org, AJvYcCUynvI8xS9TMlQHSKSEaUl1pKoVQ3+6n7/1cKMxILcIJkcCpZ5bNGJV3L+2kAt43YslVS+3dTJyVUKFcYeC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr581USSJYybZHV4cyRpniR1k+9G0+Zk4V35rSMYmm4TMo9wwj
	xxEyZ+ka9lwnde9ChyCs5lDG82A5LrY16eRtgAgDgCmaMTnKRVaQ
X-Google-Smtp-Source: AGHT+IGy6XBinqHN2biziYVYPIivzfLbv3BkETS0DT0xIa0yiUoP6SRdTTr1nKiVtLH6NfNaOjw/+g==
X-Received: by 2002:a17:90b:2251:b0:2d3:c0ea:72b3 with SMTP id 98e67ed59e1d1-2d646d269f9mr15273439a91.34.1724757241903;
        Tue, 27 Aug 2024 04:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbd9d65sm13997504a91.48.2024.08.27.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:14:01 -0700 (PDT)
Message-ID: <9cf7d25751d18729d14eef077b58c431f2267e0f.camel@gmail.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: Julian Sun <sunjunchao2870@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>, 
	brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Tue, 27 Aug 2024 19:13:57 +0800
In-Reply-To: <Zs2m1cXz2o8o1IC-@infradead.org>
References: <0000000000008964f1061f8c32b6@google.com>
	 <de72f61cd96c9e55160328dd8b0c706767849e45.camel@gmail.com>
	 <Zs2m1cXz2o8o1IC-@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 03:13 -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 04:54:41PM +0800, Julian Sun wrote:
> > On Tue, 2024-08-13 at 01:14 -0700, syzbot wrote:
> > Hi,
> >=20
> > Is this still a valid problem, or is it a known issue? If it is
> > still
> > valid, I'd like to dig it into, but do you have any ideas or
> > suggestions before I proceed? Thanks.
>=20
> I tried to reproduce it locally but haven't hit it.=C2=A0 Once reproduced
> the next debug check would be which of the need zeroing conditions
> triggers.
>=20

Hi Christoph, thanks for your reply.

Did you use the config and reproducer provided by syzbot? I can easily
reproduce this issue using the config and c reproducer provided by
syzbot. =20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

