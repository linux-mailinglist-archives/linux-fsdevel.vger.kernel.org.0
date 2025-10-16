Return-Path: <linux-fsdevel+bounces-64347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845EBE2216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F9B5810F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CEE304BA4;
	Thu, 16 Oct 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Q/uVjoe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40992303A18
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603001; cv=none; b=QcP2Ti4bboFqeW5a/vbFVDA58eD/ex9aoptnYj/1ql3gfYfZErSGBFLnOz+ZLC88FJPf218cYczFpHLo/CS9GjPSqdpRcvIjcZdLbC08H5in32bpme/W9qPXDmc9SwJYVDMn9chJHe0PdM5N9AWI7CQ+uhn0T0T/IQ49UzsUmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603001; c=relaxed/simple;
	bh=JQJvV6yRfBzQ0roNf3+gVAmWUMYqFoc2hs/p+SXZdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGZgvP5ij0RzPy76r0RoLa+0N7RCs3JODIKlbTAbqB4Ml16Pq66HcYpPb6gT7zDkjdRD+OmzXn5mw/JLPP3HLgQn1q1gBF9CUmtFHFy6amdW/GjsXsVxK9kgNpVMQqgnwpS8bB5RlMLsG4JhuxFca11rt9FFl76HVC+ejNRyHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Q/uVjoe+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d3540a43fso4964965ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760602999; x=1761207799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0VUZMtcOk9KdtskCy8ElFmsJ9tky1TG1GiZcpekt6s=;
        b=Q/uVjoe+BxIRyf3jtZzEd72+e/UbQuImi0I4A/+qNg50aXYchEB0Ouk6ypUfnG3s7W
         pGQzbqsdzpjXQ4hOieAM7FUqsA4A76QLLdjVDAFdWBy0gSlU5XRjx0VzmenXDCHzxjfC
         BqnnTH3T5ZmeWz3wKIPw6NHH7iJep/sr+G820y2KMGmNtNqTqWDTOr+teUkZ0ZDFp1Ho
         HNAeiQNsIiCUZ1vytNSW2xJBZMsmm4KOaeRx4Py3vOIDlOv6qOyzPcGkuKHg8A8Zy+Ya
         /f/40/+IAKfyoTPORaso2zL+CuUskfd1+TeUxW7P8k4n2xzRgXajy2hXXl+opMFCrnMz
         s2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602999; x=1761207799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0VUZMtcOk9KdtskCy8ElFmsJ9tky1TG1GiZcpekt6s=;
        b=Cqr90rQO0Jk4MY/ENeLhwv911OCzka3HYCPjOSt6vBIRgVV5R5AwncyY//ilmyAxyu
         wC3Bo1L4cgXciMkZgvwtvzmVgPvijJJqxbkkpz+dIY6BTQAICuws0jESXxkoxJzpsXyj
         A+DViKvSDHrQVrkMXMy6Wajj3ko9L/fIBj8GAl5Qq5LVLe5ckH1XsoYDPKaqOo+RYg4s
         4TKWq0WAvH6Bg0UaI999LMTCI8+ICq0p4cmxuMCiLH9zzDAAEmz129MEDzyzWbKl02e2
         fS0T5Lbv5r15ii7vziRPW0nNY/VcuFSSbIxk8klOWFPLXg7JcxT8btyNtLdwfL3oPjcV
         RWaw==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ/9wXUrZQj/h5yGqYiRFAExBDyvOKgqJQ9ut6VUKKFNzXUDgZ9I4VBN49sAg6NDN1OHyYVBWmappsamo@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHmnwFMpdDmUODcpClp7oC12ezu6gn7NLTAmzPV9YVk1J0uRS
	+DvPPaG2VdFBZi123XROc316dDgDjlNljkFpJvTdRVDjl88tTDxq8qnvgtxER8zJYa4=
X-Gm-Gg: ASbGnct/vDwOM1YEEmDP793TRT+ObhWgIuvwTSVKYwjrSmLSrgDb+H7W1994zFu+0mC
	yhzP5ktyKZa75RGGSsjUk0WtHOIgSGezfG8sWHhmCaihlinL9U9ahnPaFPJNxvwdLT9Y0Yz5bsR
	mIcy/apv36f9n1oTk23w7MsV7qdO4bReTsUmdVpbZTMCmyrPk/VYR5SZztnrHEhH5+61+gyYSD/
	6fEDUdv8a5S3rlvo6pvd5VX3YOu9LpH1ofGwPFE3UriWuyi6oZBERM7DlgKVw2+IWG65fzslAkS
	UItf5O0R9obxqPVoNn0gYnN+HB2HlcnDWM3yAI+Ndv0V+BqM3kWvFcO8RqVY6+a3Xytev0avAFB
	2mdqUe/0Uw64AIk91REPpxL7Ez8oGfO7kSib6cBwFl4g0nJA0qJQCrklETIH+UgamfDR2bKRT5j
	crK8r0DUlJHt7z1T2MC/uCMfA459t0uq8Sp/sWvpira2wvwLWf+g+ekLreViZ/1oizljh7zVdK
X-Google-Smtp-Source: AGHT+IF1CQThIQIcsUYNeKF6zSjisAw+PGIYgUlb6D8gypneTiF3iak1UWrAgN1vx7iI8WrWlF2NeA==
X-Received: by 2002:a17:903:1b4b:b0:26d:353c:75cd with SMTP id d9443c01a7336-290272409c7mr413436515ad.21.1760602998773;
        Thu, 16 Oct 2025 01:23:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930fd3csm21322745ad.12.2025.10.16.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:23:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v9JGV-0000000FW7S-1kMH;
	Thu, 16 Oct 2025 19:23:15 +1100
Date: Thu, 16 Oct 2025 19:23:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] writeback: allow the file system to override
 MIN_WRITEBACK_PAGES
Message-ID: <aPCrc5GvQRkwmTOU@dread.disaster.area>
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-3-hch@lst.de>
 <aPAI0C23NqiON4Uv@dread.disaster.area>
 <20251016043958.GC29905@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016043958.GC29905@lst.de>

On Thu, Oct 16, 2025 at 06:39:58AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 16, 2025 at 07:49:20AM +1100, Dave Chinner wrote:
> > On Wed, Oct 15, 2025 at 03:27:15PM +0900, Christoph Hellwig wrote:
> > > The relatively low minimal writeback size of 4MiB leads means that
> > > written back inodes on rotational media are switched a lot.  Besides
> > > introducing additional seeks, this also can lead to extreme file
> > > fragmentation on zoned devices when a lot of files are cached relative
> > > to the available writeback bandwidth.
> > > 
> > > Add a superblock field that allows the file system to override the
> > > default size.
> > 
> > Hmmm - won't changing this for the zoned rtdev also change behaviour
> > for writeback on the data device?  i.e. upping the minimum for the
> > normal data device on XFS will mean writeback bandwidth sharing is a
> > lot less "fair" and higher latency when we have a mix of different
> > file sizes than it currently is...
> 
> In theory it is.  In practice with a zoned file system the main device
> is:
> 
>   a) typically only used for metadata
>   b) a fast SSD when not actually on the same device
> 
> So I think these concerns are valid, but not really worth replacing the
> simple superblock field with a method to query the value.  But I'll write
> a comment documenting these assumptions as that is useful for future
> readers of the code.

That sounds reasonable to me. Eventually we might want to explore
per-device BDIs, but for the moment documenting the trade-off being
made is good enough.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

