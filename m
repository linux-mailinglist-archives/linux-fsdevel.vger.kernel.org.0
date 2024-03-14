Return-Path: <linux-fsdevel+bounces-14414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCC87C1F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EE61C20BFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED5745D5;
	Thu, 14 Mar 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiLvati5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CA745C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436571; cv=none; b=UPgCyt44zr9kCRzaVOG6WrxPSAVpBCTtbKmk+lUTZTeT34EYVjU3TOGH3kN+peB8GyWqtg6RWNUyk0i9Oet1zSfumiZe55HQuzc1tTK4NLWcFUvaMrBTlRLjoITsVY9AcC650bdhbZ8teXb93w8jcYpGzXYriP4Bx+BOVgI/3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436571; c=relaxed/simple;
	bh=yJ9lhppTwYft3uAXsPtQ9JakH3AP/Ec6HHHPVz1Rbgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV2fhq7A2Oo3yn0FHQtR7S5gtTssxd/Bj6PHz3sEfoDFsGMqcllTeWfriYGs5vlTVkaupV3hw2NBlboogXo0GUdNxk2qfVUVBcijur/fcmsNL5BGO5EceGBuAFRZpB6qWrPrVHzOYdnoO+Bl4OV7zWRKwTxNZcdoPQeKbBIHiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiLvati5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710436568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yo3wkqTGWc513kM6wvuDHFlEJRGidugW7GVqad1jST8=;
	b=SiLvati5B4fTGEKJYPg2IkwTtyn0kVPzBeKWCCCkMXmdooBexZwZIEgOWsKlwcs2GIMDMu
	nGeP79ojzgcCQXg8rvSxr/CEeMZcxyxowwVsPWH/MKWxJlkK/E5UQJLNF6BWsRyt8Tb3f9
	1u6sCznIPI5N6p+JYThujerYHwNdZdU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-RZSYEIsTMRWsjUVAF5PlDg-1; Thu, 14 Mar 2024 13:16:05 -0400
X-MC-Unique: RZSYEIsTMRWsjUVAF5PlDg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-568a3be9127so449598a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436564; x=1711041364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo3wkqTGWc513kM6wvuDHFlEJRGidugW7GVqad1jST8=;
        b=Wmgm7hyfG5T4/TqS8xBYatGQaKmmUwwa53Gsjh9avmbeAqUt/6Pwv5qKmaTrh5QWsE
         9KZtaOylFY57o/GY9jMvpFsdE59QjTikwsDLRJ4zN8+4pBsJYPnymeaJBzmLauFuB7IP
         iloFafO88oOLsYAw9B8vbzYDdUjyhTN2ikj7bHDPXMNwZsrEEBeLQJ2NKu2dUAoioV2+
         1kbFMV99+lH/KunvN/u3JYutslEfZHmrSuqecmIAZLvWYu7fU42sZMg1tdjdBZQ+uWi0
         HlSWPZ70CoqFP3fJ53qNbpq6zxXlcjUXCHXsNG2csUwVq+9BTyVErcVKggaN+vtAmH7u
         mQRg==
X-Forwarded-Encrypted: i=1; AJvYcCWtvXQdcAyEmJXHNlLrFXWQ/lIL02GLOY33SqM81SUiceIkLGV5ktNHp1EjB2vveUlBjbS+fp7N/LEDLjuuiyNe7hb5uwRSYLgYIVO1uQ==
X-Gm-Message-State: AOJu0YzL5E1Gun9UbX+FdqmH9XGaGfBqwdlvpdjGzd03zl8Y9AY3gYaY
	jaWdx6NMw/aGMFJXFwiCAdjVQe/oiRhyvjOuN6RCSoGVPbcdhwnU6L9n/16UVjCnVwgqapnPE5Y
	85x9+mBU2qxj/kZ7N+Mp1WRLLKuGrGLCM5+rQBPf7Vy2HraEWf1NQMDe5Phm9cDoOhYVsVA==
X-Received: by 2002:a05:6402:5d3:b0:565:c814:d891 with SMTP id n19-20020a05640205d300b00565c814d891mr2108654edx.0.1710436563927;
        Thu, 14 Mar 2024 10:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpiQiYtlVEkMxL0Um6412Pz19nDaf4h9YSERjM68EoccsOsNTvC2KFnAl6vcMHFJMKQA9igw==
X-Received: by 2002:a05:6402:5d3:b0:565:c814:d891 with SMTP id n19-20020a05640205d300b00565c814d891mr2108591edx.0.1710436563299;
        Thu, 14 Mar 2024 10:16:03 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7d1d1000000b00568a44036a2sm546147edp.46.2024.03.14.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:16:02 -0700 (PDT)
Date: Thu, 14 Mar 2024 18:16:02 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 21/29] xfs: add fs-verity support
Message-ID: <lveodvnohv4orprbr7xte2c3bbspd3ttmx2e5f5bvtf3353kfa@qsjqrliz4urs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223693.2613863.3986547716372413007.stgit@frogsfrogsfrogs>
 <20240314170620.GR1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314170620.GR1927156@frogsfrogsfrogs>

On 2024-03-14 10:06:20, Darrick J. Wong wrote:
> On Wed, Mar 13, 2024 at 10:58:03AM -0700, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Add integration with fs-verity. The XFS store fs-verity metadata in
> > the extended file attributes. The metadata consist of verity
> > descriptor and Merkle tree blocks.
> > 
> > The descriptor is stored under "vdesc" extended attribute. The
> > Merkle tree blocks are stored under binary indexes which are offsets
> > into the Merkle tree.
> > 
> > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > flag is set meaning that the Merkle tree is being build. The
> > initialization ends with storing of verity descriptor and setting
> > inode on-disk flag (XFS_DIFLAG2_VERITY).
> > 
> > The verification on read is done in read path of iomap.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > [djwong: replace caching implementation with an xarray, other cleanups]
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> 
> I started writing more of userspace (xfs_db decoding of verity xattrs,
> repair/scrub support) so I think I want to make one more change to this.

Just to note, I have a version of xfs_db with a few modification to
make it work with xfstests and make it aware of fs-verity:

https://github.com/alberand/xfsprogs/tree/fsverity-v5

-- 
- Andrey


