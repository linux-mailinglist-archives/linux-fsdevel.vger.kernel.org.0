Return-Path: <linux-fsdevel+bounces-26495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D231495A29A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F22823DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC481509A4;
	Wed, 21 Aug 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gvoknS2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CD146D69
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257128; cv=none; b=Z7DDVtaIoxnEkGS0kZ6vW8WVaqYiBEvaAk3YFz6gEDjorZRqDxY97R+SfprDBWW8nC77V0C9d0PCpv5AT0+bgZzcLm+gN6xBg3G57onsSda/H2+OwSFE7a8IDk7fEWja+jnnLmRDjwGugNYsJQ/I+onhLbvxNlss7hk58TDIkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257128; c=relaxed/simple;
	bh=NVlSLUACrQTYbZksxL/XnbOSecuIJMMiSd8hW7WSQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5N4x5D5QgJYOg9sBGUTNTPf5Oe7oHQwMHnKEnDJOfMPNHBHTjKHlL52QVesOLq9oXqAJ5jaEdym+5/lYoR3dlMmOvXuaeLp62Z8HKa/dFk5WcUl5g/+4XfzMIfLpDNG/FkDV8UUVYa8Vn4+DKeuLxLOpe9BI5LBHfv8t4zcPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gvoknS2g; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334879ba28so1142514e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724257125; x=1724861925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVlSLUACrQTYbZksxL/XnbOSecuIJMMiSd8hW7WSQNA=;
        b=gvoknS2g3w2NbEfjMClN4EV3ISc4D8UwgC0mm+FhBkDFHeZ7iDRR8/y+6uWoSd1PMp
         yCrnd7O9I3TIefS1epvv+cOnJz4jTG7si5m1YK5LggRq93j+IKyaZSBWxj//p+9DRzcf
         UoudPN2bjOVjr8uVu/J6/ej71Mej1NhnHbN7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257125; x=1724861925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVlSLUACrQTYbZksxL/XnbOSecuIJMMiSd8hW7WSQNA=;
        b=T6yY/0xf6Q7+r06KvmhZEyEL9eFxtRmQfYr+q9+ZzeHb4SDLV5nOWBQxbJbEr2bOel
         90ReaOVNuAcBFUgKW7SRlvkap/0xb+C6KLU6NvHizHNmA6ngWBMhAC0cEoTr6qAkx5RT
         KEi/eHnUgtYEZgLCXT6Q6xwIg3AdFkY8n6aNOa99VUsDzJkrQ7sLAlyuUa0P+9q9fRb/
         qqQDSY2sk9TbzFzBgyTlZb11WZ89cfUOHq94otrrcVMLH0jcnrNjhoBBgghuhMppjyCH
         7I9rSpBh4P9C/KzkuVDhqN96uSzxsvQTm889eJdcsm7/MAibvdOEn0v8tmg9tHPFCDS7
         5SGw==
X-Forwarded-Encrypted: i=1; AJvYcCVCaUdShENQfNFywLTdW7CqNVkfMchBKo2Cd2KlOEL//SVj2h+HyEA2qO1SutZF2NTfvvbq2J0Ktya2wIFg@vger.kernel.org
X-Gm-Message-State: AOJu0YwklORES7Y2G9wG4jxf7u72SGT8LdtC1I389P0HzVEzLOQpsyCS
	TMRQ+dDdCY71oFCp+GRPQufs9AI3928XuVf/2JAOhAd6Rc4wMutLeQqJMqDVoth2BHtOW3ioSGY
	K0fxCJFWq0AT5h4/aCM2xnW1RTO/AGgFj2BS0TQ==
X-Google-Smtp-Source: AGHT+IEVFVvjsajLnyr0LHZrDRuPDoSL8kysC4ZQOIgEyBLhuPNyBNUC2LJB7pO10J7osPvSCAJvGCgkBjnORP6y4/0=
X-Received: by 2002:a05:6512:3b0a:b0:52c:d6d7:9dd0 with SMTP id
 2adb3069b0e04-53348557574mr2029987e87.20.1724257124663; Wed, 21 Aug 2024
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com> <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm> <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <3fc17edf-9fb1-4dc2-afd2-131e36705fae@fastmail.fm>
In-Reply-To: <3fc17edf-9fb1-4dc2-afd2-131e36705fae@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 18:18:32 +0200
Message-ID: <CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	joannelkoong@gmail.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 17:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> But how would fuse_file_open() know how to send a sequence of requests?

It would just send a FUSE_COMPOUND request, which contains a
FUSE_GETATTR and a FUSE_OPEN request.

> I don't see an issue to decode that on the server side into multiple
> requests, but how do we process the result in fuse-client? For fg
> requests we have exactly request that gets processed by the vfs
> operaration sending a request - how would that look like with compounds?

AFAIU compunds in NFS4 bundle multiple request into one which the
server processes sequentially and the results are also returned in a
bundle.

That's just the protocol, the server and the client can use this in
any way that conforms to the protocol.

>
> Or do I totally misunderstand you and you want to use compounds to avoid
> the uber struct for atomic-open? At least we still need to add in the
> ATOMIC_OPEN_IS_OPEN_GETATTR flag there and actually another like
> ATOMIC_OPEN_IS_DIRECTORY.

Yes, the main advantage would be to avoid having to add new request
types for things that are actually just the aggregation of multiple
existing request types.

Thanks,
Miklos

