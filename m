Return-Path: <linux-fsdevel+bounces-13830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087578742CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAD9B21822
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFD1C68D;
	Wed,  6 Mar 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rTRcqXxl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140271B945
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764301; cv=none; b=b2vMKgV25Dl5GAc791DCfZoElyquLe3uZwQ0ztO4O8y4j1VpJllrkQb1Vf8VHB5SeWLoQ0+bh+BjFNb6e47l3u4Jj3eNcI32HknEx5NYAeiIEfZ3RfYB5qxCfDeLIfL+7ORdivxJZmPq5RmIvCs9DJHxx27y3j2wvRfuvVVj8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764301; c=relaxed/simple;
	bh=1H76s8lvsjluWXje2IJNuiP2CaFbNhg1tSJElw32v60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n56E1fBE77dLsdH3IoeYh0W7+siM+hvZKmg8KW/coexM7JJmp0igmf+CfqkC9OeD0JFzb1MvZO1XkqlhcG8COJ6UvoPX/zdDDLhTz0uRQwQ9Q2Y3bsZksTFBmb0kBAdPncAOGZRGdgA84fDSCCHD5S95/RIH788pPbisK6bZ/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rTRcqXxl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e55731af5cso202914b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 14:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709764299; x=1710369099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ddq6ozwzs20fSyKwA0b3LwCkeOygm77z9EFRDlAgB0=;
        b=rTRcqXxle6RPes/QpJ4wM3MF/S/E0koKC/8bv/jvVkZLdONxx/DU8wCBE0Y0rFsAIC
         ayp0Y5lqeBS1Mfae5RNdi+DVr0m19ljA0nzNkZ+yahH3k7J91TZmRW/kSQSwZDZYbjAM
         Wz2X5fl0vF31n333Bc3Y2fPZcmAG996tbiJ0m1Qe+ivwOOdoyO/Zc5AvedjwUEeuQ1gd
         86VGskRdzXouNtpXm33smm6XobUrvl/wu73H0b0jFRy1QVyJWaOwXActusKU/bOMM3Kx
         PTXnF2s8xT19stmNUm0/v/aho5FjXI67sZS6E2mWVbAqcTOYruhKvOTTj+R0kMsQf3mX
         OHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764299; x=1710369099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ddq6ozwzs20fSyKwA0b3LwCkeOygm77z9EFRDlAgB0=;
        b=o0GWufzS2FmJBrPcHuFJrZ/1Uf7pePK71dAfG6aurDqhN0lKitxXiX+nHaZbfcJUtI
         msz8kAUGa++0C3XyHr+d8Hltt2qL837t4oP1qB8lF4hE6qv+da911c+6dYmnWAALqNbu
         2d+bsHW4gv682E2k2UV34qHovPFnuKXF0N1RZXoeo9XUxm022a2xQfMvUJJYWHiX/9mB
         m5Kp6Yao+WTzNtVrgFYVeFVvcNFNGqVmz4e7PCcCLrtRk4MlEMfJbzdKz0SRU9KiyVm9
         5GcdB4luFZbKV+SFrzu0oQ8QpdxUTDMLRVhwh41+aBq41EZPR7rd6707MiWbhVg9+z8D
         XH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJToY5j0mB4pjcCmpVEDgO4usnSr2IfBQFpGat9i1cuMoqxqsFOrCFN2benFfguYiiTp77B1WtkAR43mxQxUloroBhwHufSQQGOBj55A==
X-Gm-Message-State: AOJu0YzK12qj2lUIdIORbyh2my0oLE0xyA48fl40Le31JvknGhv0mnom
	Xkd9BloCjvBwnnEjozhF5S7yzSRdOlOTwqANuK1Sfx7Z39vZg8wK8VShfvwM3Wk=
X-Google-Smtp-Source: AGHT+IF+SxK+jXeGblY/kQ5DNcJhW2Y/WinOWvyXLJHzVb4x9sw9BFSnKAXVCjiVFfuTMTymvanPqg==
X-Received: by 2002:a05:6a20:244c:b0:1a1:6cec:7261 with SMTP id t12-20020a056a20244c00b001a16cec7261mr1489135pzc.16.1709764299091;
        Wed, 06 Mar 2024 14:31:39 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b006e5dc1b4866sm8564942pfd.144.2024.03.06.14.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:31:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhznU-00FziH-0G;
	Thu, 07 Mar 2024 09:31:36 +1100
Date: Thu, 7 Mar 2024 09:31:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZejuyKWT0Y9nXB+g@dread.disaster.area>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
 <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
 <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>
 <ZbMe4CbbONCzfP7p@casper.infradead.org>
 <ZbQzChVQ+y+nfLQ2@dread.disaster.area>
 <ZbQ1CrwP2IT4v6sq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQ1CrwP2IT4v6sq@casper.infradead.org>

[Sorry, missed this when you sent it and I think it deserves a
response...]

On Fri, Jan 26, 2024 at 10:41:14PM +0000, Matthew Wilcox wrote:
> On Sat, Jan 27, 2024 at 09:32:42AM +1100, Dave Chinner wrote:
> > > but the problem is that Microsoft half-arsed their support for holes.
> > > See my other mail in this thread.
> > 
> > Why does that matter?  It's exactly the same problem with any other
> > filesytsem that doesn't support sparse files.
> > 
> > All I said is that IO operations beyond the "valid size" should
> > be treated like a operating in a hole - I pass no judgement on the
> > filesystem design, implementation or level of sparse file support
> > it has. ALl it needs to do is treat the "not valid" size range as if
> > it was a hole or unwritten, regardless of whether the file is sparse
> > or not....
> > 
> > > truncate the file up to 4TB
> > > write a byte at offset 3TB
> > > 
> > > ... now we have to stream 3TB of zeroes through the page cache so that
> > > we can write the byte at 3TB.
> > 
> > This behaviour cannot be avoided on filesystems without sparse file
> > support - the hit of writing zeroes has to be taken somewhere. We
> > can handle this in truncate(), the write() path or in ->page_mkwrite
> > *if* the zeroing condition is hit.  There's no need to do it at
> > mmap() time if that range of the file is not actually written to by
> > the application...
> 
> It's really hard to return -ENOSPC from ->page_mkwrite.  At best you'll
> get a SIGBUS or SEGV.  So truncate() or mmap() are the only two places to
> do it.  And if we do it in truncate() then we can't take any advantage
> of the limited "hole" support the filesystem has.

Yes, but the entire point of ->page-mkwrite was to allow the
filesystems to abort the user data modification if they were at
ENOSPC when the page fault happened. This is way better than getting
into trouble due to space overcommit caused by ignoring ENOSPC
situations during page faults.

This was a significant problem for XFS users back in the mid-2000s
before ->page_mkwrite existed, because both delayed allocation and
writes over unwritten extents requiring ENOSPC to be determined at
page fault time. It was too late if ENOSPC happened at writeback
time or IO completion - this was significant data loss vector and if
we tried to prevent data loss by redirtying the pages then we'd lock
the machine up because dirty pages could not be cleaned and memory
reclaim couldn't make progress...

IOWs, it is far better to immediately terminate the application than
it is to have silent data loss or completely lock the machine up.
Hence the defined semantics of ->page_mkwrite is to send SIGBUS to
the application on ENOSPC. 

It's not an amazing solution but, in reality, it is little different
to the OOM killer triggering when memory reclaim declares ENOMEM. We
can't allow the operation to continue, and we can't return an error
for the application to handle. So we kill it, just like the OOM
killer does in the same situation for ENOMEM.

We even have an fstest that explicitly exercises this case. i.e.
generic/619 creates this mmap() into sparse files situation and then
checks that the filesystem really is at ENOSPC when the page fault
throws a SIGBUS out because ->page_mkwrite failed due to ENOSPC....

> Most files are never mmaped, much less mapped writable.  I think doing
> it in mmap() is the best of several bad options.

Perhaps so, but that makes it unnecessarily different to the major
Linux filesystems....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

