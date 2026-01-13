Return-Path: <linux-fsdevel+bounces-73411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8375D1848E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22A23047AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6C38BDA0;
	Tue, 13 Jan 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2slBqe6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8ODdyCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5638B99A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301591; cv=none; b=YKVuOGT0SCaYWDccUmGR6oBzFS4Al2FnxeP5yWtlDH9nhg2nxrFjoKeHAmWmx/Dmh1zZOFpbYaQUnH48LaB0P0++oWvXhYxh0PAJ69BF/87roHCz2EBjDzJRhi08mZpxvW9LcIcsGSBjlHxPrS6pgQSGkXcwXCC1/y5Tm7BlKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301591; c=relaxed/simple;
	bh=PjHHNXMU2ECbmiFzVWprvbt8oK2qCpnxqnQXWFkJbRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0c7ni6MkmjLnEah70S75N1+2B1rxFLUA9FXIJP5uyEx6ODkRKJNjO27mNpJg0nj7DEgImTkMxfSCIxko8CqGc/p6PvgIUGkE32TosJt2ef3IHcYkObGuer6wg6xQ0vs16j6GU6PcP88pD4t9zJthunnMp7GUM/VosAZJvqwcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2slBqe6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8ODdyCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768301589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RRzq/OiqJCPG2bkBaZVulxyOOCKnLsjXMbp4ew7Pkeg=;
	b=h2slBqe6vwakrqvCTQzx6d0/75UXUAKQ1/vM4ZDAv/1K/Kf9HtKagXIUDEmFMIVqicbHdN
	M6Q7Juw/0ZPOkpLX9+nAEnN+42HWaiZUs7oaW4H0aTdELaRpU7jzoG/4/TSsiB4U16/SCE
	UcyUt9GVuE4Ka3gB9hTwwR6fV8a3ot4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-v_BpeNaZP8iRYo3oGWOa5w-1; Tue, 13 Jan 2026 05:53:08 -0500
X-MC-Unique: v_BpeNaZP8iRYo3oGWOa5w-1
X-Mimecast-MFC-AGG-ID: v_BpeNaZP8iRYo3oGWOa5w_1768301587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so4364359f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768301587; x=1768906387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRzq/OiqJCPG2bkBaZVulxyOOCKnLsjXMbp4ew7Pkeg=;
        b=a8ODdyCfQnGJhZhTkPaPWjWfow1mXty1eyHTtnP+sfzzcmEcOafZmPFam7rnWRIDy/
         cbdhcuaQ6vXHDivhjJf1LUZbl5KPlp1hN6RnfT5Y3aQab1zBOI0S/jvbwAyEbLAvBt1W
         fzXEtiM9wXRNvlGjsIJSGAyfvKIbgElsjXtJW7ea8Abe1JhOmu27ZiaYQLV9YHJBS7W1
         fDzdJYxY3dh7lJyDxVWbKBp4+lLr9LXVCBRtR8g5OjxFyHJLUeBluoMyzQ20Kpqerw17
         DT0Crtfy7DLAqeuXUYRJ6ur5zC98OZLORqpT2UJxIDKt8PF/ltlCiAnpFACzfoog/3Qc
         MY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301587; x=1768906387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRzq/OiqJCPG2bkBaZVulxyOOCKnLsjXMbp4ew7Pkeg=;
        b=SCaWPkDHvISaC4ur33gg8AYNs5KxHxCH4+zmgF/C/LmWW5/ZcaGvEMwOR4TlB1w6IR
         lh3e458bQqv9RkKBDb2pGIvq+CfdlH9Uu/JBK8AZGUPLO8L6wTyJ7I7nmaS1UZxMemMk
         zC/atFQUcSWrzX2OJ1WiY0Jyh/v+orPTW0pRvrHVcnlLs1j+eMGhPCwxmWMFd66kuhY1
         uMBmBcxHWNqdkAwQ12LRbbMDcXuukuNqcp1k91Bf4mkA1v4qjXwhUUd+BENbGN0rS4U5
         uh8fI+lSSEr3ClJeowBIVZ4oV2/4uJZ7dRlxU7dcVzxFnIh4Jm7eZXxNhEAptDKHkoPC
         qEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlj5ICbyELBq2ALOxI47RB6pneHG72ENNc8qMDGJ4A2AIAeH+mz4WqNsi93pZJZS2NZFDKSMU31KMkIeJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/5cnaist83OEzjP79sNJI9QNsvaGmJrYCRUP1Iyk9P8Qm445
	yQUe+yy4fWuIPpXSkyN6Zar4fm+pjzrqY05q8Dp8iXZVzoKlBs9d8gUwBzVt0vT8YZW47nuDJbK
	g7/OCPtwY72Wax+z0Dh51hh6MkGoISaj2Dq8evFECNc13Yozp5Dirwdj01JQYfqk2vg==
X-Gm-Gg: AY/fxX5BMs0Fvvfbw5hbsIWVRLGVlxIrUxMhmEnrHOueopE60HUN8aexEi0KVkVYUyx
	77qSEbesxeLJsCRq4IUXjHxODS4406trKhGJmZcfGiBp2AfUI5y8ZM3nRBevDGZJ4F5/Ulgq1qM
	hyJDcg6fR1YaEML+6YZKcSpAneQcMIVGbOZoegtK6kXzPeK8yne5GNu5qoWLV9wU668GVIfpxGn
	LhD32fj8VKQPEA3hK6GK+IJq1nbZBPuz/kIWKLF8/cRJl+lVK+RezVH9iM9lf791yNZ+KCP3OHn
	sG9EDfhABXfmsrXAs6XUBTc67TtasrW9qMAKQYiQ4blLF4owZ8diklVgdLviSWVRMxmwg8mS9dM
	=
X-Received: by 2002:a5d:64c4:0:b0:42f:bc44:1908 with SMTP id ffacd0b85a97d-432c3628318mr21995934f8f.6.1768301586774;
        Tue, 13 Jan 2026 02:53:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh4NEoqV1IGWMRybfYo/BPX2SnOF98P97L08GyHqewwRXa7H6fD1m4rMETsETdz+2sbqsNaQ==
X-Received: by 2002:a5d:64c4:0:b0:42f:bc44:1908 with SMTP id ffacd0b85a97d-432c3628318mr21995903f8f.6.1768301586365;
        Tue, 13 Jan 2026 02:53:06 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa78sm44253141f8f.6.2026.01.13.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:53:06 -0800 (PST)
Date: Tue, 13 Jan 2026 11:53:05 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <3h675bqgb6rslcn5anicpg4f3n4j4irqqotyopmebh4bx2crqw@nh47jqrj3ucm>
References: <cover.1768229271.patch-series@thinky>
 <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
 <20260112222215.GJ15551@frogsfrogsfrogs>
 <20260113081535.GC30809@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113081535.GC30809@lst.de>

On 2026-01-13 09:15:35, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 02:22:15PM -0800, Darrick J. Wong wrote:
> > > +		iter.inode = iocb->ki_filp->f_mapping->host;
> > > +	} else {
> > > +		iter.inode = (struct inode *)private;
> > 
> > @private is for the filesystem implementation to access, not the generic
> > iomap code.  If this is intended for fsverity, then shouldn't merkle
> > tree construction be the only time that fsverity writes to the file?
> > And shouldn't fsverity therefore have access to the struct file?
> 
> It's not passed down, but I think it could easily.
> 
> > 
> > > +		iter.flags |= IOMAP_F_BEYOND_EOF;
> > 
> > IOMAP_F_ flags are mapping state flags for struct iomap::flags, not the
> > iomap_iter.
> 
> But we could fix this part as well by having a specific helper for
> fsverity that is called instead of iomap_file_buffered_write.
> Neither the iocb, nor struct file are used inside of iomap_write_iter.
> So just add a new helper that takes an inode, sets the past-EOF/verify
> flag and open codes the iomap_iter/iomap_write_iter loop.
> 

sure, sounds good

-- 
- Andrey


