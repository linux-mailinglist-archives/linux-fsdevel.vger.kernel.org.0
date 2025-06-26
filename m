Return-Path: <linux-fsdevel+bounces-53119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B0AEA995
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 00:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6A91C43CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF266562;
	Thu, 26 Jun 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VAFFwuGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8D260574
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976578; cv=none; b=dbbKS2LBw6pvIt8kHp7PZCteE5OzzHMLMius9P7iguPNafeGgmExpVXSNg5DZNbu8+5QYnxwQLOEt7SXw2J3P87KWNW8zD6a1TbJ2rERsmND33aGrnLOgnRsf9RD7/6qhbB+Sdy7iGvS5avsgIzormZSYVhtGFw4BwBmjWx582c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976578; c=relaxed/simple;
	bh=a4jHsPRr5enaP3Vr+DhkEerO8CUTIgG6L5ox3Cj8o0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCpV4TDfI+hAq7WVM+IPPFOBmZt6esRyEQTZyo84FxN8sOigU9iScP0WhBUobEGuSHSFvdiLNzoe/nbuSbLLXFRKNlyQMELkP8NkZ+a6jh7+o4lC3mt4PRUX1WrHCR4kb2Wdn9sUJX+S0bSVatGU/RSAqPaDSvkNSVIdITZOXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=VAFFwuGD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747c2cc3419so1447312b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1750976577; x=1751581377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah/vUtoe84nETT7QauJ1wYRip4EoEebv4kUDWBtoCmM=;
        b=VAFFwuGDD8bY3oRCBCUfGf8jbQlV6rpsv1wd2H1JPRkGo947DKeybg2sB+Nd3/FAGw
         3fKXZ4eRVjyRs6LVwVNCWzk9W3lxv6xQc6c/Ijds1xKt2p3l5arUuz6B12mhuhBNknm+
         1D9Chjl09QUyd0uU2m62y5+KsKw/rrjqHx/kZ90UsHi6qngAF640VQXR2TAkFoCc1ofI
         URyGpTBmzq4EvsDnPi21aDkJJPkWVSQInJQ+/YhI9YfRconUlrqFL/sdOYi6r77cAr8N
         /BXaisFG4uw25fIXJLQerGg3hJlgAWw84FtThfoNHUwmNZVSPv2fGhijEExwYQyPMMtK
         Me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976577; x=1751581377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah/vUtoe84nETT7QauJ1wYRip4EoEebv4kUDWBtoCmM=;
        b=NuMKiY7vDi2IfGYWzSFd98u5ZHX9iAVN4T0N5GxQQTZ8wiWKCu24vPweWtNHQ8XOCA
         xxu2bbh3JxcBWznmUDBUerzgTBtpx4UDRp3EuebCnnEIeZ+J5x0qq5lgYa1lJiuvTei2
         iSSzxmxn6dJqbe0es1JzW6mPjqXqtQ5Tdia9t7lFL5+Or/b3dNG+GU87qUgmG4mGCN6r
         qdXbSStsOVLgiQuf5T4f1aLAPB6GtnRndovdN5cOjGg7WSLsYQypbFWGXYzXbkGeRRwY
         1FixIwghaLwIKQdvCXHDD8xYFaA73MQh1jANRJmiqc9QgjLmABLmVQvx/MIp0/rzs+Cs
         204Q==
X-Forwarded-Encrypted: i=1; AJvYcCWW7Tt2shGUqTNHK6L2ZMZRNElxLXRnmKiKRutpXyqShomnpbNCimWaeHFofHv3Tyz42WQX/QXHyE5Kh4/3@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYuOgMHGiZp5Lm1ALpxsbiPiOIbCl3AZCvYElSOLsRn6B7tsA
	mlqD71LtcSay3CplvgVOo7oc9o8dxw6EkeVYhDWqoNS7h6cUxSXM+o3gGzMK7rQqBjY=
X-Gm-Gg: ASbGnct9/anFWO2sjv/KjTmCi7HWTxCiLM62/gpnavPbNvCkTLkoU2SUeKJs3y4aGS8
	G/QF2sungvJOWC1gIe4e/vTHumPivoiWYgh2imCafjVhovRDt2h12dMb9UMgiQ+nKsQ5Z1wcHyN
	hQiBID5ZpCbJPvtP8q9wfZjdEeXKR2T2+9BcEmAG0QO1gbFffYjbDj/sH6nbbATrsu6ajVQA4+p
	lTejyzjTcUJipXzhC2VYBEB81cw7yHI1XoWwUpUUgsIs1sixQP6B/rbvSprzWlR2bzSMw0Eem0G
	ojYtVu+G6zk3r6u00BE+GR+qjSztMgWv/DI9UD83Qxg8Aj3mEC6Oh3PE1uYnieSjQlCcwI6d49r
	cgNQzy/X+/k28emGwxfzqcyyxgwhk4lNB+iuXHwcQR8Ao79UI
X-Google-Smtp-Source: AGHT+IGZqxbYMtRvgBqsBbXs9pkjdt0WrMR6P1AO8ewf1WoamoQJAJslXOV5lUTFgbrAr4tvqgyCnQ==
X-Received: by 2002:a05:6a00:2294:b0:740:9a4b:fb2a with SMTP id d2e1a72fcca58-74af6f2fb92mr1155053b3a.20.1750976576844;
        Thu, 26 Jun 2025 15:22:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55786efsm645858b3a.82.2025.06.26.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:22:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uUuzd-00000003eTL-2bwB;
	Fri, 27 Jun 2025 08:22:53 +1000
Date: Fri, 27 Jun 2025 08:22:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aF3IPcneKbUe9IdH@dread.disaster.area>
References: <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org>
 <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
 <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
 <aFzFR6zD7X1_9bWj@dread.disaster.area>
 <aF0gEWcA6bX1eNzU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0gEWcA6bX1eNzU@infradead.org>

On Thu, Jun 26, 2025 at 03:25:21AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 26, 2025 at 01:57:59PM +1000, Dave Chinner wrote:
> > writeback errors. Because scientists and data analysts that wrote
> > programs to chew through large amounts of data didn't care about
> > persistence of their data mid-processing. They just wanted what they
> > wrote to be there the next time the processing pipeline read it.
> 
> That's only going to work if your RAM is as large as your permanent
> storage :)

No, the old behaviour worked just fine with data sets larger than
RAM. When there is a random writeback error in a big data stream,
only those pages remained dirty and so never get tossed out of RAM. Hence
when a re-read of that file range occurred, the data was already in
RAM and the read succeeded, regardless of the fact that writeback
has been failing.

IOWs the behavioural problems that the user is reporting are present
because we got rid of the historic XFS writeback error handling
(leave the dirty pages in RAM and retry again later) and replaced it
with the historic Linux behaviour (toss the data out and mark the
mapping with an error).

The result of this change is exactly what the OP is having problems
with - reread of a range that had a writeback failure returns zeroes
or garbage, not the original data. If we kept the original XFS
behaviour, the user applications would handle these flakey writeback
failures just fine...

Put simply: we used to have more robust writeback failure handling
than we do now. That could (and probably should) be considered a
regression....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

