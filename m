Return-Path: <linux-fsdevel+bounces-44929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A40A6E6E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B33B3789
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1688E1F0E48;
	Mon, 24 Mar 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jREaYvo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF5198A34
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856808; cv=none; b=JUtZLNufBWuuKGGdq74aE0f/eiDV4Ewp4BsuVyRwz6DM1RDEWj62jotbA/ASSXr0UWMrSlu2g2C1XVRNc29Y6nETFmWaykS/dx4XqkfMZFG9dGcl/95htoYZ4FVbMjKt9mMv63a6fhfDCE+/gTd8qu/5L1u5+Y0OXmjLyd2TByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856808; c=relaxed/simple;
	bh=ToxbzIYyo3mvRaXjuB9xek6kAROEbqQqma+tRsnVEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOu4lW0eVVx9yTHd+cQaCiTy593nLa0I49yALimNpOKUIEaKQy3nZ50aZijHlXn7DdhSMMVkXTNrJxwbFZ1V0H8A5PYyNiA3kVWxnbPzZ72aRpMl6+eiMYsDI/DftvwNH4Q4zI/Nqlk7SLDxGG0bhzk3q+v2x6eZ0KY0DT0LGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jREaYvo5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso99656335ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742856806; x=1743461606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=jREaYvo57MPL+l3RkqhmfTpRRNcCmIgbFKNqqoAO4iGm7R35Sc9mPOUYpCGVsQqVWt
         fHiMnoe4uxn5F9zDBrtSNK066IZ88Ib70jJPmMuGHc292WoLC2qjdOG91ahaFhnA8laf
         80JL19eKq5wgRz66+n2kZ9RLc8eG7fPyh3ikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856806; x=1743461606;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY5rtG+txjgUVmR2iB8ixWTB2LUTd4fgsHR5xXKKbDk=;
        b=PL9c9Wpyeii08eh4pniRcvS1hqQuQ7uW1iVmuayrwpiiB9SJHGdCGOnGQrMeOoYf3C
         n+wDW0c3WejLdImsS7ETx6P74lYZyQN24FXPZyNzgYec3spBLzMGoi1aFdE5PfsRFvi4
         uyfoOXXIx2jEzFAenJX8qIXPx9XV65WVpVpZPXlM0QCMU7Looc5Hl+/s/G+S5m/3+7iW
         ByNYjQL9r/SxEhzi9SkiBiQVaD0aSukmJl4RrBhbEY28gKwtJdMY6oohj3nPUOIBQlda
         a0K8xzccDjBKCZjdnEvksqrz7OgZYYSLo3LXh+IUQFyhBVKmKxg0eDUs4zqDHmRXGPRH
         vSEg==
X-Gm-Message-State: AOJu0YxWcHYvmEcmgPKW9TrF0us57tm/DugbkqgqbFKajyWKtiJPcwes
	ODx3Nym4wcAnPL4FwVRoiRWu2GBpD7BHy2vA+kRAfofPCRVR8yBAyn+EhSxlpRQ=
X-Gm-Gg: ASbGnctu5ezwR8QkSZXqf9YJPl10JdI9Uzo8AMIHuawta5bYy29AXwDXl53BJwks18c
	jUnzZwFWp/DYZLoVwGWsR+e70Ewt6tP6WX7ZIqNR+1XNyGBus8X1MvaaBsnYU368duexRZNVRBV
	sU58z7qQilB6i8FoZOA2ytAj2kol5l3+Wcn/mKeD0wOwAQy4yM1+LPNaQGEtENS8dGJTtIj6M2v
	SueJ/6yOuxrsZ2HZFT0V399+uzq1rc6ja7DvsKep9fyffgIW/Kl4EX7W9GPzgbvkFfH+k7O/W81
	HuRNWyuNqqc+y+SuVZLA89Dx1t8+MRj+1xlAMYv7l4IV8bURCc8XG5eAl1jUPxCygezsF/nWBzp
	Pj/jyq4+CIMB84OSz
X-Google-Smtp-Source: AGHT+IFWobGI3AEkJrBmjG5hbnM0Sj74+gyMoEBB6XT22rPpwcgsE/V0VDJPRGUi0WtMaaGwjcoesg==
X-Received: by 2002:a17:902:ebc6:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22780d80189mr241804415ad.19.1742856806372;
        Mon, 24 Mar 2025 15:53:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b493sm76770675ad.34.2025.03.24.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:53:25 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:53:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, hch@infradead.org,
	axboe@kernel.dk, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/for-next 2/3] splice: Move splice_to_socket to
 net/socket.c
Message-ID: <Z-HiYx5C_HMWwO14@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
	hch@infradead.org, axboe@kernel.dk, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-3-jdamato@fastly.com>
 <20250324141526.5b5b0773@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324141526.5b5b0773@kernel.org>

On Mon, Mar 24, 2025 at 02:15:26PM -0700, Jakub Kicinski wrote:
> On Sat, 22 Mar 2025 20:35:45 +0000 Joe Damato wrote:
> > Eliminate the #ifdef CONFIG_NET from fs/splice.c and move the
> > splice_to_socket helper to net/socket.c, where the other splice socket
> > helpers live (like sock_splice_read and sock_splice_eof).
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Matter of preference, to some extent, but FWIW:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the ACK.

It looks like Jens thinks maybe the code should stay where it is and
given that it might be more "splice related" than networking, it may
be better after all to leave it where it is.

In which case, my apologies for the noise.

