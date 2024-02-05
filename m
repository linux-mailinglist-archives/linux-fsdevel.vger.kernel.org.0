Return-Path: <linux-fsdevel+bounces-10237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78B8492C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 04:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC45283717
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB056947B;
	Mon,  5 Feb 2024 03:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uC3wklqO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3478F56
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707103344; cv=none; b=bRT/Y65doXeXipQLvcBkANUhmtsVnFs216qBFLrqboPqODJoY25wFwkNYlfpseJTQTSyOzlwN7fHReeMOgfL6upu2IepdXlodTe2hKnmACQq4Fsi0n3mxAqyvAcxcTNmrlG4ummXyWv7iesJFq/ry01gET6iqLYA1QZnlO00Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707103344; c=relaxed/simple;
	bh=XyfhPnUoJODxNc3ZwrhuRYhadqhOm857n75FXTfvnbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASq+WHhNrasF5QCuNMMDYA50oJddzWj7h/OU4AgBlvicw/26b5TXux8H7j1iTv33HbcWCeTdPR4sv4Ld9pH+Qm5Me1XWg8W5SydVLZY2EzozjLIPSQmxhXp2M84yaAkJWdMbpDU22mAktE6a6PLr/yKBhkYIF6UrDIZngYD0pLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uC3wklqO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so28511145ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Feb 2024 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707103342; x=1707708142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwTm1RkSWsek/ZgiLOPc1M2nPjnWCBsumYI1gxSnKuM=;
        b=uC3wklqO1wpVn8rupE0CLBkrKmYG8dngfZgTdtk8AkHeH4Q96vgivu5gpxjk7v63wb
         oS0fxY4YNespi7F8L5FzRtMLKagAU81sawrxc8gg1aNYCRZWogPH4XREMyiP5QN3t01F
         lZHIictsQ71LvtP1bqi6b4tzs50t0PPl/R8ikygSCgw2Ys/DLRJ8tqV0IQlCg9z6V3wj
         IlZj1xSjyzQWFUi8X9YR9d9cRkTuSn3B4dxbA8f3bGYLw1S/qSbQX0egirshzySenZdc
         i3VLteqKz69Z4GOXZrZ/s7agGoEUtgmVlxpbKbCPG17XcowXFKnhdtNZcPYNq4NhjdOA
         B8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707103342; x=1707708142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwTm1RkSWsek/ZgiLOPc1M2nPjnWCBsumYI1gxSnKuM=;
        b=A67EKQdPB+tGXN8AGJ87y7vXVaoTIWseuwQ9tZKyKLQhKYBb3TpGGdq0mhjPb/m+tL
         CIHp1B3gB41biFLSyAqB/ia5CsfrKD/hzZO+/xZgwRt8Kjk7+E1VJojUf8GWPPmiIu5b
         YOx8mkE0h0ExLfYVsH/xWh8KjKvmYFxUlkWS63fPhQ3X9ZCkuTWOyk5Cb3CCkfQRphjP
         fRJzoIi4ic3EySYYFtL3CjDADBN10oMagQlvS1z+J/HMkOq63xi7bYLHj4onH2wgzUvA
         SzoBSgO47pSWLpb2IolIehrlsuhowaZOwnCgA7eJbRHvA/UaoqijwptZFcRMcrL01UEL
         QLZA==
X-Gm-Message-State: AOJu0YyWAEBfZGOzic2nUU7OKc8yN4UwpCgM4FLpA+0nR0wR1nIkYnBS
	i02/7fhShmyyjcGK9x0SCLkh5Hvcwyy2tTbzwotFP+KoiTZ1k4pYzP7WtGQc2zY=
X-Google-Smtp-Source: AGHT+IG6GUzFbraMrLLeqMuICqp2tzxiTV2VqxCUIPu0rjbJWAwPxgLxJJdHBNtXdKFLcBm5yuliyQ==
X-Received: by 2002:a17:902:6bc5:b0:1d8:d705:c4c6 with SMTP id m5-20020a1709026bc500b001d8d705c4c6mr11482405plt.21.1707103341650;
        Sun, 04 Feb 2024 19:22:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUxDLIzUimX9X6atVzw1jeTaCh+PVTpqhQC+Hi/O1APv5xIpXOTkkpTvP6wCp4f9FNc2AvHTmVAYeMGbIuIze/p3MNgyYSyeF2/Z4jMVNYSs1lYU0zf31t7uQ0lSqyBv+ye7/8/RkKsKv80WMXKl4nlVdDju44BT5UTfnGX3hEjbrchhdntjYERL1P5I1nSUg6/I0SUBjcjmUiYHkLEPt2/qdkBW9pmkvsxf37RDZnWtBN0w9OzI1Z0HTWYp8AGFgrSo3SG3v0SVYEAtobv+gk9mEdjDM78UEUmKcoU6vmKSvYyEns0ss6a
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001d91b617718sm5293165plc.98.2024.02.04.19.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 19:22:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rWpYo-002DEi-1L;
	Mon, 05 Feb 2024 14:22:18 +1100
Date: Mon, 5 Feb 2024 14:22:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcBUat4yjByQC7zg@dread.disaster.area>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
 <Zb0EV8rTpfJVNAJA@casper.infradead.org>
 <Zb1DVNGaorZCDS7R@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb1DVNGaorZCDS7R@casper.infradead.org>

On Fri, Feb 02, 2024 at 07:32:36PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 02, 2024 at 03:03:51PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> > > In the struct address_space, there is a 32-byte gap between i_mmap
> > > and i_mmap_rwsem. Due to the alignment of struct address_space
> > > variables to 8 bytes, in certain situations, i_mmap and
> > > i_mmap_rwsem may end up in the same CACHE line.
> > > 
> > > While running Unixbench/execl, we observe high false sharing issues
> > > when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> > > after i_private_list, ensuring a 64-byte gap between i_mmap and
> > > i_mmap_rwsem.
> > 
> > I'm confused.  i_mmap_rwsem protects i_mmap.  Usually you want the lock
> > and the thing it's protecting in the same cacheline.

You are correct in the case that there is never any significant
contention on the lock. i.e.  gaining the lock will also pull the
cacheline for the object it protects and so avoid an extra memory
fetch.

However....

> > Why is that not
> > the case here?
> 
> We actually had this seven months ago:
> 
> https://lore.kernel.org/all/20230628105624.150352-1-lipeng.zhu@intel.com/
> 
> Unfortunately, no argumentation was forthcoming about *why* this was
> the right approach.  All we got was a different patch and an assertion
> that it still improved performance.
> 
> We need to understand what's going on!  Please don't do the same thing
> as the other submitter and just assert that it does.

Intuition tells me that what the OP is seeing is the opposite case
to above: there is significant contention on the lock. In that case,
optimal "contention performance" comes from separating the lock and
the objects it protects into different cachelines.

The reason for this is that if the lock and objects it protects are
on the same cacheline, lock contention affects both the lock and the
objects being manipulated inside the critical section. i.e. attempts
to grab the lock pull the cacheline away from the CPU that holds the
lock, and then accesses to the object that are protected by the lock
then have to pull the cacheline back.

i.e. the cost of the extra memory fetch from an uncontended
cacheline is less than the cost of having to repeatedly fetch the
memory inside a critical section on a contended cacheline.

I consider optimisation attempts like this the canary in the mine:
it won't be long before these or similar workloads report
catastrophic lock contention on the lock in question.  Moving items
in the structure is equivalent to re-arranging the deck chairs
whilst the ship sinks - we might keep our heads above water a
little longer, but the ship is still sinking and we're still going
to have to fix the leak sooner rather than later...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

