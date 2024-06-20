Return-Path: <linux-fsdevel+bounces-21983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCA9109A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662FBB20F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6D1AED45;
	Thu, 20 Jun 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fR/8tzi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8C27456
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896919; cv=none; b=GFe8jnMr6JKrOKEG/wWmTa7OabsMRg6YjblhtYuQhnpLPHSw1OH8i1aqebxZWnUZKiclIsYOqj4DoUhbdwIEXKG7ICT5WyyE+qwJ3oA4lnbAzQAnGXGWDdwT1Xn6AtLiK74wM+hHbueFA0/Y2emdxox8nxblF2wdwNxnPu8vBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896919; c=relaxed/simple;
	bh=0VfEbqmlOUQ+zPYRUL/IOuev2P5Zh4WeBNpMp1Cizo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb6j0+Cy5r1NeUtNlC+BvBLwizgNc7BfdhEl++959so4mff74LWstivZUUjMHHk0YJoGgVNxBzi0YQZm8pbzY0UZzo6FORv1bIMYL4kDOFSeHUUn8I+4VI26oG9C8iv6TWq6MSXfQSpn32RavACYWenvH87QDyLjhrVO9A6Yj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fR/8tzi5; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-254f646b625so149338fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718896917; x=1719501717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eRgwO/9COpxcofzFfOFxfJtOVnLPVv3E1DKVsbAftQ=;
        b=fR/8tzi5zJGuhPFxdnVYlUXTu5P1PLg49jbamExtdQJuUVOrMKVbWYoWOV9Pk0Trkk
         Nn19bxFUq0LcN+YTKdFos3BfQoNpvE/h2vibOi0TzyvbErCiMBD8LnHuIX+qIB+2nWNR
         5qDO1BPdeftr02p0TSiYJySxvRzSg64tIQQbktfjq0DTiUmIR+zoAySRpjMWfLO8KpB5
         B248UZytnH3uLgRMYg5Vc6jislYKG+YQrTYNiue3Ft6SE5cnRvTP2aA41O4KeAP+4NgE
         /MEZpUPfNVOh2BcLlNJ5Q3sTE+0Q+6F647IXnZRQGnXINe5Evt/W13G9JqxGUdeAhQfp
         OKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896917; x=1719501717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eRgwO/9COpxcofzFfOFxfJtOVnLPVv3E1DKVsbAftQ=;
        b=OoX70CL4QzjTUL/BOqq7T5g0N9XRNrffqVH0HPb2qeSw5an6kVJk1it2EBI85wn95d
         zHgJRJVBEMYRJrpqiXb9fQYI5K/KWrc6ucGYZvRdgWNXMgcERT+eo/eD50hRXG3Afoq7
         gnMJmgU9nInOCdgFYekwtO370e430ejhq29ROA6Y86jdgtvFD15/GMV6QBF0UTC+0QcZ
         D+daU23q3LYu6d5KKB3F7cDEtUaHFoj7MSd1Cel4bYJ90/dI5WbyHJY7AWc3GDpVDDVQ
         06I/18ARwHYXZLFvxOoVj63Ty6qce4VGw1toQF4Ihf/b9gqI8Sx3le2LiLOvcZ8YelQh
         oyrg==
X-Forwarded-Encrypted: i=1; AJvYcCWI4JEVQK15cPSaufN3tcplvHn+s+yR44Xe9dXq6QM80UjFU5dhqrNy2/mxDbhtjZyE0ibXNToxAUXVSDut5pLqpL65/0WwgZGAAPULww==
X-Gm-Message-State: AOJu0YwkGeGJJxSFUNAYhO8uC2EH4VeP3u3lHE7MA3/l2keBmIjIDZu9
	705pUlM+zSLUiS3EiKbN0OtsmleuSRB/eaXl+cNmjmEtDQC5LisUC1tKzHh3SGI=
X-Google-Smtp-Source: AGHT+IHGpP0EBmPWd6UInic4MRJR4Lqjws9grnz0EiC/pvvYKid6gK40o+JqvLJ7p0Yih23/lzz1RQ==
X-Received: by 2002:a05:6870:1714:b0:258:4ae8:4aec with SMTP id 586e51a60fabf-25c94d411damr6291640fac.3.1718896916689;
        Thu, 20 Jun 2024 08:21:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f69asm4297303fac.45.2024.06.20.08.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:21:56 -0700 (PDT)
Message-ID: <9ef3f46e-1534-4d93-be98-22cea3bbef58@kernel.dk>
Date: Thu, 20 Jun 2024 09:21:55 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <ZnRHi3Cfh_w7ZQa1@casper.infradead.org> <20240620152026.GA25908@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240620152026.GA25908@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 9:20 AM, Christoph Hellwig wrote:
> On Thu, Jun 20, 2024 at 04:15:23PM +0100, Matthew Wilcox wrote:
>>>
>>> and have O_DIRECT with a 32-bit memory alignment work just fine, where
>>> before it would EINVAL. The sector size memory alignment thing has
>>> always been odd and never rooted in anything other than "oh let's just
>>> require the whole combination of size/disk offset/alignment to be sector
>>> based".
>>
>> Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
>> doesn't know about this yet; is anyone working on updating it?
> 
> Just remember that there are two kinds of alignments:
> 
>  - the memory alignment, which Jens is talking about
>  - the offset/size alignment, which is set by the LBA size

Right, that's why I made the distinction above in terms of size, disk
offset, and alignment - with the latter being what we're talking about,
the memory alignment.

-- 
Jens Axboe



