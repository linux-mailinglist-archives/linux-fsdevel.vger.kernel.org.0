Return-Path: <linux-fsdevel+bounces-40690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED1A269E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B6E3A5A2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 01:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98C78F4F;
	Tue,  4 Feb 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oVQFhM3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5023BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738633684; cv=none; b=sVrdA3WPOBWxZVDDp8ToJjwPVegHHXjJgnhLHs8rYc0mBd7ZUCiXf+BEGEx2tHnB7O85QbFrUnFQSWken4CKh+65+auUDPQyJrbA/6pRRdKoRN4SFSFBk0Hel2iGxYnZIThEiXAo76XRYqM4blFnwUFAyxly0max/oITMLWTWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738633684; c=relaxed/simple;
	bh=Hd0rIA0cDj6aX4GWuNuBrVXnCtlqaVEbJoBSCJU5Swo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie8a/GoRXPyVVZmq5DYG4OXklfGZpDlGFUFi1xxRm+Ra+exYS06DF1e86P57uKMonZp618is9ijuZDewcJcosFhfHR91rOp8RfSnlZtAl11nOCuKlHVD2N5lpJwPkUAs6aMsrCsRqfuohwIReBpnNzyzc9w67VJ7lTKj2iYmynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oVQFhM3n; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9bd7c480eso520497a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 17:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738633681; x=1739238481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8j9JGJiWTGQHwX4Mij6DcJyUmLrBk0SRkAVyFSRmoVo=;
        b=oVQFhM3nrPp8B3WdB4iXq0riDk+p0vJ4x8UnQsuLWjvRR95HvZwKESWrZIaIEbReHS
         S80tuR0Px9ML4ctiIaZgpdSyIUMqLjGVkRb/lrstMFPi7eHrZRzSNmnCMzcQ0FodIpKh
         4rmMSU32+6iYj6P81nDTUTXbTOdluotyKA2DaUiFPOMjv4tLJNsV1yjg+iimE6O466cl
         KEAH0GFDO+3XoQty78lcF7wjIHiHBswbtJAKddm8IvkcNSgI4IgIZc2N171ZpyXRejnR
         4VwYAIluvnWmHZAPKsIuU8MYucsx4lx0nxZa04KsHSrQ/oq0B0tYjw8QM8ThJVYXx8J3
         XBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738633681; x=1739238481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8j9JGJiWTGQHwX4Mij6DcJyUmLrBk0SRkAVyFSRmoVo=;
        b=TcPnRQcDNB8llYy8mtskQP/kqmPAYrzbps/OhP9lvqOsLGgRvcbBi7aGhCx8YtVMSl
         ezUOIluxIsSvAXvjV1zBObMgaV7WJXpNyZplZIWuegLWnOLWbBqv+fp1crfMUsvyGVbG
         GR8hvMIxn0Ad2kKI1gJE362mNI0qeMdejFmrNgPLKjV8lo+J+HGT/s5VpisVQo5LlfrC
         TGcP2jkAndPskOpRTJobMGA3MYQwTyQtE2NVca0toMJTofw8CDxL1MQsIjoJlzRyp7zT
         dG4A5R8KemZ6f3jDXoLnFumIYm6IEbNVPczDC23U6JOF4QZh896+2ND7Mxt/H8SdT/tH
         7+dA==
X-Forwarded-Encrypted: i=1; AJvYcCXdUDGZ3pOZCe5zpzFI7jUYeHpB48sxP9Z0K0/JO4QF9Z3QeXhd6tRk1mJhvuB3cKv86R39/LcPjhjDaC0+@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxJDFC+FAi//UJax66Zpg0k6WscdaVJy/CLMU7NyTHPBHFOsS
	O+i3fjYLsNf+iSStLRZ5wr34RRkKvfSUyA00mZ3ihdRHlKfRu+wPPD6yl4gu7ec=
X-Gm-Gg: ASbGncuXoAuYDa0bXw0q1kZ2pjpuQY9gjIlzm25keUM69UaswEWqzBrrC96HkyEUeRC
	ixlTS6tkWyDE6kUk01y0QM86IfPSUW45uMv8fGUJBquOUTShdmWMBfht0TagrBmuDJal3IGztOY
	XKvvXsGt44HvqNJYa5mHJiHd/EUFcg5+wZpnHOOgerRrOgKRMzfIN5dp5yIdilcHNxj9ajOqSK7
	ibQ59NV697/XaIctqFWuPRjTZQ/nPBVBDMn40vIcDGe3cqjDWnJqwrXJ9F6bSXys39xVu+ELyit
	tYg6/TIEA/eXLUhfm2veFtpcXHpDFLOQBZlHoP1960KzLMV6/ZNeK33LnfOSgCMcTno=
X-Google-Smtp-Source: AGHT+IEjmASEkMGLENf32yA+dmk9hsa0morhX56VjY6yBvG7jEnhlFdDvpMyFctWv2izOqDvptNLXA==
X-Received: by 2002:a17:90b:2dcd:b0:2ee:d96a:5831 with SMTP id 98e67ed59e1d1-2f83ac801e2mr35464319a91.30.1738633681354;
        Mon, 03 Feb 2025 17:48:01 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bf9498asm12108978a91.32.2025.02.03.17.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:48:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tf82g-0000000EKGN-0SI4;
	Tue, 04 Feb 2025 12:47:58 +1100
Date: Tue, 4 Feb 2025 12:47:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ric Wheeler <ricwheeler@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, Zach Brown <zab@zabbo.net>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
Message-ID: <Z6FxzraXgNYxs2ct@dread.disaster.area>
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
 <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
 <cf648cfb-7d2d-4c36-8282-fe3333a182c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf648cfb-7d2d-4c36-8282-fe3333a182c3@gmail.com>

On Mon, Feb 03, 2025 at 05:18:48PM +0100, Ric Wheeler wrote:
> 
> On 2/3/25 4:22 PM, Amir Goldstein wrote:
> > On Sun, Feb 2, 2025 at 10:40 PM RIc Wheeler <ricwheeler@gmail.com> wrote:
> > > 
> > > I have always been super interested in how much we can push the
> > > scalability limits of file systems and for the workloads we need to
> > > support, we need to scale up to supporting absolutely ridiculously large
> > > numbers of files (a few billion files doesn't meet the need of the
> > > largest customers we support).
> > > 
> > Hi Ric,
> > 
> > Since LSFMM is not about presentations, it would be better if the topic to
> > discuss was trying to address specific technical questions that developers
> > could discuss.
> 
> Totally agree - from the ancient history of LSF (before MM or BPF!) we also
> pushed for discussions over talks.
> 
> > 
> > If a topic cannot generate a discussion on the list, it is not very
> > likely that it will
> > generate a discussion on-prem.
> > 
> > Where does the scaling with the number of files in a filesystem affect existing
> > filesystems? What are the limitations that you need to overcome?
> 
> Local file systems like xfs running on "scale up" giant systems (think of
> the old super sized HP Superdomes and the like) would be likely to handle
> this well.

We don't need "Big Iron" hardware to scale up to tens of billions of
files in a single filesystem these days. A cheap server with 32p and
a couple of hundred GB of RAM and a few NVMe SSDs is all that is
really needed. We recently had a XFS user report over 16 billion
files in a relatively small filesystem (a few tens of TB), most of
which were reflink copied files (backup/archival storage farm).

So, yeah, large file counts (i.e. tens of billions) in production
systems aren't a big deal these days. There shouldn't be any
specific issues at the OS/VFS layers supporting filesystems with
inode counts in the billions - most of the problems with this are
internal fielsystem implementation issues. If there are any specific
VFS level scalability issues you've come across, I'm all ears...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

