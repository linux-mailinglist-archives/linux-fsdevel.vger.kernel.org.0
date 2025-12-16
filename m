Return-Path: <linux-fsdevel+bounces-71381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2906FCC0B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 04:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2AE301CD9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93369296BAB;
	Tue, 16 Dec 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOFBuCyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8F2F39D1
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854747; cv=none; b=cDpYdnGb2SMermHNH+xsnadIe3LQCKXUCadtnMX76uwZ/3albllSiDKq2slNmudpc20AVOM5B4SglLe+hqPc1cFpZwacVW4daTPS8VE+B40+6UCW3bLLv0atLDL2APxX4GqFVeYLxyVPP9hN2cEvIpoXCNrLQE0S+/Zg3e1z4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854747; c=relaxed/simple;
	bh=MHj5eMaKpbXLESG/oNUTKn3hO7O7opkUhpED1G1y26E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmN9v1rU2wRcYthfbP9eMBwZGuE+bUHjpl9tnX0owHqVz6zeBppjdieb77IYYtAiYBh3VtsU6tfr0FQOkglc+y5z7nyUeUhLBGszQfHLMQVw7YbGUSvfImlhZUqH4ygxyTgsNY+1+QYz7uoEql9234iEhWhTj4md73vvdk4Caec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOFBuCyj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so5135346b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765854745; x=1766459545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1XTKIE7lS6ISh9SSrfsgd7hwp0qO7clmkEC+ykt48o=;
        b=AOFBuCyj5biOosYWEPnJZmYqmDNs/s4hEc8ENSzZJM6QjNPTyOKpB/75Onk+oNaLlZ
         tQxfk89kAQgkNSxUtrkBgHZ3O2x3+w29YQTDTM92xEgDMPbtBytuX/m2VpkjBlV+raqA
         5oMfy/dlcGuGW7xk6hu7I1gPBzhuNEpZP0+JQSr5JyiSbGX/to4lTAFW0SYQrGSbOkyh
         AuG2PVToLgtczCi/sAONDEaJOMzR5LCFYoFJkQzgWemSiRZkCdACniI63GmTGOIKMc4m
         x8jcOIyjj7a5NARv2pHmMEBnKtx1hKeNmUZwQl7kTgSL+7RSmt44QVNCK3BLLjQYw326
         7oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854745; x=1766459545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1XTKIE7lS6ISh9SSrfsgd7hwp0qO7clmkEC+ykt48o=;
        b=AqTxDSha1IdSjkTE+QslnJEl6LwPPf+7GFVpTl24xhpj4ydjG5yVqQFd/ebFNtaGXP
         cmKojAyXiZXuRTP/v+QV4jf2dj0H0gpGtBneGi9lITPHntCtpCrUUUfOaDxrHrsfSQeZ
         /cyDxFE4FFfjCMC3cYU7LPiIe0fEWUdbZuOfI7w9EWguCk1n5whCW9VYUkIEWU8SUOLz
         l3LlwSvq6U2kFxy2cDcUr90iqa457u5ktaZfwvKF4T9Ofrj3Vmd3zyR4+tvjYUkp75Q7
         HgA2+80e0nZpJQlb4VeQ9uWRoyzGqYZrZqPBROoUFsc4nkutIAyOqDp9Et3dvnuM+zTG
         PE5g==
X-Forwarded-Encrypted: i=1; AJvYcCWrOkJoX6108NDUfcWffWvaOMrJv9X5UnlZXMm9LLFBRL60xKw9BMw93+acYSs4ACNBhamlmvMkUkSwfnR0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07IHOD9yjYHWcQBRvQkrqe3t3JVSCnD+4dB4aNBg3klDzhMYc
	UzKsByD1YmLMGgsfsrVrYtwC3tD2t4QEaJq0qsuGfpNSASIhNQfvpIGmMqUdhlpB
X-Gm-Gg: AY/fxX6ojkRFCpTXlyo0zfWRWTQrU2MdsRlkysh0J0LYogXYCZN07EpLl79PAKe4Bi4
	shK97TSfc11IhlyK/SIC2m/L+fRxxNHCE+XnWwYxv6nG2mBXEIxjgURouOX83z7XvKnwaNjwV34
	fGP7Zc2GAPbkDbLHfaqneYB+vPg3DxjL17RN1zSMOtNka7EMF/G+jKmzUBUioqAOuGpyaPhfD00
	ZlWspZbRwH858Eh6Gx1mIORsMhMbybCcwMeK4tQrQtE5YxeQ8cbM0q8uyolPUo5RgGTPjdZnWsf
	Yg61sZu3GkGQ45d01iPbH6PhZ56Gp10bgsfdVtQLN1q6FLRAOkR6FbMENFGJf9t3VbgdOD2EimG
	wVCsX3oQSbW5aqX9HVWlymDm52DIn+mhomIf12LTjWV76YJ6mBF0UBWQc21PJUDTuANpGJSczJU
	Ki5QQ=
X-Google-Smtp-Source: AGHT+IF0tz0zYbc0FACU6KRTQzZw3IhUO2xklXRdt4pY23/rn5onAkq4lgOwW+t2ZMZ15thjO9SINg==
X-Received: by 2002:a05:6a00:288e:b0:7e8:43f5:bd2c with SMTP id d2e1a72fcca58-7f669c8add9mr10107967b3a.65.1765854745459;
        Mon, 15 Dec 2025 19:12:25 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c585cde0sm13791160b3a.69.2025.12.15.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 19:12:24 -0800 (PST)
Date: Tue, 16 Dec 2025 11:12:21 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUDOCPDa-FURkeob@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
 <aUC32PJZWFayGO-X@ndev>
 <aUDG_vVdM03PyVYs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUDG_vVdM03PyVYs@casper.infradead.org>

On Tue, Dec 16, 2025 at 02:42:06AM +0000, Matthew Wilcox wrote:
> On Tue, Dec 16, 2025 at 09:37:51AM +0800, Jinchao Wang wrote:
> > On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> > > On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > > > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > > > constraints before taking the invalidate lock, allowing concurrent changes to
> > > > violate page cache invariants.
> > > > 
> > > > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > > > allocations respect the mapping constraints.
> > > 
> > > Why are the mapping folio size constraints being changed?  They're
> > > supposed to be set at inode instantiation and then never changed.
> > 
> > They can change after instantiation for block devices. In the syzbot repro:
> >   blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
> >   mapping_set_folio_min_order()
> 
> Oh, this is just syzbot doing stupid things.  We should probably make
> blkdev_bszset() fail if somebody else has an fd open.

Thanks, that makes sense.
Tightening blkdev_bszset() would avoid the race entirely.
This change is meant as a defensive fix to prevent BUGs.

