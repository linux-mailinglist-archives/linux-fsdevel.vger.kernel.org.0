Return-Path: <linux-fsdevel+bounces-44897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07135A6E4AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2513ACFFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED042A99;
	Mon, 24 Mar 2025 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CITcRPjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C301C84A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849428; cv=none; b=bxiNO2gBJfi8plTWeatn78pR/qprBqWYSBOgsP3PpoebWSXODTm9Bf8Yymqgt959tQVOGbE1WiriKGsvMLpzt5ZEq/r82k79jjUhGxdkJ+0p2a7hZqlQvkI6u8SybVlUH6mrIKzVMkRyNaQGdjFR7kulHx1QyQfs07AKo/On454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849428; c=relaxed/simple;
	bh=SFoNOdoEaY4NrFIRMpIFOAoyGUANh9yax/xiv3NKPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iawdsA98cP/bu2Bw6zYgg9yJ8BtTpiGC9j+9+0ILQEO0nTJcj/jb1Z1hqOgoWfFt5A1kYoZ1Oiyb557I5uo9kY6vUJWYpPucplHeAoJO9OzkMmQQV0FDLKElNu+9Hv5Su6Ymv1s/K0YtyhtQ1gFGhWlF4IFgDRn5qwbJok6WsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CITcRPjV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so90678605ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742849426; x=1743454226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjJXJUqemeb9q5I5nsAxznNDq6WCgQr4RMgDqusQti0=;
        b=CITcRPjVwZChsUF5n8UuGYbIcAsuQrCOA0co+Z7qpoE+R8WeXREr4UqBZX4b+hYvSL
         zFv8pA5FhuO3odKJ14lulFX527z4jK498dBca1fvWNseyMHzC3DMe1gdbFhbdM3prmMH
         0V7bJymTj7I60WTY04e33W0L5yzRqNtsScrhd3cd1s913wFsU7Y1nK1klUumgxotvwsI
         0bnmgppv9w5ZdFKuqhVMwbAXEt1vt9z3E3RHRqD0rj6ib2eOW70qztigLncZD+WXgtiG
         VQNoyP6ZlrMTWjbGhJBilLO8m4R5nBtsdCfLTWJ4hvMr8ualo4hPDbDsKZovUJFGuRhG
         MTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849426; x=1743454226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjJXJUqemeb9q5I5nsAxznNDq6WCgQr4RMgDqusQti0=;
        b=JjZOPdiPRXx2k62U4SYPeac5O+dAnH91zd9WsoM66G0LgxIXNfuJZ0b6EEXNEGOFdM
         FBPQH4oLSJXgcC/qX8tBg3kqMJt4PTjjcIY9OIMTiMcPEe/iZpoD+QYQriWpXHhWrell
         w07UJbV5H5HuhJnUd4sL1q3H+cGFpbhauukewfbFMyX0Zu1xekOVR2i3MNw99IfXwsTL
         BDh98AY3AE/DO4vayyQz4CzkzEXtccDLN4lI6vnE481Nhc9nCPOkoPkip1cxNXi1R4Y6
         c9J5PnyauROEaF1DOkWyhG4hpYmJrcxvlzr79EcDzHOoJXxDRknRLpUcwAXBgGjGTJnj
         jTCw==
X-Forwarded-Encrypted: i=1; AJvYcCUaafAVy65svhrcdJkilMiwA51z+kdhJMQSVrUp5/q/GNfEi2tYYgPgA+cMeeKdrx4/zGhl5OMm3FS5cRg6@vger.kernel.org
X-Gm-Message-State: AOJu0YyusAByNGNylAZdT9TlkBOOH2Qj9jpVHivwaZKXVHPDFiiJu/KS
	7HxuLYaUEcmjWOtmTRMGiB7qIZDIUXUJfX1JYGamHcXiAOjS1+XmAOw3aOZuOMc=
X-Gm-Gg: ASbGncvogWAJ8Y2AIHLnua5zJR0Raz4s6XYZlxnnU3sZ0pjYuPDFu2RibkDcaIVrpOo
	Ju6i/FNs1yNkeJuey2X5cMXb75e75nwI1ttkoNbhZ6ik/0qaIJXl9rz7oI2gODwrY3jlSnIMJXU
	i97cV+bdITE9Mqnyk9QDYqzsLD+uLMj2UXv7m6/XmeV3vkxN7Alk+gyfLa3h8pdmqad4T9bevPq
	5JWU2KjzV1mHmrdqE8X43AyLAgJ2imuS88yCJ+7sfbUY72+6DSo2oVfhKeqwZtvofWRDGDhS1+k
	NLk019Yv8jw5/kPSFvhc5eTUHdJ4H+2Wo9k0IKBD1eaZNRFuNFpeHZsrBlADMKSbqsRIsYT83xK
	6+U1PSoaKVXQdznGrK7HI
X-Google-Smtp-Source: AGHT+IGfwhoMrNDuu2FSDaIUvNh+ANjpK2Pa+NB1ckt78Z3v6PKS8aZ0mPwACjXGQEt/AfAsp9WFlg==
X-Received: by 2002:a05:6a00:92aa:b0:736:69aa:112c with SMTP id d2e1a72fcca58-739059b284fmr17613497b3a.9.1742849425426;
        Mon, 24 Mar 2025 13:50:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611cafesm8742755b3a.109.2025.03.24.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:50:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twokX-0000000HQLH-27pb;
	Tue, 25 Mar 2025 07:50:21 +1100
Date: Tue, 25 Mar 2025 07:50:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z-HFjTGaOnOjnhLP@dread.disaster.area>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>

On Mon, Mar 24, 2025 at 12:38:20PM +0100, Jan Kara wrote:
> On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > [...]
> > > Let me digest all that and see if we have more hope this time around.
> > 
> > OK, I think I've gone over it all.  The biggest problem with
> > resurrecting the patch was bugs in ext3, which isn't a problem now. 
> > Most of the suspend system has been rearchitected to separate
> > suspending user space processes from kernel ones.  The sync it
> > currently does occurs before even user processes are frozen.  I think
> > (as most of the original proposals did) that we just do freeze all
> > supers (using the reverse list) after user processes are frozen but
> > just before kernel threads are (this shouldn't perturb the image
> > allocation in hibernate, which was another source of bugs in xfs).
> 
> So as far as my memory serves the fundamental problem with this approach
> was FUSE - once userspace is frozen, you cannot write to FUSE filesystems
> so filesystem freezing of FUSE would block if userspace is already
> suspended. You may even have a setup like:
> 
> bdev <- fs <- FUSE filesystem <- loopback file <- loop device <- another fs
> 
> So you really have to be careful to freeze this stack without causing
> deadlocks. So you need to be freezing userspace after filesystems are
> frozen but then you have to deal with the fact that parts of your userspace
> will be blocked in the kernel (trying to do some write) waiting for the
> filesystem to thaw. But it might be tractable these days since I have a
> vague recollection that system suspend is now able to gracefully handle
> even tasks in uninterruptible sleep.

I thought we largely solved this problem with userspace flusher
threads being able to call prctl(PR_IO_FLUSHER) to tell the kernel
they are part of the IO stack and so need to be considered
special from the POV of memory allocation and write (dirty page)
throttling.

Maybe hibernate needs to be aware of these userspace flusher
tasks and only suspend them after filesystems are frozen instead
of when userspace is initially halted?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

