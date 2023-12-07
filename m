Return-Path: <linux-fsdevel+bounces-5205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B343580959E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AC7B20D10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74065027F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EmVgL69G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB41713
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:04:19 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so1978039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701983058; x=1702587858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnOdAbbW738dDSEwDw+Hubt/xTKBIoFneuu6uVDJrR4=;
        b=EmVgL69Gcfk88PCbu0YXOI4s4z+u9IJ8dA/eIqX9krBF7ssogYil3FgLyEVZq6iHOA
         Zq8YoXgSMKMdNDhA4XFXJxFp+8CcYjD/Us0Igi5qJlluh86+XXj9iAjl8Zyj08vg7Zg5
         xY5IXD5RLzoYF4POr5vTB2TNz4+LFkvUZk+R0Q+9esNtYIQRkmQUECyYlUzmXObPwhrm
         oHt07rh8cG6mzMPjRuAzV/2STMl5pfHXFmOyBIUvpsm7ejDig61iMbInoQ6Vt35hVLEN
         VRbKbg2QEIkwCxBjry4Os8mu23XhETHAK0hnCkWeZPRKKnVy7Pcc25sI7MehdtJCG0CM
         2R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983058; x=1702587858;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnOdAbbW738dDSEwDw+Hubt/xTKBIoFneuu6uVDJrR4=;
        b=VrDqelyvXF/WAWLl2/YiAhsro6IQjNu5x9GMBM+cFmMZ5eTEuuy5Vp80mFwkm/83Ig
         0FpOj0fkdjaLJYNCGJvxjl76qmyJAE6ksxV2j9svjIBdqVkOXbOLMNBbEoHjHT7WmRWf
         xLdKbsHxYSuWCDFGmYzY2e/z320c2EqWvkwIsDB7L2HqZLFMenhiBvgJLol1gTzF3Bf7
         /swi9i6LVqZPKiwVbGSwhJnkaeRQkSnvq/VhL/dih1MRbgrxbUgJH3DcE+huQwFDLa99
         VpYXOEjZ4OaB4M77M4EUW8ZKBc0bAkTyi3VZZ+Z3Piqnlr1XUdAFfCjjHR4AEOSBR3x/
         kqUQ==
X-Gm-Message-State: AOJu0Yy0c1QpeU5aX1kl4ZYN2L1tKKw1NejzqmyF7aKfKfmZRj54kMO3
	NcUWIXgBVr4DVtm+Yu7JtOgxlA==
X-Google-Smtp-Source: AGHT+IGfk5tzSp7oJ5ohoU13545PtMbkNpTMDj2V/8iQwlmAOMGlnDVaWU3/3N545c7XpSLYZp2/tw==
X-Received: by 2002:a05:6e02:1d01:b0:35e:6ae2:a4b7 with SMTP id i1-20020a056e021d0100b0035e6ae2a4b7mr332658ila.2.1701983058607;
        Thu, 07 Dec 2023 13:04:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id db1-20020a056e023d0100b0035ab93df306sm122027ilb.13.2023.12.07.13.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 13:04:18 -0800 (PST)
Message-ID: <8d81a701-63a4-4d24-b5d0-124628234974@kernel.dk>
Date: Thu, 7 Dec 2023 14:04:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
 <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
 <ZXIx/FVRYb8E5r37@casper.infradead.org>
 <4aef0190-8749-4e04-b061-03b8407b8954@kernel.dk>
In-Reply-To: <4aef0190-8749-4e04-b061-03b8407b8954@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 2:01 PM, Jens Axboe wrote:
> On 12/7/23 1:58 PM, Matthew Wilcox wrote:
>> On Wed, Dec 06, 2023 at 03:40:38PM -0700, Jens Axboe wrote:
>>> On 12/6/23 2:34 PM, Kent Overstreet wrote:
>>>> On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
>>>>> This patch reworks bio_for_each_segment_all() to be more inline with how
>>>>> the other bio iterators work:
>>>>>
>>>>>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>>>>>    one in the iterator and pass a pointer to it - bad. This way makes it
>>>>>    clearer what's a constructed value vs. a reference to something
>>>>>    pre-existing, and it also will help with cleaning up and
>>>>>    consolidating code with bio_for_each_folio_all().
>>>>>
>>>>>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>>>>>    this makes their code clearer.
>>>>
>>>> Jens, can we _please_ get this series merged so bcachefs isn't reaching
>>>> into bio/bvec internals?
>>>
>>> Haven't gotten around to review it fully yet, and nobody else has either
>>> fwiw. Would be nice with some reviews.
>>
>> Could you apply this conflicting patch first, so it's easier to
>> backport>
>>
>> https://lore.kernel.org/linux-block/20230814144100.596749-1-willy@infradead.org/
> 
> Yep I guess we should... Doesn't apply directly though anymore. I'll
> check later today why, or just send a refreshed version and we can get
> that stashed away.

Just an added symbol, applied.

-- 
Jens Axboe


