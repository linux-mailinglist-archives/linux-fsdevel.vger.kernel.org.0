Return-Path: <linux-fsdevel+bounces-48154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C995AAB7D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FA3174271
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4A298402;
	Tue,  6 May 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hJnFu1yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA74300A34
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487768; cv=none; b=MivX35JMS+9oCOHIUKfmHkvSx1uU+rN5G/4O3l87Ae6SixdBOd9KYstgwbcELwVtPaRlSCK1dTTIM31edL6ZM0NJt2jgm4CGXfBs1cu0km2cmyNaJN8IatHbXhHfcDy2XXDBKIEqM5fIJ6a+rJgDOqkSsBSyCNJydtF8Pk58P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487768; c=relaxed/simple;
	bh=FzjaVv6DoFmC5NFufBQbd9cJq4J3trhPtTw0GwOVI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP5uoxZVJ4UENbKQn2S90aDtMpNt0MxVkoTg5C7t9Qv53M/l2HXBFkHvqbKeHf/RTlGkesY92VkrSjGHV2mNx2f8/rttI1s6JxDaTiDgI1uSDBY6QnmYMVFKYzK1ApElO9cJUFN3RwiCGvcEPbiwOoXnRcKVQcxjhM7kPXuGkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hJnFu1yz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b828de00so57630905ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746487766; x=1747092566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv/tk/5UA96wzruANBPiWqge+x6HatYw6W7cfsHGVHM=;
        b=hJnFu1yzSjpHFBQtDBxumwWpFrFGL8ySFYcgrevmlBApfI4Lrh8ZovhRNFl3IwX6eE
         KxWI1xmeixS7WYk7jkhaza5oxtX5P+8U1TxDwi24JstUMLKZJGS90ED0tGyUSko24Yce
         j0MsiSjnUgIzee4Ejf8MQV0wcoIjUH5Ap1+PfsucCjuNG8+ZXKglBYuNk/nVlNt2FuqH
         QYdAoihQT9JCr5WQnU8QsrTuEVUirnZyv16sSXIorX9zVi1jKnJhzPULshOAMXUOb7ZQ
         ZKp+xgFi/NtOcYkbnMYARkeJGnD9kB4P4QiswroYOnQGA2z2JNiAsd+7nagel89bOXWZ
         eciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746487766; x=1747092566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv/tk/5UA96wzruANBPiWqge+x6HatYw6W7cfsHGVHM=;
        b=aXMoILcOsiqjxvTnpE6Y+khErNuN5Q2UHbpSg2+636nfnSt4/Q7SW8eLegU/WZEixD
         CUHjEmCqoVpcfi+I9qavYhsLEhAio6Ma2ogADzsT9nXlwTzk7GejvtcxeCmbNcqrcDly
         NZ1SlAUWUbwkURuquwkUVcA1TiivRi6GYm4wGiqvEsOlQFp5s33QhPPgK4XzPm2fT3Th
         5Xm7Tc+rDZSClRVov1WbQIJ+sKFMDxQo36WKg1nqItudcgl9zI9K2EOICb+IvOuMgosA
         7XW7rUdwEUcbHqZKxI3BeTj4VD16N4IOq0LiHRNLamWe9zljyLzQ+CD0LUBaeitSkAol
         fmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/vdDYKcr+edaT+NpQZZR1iK/AXQsUCqK7yfF8Ad7anMnijsj+BTqsUMPht5Pps6Pgn8Xl0PcwvaD1imHS@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyJL9oUMSurG/MyVWyxj7nBVlqWPd35MjGwzRmUtVdYlAY8EO
	S5Wc29f9evZTUrlWkVPlC6GcHi+QNhHY4n7p9DQ899s82l39VB0qESn8q2g8rmA=
X-Gm-Gg: ASbGncvLCwY5CZhvEmtHueoFn9OaRzN+tbuBln9733A+eEZUF1vBVdBmhZ5ahzlnp1X
	0ZO+CONlHvUP/DLT+pKpWEc3HToqEoXIbEw8YsCzFicT7D4PV3XzxcQtuoFvM+0t14cArV5I2Zw
	tPUz8zxDCrC94UYxW+s/+WRJTw5xADeavaaOxIzwT6WBN3dW2T4iNN+zQLn25C43LS3uZ7dz8ym
	QBC5+REzSgCYZxfrX0g016ykyKh4LA3GJmI2piTwk6MavznFLWKnCBh5neU7m4WCXo9Mc6KOVYU
	hVm8RAwV6X9pIqIXRq0AmNTfnmi41bW2zxc/a+ts33Br6cHm81QYQtDvWS1zrjKdgpLfrnFNX6q
	/px1JdpYk8gPBxA==
X-Google-Smtp-Source: AGHT+IGNmATDG7nMeyEa4zdMPk47/229EKnS8GzX9yOLKZmhRqPzXmTD77cUZ0WryvDqqXCIZToVWg==
X-Received: by 2002:a17:902:e394:b0:22e:3730:e7e3 with SMTP id d9443c01a7336-22e3730e885mr6733545ad.49.1746487766576;
        Mon, 05 May 2025 16:29:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e992fsm61067785ad.85.2025.05.05.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 16:29:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uC5FT-0000000HTd3-0OdQ;
	Tue, 06 May 2025 09:29:23 +1000
Date: Tue, 6 May 2025 09:29:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Tobin C. Harding" <tobin@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <aBlJ0yhsCTTh9svQ@dread.disaster.area>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
 <aAttYSQsYc5y1AZO@harry>
 <CAG48ez3W8-JH4QJsR5AS1Z0bLtfuS3qz7sSVtOH39vc_y534DQ@mail.gmail.com>
 <aBIhen0HXGgQf_d5@harry>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIhen0HXGgQf_d5@harry>

On Wed, Apr 30, 2025 at 10:11:22PM +0900, Harry Yoo wrote:
> A more general question: will either shattering or allocating
> smaller slabs help free more memory anyway?

In general, no.

> It likely depends on
> the spatial pattern of how the objects are reclaimed and remain
> populated within a slab?

Right - the pattern of inode/dentry residency in slab pages is
defined by temporal access patterns of any given inode/dentry. If an
application creates a new file and then holds it open, then that
slab page is pinned in memory until the application closes that
file.

Hence if we mix short term file accesses (e.g. access once files (like
updatedb) or short term temp files (like object files during a
code build) with long term open files, the slabs get fragmented
because of the few pinned long term objects in each slab page.

IOWs, the moment we start mixing objects with different temporal
access patterns within a single slab page during rapid cache growth,
we will get fragmentation of the cache as reclaim only removes the
short term objects during subsequent rapid cache shrinkage....

The unsolvable problem here is that we do not know (and cannot know)
what the life time of the object is going to be at object
instantiation time (i.e. path lookup). Hence the temporal access
patterns of objects in the slab pages are going to be largely
random. Experience tells me that even single page slabs (old skool
SLAB cache) had these fragmentation problems (esp. with dentries)
because even a 20:1 ratio of short:long term accesses will leave a
single long term dentry per 4kB slab backing page...

Hence using smaller slabs and/or shattering larger slabs isn't
likely to have all that much impact on the fragmentation of the
slabs because it doesn't do anything to solve the underlying object
lifetime interleaving that causes the fragmentation in the first
place...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

