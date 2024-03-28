Return-Path: <linux-fsdevel+bounces-15609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBEC890AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B841F253BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32832139D0C;
	Thu, 28 Mar 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIGlL9zL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FE139CED;
	Thu, 28 Mar 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656811; cv=none; b=lDF+NC5GgZ9icUitYwP8fcoZxoMIxt4kA7OW9XBj4XOtDLYRSweZhShmR7dFC/zcpHunQ5Elq4HpiGP26KUiOJOxk9g6X4wcQKiEiLKEb+kz5nGy+5/ImY4xbSj45k+n+U6NMnay0M5xVu04yzK8gYXJPgRZtbtK1DEawqGLtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656811; c=relaxed/simple;
	bh=sx0xdhi9Aljo0IKpocFtbr8LZOORqSUEX68dDOkcDxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV16FcxhYDN1Mcku5lqdGNW1D3NdhjHTvJ+Xfbf/5ajbTZdrYGXUDXDlYmmACDxdd1fadr0kKgv2S2RjlpF/kIZM74CE73yXjd2exD9geukEhlRsqXMxafmDn630FXIT2CnWEiRXtdkJp8QC8UyQNVd/Al27Qxn+DRlneuKGxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIGlL9zL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0ae065d24so12611625ad.1;
        Thu, 28 Mar 2024 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656809; x=1712261609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJh0w+6LNIpaseEpVPREtMFaluSVUJYpCPOmmi1HWNg=;
        b=XIGlL9zLUemmiVX/Tdgv6MbkZj341sEjQMgIO7bG0DnisevgYAmiRHCZQUfgETcK8f
         wsFlzDqwyje5qYnAKpeKWhRoyqCZ8LdOSvRs4p/lI+D2aHo7BwowoqSLE6rznDfzMlC7
         xOQIDxOoOTcIzuXgUq/RxfKivGo1ayZwVKumwBfzlJ83yI15vkJ2RRJHuYg5uckF7LpH
         okbL/6V56+ZPZQ4I1riBLFjEWla3aqz4lgs1gyEWYK05ylK0Pkcoj00wGtu3e1BZhPkF
         wH8v5Wm7Wl+xj9/1C0NvqYhoXazOuo7h3muhaV7cNKxfjDHLXPYq8Az6+YS55FD5cpbL
         9G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656809; x=1712261609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJh0w+6LNIpaseEpVPREtMFaluSVUJYpCPOmmi1HWNg=;
        b=bh2sfD0SzKEoAWLd5DP3cajFhlIzmdCnOHH9bojZdIBw90VpGMFfj7iUW1daFwAKw+
         31YDp/9j5drc64lAa3b6HjDykYWDRr8Q37fvGMH+zN83kKqhPYz2tv0tE872dS2wSO4s
         dItHZC6Z4cFASb9QWN/ROztZW2oEAYAv+Rx21aomEk6mYZ5QYPVY5K0m36CfK4InZHcV
         WQIIy0UgjOsAiQZds+tZ+4TGXL6ZqfbcDAYBjPpIYFw8AS1Et/YTQ3zvz0FhtZHEgI0T
         mAmg2XBAGGc3mbXja8zUOrbfLPYdX3s7Uc2Or4sZb8yrTpyD9t+zFDq4Hfi6cSfC/5Po
         j3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVDHIApuffnJqaEuXGtFStFZRT4wWtGawRUce4H2DN7gpqYaz2Ca5xrEJNFMF0QWaWqfJsHYt8Z1h8UBVxuIhdDw+ZVbVU1CEP16VW8WUZ/WELNVDIfLViQerSYqM6MBu1d/ZLk0kXP3Zreag==
X-Gm-Message-State: AOJu0YzSrFxzblaP5avFB4ZRL49nYcVRN2GHKLg+qCXxGdYp8MtIVfBl
	GX57zw+hyca4i541/FPXooBG5h+FeLnI1Kz1bX7RTtXS5nKKTc8f
X-Google-Smtp-Source: AGHT+IF2RZEilfGlheBdjw01iR0oba703+q/sHwMzEEvWDchg6pVds9Ll4DvJwEw0oTnZsBiTFQzQg==
X-Received: by 2002:a17:902:8341:b0:1de:fd12:1929 with SMTP id z1-20020a170902834100b001defd121929mr485333pln.55.1711656809385;
        Thu, 28 Mar 2024 13:13:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001e208707048sm2041353plb.117.2024.03.28.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:13:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 10:13:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <ZgXPZ1uJSUCF79Ef@slm.duckdns.org>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
 <ZgXJH9XQNqda7fpz@slm.duckdns.org>
 <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgec7wbhdn7ilvwddcalkbgxzjutp6h7dgfrijzffb64pwpksz@e6tqcybzfu2f>

Hello,

On Thu, Mar 28, 2024 at 03:55:32PM -0400, Kent Overstreet wrote:
> > On Thu, Mar 28, 2024 at 03:40:02PM -0400, Kent Overstreet wrote:
> > > Collecting latency numbers at various key places is _enormously_ useful.
> > > The hard part is deciding where it's useful to collect; that requires
> > > intimate knowledge of the code. Once you're defining those collection
> > > poitns statically, doing it with BPF is just another useless layer of
> > > indirection.
> > 
> > Given how much flexibility helps with debugging, claiming it useless is a
> > stretch.
> 
> Well, what would it add?

It depends on the case but here's an example. If I'm seeing occasional tail
latency spikes, I'd want to know whether there's any correation with
specific types or sizes of IOs and if so who's issuing them and why. With
BPF, you can detect those conditions to tag and capture where exactly those
IOs are coming from and aggregate the result however you like across
thousands of machines in production without anyone noticing. That's useful,
no?

Also, actual percentile disribution is almost always a lot more insightful
than more coarsely aggregated numbers. We can't add all that to fixed infra.
In most cases not because runtime overhead would be too hight but because
the added interface and code complexity and maintenance overhead isn't
justifiable given how niche, adhoc and varied these use cases get.

> > > The time stats stuff I wrote is _really_ cheap, and you really want this
> > > stuff always on so that you've actually got the data you need when
> > > you're bughunting.
> > 
> > For some stats and some use cases, always being available is useful and
> > building fixed infra for them makes sense. For other stats and other use
> > cases, flexibility is pretty useful too (e.g. what if you want percentile
> > distribution which is filtered by some criteria?). They aren't mutually
> > exclusive and I'm not sure bdi wb instrumentation is on top of enough
> > people's minds.
> > 
> > As for overhead, BPF instrumentation can be _really_ cheap too. We often run
> > these programs per packet.
> 
> The main things I want are just
>  - elapsed time since last writeback IO completed, so we can see at a
>    glance if it's stalled
>  - time stats on writeback io initiation to completion
> 
> The main value of this one will be tracking down tail latency issues and
> finding out where in the stack they originate.

Yeah, I mean, if always keeping those numbers around is useful for wide
enough number of users and cases, sure, go ahead and add fixed infra. I'm
not quite sure bdi wb stats fall in that bucket given how little attention
it usually gets.

Thanks.

-- 
tejun

