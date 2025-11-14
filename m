Return-Path: <linux-fsdevel+bounces-68419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70172C5B5CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 06:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A234F3BC533
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25122D6E61;
	Fri, 14 Nov 2025 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrQf2JM0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB22D0605
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096863; cv=none; b=LObQXzsKcVOCA+wnQx0hU9/H57a+6h7M1RJCnpEOhEH6jvT0aLSO6g+fWhC5Epg3VL6QFeIHItCRv53XeHrEHxgfsNfpf5lqzkPfmJLxo4q7TVSVyOze7iT+RohnnQ7XIbCZzgC7M55t2rz2ugsHb+zljR5gfQ8BxYfX4yBuyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096863; c=relaxed/simple;
	bh=PfYlbSnhkbQA76udjWHZBttEuBLcch9/E9x/Zjt8xyE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oThgMYUqaLDozrjlmkvlil459IHx0VgUBG9WyqPsc5/xsRZWHxkkDv/9WkmJHvBORS/S0yzpva2S8g2ZbayoFEZxqaA3Bly1MkmQfTDO5hn7roiO4txsMiK/fo+50aVBRoYo7W1zXoCrJpvs3WJprJpzM/9sY1MmS7nQR0dRAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrQf2JM0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29844c68068so14161285ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 21:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096861; x=1763701661; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kc5SP3ZHaud5cAzsFrlPvf9GXnKWLDwtapilGbxVFYk=;
        b=GrQf2JM0zh8zw6Jr7ILa9BEPQx4LfTUvAE5+qXxKFDBMvsY56NxzIkrDrQ1kyFbAyr
         A27hb6EnySfASDkrx4ncV6BSuszpVSRlpJ4JaV6Bg5c+ZTvWTOONrtWjN+K9Wb4SHT9W
         wSICbWm7eY1f4SmkuB8M+b/SSLsf4vRX4qw45+J4GaOHzFPgTt1nqzAocm/5ocW2I3hz
         ZclpDE0ueni90R8yp7L7MvsujNEadJbL7Cldeqch8/KI5GH+Guy3Uz0Z54Tq3MtepuIh
         aW+X4TbFTmaWbqJMAMC596MSrT3HTeIswVE2WxLdHS6+wLJeIiUrtWfKrJ8lgm+WS02w
         ZIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096861; x=1763701661;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc5SP3ZHaud5cAzsFrlPvf9GXnKWLDwtapilGbxVFYk=;
        b=bMrt+iEp+vLzU/xj/jyPDrShzuS6GZ7i42GWNKbl6VSQmmxKowhCMAQNE4+caadYQY
         EqJ8OMRTM75uWMDHYaZAXF2Y4hOBtiYL2jZekSH80ujfgvEtQTLZIpePoKHTMSfXDzkJ
         tXCelnyvvm0Zbx13WHLIRqPvD4+eMJwWMO5XLJUQVnaccsoCsoEGnkylZOZUZ/Yg6mTe
         TAtpRc3iMNUKlqOV/WaoY5JTv8/YGEkH6XFCWvZoimaQbhgCLUaZ7YkFEdRPWCb6Ziql
         jXFnO85QtqdgmF4KSzUt2p19WyCEe7exvtKptsxGVB/Dnu/L9CuYOPUx4+9eZBzVhTeM
         1ytg==
X-Forwarded-Encrypted: i=1; AJvYcCWMTzuJ2n1kRmppR65DSSRCc7QCCkLonV/yY9oZ+cYN09w6bvfHdbxAvXW0+TIHaBdhofiuMSDpNaodfdaG@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHj/RX/tEsbBQnuV0zsHGMQao/7KKbJ9uu92gu0e1fyqM7YEJ
	XG4ZT4UcE6fBlwIeVA6SBXtVVrdVu8iknb98x55xVVrJvWfC2tfpDgNP
X-Gm-Gg: ASbGncufZs6m0zy3QAgBexbMCqcwDUxCuqEi+LqsS4ZbrIReWs/y6LmVdaymIYLIXNx
	WcFHACwHEXskA2l3xUD9mWiiGlmBt53Zji3eWlqgMPoGfxXLWDhPfND/XZM7jQKG52FzEIBQ9Yf
	oMmynfjPHbRo1SWV8KUy97LH0D6rqTHA/N3ndAqeRD4W7oaLnVXD1FY7IzKg0z/6+M0vPxvbok3
	OSdmA9h0Y1Sl/s19Qt3KiwUVj1iesv+G3kA5Qx9LkO9OXM3/fgfIgnk4rQ7rw9nCdj7GAhEmlAo
	LlFgUSSj9D4pPzCNFcwCqW5MgnTSIlGZeQV5vPox54qFT+0zd6FHD/XeVB7trOm9lPOApdtmCYb
	VGVfuCYFFgGTZOkHim2JU6zPteKRZFZuDIEbA6+LzloqK038GixKIvAJjW+k9FHs/oIGWJBs=
X-Google-Smtp-Source: AGHT+IEK285v1wC2XvzGikqccbF9tOIC6uZx3BccuaEpsjgYn5FPyTQAAYCs+R3hkEKMpO8EagDTJA==
X-Received: by 2002:a17:902:ebcd:b0:294:f70d:5e33 with SMTP id d9443c01a7336-2986a6ba476mr19617915ad.12.1763096860963;
        Thu, 13 Nov 2025 21:07:40 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d195fsm3835410b3a.18.2025.11.13.21.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:07:40 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRSuH82gM-8BzPCU@casper.infradead.org>
Date: Fri, 14 Nov 2025 10:30:09 +0530
Message-ID: <87ecq18azq.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> From: John Garry <john.g.garry@oracle.com>
>> 
>> Add page flag PG_atomic, meaning that a folio needs to be written back
>> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> in upcoming patches.
>
> Page flags are a precious resource.  I'm not thrilled about allocating one
> to this rather niche usecase.  Wouldn't this be more aptly a flag on the
> address_space rather than the folio?  ie if we're doing this kind of write
> to a file, aren't most/all of the writes to the file going to be atomic?

As of today the atomic writes functionality works on the per-write
basis (given it's a per-write characteristic). 

So, we can have two types of dirty folios sitting in the page cache of
an inode. Ones which were done using atomic buffered I/O flag
(RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
need of a folio flag to distinguish between the two writes.

-ritesh


