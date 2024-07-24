Return-Path: <linux-fsdevel+bounces-24207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA293B514
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117ED283070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF715ECE0;
	Wed, 24 Jul 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa+AFWiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49547156967;
	Wed, 24 Jul 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838737; cv=none; b=EzmssbSs6gc4O0BvLV2dkBDKAAmzjll1Tw5FGC25FmuHzvAnRRDR8HTyfEhXsS3UReZU3sOuhsVNgRpy4Ou4m1xJCCfCrLOZMR3ZPQXs/RL7tJvF/v/8lC0CmmDJsJx0HS9FUP/SFKQ2WgSQaHHYeuA9/LRpUf0sL2QISRQdkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838737; c=relaxed/simple;
	bh=scyzFQ92jy9OOzPGhgrPhHsJnyLA/b/uhWSzMgGAsDM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCafBucQyc9ltUVe8lE0lFZBPKnjK4TzjdIe6jIIRGjsSg9ZrLyVvViNqDn/i6MHQ/GNi+vzKjs43w8gYbRZLPbOCxMX3pL8YhtRpilNYOrPQhHCpNKCtfPu1ssnNotaJ8YirRdN+v8emOy3jD5pzwsSy9AhfrQ7VM2QXCDaF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa+AFWiJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52fc14d6689so3548721e87.1;
        Wed, 24 Jul 2024 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838734; x=1722443534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw1HP4C9dFApYaEVgjqdNU8mvTzz9RLC1l5RF4g7wuU=;
        b=aa+AFWiJu1tzNOoOq6WiJsc9em9LVvd90Yj86gmRTc/PMaR9XDuTZLm0vUO3Qbi1uz
         o5qk1SIQSd3jqfN5DnH6VKHfgk0SIziIGJoPLT/05zPAvCqTy5Qu+XzaK/k+v7sk3g8+
         9/14ZQeotQwopXD6UKgkiYyi5abU5GSRnLThOiDkcsuD5lSnBpXD1bOvY8IGug/ygNOz
         h2ivaFrJzX0Ie6ZDJbU6NKxU5Z0yzmkollAy/0B+2PSlgoZxeyooDQTWL1XBa+9lA8kY
         JYxdoLkAD8oXR4/RIxyq8s/1AhpKGk7Ev14GXXNmSSbuxkiJcmVibgjDk0YON6u7UUm9
         gnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838734; x=1722443534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw1HP4C9dFApYaEVgjqdNU8mvTzz9RLC1l5RF4g7wuU=;
        b=qNJaVh7/isAYNyMofbghzdCqUkUWtu0c/noamhOxONNEUdzZwLaGaI3kaL1abW9nn6
         MXNsE/3/Oqwi7UMOH9uz9xJJw/3vuHyP4Igw3qpC1XTVZfiL2h86uwUrvxAF/rV4Yiwy
         vmrijULAp5IsrzcamekNtF/gYM0oacH/gPh9mUsyPnV9sRzhQcwJnK0zHfNBGermLTI4
         xcOpPW7dLTOvvsfyQxZ/sf8z/xS3pIDPFEhC9NvVYCUxHA98CJQ1blDjB3Hys/oWTcrx
         nN4m1NMyXm2aiD74utKB+tLzmQPIW8UBUrOtZXpzllFUaGBE14K6UwVqjHDgngSpV3lp
         JZOA==
X-Forwarded-Encrypted: i=1; AJvYcCW+xJW/2L+zpBMxIgz5FMV+eP12BhWISTFbPN9PWgii3mcFgHCSlSgZ9d1Vd/SwQJg3o283hGzkc759YKa0gP4N2xW/FogO/ojZQ96iRJ0nf83Hx9CPe1BM7+Ay+138cp5h6/JRqfftaNJulfwkVb+O/gQVA258d2T8ateorsv4yQ==
X-Gm-Message-State: AOJu0YwCMzGfkBTzdOpifyNbewDUftRFTP5yhaPxp8jEMB8kK58oy5sJ
	CMzPubNqZkqL5AV3HuTCoYeWk2XxlEnD+PgBEbMQhEG0xOhp490=
X-Google-Smtp-Source: AGHT+IEhmTiBYmoL/pJkI6U2Syqy2qiGc3ZHd8ofLdrOUucG6INU+NQlqegOxUZ8URDVXh2epQW8RA==
X-Received: by 2002:a05:6512:1249:b0:52f:cf8a:ae15 with SMTP id 2adb3069b0e04-52fd3eeba16mr250839e87.2.1721838734050;
        Wed, 24 Jul 2024 09:32:14 -0700 (PDT)
Received: from p183 ([46.53.249.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8eaa7f4bsm210845966b.166.2024.07.24.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:32:13 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:32:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
	surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-ID: <8fca63ef-4618-4e3e-a754-c0118f84e920@p183>
References: <20240627170900.1672542-1-andrii@kernel.org>
 <yv6k4j4ptmyhheorcu6ybdcyemxez6wy6ygn64l4v75zwbghb4@wewfmb3nmzku>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yv6k4j4ptmyhheorcu6ybdcyemxez6wy6ygn64l4v75zwbghb4@wewfmb3nmzku>

On Thu, Jul 11, 2024 at 02:07:18PM -0400, Liam R. Howlett wrote:
> * Andrii Nakryiko <andrii@kernel.org> [240627 13:09]:
> > Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
> > applications to query VMA information more efficiently than reading *all* VMAs
> > nonselectively through text-based interface of /proc/<pid>/maps file.
> > 
> 
> Thanks for doing this Andrii.  It looks to be a step forward for a lot
> of use cases.

Yes, looks like ioctl on text files are the way to go. :-)

