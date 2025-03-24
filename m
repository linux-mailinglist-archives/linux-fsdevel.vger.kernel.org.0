Return-Path: <linux-fsdevel+bounces-44898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC4A6E4CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD1C7A58F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E61DE3D1;
	Mon, 24 Mar 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Ko0cKWoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B21DD877
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849808; cv=none; b=ltk8AUBWzp3XKGnoTvMyjGOVdPhH6VuPxKcHB/zGfzR4JnoV+JvjlbeWfuYBUZP6mKdDo+8NJMn1dSREX7FCS8PP8OD6liF1ZE+n89vtYjOnR1WP9TQEC62r0ehFPrDdBMA4C68aYSExK/DGlzxIk8cNP7vAODT8U8WIey1WYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849808; c=relaxed/simple;
	bh=P/V3sA25v6913l7QyvxKRXe8wx7j1EMWqQ97PM9AOww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erdGufk3/Yp54Y9AL8IebdYVKovbRXlAlvSfOVJNjo3GxwytHu5o3urfYrZoJxVtrU4iW56RNnry2r/kDtnaIBExrkDn/Z3CTLYJMITwiiVllj41sF/l4xxKVzqki2iN/3KngWTZTy/IgJtQrs6FMEfVWPmBr/6uJnZcZfUa/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Ko0cKWoR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224171d6826so19417965ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742849806; x=1743454606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyny/RE4kTu/uSuP1NjcFvioBc+2a8T7cZXMNrZrjVo=;
        b=Ko0cKWoRh7lcytcZzHvaU7Zb0jpGuyleD0FWHPGUOq96CLR3Qn6OQelL11pbRYCKzg
         Lh+Vh+0fbPJAWuToZPHJ2nt3iCslZU2WXcBA70qm1clsm/7BnR+kk3SAJpEot3YNaWEd
         R+NldTQkdTbzZCQazO5FdXrAY7WD3Dl+gRCvImHEhJEJKHBSukk/egKLPMF3Y0AFDEx5
         iXik5NDW1/QKOYYgrlH2HPduLSOKNmeJG9lTw7AS4zfwoxn95POFnzWEK9y1/qBeTL2K
         JdsRoTSW41C1ajYVNYmjcUqdrl560Ssgxvb3cj26yJzviKdhtt2eQJZBoch+0fb+iPUk
         zwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849806; x=1743454606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyny/RE4kTu/uSuP1NjcFvioBc+2a8T7cZXMNrZrjVo=;
        b=fJlyhcZw/Fs0SSlGFCt2k9zvdmOZqmtnLxJpGpEN9RSCl6xqvMyZ+c+PrKLBKeHXyQ
         0jSDlLQltXE3ed2byd26a5zcICppVD0Jqbm1ujyj8wXL9fn4HJGZV2/LnqpOcxsf7TJF
         Qjr0fFxAHmWpCrIjP2FeezOOfdvHkrIZtyz6WUCLaoJRFE7yiC41cIe9b8VYovr/5JgI
         Gtzx89iFxkVPbKnF2XGm4bgTjBCI27llkT64FS/oREtt99Wc/haUvPgcYj8sSX/h5AFu
         SLc8CabNsG7KOaR/qlMe+Nt7OkJqhVhCiMzaxLH0hQwafFZgSSenF/HWOkOzxpeRBVnb
         pRyA==
X-Forwarded-Encrypted: i=1; AJvYcCU82tmTWvH8DUol9oWyO5N6qHHCtfd3a0UPuHSuw9vLOBWMqk5O9GqfdsIPorK9tMCVOMyx+2OU1BtVkRq4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wQQaIjhd1u4xepBxiuZgH69dWoBRratV4tookrbE4kzMjfE4
	wtYSuNLETn4pKgwmkMJgWJXSmdT1hRWO3slqk9lBnKT8pxwSieHHQ6usjeOANkA=
X-Gm-Gg: ASbGncvtO4nN1j+fhwbU0ratISxHaYE1Uz9WO79ek98DWMRUR9PUgwYfFOzNaDe2fo5
	u3XNFj9tcTevmjUZK2sxc19QF+a7SkQ3TPvveVrXkQAzHlyYXQ0RDELW8gWWRswNCklgy6WsW+P
	4OLz20Ot5Tvu7Tqc4foJklvY/C6H1ttE+6o3RaNgCF0nUk//sBlWiATO9X8fbwtS9tAs2rLXt9O
	Y4vUH9bB5MhYCVmQ4evFS2F8CxXv/3WJiBSEhhu91Ms5TnXoNKGmXEo0RUhne5u2+bM6jEE55/j
	FK0Ef6T4y6ivZ1b0oQtnAUdMFDQpKha9UsBGYTaiTfgZP7oqpMrWbs+SeslJeeSRP8k682dNZlu
	/ddxsve9cIXP+SaUZV9WF
X-Google-Smtp-Source: AGHT+IHvqTkyWCKz+EHqwOCjEFijgHZgJBBBrv04/RK4mKj9WbInmofIG79TqHnCrUGjEUHUIRqGeQ==
X-Received: by 2002:a17:902:e748:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22780c79ef5mr180461095ad.16.1742849806217;
        Mon, 24 Mar 2025 13:56:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f14easm75526935ad.222.2025.03.24.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:56:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twoqg-0000000HQbc-3e0D;
	Tue, 25 Mar 2025 07:56:42 +1100
Date: Tue, 25 Mar 2025 07:56:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z-HHCrQgWfQw8Y9h@dread.disaster.area>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>

On Mon, Mar 24, 2025 at 10:34:56AM -0400, James Bottomley wrote:
> On Mon, 2025-03-24 at 12:38 +0100, Jan Kara wrote:
> > On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > > [...]
> > > > Let me digest all that and see if we have more hope this time
> > > > around.
> > > 
> > > OK, I think I've gone over it all.  The biggest problem with
> > > resurrecting the patch was bugs in ext3, which isn't a problem now.
> > > Most of the suspend system has been rearchitected to separate
> > > suspending user space processes from kernel ones.  The sync it
> > > currently does occurs before even user processes are frozen.  I
> > > think
> > > (as most of the original proposals did) that we just do freeze all
> > > supers (using the reverse list) after user processes are frozen but
> > > just before kernel threads are (this shouldn't perturb the image
> > > allocation in hibernate, which was another source of bugs in xfs).
> > 
> > So as far as my memory serves the fundamental problem with this
> > approach was FUSE - once userspace is frozen, you cannot write to
> > FUSE filesystems so filesystem freezing of FUSE would block if
> > userspace is already suspended. You may even have a setup like:
> > 
> > bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> > another fs
> > 
> > So you really have to be careful to freeze this stack without causing
> > deadlocks.
> 
> Ah, so that explains why the sys_sync() sits in suspend resume *before*
> freezing userspace ... that always appeared odd to me.
> 
> >  So you need to be freezing userspace after filesystems are
> > frozen but then you have to deal with the fact that parts of your
> > userspace will be blocked in the kernel (trying to do some write)
> > waiting for the filesystem to thaw. But it might be tractable these
> > days since I have a vague recollection that system suspend is now
> > able to gracefully handle even tasks in uninterruptible sleep.
> 
> There is another thing I thought about: we don't actually have to
> freeze across the sleep.

Yes we do.

Filesystems have background workers that do stuff even when the
filesystem has been synced, and this can race with hibernate
shutting stuff down. This is the whole reason we needed to move to
filesystem freezing - to tell the filesystems to *temporarily stop
dirtying* new objects.

> It might be possible simply to invoke
> freeze/thaw where sys_sync() is now done to get a better on stable
> storage image?  That should have fewer deadlock issues.

A freeze/thaw cycle still allows the filesystems to dirty objects in
the background whilst hibernate continues onwards assuming
filesystem are all clean. It took a long time to get all those worms
in the can, and we really don't want to let them back out....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

