Return-Path: <linux-fsdevel+bounces-60404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAEEB4690D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 06:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611831CC1EF5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 04:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCB26981C;
	Sat,  6 Sep 2025 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5zO1gXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096D2405EC;
	Sat,  6 Sep 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757133114; cv=none; b=SNGew/uoAKDz0aFouAFYOgfF1hZCt9XIQRuHS8e/647HkkF7WbS4Uef+sGj7t4kUuZzeqaBgpX+5O/TNV0484mW/Dg+zMlnvnaTqubxK5VDi5pidiAOxp0+HSmDSCi287njK2y/xbocxDuQBGiOvrnOPY4GG7ODn3HlhHe6z2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757133114; c=relaxed/simple;
	bh=tk3uLFQ1lvssNpqZ+oAIcN2xsKgsprOSM1Lv61tNXdw=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References:
	 MIME-version:Content-type; b=Bt/7qRcGIlh0yPNGq2wanE11ESbPsBm8yngRvQpuy7l2K87PSpRPhujKZiQghdAq/oCNY1GvP95Rt3T+Gyw22RxLTMD4wn4jdMD6Cd9BRo8oO8dy2eXbPDOekVOYjLUx3ZT9WmemTQWMr/Rk9rBHlM+plFcVuukxn5kQVXMQrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5zO1gXT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244580523a0so28329195ad.1;
        Fri, 05 Sep 2025 21:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757133112; x=1757737912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taZVQcUzYNHOu86qpcBI6c5R3yv+krgw0OTmQWCiwcE=;
        b=Q5zO1gXT9gbRRbfRJFJTtlj6JaA4LtvutHAm3NM/tJEywvCffKoyuY4o7S4urL4DfC
         h+F9PAarZJPNlylP8lE9IcdovdPPJKqyFdhJwouYFmM/fjcOInQxQp3djF9J3pZyRauB
         31p/Rg7m9RMY5SBcqqw1tAI/L/YJN6T5zl0/Xb5VQvvp4Jh4k2t28FbeDQA5xyjH0PVA
         eCFIG6zDlJ+VnNPY4Eoy+RFoAcEl+6q/ROie+YGUy85+Pv4sjrX/9GOcDnmzmZomXJ2k
         zaPWkVQs4wf4SdNIpLn0wezdRPnUKRQldpywmBe2nW9n6dgO9/gPQuE7zIL/2yVKFD6x
         owWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757133112; x=1757737912;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=taZVQcUzYNHOu86qpcBI6c5R3yv+krgw0OTmQWCiwcE=;
        b=ZVpRKYgDoS62oIFWrw5W7ouoQjdY9sx4YWsueXgz5bFz1+aQ2+JKOj4BjKUmX+Ab1M
         1kdjkrkaBdn+/lPAqnbWH/y2SSylvP6eK5zLbzMhvW8LycTByL7uvtyepzg8+ucayWTn
         GasvQsQpLZ8ACwC8iurNXPPFJinpHqm5PG9jRJVj9dNLuUGbglvbc6UU9m0BqhzpEYAk
         SafDVFczlAOmC/ymihqnjTgTS2DetIc3dEqk9+95PIhpQJkLum4evFnr9vV8/bieuJwY
         PfGfRgQss7IcdJ4i5SGMhN9q+C6dtXTOsyOvgX9g3T3u78rXs+ZwEw39ywnESyPi1ELi
         z5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcxEbBoQ+CFjFgtu2x74ssQa/UrFBE9tPtw2TSmluBa+zZvhq/PfeUJbZwUWLOBcVpLtR/dBo3lcdif/+11A==@vger.kernel.org, AJvYcCVtFwtcVSyV8tmpKWuQtuV0p9UpAzwtnEEymOhQ7K3d/UPYrqkYTJ2gr92v6NOay8Qx+Z4iNDtXuPLb@vger.kernel.org, AJvYcCXECtnRjzsJW9nESEwQj4wG74JAQQK8Hl6N8hLgIIioPUghkU7GXR/1W2I+LE3nI+JqL1wUHkSfJPoEXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyevyC21H3ByHxu8+LCNgD17jP8qHVzFRTuBS8ucoFPSTJN2lpZ
	jHb5wAb3MyAjPyBzJQrK14Gv1rCgrk1FcJuNLnKCVDUH02YeL0db35AQpwLlNCDw
X-Gm-Gg: ASbGncv7vKL0VQojzWggqElloI2B7Nuf04liggcHqXwBb92l7DwCXtoHofgrnnHQ/tj
	cq6nzIPzMkIe00by95lE3BlHYqAOwgdODOJJ6pPvEfvcbll0lplQKN4xt5XVX/iuNy/rS1lB69V
	Z7YkZpxlrDB1Bq88Q6oLZbNE+2bF4ZXXbcvbvGbsY3NNpOvTFapEY0SpS2TF90uHoRZqlHRvXo1
	GOGZ0Bv2UM+mt01pJ/YvhyYIaHBZ1uU8CDKuI5NRDKtKj+6SHp0rJG6FNJDtEeXYrlo8oMMOoo5
	g9klHlu3jbMS+yClse64yi/LzM2TI0nnJlsSXOfuqB3bgyNMlPEZNqR5IZpKRZliFG5pKU5zrOd
	pvWK+QP7uG53p02Q=
X-Google-Smtp-Source: AGHT+IE08lXX+aPkufZ05aBzAdOaMScPdvR43WwI6+QFcRK8/6igEHsV1F1ymSTLVmQkj9nRdQR2ww==
X-Received: by 2002:a17:902:e850:b0:24c:784c:4a90 with SMTP id d9443c01a7336-2516ce603famr15353675ad.1.1757133112471;
        Fri, 05 Sep 2025 21:31:52 -0700 (PDT)
Received: from dw-tp ([171.76.82.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1d2d5a66sm110862175ad.125.2025.09.05.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 21:31:51 -0700 (PDT)
Message-ID: <68bbb937.170a0220.18f9a9.aa0c@mx.google.com>
X-Google-Original-Message-ID: <87o6roi4vr.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
In-Reply-To: <CAPFOzZsbEgmogYMdt7Koau-GzRf9vu8qF7615VNRjW9cLUREKw@mail.gmail.com>
Date: Sat, 06 Sep 2025 09:55:44 +0530
References: <20250822082606.66375-1-changfengnan@bytedance.com> <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org> <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org> <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com> <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com> <878qj6qb2m.fsf@gmail.com> <CAPFOzZsbEgmogYMdt7Koau-GzRf9vu8qF7615VNRjW9cLUREKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fengnan Chang <changfengnan@bytedance.com> writes:

> Ritesh Harjani <ritesh.list@gmail.com> 于2025年8月27日周三 01:26写道：
>>
>> Fengnan Chang <changfengnan@bytedance.com> writes:
>>
>> > Christoph Hellwig <hch@infradead.org> 于2025年8月25日周一 17:21写道：
>> >>
>> >> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
>> >> > No restrictions for now, I think we can enable this by default.
>> >> > Maybe better solution is modify in bio.c?  Let me do some test first.
>>
>> If there are other implications to consider, for using per-cpu bio cache
>> by default, then maybe we can first get the optimizations for iomap in
>> for at least REQ_ALLOC_CACHE users and later work on to see if this
>> can be enabled by default for other users too.
>> Unless someone else thinks otherwise.
>>
>> Why I am thinking this is - due to limited per-cpu bio cache if everyone
>> uses it for their bio submission, we may not get the best performance
>> where needed. So that might require us to come up with a different
>> approach.
>
> Agree, if everyone uses it for their bio submission, we can not get the best
> performance.
>
>>
>> >>
>> >> Any kind of numbers you see where this makes a different, including
>> >> the workloads would also be very valuable here.
>> > I'm test random direct read performance on  io_uring+ext4, and try
>> > compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try to
>> > improve this, I found ext4 is quite different with blkdev when run
>> > bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but ext4
>> > path not. So I make this modify.
>>
>> I am assuming you meant to say - DIO with iouring+raw_blkdev uses
>> per-cpu bio cache where as iouring+(ext4/xfs) does not use it.
>> Hence you added this patch which will enable the use of it - which
>> should also improve the performance of iouring+(ext4/xfs).
>
> Yes. DIO+iouring+raw_blkdev vs DIO+iouring+(ext4/xfs).
>
>>
>> That make sense to me.
>>
>> > My test command is:
>> > /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
>> > /data01/testfile
>> > Without this patch:
>> > BW is 1950MB
>> > with this patch
>> > BW is 2001MB.

I guess here you meant BW: XXXX MB/s

>>
>> Ok. That's around 2.6% improvement.. Is that what you were expecting to
>> see too? Is that because you were testing with -p0 (non-polled I/O)?
>
> I don't have a quantitative target for expectations, 2.6% seems reasonable.
> Not related to -p0, with -p1, about 3.1% improvement.
> Why we can't get 5-6% improvement? I think the biggest bottlenecks are
> in ext4/xfs, most in ext4_es_lookup_extent.
>

Sure thanks for sharing the details. 
Could you add the performance improvements numbers along with the
io_uring cmd you shared above in the commit message in v2?

With that please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>>
>> Looking at the numbers here [1] & [2], I was hoping this could give
>> maybe around 5-6% improvement ;)
>>
>> [1]: https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
>> [2]: https://lore.kernel.org/all/20220806152004.382170-3-axboe@kernel.dk/
>>
>>
>> -ritesh

