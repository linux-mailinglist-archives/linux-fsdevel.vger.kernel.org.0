Return-Path: <linux-fsdevel+bounces-14881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC6880F70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F943283717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF83C47B;
	Wed, 20 Mar 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajzGFEgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89C3C471
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929770; cv=none; b=ogMzAPAY79s/GLdLG0SSKu2jUEspr1qRjIR6ITc9MpRhDqvDlvwqMZAjZrqigEF2LuRKeD+GNqn96o0Ye9yxr2fmElSFtAr5eHCXq2cNkM8PQsSESNWsU2IQXmVHk/NjRepCllXRFM4P2wzzMeDIJxd1tv2eFgNKAyc9J333Ap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929770; c=relaxed/simple;
	bh=rPa9t11DkjZ8Ed7kwM28DoTQ4P507YzandJi5vcUYHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAyGaQqL2A3ND/BuvBo98KAK4dEeiLIc+M0zGjGbzCRRgK47Bzs2ywXkhWhElhUfxvNnwVmsMWThVXBeNmkY/mviDL0muUu4HzFAzFeVfH/sgIwXPjYmbuEniuaxjkh9++RaFSvWIcsdrdYI+GVhqhqTOzbQK3fk4pV4xCn4cuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajzGFEgO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710929767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t44WkNVUoNO+QtPNbszmzeZBcjv/Mxh37EetmY3mq4g=;
	b=ajzGFEgO+2bG5quG+zn5rkdjD2h0OMwHcizVFdqsRrN8zShppv01wUrdHv29S3B6X6PSXu
	ZGHiNWqm5imRdNJVLvDDljPoANFju443IRVHZdnPORG3A05bNBFfZE1UgBueua4Ru+h+Pq
	YY2j+bHqYyAPVYZIMLfRSM6vO/6Gc6E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-QM__AnlYPXOay8K8qTz2Fg-1; Wed, 20 Mar 2024 06:16:05 -0400
X-MC-Unique: QM__AnlYPXOay8K8qTz2Fg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56b829a3b41so1506548a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 03:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929764; x=1711534564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t44WkNVUoNO+QtPNbszmzeZBcjv/Mxh37EetmY3mq4g=;
        b=b3jQ4jMsav1VV6IP2Cm5Q8WsEvYSvUukcu9cpCt+kmKoW9wkm+0gtrSucK2wAurIjF
         IiVPZD3p6/BJ8TXfGomVwsTq3eDgXRfoAcEX+0BWXbI+oT1709rft3L+slRo3l4ttTlb
         7MdNwuGRYy1AbdXx3SusfEhHZ1v5tIOLQnUZ3IglWZldCIH1Jj4op7CJCcsDPNrHD7Sw
         /p/T5SkQI4ALIV2+j6oAIH7krb+jYEU6lF6QEb8dmjRh8WIGG3mt7zcFd0vsnmKy7eLK
         fThBATnsXxza2ws/DlVJD7tX/3MUBiXrYTcL7sRk5Bl+iukSLCF9mqbP9bebBNMYddHh
         h86w==
X-Forwarded-Encrypted: i=1; AJvYcCXoqHN93Cs79TTESbo99pekWBdQvZ/gtIVZD3dOityvD+LxtP8q9rBDNMC+e4b75cK9itFCeY/k0GXsVwxf1CJF2TmiPrvWEWrzHOE8Ug==
X-Gm-Message-State: AOJu0YxW26x9EOAyzWMln5h0k1ZuKmVNQSIKYBh1kmBLjF6ID4tLhE6g
	fU3E8r3G2qyWiekHYHXOb/z8XDFMCQvLbPB2VEOpxVGgWEWOBO/z/t6RibvUREgXB/cPUHWGTL3
	ZlG2DqsyzNDS2tQiUBT8lOrw40k5uT+N92rWLXU9ePHLhMef61aoRYXkmIsNpamV+KDGxBg==
X-Received: by 2002:aa7:c402:0:b0:568:99fa:26c with SMTP id j2-20020aa7c402000000b0056899fa026cmr10205690edq.11.1710929764182;
        Wed, 20 Mar 2024 03:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7TqJtJpn6F0nyXq620kFUM+OS+Yv9phf2USDD8d0KiBXDmdTBFbx3kb2cefQw/Lig8fvKUQ==
X-Received: by 2002:aa7:c402:0:b0:568:99fa:26c with SMTP id j2-20020aa7c402000000b0056899fa026cmr10205662edq.11.1710929763564;
        Wed, 20 Mar 2024 03:16:03 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b00569aed32c32sm3327689edw.75.2024.03.20.03.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:16:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:16:01 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	Allison Henderson <allison.henderson@oracle.com>, Christoph Hellwig <hch@lst.de>, 
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Subject: Re: [PATCHSET v5.3] fs-verity support for XFS
Message-ID: <7ov4snchmjuh6an7cwredibanjjd6zvwcwyic6un6lafjt5e3i@kgt75bq3q56t>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
 <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <20240318163512.GB1185@sol.localdomain>
 <20240319220743.GF6226@frogsfrogsfrogs>
 <20240319232118.GU1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319232118.GU1927156@frogsfrogsfrogs>

On 2024-03-19 16:21:18, Darrick J. Wong wrote:
> [fix tinguely email addr]
> 
> On Tue, Mar 19, 2024 at 03:07:43PM -0700, Darrick J. Wong wrote:
> > On Mon, Mar 18, 2024 at 09:35:12AM -0700, Eric Biggers wrote:
> > > On Sun, Mar 17, 2024 at 09:22:52AM -0700, Darrick J. Wong wrote:
> > > > Hi all,
> > > > 
> > > > From Darrick J. Wong:
> > > > 
> > > > This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
> > > > fsverity for XFS.
> > > 
> > > Is this ready for me to review, or is my feedback on v5 still being
> > > worked on?
> > 
> > It's still being worked on.  I figured it was time to push my work tree
> > back to Andrey so everyone could see the results of me attempting to
> > understand the fsverity patchset by working around in the codebase.
> > 
> > From your perspective, I suspect the most interesting patches will be 5,
> > 6, 7+10+14, 11-13, and 15-17.  For everyone on the XFS side, patches
> > 27-39 are the most interesting since they change the caching strategy
> > and slim down the ondisk format.
> > 
> > > From a quick glance, not everything from my feedback has been
> > > addressed.
> > 
> > That's correct.  I cleaned up the mechanics of passing merkle trees
> > around, but I didn't address the comments about per-sb workqueues,
> > fsverity tracepoints, or whether or not iomap should allocate biosets.
> 
> That perhaps wasn't quite clear enough -- I'm curious to see what Andrey
> has to say about that part (patches 8, 9, 18) of the patchset.

The per-sb workqueue can be used for other fs, which should be
doable (also I will rename it, as generic name came from the v2 when
I thought it would be used for more stuff than just verity)

For tracepoints, I will add all the changes suggested by Eric, the
signature tracepoints could be probably dropped.

For bioset allocation, I will look into this if there's good way to
allocate only for verity inodes, if it's not complicate things too
much. Make sense for systems which won't use fsverity but have
FS_VERITY=y.

-- 
- Andrey


