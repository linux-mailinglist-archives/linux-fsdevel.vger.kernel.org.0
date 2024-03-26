Return-Path: <linux-fsdevel+bounces-15311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C388C057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1941F3B42F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8004AED0;
	Tue, 26 Mar 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsdJQtuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7A5647E
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451654; cv=none; b=iZYWnJ0B3iBx577kKI3s2kZqC9nc2M9njPFUmLekhWe2BjU4n1dhSC1zPILnbF5vTRLJ+AyHUZ/To2RLxEKf87QfhRp0tppAJ3zEUkdQtI0txOr25HIh7V42pZiC8PKDgfxmSFUPQrRenTzuI8LwG6+AfCO0RTlEM9amMkeNEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451654; c=relaxed/simple;
	bh=TYMtfvN2vUnRHd6EWkh9ZqTFU7JiBbIR99/HAjSX77k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag5PdntCx+D/92gUZ1t3rmucq8B/05AeV3yrGrtwOMW7TWRjzjpJFPzL4u9O+jySIEWSzvJG6rZ/NM4Q90MfmYn+P9mz33Z3ZxjywMXKqWU17MNRHCiNT9fpuxYPwqODuCMVrvfOdvb07/fVPqATTghi6oTPRXlu4vXRu+QigEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsdJQtuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711451651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4gvtX7ytW1UnmTr6oylQHGYU56ln9d+44kJej9o2BNg=;
	b=SsdJQtucOpgUEm0CweKofRUUBKUm9CQrFfudyrtsr0JyccqBDbx+SaHjBBKfJrfZQQIPg1
	X/pf9q3yP8do+k21OG+IbeJLkjlI1kMrKCCUIVnrLBHOVT3R7ik+wkFp+uwayOjocfHxBb
	OZWBjwdN6iAry/ekXvYh8FqOx/6LbxY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-0RyZuHOgM52IcNKVq14wnw-1; Tue, 26 Mar 2024 07:14:10 -0400
X-MC-Unique: 0RyZuHOgM52IcNKVq14wnw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56c079c74d1so952349a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 04:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451649; x=1712056449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gvtX7ytW1UnmTr6oylQHGYU56ln9d+44kJej9o2BNg=;
        b=KTDfif2WP5nwpqYAw7TyM48RcdE1bh51CCtZrI9eX3k9iPV598Fh70GIhyE4nZfEG6
         P6DCv4PN5kTZrusbm2UFw/6ROkpRW0RWUf61JDKYorGi6IhiGQPYu9LWfZahy6fn2IiX
         YgrgciNlwAHk7s1WAKSM4XKTSeD+2Mi4HPzq5qr0bmmqr3L6Vg3s6ilFqKUfkBnx9wl/
         SC2YEHgi/WqwEHzg2PMJBGGUBP8cQzjjuHGOWUGjiEwc+4tdFFlgdreKmAkIWEeUtjrr
         1ARM5HFAEK2twmkTLTenTWNAno9QgQLsxhNPNq2LvITWokfS61S61SlVPKcHFmPYayOJ
         PmxA==
X-Forwarded-Encrypted: i=1; AJvYcCXY/R2SWg+c9o3IsEQv8aMm3MDkO3lCG2cFfe3rv56oL7hh5cOZwEKSlytG+qrvb0rqOuXpNvMaDLVF3fQnK2WSvODgTwTbU/O/4Q/WIg==
X-Gm-Message-State: AOJu0Yz+mTTc9iKojSvVYTbAodKVaLtM3UOWOg+rrCicnJL1gktz7uik
	0oLN8XhhQcS5ELP8Nj+cWLvFsb52yCudJbhod/h/QWCTNAfSK8GoTEtCiWAOi/xAUAs8ysrpFQL
	x6MM5CUxDswGA41CDzzJfMm5p8ZIyAp0tit56sQKjYKrfyjs1wKgo0yNhM554NA==
X-Received: by 2002:a50:d5cb:0:b0:56b:cbb6:f12b with SMTP id g11-20020a50d5cb000000b0056bcbb6f12bmr6394795edj.41.1711451649261;
        Tue, 26 Mar 2024 04:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9G+oAGBajKHJGKZJ1BqUzj64gXzHas8/hLl8OK59dXzf5a7WIti2wmaIWM9kOtnJxdLgd7A==
X-Received: by 2002:a50:d5cb:0:b0:56b:cbb6:f12b with SMTP id g11-20020a50d5cb000000b0056bcbb6f12bmr6394764edj.41.1711451648622;
        Tue, 26 Mar 2024 04:14:08 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4015250eds.94.2024.03.26.04.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:14:08 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:14:07 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to f2e812c1522d
Message-ID: <s2kxdz3ztpuptn3o2znqpsbskra5yqxqnjhisfjxyc3cqw33ct@k6bvhr2il2sn>
References: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <wdc2qsq3pzo6pxsvjptbmfre7firhgomac7lxu72qe6ard54ax@fmg5qinif62f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wdc2qsq3pzo6pxsvjptbmfre7firhgomac7lxu72qe6ard54ax@fmg5qinif62f>

On 2024-03-26 12:10:53, Andrey Albershteyn wrote:
> On 2024-03-26 15:28:01, Chandan Babu R wrote:
> > Hi folks,
> > 
> > The for-next branch of the xfs-linux repository at:
> > 
> > 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > 
> > has just been updated.
> > 
> > Patches often get missed, so please check if your outstanding patches
> > were in this update. If they have not been in this update, please
> > resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> > the next update.
> > 
> > The new head of the for-next branch is commit:
> > 
> > f2e812c1522d xfs: don't use current->journal_info
> > 
> > 2 new commits:
> > 
> > Dave Chinner (2):
> >       [15922f5dbf51] xfs: allow sunit mount option to repair bad primary sb stripe values
> >       [f2e812c1522d] xfs: don't use current->journal_info
> > 
> > Code Diffstat:
> > 
> >  fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++--------
> >  fs/xfs/libxfs/xfs_sb.h |  5 +++--
> >  fs/xfs/scrub/common.c  |  4 +---
> >  fs/xfs/xfs_aops.c      |  7 ------
> >  fs/xfs/xfs_icache.c    |  8 ++++---
> >  fs/xfs/xfs_trans.h     |  9 +-------
> >  6 files changed, 41 insertions(+), 32 deletions(-)
> > 
> 
> I think [1] is missing
> 
> [1]: https://lore.kernel.org/linux-xfs/20240314170700.352845-3-aalbersh@redhat.com/

Should I resend it?

-- 
- Andrey


