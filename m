Return-Path: <linux-fsdevel+bounces-15868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F45895349
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06022850BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69D7A151;
	Tue,  2 Apr 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+NfgNHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469F7E58A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061479; cv=none; b=EClIdwjyaURB8eOGprfq4NtO4XzYJBzKw2AlG4N5xJpn49E56jDavNzpzfMn7OZ1S2TM/lIBll8lbEtT1oRK5p0RpDBaZhEzRIl7R5ATRJxAo3le7BR5rOAUKvphmmlLvNJzOcG/jGmYQkubzwNTT21dX6thFCs8Z2ZxnAMb9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061479; c=relaxed/simple;
	bh=mTKiK/bd4B5Snb61jQKfVAlk1Uk8dcd9CCgYlmgpV9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUnqAqJw7QXebDgpNLGZFd7V3LteEv6YOGND27m9uytoLypnLpxOZE42E9NM4Z2enm4BXg2LnFVOHTfuvL68MYlEPi1fz9txvpHyur10AXplDYenL99sKzw1EbvKmA4arc0N3LIZoy7hrfOw+FoJbmJITZGEH/f6JsLuQpeBfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+NfgNHq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712061476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6k4yhaZw6MRRje/zJwwEymZQjJ1fk5zRXcMKDtCSjQ=;
	b=S+NfgNHqwJ1I9NbtXGRsTxbDakRlCLtHV6VeJ/94lyulaKETup9Kfm/83AkAb0fdCKSTxN
	HaJ75TE2StTHKItwosf064q5m4eFDgUAEQqV4guNrIcHsGKpKVDPZApE0ZRK6gcpI0L1LB
	XYbBvmANQ3MjsbC8coek3pTQwT+mWE8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-T5z8V2-9MRmeJFVkWsR_HQ-1; Tue, 02 Apr 2024 08:37:53 -0400
X-MC-Unique: T5z8V2-9MRmeJFVkWsR_HQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a4e53b37d9fso178591666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 05:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061472; x=1712666272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6k4yhaZw6MRRje/zJwwEymZQjJ1fk5zRXcMKDtCSjQ=;
        b=VMFg8SDsVZyLb+n1r6M6R6kHhpPwNu8lcQNiLQjfiGTYPsr7F9jWoNsZBldcrlKBKG
         wPQts7r1P9S5+GHlPDSPTx9QHCltWpDNo9QvIXFNCbraPfXZ8FNcxRHDBsGR+M1B+rsH
         jiqXSEaNnlqw8nDxJS/OzvTMph1dcrWL9vXRC9uSAbk1N0SHmwK3903S8Fg2Mu+CW4wB
         DV+aOFHmrW5/0ZmuezyA6AouaTsQ1vDQHRa0q7r+Oav+lMHQe8Zr/Em/m3esIdiC8DYO
         10LfoLTb6tMSLAvFMmbVLnMN24DgC06gY+RcTy9F+a2hKd0/H7IwMeskfbDhXZYldfS+
         ij/A==
X-Forwarded-Encrypted: i=1; AJvYcCWRuUD93iv4aRIs4DXXW53PSSfIArU/NCzl6+ybav/JPTF0+1QZlDUnkLTkc3yUp5z8/AiR+IpNPgdQcL3fcEpiitEelZz7VY4dymVGNQ==
X-Gm-Message-State: AOJu0YxdUPlDjtPydHIY3K1Ffuj0ETQc6nNdICCpUXNlcrslUmLG/UNU
	lwt45llq4fCT4gHSkQvbxXdVxJ+A8bdZm4d4QjzNsP5kowoqOsSF5HlChKkAYXNP4ium4Nmz5PA
	htQ0P8ZEIpXXtXoC27i4dPrq7JNz/WGFqacWzxlA9+s6YtiP4nP+qbujBRTGYeIpK3BHBBA==
X-Received: by 2002:a17:906:f284:b0:a4e:2123:e3c8 with SMTP id gu4-20020a170906f28400b00a4e2123e3c8mr7407271ejb.56.1712061472105;
        Tue, 02 Apr 2024 05:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlEz2I255dOogolt0uIznw+lpBOPt+W1j5C0C+337idh8Agza65YdRH9pPiFHshDM6HSGN3Q==
X-Received: by 2002:a17:906:f284:b0:a4e:2123:e3c8 with SMTP id gu4-20020a170906f28400b00a4e2123e3c8mr7407256ejb.56.1712061471443;
        Tue, 02 Apr 2024 05:37:51 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id dl5-20020a170907944500b00a4e28b2639asm6003714ejc.209.2024.04.02.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:37:51 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:37:50 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/29] xfs: widen flags argument to the xfs_iflags_*
 helpers
Message-ID: <vhk2g3qvkf224oklr57pmdnrjh6odshv62ciqguxcsgbrbplt5@3msropqnuqfa>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868758.1988170.13958676356498248164.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868758.1988170.13958676356498248164.stgit@frogsfrogsfrogs>

On 2024-03-29 17:39:11, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> xfs_inode.i_flags is an unsigned long, so make these helpers take that
> as the flags argument instead of unsigned short.  This is needed for the
> next patch.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/xfs_inode.h |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> 

Would it also make sense to flip iflags to unsigned long in
xfs_iget_cache_miss()?

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


