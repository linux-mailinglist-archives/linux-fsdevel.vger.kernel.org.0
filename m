Return-Path: <linux-fsdevel+bounces-48479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB0AAFAF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8579D463631
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053C22D7A6;
	Thu,  8 May 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JWf8NvVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6A22D4C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709821; cv=none; b=XjNJTtWRzFEUfrLDN0jtusDCi8gZNmhVPGO6t2rxk2bdsN8QARAwv+pfeDYBO6TIRMgbLogkUOEnPvfTdse9k61gWBVCxLx//rQ+grIyeyQUIV1++EsxCegnT3JlJSdUU8axhX853ZrR3ue8aJ3YfinwN54hBKqpdAXko4mIEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709821; c=relaxed/simple;
	bh=p3igjo1WeQ4ei3xNoOb2bq7IvOmv4IUIwEwUY8QYhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGK5EsxS1xRPl0P2sNxffrPpK2ceRutSxi6M9T0wdeRK8OXd9C8B1UXegibsGRlnopTndEN4A+xta26/rDYIb6Rc47AMs8MdydIvhFJYctRZj3bV89iXJd9mpQaPx8joXOK2j1YIrT6JguhapKmSebf1eHOvip3tL59ITlUx2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JWf8NvVK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774d68c670so16227911cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746709818; x=1747314618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=JWf8NvVK9bUx0/Ju0P0yDXn6tL+F8x5LDb8BTcVfNadkKrSjQWAvuLseMheqG+1Slg
         zV0ej5oRae3oaQR67NJzvwpIz391Qv4j97wTp/dpjFRZ0oZ0Boag0F5hG42/2G+JreZX
         pBWHMwLA0rZ0Ue14AR+cT0qB24c8Co1T64YpB3Wx2r1KPiczlfTeqq9NHreyncmE9w/D
         hYXmy/2d4kZ0mXeHVxwxyn/33ydCWqx29AlspiOp1I2Wcftj4rXXu6moiUGI5897TwgE
         xobMNV3ljgx53LwTKfs0uw0oyk3KQB4X994AcNUDhYv86UDtnic8iXAvZiYYAMPFx4E1
         eT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746709818; x=1747314618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTDtbe4K12xhEpViDB+3A6qWj2g+MO64MrS+vZvyuzM=;
        b=t8uY6Ts/PgJO6h/o2Z2Nq09q+9MYPxjoN51gElcBfK02euQ74FnRjKmduyeRGsiwUI
         BpusTbE7Ua7f72SPnTYAJDWGblskGA3eQOxXTbZCAkW1xMucY4juxGlYSdBvqYjvS79V
         EVuLSmVkPD3w7j3n6wSn6uUTWOniE46kNdAY0cijUtt3mey2jio35Nmu6FyDqNQJp8lp
         Ij0sU+5aXXAoVQw5GvKqF11b01fDqJrhY9wvqDtfCtRXUYeabtN81K8WxCvEjRGsxWss
         sGlx6+lTY+vHEZ40AW1kRT2B10OJzBqKdQ2AxfiYu6Y50J2wqQyZrnTmqO7qOMmlxFSF
         TXOA==
X-Forwarded-Encrypted: i=1; AJvYcCXmvVQlGUrotbxGSd7yfVk0bfTLHpyq+cu05OlhVXSS7fOorIv8kq9TVqsdSTOTKxB8ihFRPz00b1Qr8t4x@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4p22qXs+9s9x6yAd4cPZ//7lu3pvgpejS8EFh3w2wfz1b/oe
	KPp4QF/mZV5vAdre3VNpYipznkEtDh1iKD4b/5bZCCaM031NLD6H54pVfoVtrD3I32VmUMChSCt
	0
X-Gm-Gg: ASbGncuaoAx1Nf8GzQSlfFnW4J2kpOvXuj0qNoDF6orIPdR3/CTW94/08Tzh+Bw0Mf/
	cMQjq30EyTWfjtQq+DeIDTfm+R+EapGmsQ0gqS4tmKuaG5Cj6d6SPO2OKgT+VVhhG78AkVN4JlJ
	K0GuNZ/Lalqw2Gi4SUSopnWUc5rx+xmWQdU1EAYk22tcYyJAtWv2fb1Pq3sAcw6LqFYQK/irZYi
	u6dpPgh1p8o+M15I1VDy+ah2ea1YWKh6wEKI0KlZoiX0he6R1FXJQ58gaFgy7FsUo3o3VWwgVAn
	VsFm56vHsaBtUYUTql0MflP/ciYywRYJutUSQfM7H9Lck20=
X-Google-Smtp-Source: AGHT+IFc67B3rj29wLwGe5b9hNdUhbBaJDAFmOrgjOa9uQdS/eOlhjhIK4I5PRu/Z5lCJQDbW0IFWg==
X-Received: by 2002:a05:6e02:12ef:b0:3d4:6ff4:261e with SMTP id e9e14a558f8ab-3da73867d6fmr68904585ab.0.1746709805765;
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945471sm3173148173.70.2025.05.08.06.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:10:05 -0700 (PDT)
Message-ID: <0df727b4-c0fb-4051-9169-3bd11035d3e0@kernel.dk>
Date: Thu, 8 May 2025 07:10:03 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 6:52 AM, Matthew Wilcox wrote:
> On Wed, May 07, 2025 at 08:01:52AM -0600, Jens Axboe wrote:
>> On 5/7/25 6:04 AM, Christoph Hellwig wrote:
>>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>>> +		size_t len, enum req_op op)
>>
>> I applied the series, but did notice a lot of these - I know some parts
>> like to use the 2-tab approach, but I still very much like to line these
>> up. Just a style note for future patches, let's please have it remain
>> consistent and not drift towards that.
> 
> The problem with "line it up" is that if we want to make it return
> void or add __must_check to it or ... then we either have to reindent
> (and possibly reflow) all trailing lines which makes the patch review
> harder than it needs to be.  Or the trailing arguments then don't line
> up the paren, getting to the situation we don't want.

Yeah I'm well aware of why people like the 2 tab approach, I just don't
like to look at it aesthetically. And I've been dealing that kind of
reflowing for decades, never been a big deal.

> I can't wait until we're using rust and the argument goes away because
> it's just "whatever rustfmt says".

Heh one can hope, but I suspect hoping for a generic style for the whole
kernel across sub-systems is a tad naive ;-)

-- 
Jens Axboe

