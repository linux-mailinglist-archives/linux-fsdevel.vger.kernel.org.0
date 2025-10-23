Return-Path: <linux-fsdevel+bounces-65302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACEC00CCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99BC03566CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7330E821;
	Thu, 23 Oct 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Xq834mES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC2304BBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219529; cv=none; b=UbsMxhi+sY3OSiEYKTnz9flejd8tdU/kK3ZW815CI+aibqThompF8X6TTuLe9QKuXu0PX+MzOU6y8DkU9MxP5KqOPxAzs+foSGFggFza08QfkQrpAFgVZtuC+eSoPpAuo7a4X9qXideFwTMNYGwNw2X2brFofCiAz2apqQ0zikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219529; c=relaxed/simple;
	bh=elbfjnjaPAJ522f0VXHQ329aVUbiNkpcToeJodR3e78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNC/E0WG7JN7dkqfQad7u2cJv1OMalzMQqF31wsVdNI5vC7+qVt5IbdBLrDhABc7rCxJ26WjJI2aIkQ7x7/OQnJaY15uN04urCSjtR2+G0oXWtnVPTByHY3Ut1mRqw/1GYhWponxkfuYCqYcYUBeid7WxiO7QuTCyobNvkkzzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Xq834mES; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-793021f348fso660458b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761219527; x=1761824327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OfFvZSBGvefp2IlhmMNRYw7kz1hyuz0xjUoRSAHeZw=;
        b=Xq834mES791bTTrxSTRQufbSn0ov9XJarOZgqRneKfovg2CUagI6ijNwisJqsYfjyl
         k+TzFW/M+1v/eChI2vL7s0JBooaFCQssp+nrRlVMmCm6OcIiwSr0i7dBQmkBG/UjgYhO
         Tr44ds5b0L78fI1eD/eRjgSL0Byly6aSPRFJZoLusFSDBj9qHejd/E+RiznlhBcGEMhw
         ptX/2KRWFwwSS9zuaKoqFdF5bRr6MeLnxZHxzyVYPemGOjH3mdyAfAfG0P7rM9ToAJyz
         2M4JSdgZnfmKrWqd8XGYXuecb4md3Ny7nEwtSElRSqlOeqFbFIpUH1vW7McaVUnRj8gW
         +MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219527; x=1761824327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OfFvZSBGvefp2IlhmMNRYw7kz1hyuz0xjUoRSAHeZw=;
        b=JFsMa4SVjthlztKdiXjLAl6Q0LTYA8+KBnkPaxTG1SxM361kF/iTK7YZGrbElAiARn
         sofJIrhaWsbfoE5p8gI/6S7Qr2Q/BVxqy0c0Wcc0AeQ+h3LxaVPCaSpO9wefqRoTLKVu
         qX42IY8s/XU1bJtmpvAk7P+OUxrzWGIhoVmzj19G80OKDpHOUgkg0jmPeL5279k1itWF
         bvmTYitrSFXg9MqaX29AVfoLYNGYV2GedUPU2Zo4N9OPj+gMuQnZrIeBzxHVd+aSbBvp
         npVGxVNeEYfgp99KeGugjrOkgobaN1VKHDbu7+lU7KjeKpKJlY53qLeIJL3yG9SbR/5/
         eSyA==
X-Forwarded-Encrypted: i=1; AJvYcCXvgWqhgZIqSt8CucY6/gBA8SmnI+I9YgFpg7zid20ofsvCGRYeSvdHhzvE7quxoFZMWSpxNYK6A4A58E/k@vger.kernel.org
X-Gm-Message-State: AOJu0YwstQsiA1nph3Bs4VzqCnGOqNxqvFLX8XyW1eXnG3/H8j0Zqdqu
	spx+thRi0HOIpZyWG91a+OI7vMOyKVANeFrIcVkVxno4mWywpA7pmrnZVSQqbnMqEhA=
X-Gm-Gg: ASbGncuWG0xCMYQXUa80UDe0TS7wi43C6nzETyySmLOyjqMlYeii0wSF4KeNoyy6K/b
	7zruXURoS4sYkGtbsvxynuqlWfNeymCGo1/d/OqRXagZHPoIrqlwQuza42tDvqCzfVXSbISqr1q
	s9GRjPR0IYIaOZrfvituaNVRXO0rpzYt8Ju6EewGTeAh60b4Y0Fy2Z1py4s48aCkH3OIRMzTrTb
	aC5a2DpWGQlYEWRPje4yEojmKG4K+KqrkkHbMhWHH+BBhJlhKsHH/sD79NP5guacHRUSfgUwRdV
	G1x8pqXinH95goRX8aerPLCKP/GhBlxm/9m9Uvx3PAHIvubI8XSIETc1b9ub8oEcUuimMXIB/5Q
	botOclbT7YbbuYkBYrz7ILeMds7SAiJX8fRcwQ7Y3v3zWiBkUAAk7iVhXAusKlBoVHN20dZ41nT
	Mo1GZh5q1PIrAi5T7fSImJmU1b2YMgbISg30Negey7BMiOCbaVcbanXD4mlW6Onw==
X-Google-Smtp-Source: AGHT+IFGvY2Pdi6Kzm9/7JRxOvRXqUtuxuo/ixSX3c7klUnIdzpgEtIPhjSJGnNNJmvDxy7KykQvkA==
X-Received: by 2002:a05:6a00:9509:b0:7a2:7256:ffb4 with SMTP id d2e1a72fcca58-7a272570178mr3763899b3a.26.1761219526650;
        Thu, 23 Oct 2025 04:38:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12bdsm2225482b3a.72.2025.10.23.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:38:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBteV-000000011nJ-0x06;
	Thu, 23 Oct 2025 22:38:43 +1100
Date: Thu, 23 Oct 2025 22:38:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <aPoTw1qaEhU5CYmI@dread.disaster.area>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>

On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> > In critical paths like truncate, correctness and safety come first.
> > Performance is only a secondary consideration.  The overlap of
> > mmap() and truncate() is an area where we have had many, many bugs
> > and, at minimum, the current POSIX behaviour largely shields us from
> > serious stale data exposure events when those bugs (inevitably)
> > occur.
> 
> How do you prevent writes via GUP racing with truncate()?
> 
> Something like this:
> 
> 	CPU0				CPU1
> fd = open("file")
> p = mmap(fd)
> whatever_syscall(p)
>   get_user_pages(p, &page)
>   				truncate("file");
>   <write to page>
>   put_page(page);

Forget about truncate, go look at the comment above
writable_file_mapping_allowed() about using GUP this way.

i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
spent the past 15+ years telling people that it is unfixably broken
and they will crash their kernel or corrupt there data if they do
this.

This is not supported functionality because real world production
use ends up exposing problems with sync and background writeback
races, truncate races, fallocate() races, writes into holes, writes
into preallocated regions, writes over shared extents that require
copy-on-write, etc, etc, ad nausiem.

If anyone is using filebacked mappings like this, then when it
breaks they get to keep all the broken pieces to themselves.

> The GUP can pin a page in the middle of a large folio well beyond the
> truncation point. The folio will not be split on truncation due to the
> elevated pin.
> 
> I don't think this issue can be fundamentally fixed as long as we allow
> GUP for file-backed memory.

Yup, but that's the least of the problems with GUP on file-backed
pages...

> If the filesystem side cannot handle a non-zeroed tail of a large folio,
> this SIGBUS semantics only hides the issue instead of addressing it.

The objections raised have not related to whether a filesystem
"cannot handle" this case or not. The concerns are about a change of
behaviour in a well known, widely documented API, as well as the
significant increase in surface area of potential data exposure it
would enable should there be Yet Another Truncate Bug Again Once
More.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

