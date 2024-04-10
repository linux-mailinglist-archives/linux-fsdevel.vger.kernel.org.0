Return-Path: <linux-fsdevel+bounces-16620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844AF8A01E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50591C21FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEB1836DE;
	Wed, 10 Apr 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPvSd4AW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BD28FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784264; cv=none; b=nwuRV0wCyCLqW1i6/gs/5r2+z2Rpv2IBr2N2xCRlKiXOpde7sq/mWiOn2PjjK9nizgRqZkxfNgFUPmFXyivC2FeJBVA20QeFQkE6DhfDiV3UKMwRnzsgdpRemCBdx9G/5RxJ/KroaTuarg9rhKQqGpIizMrpKBxBRn+3EDRk89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784264; c=relaxed/simple;
	bh=oNj+qHG/aPlOVSAddYMjvDcCQqd46yM2ZrvuykmW7Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKryjF9c4pVmtVLBwpbVaYlG0H/fEIttFyA2bbXa3ANvYIz5SaRit7/c7TvxJiRWHSgF+ZReSZL0JrTNX5YhcHImWzbtsjoXSM2/Eqnj7x4yhOGHZmPfWTL6fWhjOAyYFV8SyJ402x4xprnaNq0ecZ9rwQo94z2JQoVQ+Z9uDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPvSd4AW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea1c0afd8eso1447223a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712784261; x=1713389061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ln5qFPwIEIGBvELFnfa1z1zWEXwC8Jvw5DRkbxzLM4k=;
        b=CPvSd4AWvvxGw8xdQpMJbhRKwo6Ip0cCBIGNS2GACak5JiZSsNy49lbOdk5j9DJQW/
         rez3545q97E3z6lV5ms8LGVMDRt9OOyIhUaLe/2ZwzrvY83BF/mwn0GkkoXaMZyrpDHn
         rBAgM6KQexMLdtChx6cA3cou3AusGQ5JEL0fJoiGpsxXIkfaqFgz94n2Z3F+MhGzr/sO
         AkHhBSHLWYB+s9VjEZ6zdxe88Y523kVcEtG0wX666tCyTwNRqiuWguq7Oce+VZ6keybK
         iUfIUGAtgJdkR+setBt9TlDnj0yrX9mz3LA0QupnYGf6QGKvSelKHFGVwlMqg3yRdYpK
         MHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784261; x=1713389061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln5qFPwIEIGBvELFnfa1z1zWEXwC8Jvw5DRkbxzLM4k=;
        b=pc1jQ1svqqNhNam1/fEn8bdxk3983oElja983IqBxY1u7+8xs21VgvAhNbq5rnul8e
         dzqhhcOpbofayC9wFhoGxmB6aKH7H2NknPgm/2liI6ePKrGAav9zCrv+E/RKnnbz46sS
         NuLBMNuzE20o1Oc7HZfJjsjO332C1zhQOAaqfwBy+HUR2dX7+mkwpablt+Gck4hfeMMF
         KCvIMb68DU2V9WrJeJShuQ+iSJg/tOFgW6+hbrVXg6x+/4hcn4VolZA497t3P1Uz9zUR
         avgkLH/O2SDKmq0lZeprafg6ZOzqti23SaZ1PULsJ1WdH4so7YRdCLMpAdUM3/0SfqAA
         fh2A==
X-Forwarded-Encrypted: i=1; AJvYcCUqlbAafsU/DeEiVZK6iqvreIUDTutb/ErcV56m+I0bpDKnsAeBpr9NZykih7xsqwZQxQ+GTjPwo00keI9IcvCy2lxez1k4+qJ3/6N2lw==
X-Gm-Message-State: AOJu0Yzg6BFm9gl0KNE4M1icoth+Baxx/WNabQ3eW0PrJyfke2/8fiTk
	twLm46onDpAIasP5rvV5yQj1ALsZAXa0y89NkzmNR3GlSeXnPkKh
X-Google-Smtp-Source: AGHT+IGxMh0wiu4r+vKKB/TS13O0I7CmFU93VHBOfA/TJh/bU4WC/nIvyHWGcWnkz8uwksWy6km5Kg==
X-Received: by 2002:a05:6871:7818:b0:22e:e568:7c08 with SMTP id oy24-20020a056871781800b0022ee5687c08mr3948229oac.59.1712784261538;
        Wed, 10 Apr 2024 14:24:21 -0700 (PDT)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id qa12-20020a056871e70c00b002331322bbb6sm45732oac.29.2024.04.10.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:24:20 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 10 Apr 2024 16:24:19 -0500
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, John Groves <jgroves@micron.com>, john@jagalactic.com
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <efsh2dsmeivdoyecrsj6qdflafyx2cigf6ibjgurw4u4hvslsa@2gu7dvpothiv>
References: <cover.1712704849.git.john@groves.net>
 <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
 <20240410-mitnahm-loyal-151d4312b017@brauner>
 <6i3kr6pyyvbrcnp6pwbltn4xam6eirydficleubd4bhdlsx3uu@kh6t7zai4pai>
 <20240410-umzog-neugierig-56fbce5987e4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-umzog-neugierig-56fbce5987e4@brauner>

On 24/04/10 05:23PM, Christian Brauner wrote:
> > I don't think &dev makes sense here - it was passed by value so its
> > address won't make sense outside the current context, right?. It seems
> 
> I don't follow, we only need that address to be valid until sget_dev()
> returns as sget_key isn't used anymore. And we store the value, not the
> address. Other than that it's a bit ugly it's fine afaict. Related
> issues would exist with fuse or gfs2 where the lifetime of the key ends
> right after the respective sget call returns. We could smooth this out
> here by storing the value in the pointer via
> #define devt_to_sget_key(dev) ((void *)((uintptr_t)(dev)))
> #define sget_key_to_devt(key) ((dev_t)((uintptr_t)(key)))

That's the gist of what my patch was trying to do, but it was messy 
because void * is 8 bytes and dev_t is 4 bytes, so casting got a bit 
messy (not even including my fubar-ness)..

Not that my vote is important, but I would heartily vote for storing the
dev_t in the sget_key rather than having the key be a void * to a 
soon-to-be-reused stack. Future developers would have an easier 
time with that, if I'm any indication.

> but I'm not sure it's necessary. Unless I'm really missing something.

I must admit it hadn't even occurred to me that a void * to a dev_t
would be stored long-term in fs_context even though it is only short-
term valid. But you're right, that works provided the validity lifespan 
isn't violated - which it isn't here.

I was around in the K&R C time frame, and... well, never mind...

Thanks for your patience with me on this. I guess my sget_dev() was 
failing to find my old superblocks for a different reason - like I 
thought they still existed but was mistaken. You may see a Q or two 
from me on the old famfs thread soon, prior to v2 of that...

Thank you,
John


