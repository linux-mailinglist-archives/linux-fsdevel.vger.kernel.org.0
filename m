Return-Path: <linux-fsdevel+bounces-20029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706288CCA49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 03:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C43283B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 01:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545CA935;
	Thu, 23 May 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Dji7+uYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB186FA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426670; cv=none; b=aa89OJM9xIj2Q04YCwvXopBC5oKM2GJ6NqfZtYGjcXIAf61HykDK58YUwd+Z0IFbW1n701jRZju5IJehZ4IkeBt52/bE/+xTLkmxBY4HWfc4ieyXMN7ImwpqX3k1JZVhloLBIo7KnKvCxxNfxuST7tezh9F04qp1mnZb2mAquqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426670; c=relaxed/simple;
	bh=irmPEB0EJHZap0scHqXlwAoFaMpePoW3FnqN7BaOryk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBYVtnvsRtj1aHgfH2YeEnmYslfO9diwt82rrQDZ9AtoJjKqrowK23aFDOwKWFveJq1Ed9GC78US47pGpqLi0tMRDUZFf1Z2+fhqrJbjKx8mCV3+nG2hyfWF/TYOutXjiKkjDAmVDESnzfM3F4BBSrZWb8nQWbhytaVFYasyK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Dji7+uYF; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b296194ac1so4182854eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716426668; x=1717031468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmvUqD+Lw4cLCsEe0vSwF972lL7nlr8Q3vsLBnKUsoc=;
        b=Dji7+uYFTPtSdPwm2cXr8wjncXPx+e1dWVj7qrpHYjJ7T6l3XIVsCUkv/UDMwtOFQ/
         KpXm3NRTkB9POaEAxRUcvzQ8uAN6o6ALv5WzfQTDjkFT/i6/MKPCt8zb1QwMNbpKGmSs
         1WBO6JHhNfHnlWA4AXwS4++xG79uNrQcFSAbIujB0AbaP08cYlVPLF7kMRQmc8EZSCvP
         loyIyNqq06i46/mxIGKcCoPwh4NU/S9ZsqtMITsfu7M9cYkAPu9Ku1va5nV7ycQsEeYd
         m5KjCXfIlacnd3CMEjT7imUxPlb2n+E4wWv1EHOUE58lxlT3f8HeqRXrOWlm9hqsCOSM
         +UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426668; x=1717031468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmvUqD+Lw4cLCsEe0vSwF972lL7nlr8Q3vsLBnKUsoc=;
        b=jZ+2KgJLkiL8ZMtMsul99IZ3BBWAaWbn5f5O/HSwEwlzWWVjhH7u/UH1OCMr3c35QM
         m9ZhQAFR/f30e0jTWzZQJz1G0ahnLWrjs5q+KbxlwpExB5H41RfuuOSk+UAV8REDcQQO
         VUNNW+Z7qXUPJjSGzdTcYdYyLJtQ9LqbYX8qa3sgXyqXou7RKBmiTI4GcvQ9sqjKSK6R
         WAnMbkEIUYiCCRX7bqvLHnuxI4o3lYY3GiVe1vAG0W8dFiSaJCnxsUAn1f4cof3vw0vd
         GNMLLuUQi37J9NjgzidbrnHzXj5f7Tg2n1jYimHNLr8DVH0bU0yyPiSzAGKyiD28mfST
         dkfA==
X-Forwarded-Encrypted: i=1; AJvYcCWcd3OztWR+In+L8FAgbLsWAJhxHVDsT8yMWNxrLADZdvKgjzAqJxnnwsCTyijK+DAVgkOiM7qdCOlBORnhwJ8KG9tns9LOQ18z2dd+pw==
X-Gm-Message-State: AOJu0Ywv+VUrecsWYe6ufQoCqNlTRS0mG6w6H7LvM1C4OdDQfXpA59bo
	XB/oiMSKdJP+tqYqAoBhyLR3PxEm/pUXJ+KHRnqTPPeh1gSe23ax4AHn9RQErXA=
X-Google-Smtp-Source: AGHT+IHLpQjpY/ZDizwGZZhnZO6kNpcNVrezvsSVGVdrwzcu/g7Obm3i7DB5DFERDBG9ikNNOGjsXw==
X-Received: by 2002:a05:6358:614b:b0:183:a0ac:b638 with SMTP id e5c5f4694b2df-19791b6fceemr296203455d.11.1716426667893;
        Wed, 22 May 2024 18:11:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341180dc5csm20062714a12.93.2024.05.22.18.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:11:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s9wz2-007786-19;
	Thu, 23 May 2024 11:11:04 +1000
Date: Thu, 23 May 2024 11:11:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <Zk6XqIcO+7+VPn35@dread.disaster.area>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
 <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>

On Wed, May 22, 2024 at 09:57:13AM +0800, Zhang Yi wrote:
> On 2024/5/21 10:38, Dave Chinner wrote:
> > We can do all this with a single writeback operation if we are a
> > little bit smarter about the order of operations we perform and we
> > are a little bit smarter in iomap about zeroing dirty pages in the
> > page cache:
> > 
> > 	1. change iomap_zero_range() to do the right thing with
> > 	dirty unwritten and cow extents (the patch I've been working
> > 	on).
> > 
> > 	2. pass the range to be zeroed into iomap_truncate_page()
> > 	(the fundamental change being made here).
> > 
> > 	3. zero the required range *through the page cache*
> > 	(iomap_zero_range() already does this).
> > 
> > 	4. write back the XFS inode from ip->i_disk_size to the end
> > 	of the range zeroed by iomap_truncate_page()
> > 	(xfs_setattr_size() already does this).
> > 
> > 	5. i_size_write(newsize);
> > 
> > 	6. invalidate_inode_pages2_range(newsize, -1) to trash all
> > 	the page cache beyond the new EOF without doing any zeroing
> > 	as we've already done all the zeroing needed to the page
> > 	cache through iomap_truncate_page().
> > 
> > 
> > The patch I'm working on for step 1 is below. It still needs to be
> > extended to handle the cow case, but I'm unclear on how to exercise
> > that case so I haven't written the code to do it. The rest of it is
> > just rearranging the code that we already use just to get the order
> > of operations right. The only notable change in behaviour is using
> > invalidate_inode_pages2_range() instead of truncate_pagecache(),
> > because we don't want the EOF page to be dirtied again once we've
> > already written zeroes to disk....
> > 
> 
> Indeed, this sounds like the best solution. Since Darrick recommended
> that we could fix the stale data exposure on realtime inode issue by
> convert the tail extent to unwritten, I suppose we could do this after
> fixing the problem.

We also need to fix the truncate issue for the upcoming forced
alignment feature (for atomic writes), and in that case we are
required to write zeroes to the entire tail extent. i.e. forced
alignment does not allow partial unwritten extent conversion of
the EOF extent.

Hence I think we want to fix the problem by zeroing the entire EOF
extent first, then optimise the large rtextsize case to use
unwritten extents if that tail zeroing proves to be a performance
issue.

I say "if" because the large rtextsize case will still need to write
zeroes for the fsb that spans EOF. Adding conversion of the rest of
the extent to unwritten may well be more expensive (in terms of both
CPU and IO requirements for the transactional metadata updates) than
just submitting a slightly larger IO containing real zeroes and
leaving it as a written extent....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

