Return-Path: <linux-fsdevel+bounces-15350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5701F88C661
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFCAB22A35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7913C69D;
	Tue, 26 Mar 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc72hLuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99052233A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465826; cv=none; b=lszMpw1qekEKBgC/B+otfEJ5WlKTL1er1j8but58MIkuaxxenfVliTNyXUIFgEJzemxd8RTCxWY03jPqtaZosr2cF4QksM2+Ew9JNs1me6LebYJA4zp7rWf+P9Y830lDszZW9Ael5yueOXa4awwAff2MoB5ZMYz/qtSAxnQ+ezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465826; c=relaxed/simple;
	bh=xXOb+BG25Vxf3ovjBUjCL7KjeaTIPO/ZI5N7H7ORD3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiMZpdW4Ojs7tb+yWMBzdxtKeiE/kyCYBbf0gx6HlwspS7U6j5va5hA1dOMaHu5VlDxK1xNPwIV+jVPJC7FxFuoIWHXKVqSB3kApQMBrqEJ3uAC2m80LHpw32sJXATDmduRtRPq2b5MneoWRmY/Q0crabaId+DtnfmU1gQGj/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc72hLuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711465823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxdV7cOquI5Q3fFWTr9Rp0HS+bVOMASvKCj8swk/RK0=;
	b=Wc72hLuKSEAApstL+TSo980ngFQu6PgC7hpapCJy0Y8ZVOHwRG7ZDHeB8IqyND54hz9Asb
	q4bDJJzstcVmCEc9uc2YODsdK8Wfm2OKgog1XX7iEQ8cytC4u67wSJmz+yPEsbbjpVBj7N
	37X6Qd2DP/G7pCrbHbpR5zHz0bZcico=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-tdOSRuNHMsW32I1wXJc4iQ-1; Tue, 26 Mar 2024 11:10:22 -0400
X-MC-Unique: tdOSRuNHMsW32I1wXJc4iQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4751d1e7a2so109863866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 08:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465820; x=1712070620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxdV7cOquI5Q3fFWTr9Rp0HS+bVOMASvKCj8swk/RK0=;
        b=AM2/ox/Z23b/6Okl5JwrMMYduz5PMhCNqnKt/T++EM3I6ue9Lsb2a5+hX029JVKlTC
         3u8vcZNRUzajJJauh8EM02a5YQCxOxfVytxWtvYzbfqAHkCDzGk1edd+wSMsiM969v0Q
         Eo7B3Hcza9HycVkAjx25kjC0AJKN95nTYHrfq1c4kaMJ5GGKBzXjiXmAQAQe2GeLylfn
         pQ3uHM2s28bb0+iBGWo4XPru++NCAL4sZpG+xFW5cU0foUR5oFPjLlNhW1GUlWBeoi++
         Td+OplorM0/+h8YYFHn22n8sqtMJIpbwNE1Gpwi4wkG5IMqVhSuIELgQVGOw+VwhSQGj
         ov7A==
X-Forwarded-Encrypted: i=1; AJvYcCUjbuD6vD6SbwuHBViztTVAN34FA3XUyzJQUF4nyDfnjcTPpxogQUSSCg9G+e4p5Fh/YWCkPirCFaBE83ZMr5GdDeFm0HZlI0VADNoOPA==
X-Gm-Message-State: AOJu0Yy26MKQEVwLO6HAGpwSIaDx9r+Oehos2FOZpAwktUzQsBEpBeok
	qqlpdLjKPG3Vw7KFC+JcniYJ4jtkSMOz2nr2Y+3Y4Ol17zEguHRw9an6dbqqKn4EJrx8HQ0aCZv
	9b+EXWPyc9zaBfOpDnnadpgNNvkXSj2OjcIdqODl3zuDkxIrC2dY53Cgg0eg+8w==
X-Received: by 2002:a17:907:f84:b0:a48:7cbd:8b24 with SMTP id kb4-20020a1709070f8400b00a487cbd8b24mr4609921ejc.17.1711465819984;
        Tue, 26 Mar 2024 08:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVYr2DynbfCAra0NeiwDGEse4TeSxrOQRUZazVPyl2v3IXwcp4SpWFoy/KtQRMC2IEi/kf7Q==
X-Received: by 2002:a17:907:f84:b0:a48:7cbd:8b24 with SMTP id kb4-20020a1709070f8400b00a487cbd8b24mr4609889ejc.17.1711465819182;
        Tue, 26 Mar 2024 08:10:19 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm4291883ejc.224.2024.03.26.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:10:18 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:10:18 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to f2e812c1522d
Message-ID: <dlmrrqswfhspcjn6ai7jfh54t4mwrgus2ex3b4klpcbszq72zw@cizkdcybodfs>
References: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>
 <wdc2qsq3pzo6pxsvjptbmfre7firhgomac7lxu72qe6ard54ax@fmg5qinif62f>
 <s2kxdz3ztpuptn3o2znqpsbskra5yqxqnjhisfjxyc3cqw33ct@k6bvhr2il2sn>
 <87r0fxgmmj.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fxgmmj.fsf@debian-BULLSEYE-live-builder-AMD64>

On 2024-03-26 18:42:47, Chandan Babu R wrote:
> On Tue, Mar 26, 2024 at 12:14:07 PM +0100, Andrey Albershteyn wrote:
> > On 2024-03-26 12:10:53, Andrey Albershteyn wrote:
> >> On 2024-03-26 15:28:01, Chandan Babu R wrote:
> >> > Hi folks,
> >> > 
> >> > The for-next branch of the xfs-linux repository at:
> >> > 
> >> > 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> >> > 
> >> > has just been updated.
> >> > 
> >> > Patches often get missed, so please check if your outstanding patches
> >> > were in this update. If they have not been in this update, please
> >> > resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> >> > the next update.
> >> > 
> >> > The new head of the for-next branch is commit:
> >> > 
> >> > f2e812c1522d xfs: don't use current->journal_info
> >> > 
> >> > 2 new commits:
> >> > 
> >> > Dave Chinner (2):
> >> >       [15922f5dbf51] xfs: allow sunit mount option to repair bad primary sb stripe values
> >> >       [f2e812c1522d] xfs: don't use current->journal_info
> >> > 
> >> > Code Diffstat:
> >> > 
> >> >  fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++--------
> >> >  fs/xfs/libxfs/xfs_sb.h |  5 +++--
> >> >  fs/xfs/scrub/common.c  |  4 +---
> >> >  fs/xfs/xfs_aops.c      |  7 ------
> >> >  fs/xfs/xfs_icache.c    |  8 ++++---
> >> >  fs/xfs/xfs_trans.h     |  9 +-------
> >> >  6 files changed, 41 insertions(+), 32 deletions(-)
> >> > 
> >> 
> >> I think [1] is missing
> >> 
> >> [1]: https://lore.kernel.org/linux-xfs/20240314170700.352845-3-aalbersh@redhat.com/
> 
> I am sorry to have missed that patch.
> 
> >
> > Should I resend it?
> 
> You don't have to resend it.
> 
> I will include the above patch in 6.9-rc3 fixes queue.
> 
> -- 
> Chandan
> 

Thanks!

-- 
- Andrey


