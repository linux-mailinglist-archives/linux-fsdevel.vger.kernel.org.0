Return-Path: <linux-fsdevel+bounces-22819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B7591CE77
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EB81C20F9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D33B2A2;
	Sat, 29 Jun 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPYY1FQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B327456
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719684046; cv=none; b=HKWi3eFHAQhDXpM/iujlWoc/Q/oLHxRlMlbII69XrzFSwjX0dt+1+7+Wq+JUOTF9XOHN22qRFR1upXP+HSPfghiSRSyW7RGVaxXP3DMt4/4PhbtbV2YiInDr/21RHQumsugO8Hl+AASQAZndt9DlOL4yJbeZVV8joTpQHuMAuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719684046; c=relaxed/simple;
	bh=K2tJ+lDEhs+Tv6hWaZomRjHqzEv7xvaE4T/jT9faUU8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFkK/Qdl+qKDSsSBfZDcZwBbCi1cQAjwkY7MqdhpCi8qLzw/yBM1syJ8mPZLLiAOwlePsu7uqmJX7ayL5qLpIggKEnwuhgyR9WTODM2aoTMuOHVkJNlOVF4s+nwinewEYxRePUe4Ha1J+raN0f4CZPzUCdfBDZeFccvBU39OS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPYY1FQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719684044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj/Unqu+T5hHrLec46Lg5zWZYwqiplNRUQpDpeLbAm4=;
	b=CPYY1FQPEFPxNcg6vgPZIlGyLZZUoDPdOCenHulSfqYSy8/FZqCCAJDOxLqvA1DAXsSTYX
	A8tGr65hdemub+Er0gbQcuKUpCbc81S26NLF5JIDL57PKgEJOTxXLQLYRzpRv/NPZ55oXJ
	jGvSe2zogJer/stWlHLRJemcGb1VKvM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-BP_KeesAPf2lN98bgurp_Q-1; Sat, 29 Jun 2024 14:00:42 -0400
X-MC-Unique: BP_KeesAPf2lN98bgurp_Q-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so107975239f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2024 11:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719684041; x=1720288841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hj/Unqu+T5hHrLec46Lg5zWZYwqiplNRUQpDpeLbAm4=;
        b=nzm/vxn/w6CMKGdz5xomXDNhdzRaayzepSobfB7JG9r0tdw4xJyFOZy15ndfuRg1kg
         RvOSlG0iAi9xLfYJ4ZGvtAs1hNCPCNIAQZiiF2Hxh4SBWwa6oLy4IAKxt4TX98re78sn
         sbmX8pcYyWBVknMOluPKtNZvgFOBM9QHqU2LAB6DuOv9mvpczV1EzkEaFhZVHxTn8MVS
         Kp7Nem/d/OCyZVo290ozIWikfaE1TwiajnQ+y2LBOdUW66OmsVtKIC+jZabDa+HtjBKB
         sxwNDT0y1NP8sUXZEicBJLV1oZOCUFKRATLVZIuI0Dk6wmORzA0cbqxZQYqzGYxa2f0x
         V0dQ==
X-Gm-Message-State: AOJu0YzfnXBKmAqqY3elciIrXZlCI7zobMmpW1tibzrxyuZyB35h/wWy
	c0yg9gQqpGuaaERjAv8cJtcN06VUZPiKbKoz2U2flOwriufRnoOrxkCLG8+Pe3/M1BL0cIc0ZTq
	spl0upFYnVaPTyQR00XH4JmN6aPCyqikNi0hKT7p6ugasi2FZAQgQK0XuBKTC5tgaQV4DCPA3np
	jrlvxphOL6b+Qc/wWgzlUza1Q6aJj8WVBxUmL9GxbDycdAdQ==
X-Received: by 2002:a05:6602:886:b0:7f3:9ac3:65f3 with SMTP id ca18e2360f4ac-7f61f43110fmr215551839f.0.1719684041053;
        Sat, 29 Jun 2024 11:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhSSd1ldkSVbm7iTNPlx4O/0PMqQitwHP6kFGHSaAYmhQfuj8mc1ZPIFUQiB1G4jT0fRDegg==
X-Received: by 2002:a05:6602:886:b0:7f3:9ac3:65f3 with SMTP id ca18e2360f4ac-7f61f43110fmr215550539f.0.1719684040702;
        Sat, 29 Jun 2024 11:00:40 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742badbfsm1175241173.136.2024.06.29.11.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 11:00:40 -0700 (PDT)
Message-ID: <982555b7-bac6-4150-967a-cd68f63574a3@redhat.com>
Date: Sat, 29 Jun 2024 13:00:39 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fat: convert to the new mount API
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Language: en-US
In-Reply-To: <fe6baab2-a7a0-4fb0-9b94-17c58f73ed62@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 12:30 PM, Eric Sandeen wrote:
> This short series converts the fat/vfat/msdos filesystem to use the
> new mount API.
> 
> I've tested it with a hacky shell script found at 
> 
> https://gist.github.com/sandeen/3492a39c3f2bf16d1ccdd2cd1c681ccd
> 
> which tries every possible option, including some with invalid values,
> on both vfat and msdos mounts. It then tests random combinations of
> 2, 3, and 4 options, including possibly invalid options.
> 
> I captured stdout from two runs with and without these modifications,
> and the results are identical.
> 
> As patch 2 notes, I left codepage loading to fill_super(), rather than
> validating codepage options as they are parsed. This is because i.e.
> 
> mount -o "iocharset=nope,iocharset=iso8859-1"
> 
> passes today, due to the last iocharset option being the only one that is
> loaded. It might be nice to validate such options as they are parsed, but
> doing so would make the above command line fail, so I'm not sure if it's
> a good idea. I do have a patch to validate as we parse, if that's desired.
> 
> Lastly, this does not yet use the proposed uid/gid parsing helpers, since
> that is not yet merged.
> 
> Thanks,
> -Eric

Just realized that one thing I missed is that in current code, fs-specific
options are not parsed at all on remount. With this change, invalid options
are rejected.  I'll send a V2 of patch 2 which short-circuits option parsing
for a remount and completely ignores options.

(Sorry, I'm famous for sitting on a patch for weeks, then realizing the
one thing I forgot as soon as I send it.)

Thanks,
-Eric


