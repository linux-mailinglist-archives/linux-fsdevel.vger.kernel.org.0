Return-Path: <linux-fsdevel+bounces-8869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1C83BE83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5F28AEE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BBE1CA8D;
	Thu, 25 Jan 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBE6lPLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DD1CA85
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177987; cv=none; b=lJxfgrQrThH1VUwKFC2J640TNioi0OwM2v9wzxXHaKWi6in88za/gscgpxpxAhf9UUqkWUqMIYFIcq6V9WFo91ep5SSfy+fEOty0/RgEoM4YWfbJQf7Lt4KXSNsvxTuKiDnvfL281zPQtN+N1ZhJ3EC7X1aH4SNnOBiF/deYiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177987; c=relaxed/simple;
	bh=DesK/s6IZ3AaNC+7BrGuEymkwdFw6BZF0QFoaowEox8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlCh9gTndU9n/acROWk3mtlI3QJLzd1qiT9NOSmXYTGqF1bNSrdGyn4kXw7S/FZC7cVxL8zUbr4V1HGZi1eoQ4nUbI6xt+Y5S6D/uslORlV5+5b5g1W7x2n3/VzOn8bOBQgaqroH5Wf4TCbPTnUbOQFSzpovjGEGlSLcyvijEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBE6lPLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB65EC43394
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706177987;
	bh=DesK/s6IZ3AaNC+7BrGuEymkwdFw6BZF0QFoaowEox8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=UBE6lPLQVtuO5mdCfChycrn0OAdAK6riEOWQbVnN0Fn8o+a8MMurRIQQaa+jhdgcj
	 GeBHkJCTdKcBkzYpgpMOPgapXVn1L4NuupsJgp1q3fE+4btMxK+pn9YF8EbtNwWgzk
	 3lifdGvF5EeRcbq7O1L+VU6Gjy7U/2bsb6mVIo7JHJjSCCrMPFnmBpq/oIs4MO55ju
	 iy6Qv8GONNn5U95RISKe6xPuIYvIXIOYXFrCVPEIBysLzey4hRqOcx51L+yUa+A3fa
	 XH77s0RGm6Nwq01/tBNZpy4LZuy5DfVmj6OUJqkPw8gnn4Nun++sdjmlcnFdEAhw+W
	 xzjnAg9PMb7Tw==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dc83674972so3569012a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 02:19:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yy8ZNRxxpAz3RhJDv9h3u/Uj1aFOISax4OL5jq5JcOzbd9MztvM
	/vUm2zCRLpSTltOHsHTWQIfoZ13Lz7vhLuu+QfEkv8PGM6c9JipxwyGN70P1aVVbWVvMeqD/MyN
	bLcWKybDae/AAMrR0dnAbo5lBWNA=
X-Google-Smtp-Source: AGHT+IFOKfxFm+RYnjfYIPOBsHSCgE/1CgoPH9hrTb4OVrw95G1Os+1S4uRBjXFCLuwWsAO8FMbHxTc7JanDDNvhXNE=
X-Received: by 2002:a05:6870:c6a7:b0:210:b468:6a5c with SMTP id
 cv39-20020a056870c6a700b00210b4686a5cmr622066oab.79.1706177986291; Thu, 25
 Jan 2024 02:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5984:0:b0:514:c0b3:431 with HTTP; Thu, 25 Jan 2024
 02:19:45 -0800 (PST)
In-Reply-To: <ZbGCsAsLcgreH6+a@dread.disaster.area>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org> <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 25 Jan 2024 19:19:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
Message-ID: <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in exfat_file_mmap()
To: Dave Chinner <david@fromorbit.com>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, Matthew Wilcox <willy@infradead.org>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

2024-01-25 6:35 GMT+09:00, Dave Chinner <david@fromorbit.com>:
> On Wed, Jan 24, 2024 at 10:05:15AM +0000, Yuezhang.Mo@sony.com wrote:
>> From: Matthew Wilcox <willy@infradead.org>
>> Sent: Wednesday, January 24, 2024 1:21 PM
>> To: Mo, Yuezhang <Yuezhang.Mo@sony.com>
>> Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
>> exfat_file_mmap()
>> > On Wed, Jan 24, 2024 at 05:00:37AM +0000, mailto:Yuezhang.Mo@sony.com
>> > wrote:
>> > > inode->i_rwsem should be locked when writing file. But the lock
>> > > is missing when writing zeros to the file in exfat_file_mmap().
>> >
>> > This is actually very weird behaviour in exfat.  This kind of "I must
>> > manipulate the on-disc layout" is not generally done in mmap(), it's
>> > done in ->page_mkwrite() or even delayed until we actually do
>> > writeback.
>> > Why does exfat do this?
>>
>> In exfat, "valid_size" describes how far into the data stream user data
>> has been
>> written and "size" describes the file size.  Return zeros if read
>> "valid_size"~"size".
>>
>> For example,
>>
>> (1) xfs_io -t -f -c "pwrite -S 0x59 0 1024" $filename
>>      - Write 0x59 to 0~1023
>>      - both "size" and "valid_size" are 1024
>> (2) xfs_io -t -f -c "truncate 4K" $filename
>>      - "valid_size" is still 1024
>>      - "size" is changed to 4096
>>      - 1024~4095 is not zeroed
>
> I think that's the problem right there. File extension via truncate
> should really zero the bytes in the page cache in partial pages on
> file extension (and likley should do it on-disk as well). See
> iomap_truncate_page(), ext4_block_truncate_page(), etc.
>
> Leaving the zeroing until someone actually accesses the data leads
> to complexity in the IO path to handle this corner case and getting
> that wrong leads directly to data corruption bugs. Just zero the
> data in the operation that exposes that data range as zeros to the
> user.
We need to consider the case that mmap against files with different
valid size and size created from Windows. So it needed to zero out in mmap.
We tried to improve this after receiving a report of a compatibility
issue with linux-exfat, where the two file sizes are set differently
from Windows.

https://github.com/exfatprogs/exfatprogs/issues/213

Yue referred to mmap code of ntfs3 that has valid-size like exfat and
had handled it in mmap.

Thanks.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
>

