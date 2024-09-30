Return-Path: <linux-fsdevel+bounces-30405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8698AC76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69E01C212CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43C199E8D;
	Mon, 30 Sep 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="AD2ZcWHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039B19992C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722823; cv=none; b=ap1sHgZK+4n/rOJta7r+Rj+lTIk3ym+NgqN05WLYoQvU4ovHkGGwrZ5+hXrz4b7vVrwn4Fcr25PAdE8r7obVKl7S8cQ3nFowta6CnXS37XQ84kIGfg00X4PMsUddv0PN0oyb4HU+DucsvWO+rvB7IUW+k7juL9TXUlObg7Ew6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722823; c=relaxed/simple;
	bh=UTeuYgMehmLJA/arPzgIQes3j/4SwwxcY8cev10CXXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+45T/17UUwnDD9n+z6BYwnlhMoF4bmy7W6M+snDu3REzDmakxUSpEX6zVmy4H2q2H2hTVgLX/LzkCBokHF1xdj/aZzj8A+Ux+s+Z6AIH9W7WTrILVGUXMdZEtfJqqneLMXd+vM2FvZv38hCrWra++vQpMwNjmLSI8ZKWqEwDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=AD2ZcWHJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e0421143so672960b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722818; x=1728327618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=AD2ZcWHJT/Eh8QCoGwtR2mU/72Hn5PXbAqIORnZDyFQ12uCk5B6tgPR0gvJL4FDpmJ
         ulZzhaj/oQ9sKYNODSjhgVv94UWmTt9EA+rp3AZxM3D7FuMreK9zLBVPVKWu3uh3+yR+
         vy+EFC32Ma8cvowRGq+XAGeEadeMV+x3qYlOPzmGn6BqAD76WPYrQPop8bkeDhZ4ERpK
         1UNXgJ0vFc4lVx8afjUXBo0LvvB6Rd4zof4t3Zc6Vy61FsDUmw+QDwS60x7YioxFUGH3
         CoTsxWXSnHhGL7i7+cVMdkBzfJQ1pVAYBQUJy/0cBhT0hau1JKlewvZ94VVeJ6zOGv4q
         0Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722818; x=1728327618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=W8DZK1Ve1eDCGQ0BFVhMDOHLpYlDYM4zUeIFIhruXg50FyVZURe+aFcq+38Rp1A92l
         opLoxbn94iUPT0bSvb8HmtfxgjBAUv1ihD+etb/m63xZXbgxgFvGAb4NpUfICIwj59uI
         8SuLi7LPbnMKnDOUNpqJBPak0ws6A66cM+JhuBbwYfoWEiCZrZMxW8BUKrzcWjpbsQ85
         TobLbeFKl+cxsGmx76ptS7LnPkMQ05ROoio2eQhYNkzZcEmcQEavnd437qdoZAtbFgwr
         GQHxtLzo17/Pk3iOzW+1anKFgXgKbzWmT23cqU0gKfi4NklR+zn60i+FwXLh2S0oRdA+
         RHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Luv7lTZY5ENAcf9AUjKssOwD1vfGFpc37Kw6yqK18BBY8y6N+6EJKrOiNmHk1typsMQ+zRWAtvI55x22@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMUMHdLA2wQvSzT4/QigiKotZ48eGiOhajFNC3Mh5xU4G29Yy
	10KU5Ia87DdNOb/+c+XTmyekd4O3yLkuL989mopONkExzHMiKBs9RXK5qVyy88c=
X-Google-Smtp-Source: AGHT+IHr3t4octArrJkwK4KlggdiRYNEixY4E7CvOHzMJxxuBtEfGjyLTrjjT9DROP00qxEU234jog==
X-Received: by 2002:a05:6a00:2392:b0:718:e49f:246e with SMTP id d2e1a72fcca58-71b260a8a3fmr8397735b3a.6.1727722818090;
        Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652a622sm6544654b3a.164.2024.09.30.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:00:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:00:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Howells <dhowells@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
	hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
	smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <Zvr1PVRpC33aaUdt@telecaster.dhcp.thefacebook.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
 <2968940.1727700270@warthog.procyon.org.uk>
 <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2969660.1727700717@warthog.procyon.org.uk>
 <3007428.1727721302@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007428.1727721302@warthog.procyon.org.uk>

On Mon, Sep 30, 2024 at 07:35:02PM +0100, David Howells wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> > Are there any hacks possible to printout tracelog before complete boot
> > somehow?
> 
> You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
> dmesg.
> 
> David

I hit this in drgn's VM test setup, too, and just sent a patch that
fixed it for me and Manu:
https://lore.kernel.org/linux-fsdevel/cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com/

Thanks,
Omar

