Return-Path: <linux-fsdevel+bounces-45109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276BA720FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 22:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9497A3584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BEC1F2369;
	Wed, 26 Mar 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FDLl1TPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36B1A5BB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025736; cv=none; b=cvGmvVkyitwhb00pb0N59g/Dum1YCqzXhHarjY6E8DwFHGPrFw+pC9vqvur54IFh0XyBiICaU0Iho4Evv1NM6oWglhz0zGOqyky5uSJ9MbFGED7vODDuPWGPoRhf72W3iQZOY03q/Jbywfdwd0j7PQMqBKsBPSxfxEAHLq9kuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025736; c=relaxed/simple;
	bh=vfQeV3TaD1LEXFq2KgnmHl5O26/mT0UXWGUHeykb0oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFs7hSrETyKpNhBliTh5kE6mbSd/Xjl3B101wJCCiACgHHz1NHcmL7k3YD1+G1eZ69FqnjWrKaQvjRi3slUag1b/FI81NepBHI5z4qRACyBodHl3WbSftc6Tdhf7/6+gboBkp2R2fwUED4Y9zhQp2lUtqqAXN/Gh3bwWWFRs2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FDLl1TPr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so7938335ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743025734; x=1743630534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOA0g6xjZW3NM82qhVrH0hYkXRzjDdNGaRStsJEGb/4=;
        b=FDLl1TPrCFvzzZR9HSuJ0/1lOjNBrImLsqyXpaEyHNWbQu2SZa6mGM7ueTGHnI+q13
         FZLGe2t5vq/a1XshOcCS9ZqB7M70LXzPHK/5SWYwnpWoQ3tEYjxZ7PFsp7TNX3wvLM6I
         sVn6Qk646DBxulihcYgJtl7wYBB2BG18eoAXYHT/W2uMxmQPURMDjLaovD7jPjJtYEK6
         cafBZ7akFPMWBPG5FWEsXurEKkuE6BGKHMYh94yLziX70nAq0vXfCKJGRwfMjfw5TndD
         vGabe+mW1+d/7MvmkQUPyWZc5K022V54NzgsBM8n6yDa8JtRboRBl8i2FsIBGqTqXDSg
         V+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743025734; x=1743630534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOA0g6xjZW3NM82qhVrH0hYkXRzjDdNGaRStsJEGb/4=;
        b=fZ1VC9nxq2p9K27/CXyFCpkVtoyOkreBl7RlMR3fgYt9bbUeu7X96QZ9FLYgRYNUiE
         K1B1AWF8AsiNUBCVbrpQgaZA3GZ2dxuLjzrAG5lgoMsl9XhjxmMdBUkJ/VPuRejfSj0x
         6/1l90nGDUFMzCbyc2W4wHUGxh6QCzKQ21CW2K8TAhdOJqHPsfPZG+xLQA+xwsInwdtC
         /JuGGb4EgofS3YhzBfPwux4wVZ5T2A241Z6H56BiY9/w01QaiDb/U3RMk1iWZXXB++B3
         D0maxN6pRpKvsKPQ7hgtEKSjRT5nVoTXkk33Xz3XRguxH352syYen/hGlV/uf80EqeJd
         LPaw==
X-Forwarded-Encrypted: i=1; AJvYcCXXWm18JFnPyKx0GDb/i/do/ywyHrbeJ7i/8XKPHUY5egvgV9ecdqRdyYYSe5C/GPXXXioy3AD00ZlJjOCZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oo8OaBm6YJmfG8N8GG6wEIgIGgQkKH8OZKlGT/skIBUKCj/V
	3Ao5CS0KpYMaz1GYLtGqds/oawiRQwW0W66ToTNz82jz1d5FfAaxjLO1v72XhTw=
X-Gm-Gg: ASbGncuqjQMEaJSnbRad+YdN5P6Ykg8OlPr+byC0gYCNKm5xXH7WS1xyowdVqTajLj9
	EspD6ai8dUo+O7zizppO+eGS7fSAefYjcLIdjWIiy4VeqRE+y6U+JosNm0Ea6RbKCAztq3UjP6G
	V2dx+GPadViXnCCiHZjBZf/yXqbtba1Zud34Bq8StOoWx635Unpz6dtZ0qCvpqiBQbK8F5iF/br
	3qubV71rEIvna7GLrqi9ZzcaNmj5ROTZIcs7kPC/IKNOCorF1vQ0PD4kvLpoeA2LxgEfxt2U77I
	FI4IOK5NGc1A8rgRCD46RI3xYVbC03sFSWxwO4/IxvqokIMgP/dMfI8IRmuAxBLwx2Uw94bzcbB
	+ofgZYjGe5RPIcqg9hA3w+72pHeP4
X-Google-Smtp-Source: AGHT+IExYtNqemtiH4PchdNU0gkFofimKplIG0mYOp41fANWlH1UQJZ5KnbvIsB+XPVtQSaw6PmPeA==
X-Received: by 2002:a05:6a00:4607:b0:736:3d7c:2368 with SMTP id d2e1a72fcca58-73960e2cff6mr1752334b3a.7.1743025733869;
        Wed, 26 Mar 2025 14:48:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a292b1ffsm11398612a12.61.2025.03.26.14.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:48:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txYcD-00000000hgM-2MZe;
	Thu, 27 Mar 2025 08:48:49 +1100
Date: Thu, 27 Mar 2025 08:48:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [LSF/MM/BPF Topic] Filesystem reclaim & memory allocation BOF
Message-ID: <Z-R2QcpHxwetMp5v@dread.disaster.area>
References: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QcUwDHHfAXl9mK@casper.infradead.org>

On Wed, Mar 26, 2025 at 03:25:07PM +0000, Matthew Wilcox wrote:
> 
> We've got three reports now (two are syzkaller kiddie stuff, but one's a
> real workload) of a warning in the page allocator from filesystems
> doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
> context.  This got me thinking about bs>PS and I realised that if we fix
> this, then we're going to end up trying to do high order GFP_NOFAIL allocations
> in the memory reclaim path, and that is really no bueno.
> 
> https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/

Anything that does IO or blocking memory allocation from evict()
context is a deadlock vector. They will also cause unpredictable
memory allocation latency as direct reclaim can get stuck on them.

The case that was brought up here is overlay dropping the last
reference to an inode from dentry cache reclaim, and that inode
having evict() run on it.

The filesystems then make journal reservations (which can block
waiting on IO), memory allocation (which can block waiting on IO
and/or direct memory reclaim stalling), do IO directly from that
context, etc.

Memory reclaim is supposed to be a non-blocking operation, so inode
reclaim really needs to avoid blocking or doing complex stuff that
requires memory allocation or IO in the direct evict() path.

Indeed, people spent -years- complaining that XFS did IO from
evict() context from direct memory reclaim because this caused
unacceptable memory allocation latency variations. It required
significant architectural changes to XFS inode journalling and
writeback to avoid blocking RMW IO during inode reclaim. It's also
one of the driving reasons for XFS aggressively pushing *any*
XFS-specific inode reclaim work that could block to background
inodegc workers that run after ->destroy_inode has removed the inode
from VFS visibility.

As I understand it, Josef's recent inode reference counting changes
will help with this, allowing the filesystem to hold a passive
reference to the inode whilst it it gets pushed to a background
context where the fs-specific cleanup code is allowed to block. This
is probably the direction we need to head to solve this problem in a
generic manner....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

