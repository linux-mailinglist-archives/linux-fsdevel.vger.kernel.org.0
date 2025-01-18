Return-Path: <linux-fsdevel+bounces-39590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD5A15D50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 15:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674E11661B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D918FC67;
	Sat, 18 Jan 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/zVbDdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D740849
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737210747; cv=none; b=owL31cDF3wigvans9aW1WekhbL8+pSB4fDPyTWnBcjBIoBWti3njmU5k1I4+LeckbBZPBSoEiHdPHm7ug4Ya38FnWWf1d+YRGZ8C+iARFPAHPh3MxjBQ7AoFm2+J04GPLvyXMN5hX5X145HvFyx1KW9/80jrHvOB/e83TWAiygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737210747; c=relaxed/simple;
	bh=C8KVAQaMXjEuqRivlDHZFfrBDzsRlU3SVRcBlpwLGmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+u7AqMFRLayGl3sVwqgiYekq08oZCevZkBkg1/F2nPLdf6amTiOxd9ta0wsOZ1wn1yF52sLCLF+giD+knTMx5xUzNrcCGiHixaz3E2luJQYs68yR4JuSA3ncicc/OKkbCEHdKa/F0pGGX4vPdtr07h/njfdR21nR7iyx9QnME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/zVbDdp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737210744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQynHqlXEbirZK19RGEZCQ1MvlBxDpmpsDCS7JVP8hI=;
	b=Y/zVbDdpHvnXH8GCGv1IJRTXyHJCiZ6/vhtpvlv7WFptLn0zyxLpW4ZfJZgEtUPWNOpbL3
	UWUIqpnhrGZOiGEI3i4lwt3B5TGJtIhXWal/A9jBEBkqMUYRMeqC0Low65KplDT/CnG+mx
	jmjjQYDvk3l+N/fOmmWo4psDGnpmr8c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-clsSHVF5M7uk33SgmUR-Dg-1; Sat, 18 Jan 2025 09:32:21 -0500
X-MC-Unique: clsSHVF5M7uk33SgmUR-Dg-1
X-Mimecast-MFC-AGG-ID: clsSHVF5M7uk33SgmUR-Dg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21648c8601cso54380805ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 06:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737210740; x=1737815540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQynHqlXEbirZK19RGEZCQ1MvlBxDpmpsDCS7JVP8hI=;
        b=SNVv9mj//qDxQ7dvIc8oJ9TGtqsgf+rCw45jNgt4e6TDVt82gQ1EweQdNa+sCxSFPi
         H7IgXHPAKzonSDJhFeO3+r15SNdb/i5ArkZ+wa9IKRero4vH+oR0hatNUH2lzh0p5f26
         kXWLfxCvJE6BHGBfV4ivuxTXhFoin0EC/DaOoiNp2iipySfW5kRSo6dFvSDstuwis41+
         xnYGs6gvZNYJi3ELNsobmAAz5uY4ZHN1teq0oAhg8FGfwrLG7831DshVvz3ouLnmDMvE
         5UHfQJtqg/esmWzbHTfbCJAbE2yW1s/vfu6CdBAR6xWQt3u1ee5Rv2c4880SjIVfsnt0
         IcNg==
X-Forwarded-Encrypted: i=1; AJvYcCWWkwBEDjArcksY9q/bvhyKb2aEv7TJ9QtNyzz0IjlxG1xwffdOpnBFtgy5wVyA7xi2eNO1KMf3vGC1DK7t@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCqIElqABTs7JRDAZeOQsxx4hT5e/q2CrK/YcOBiHJ7qqLkZp
	DNEhzB45K1Sxeb41ch/k2YtqsfpKPd/32ZW4Xsi5uny6lN5TPjrEL5xhhIqEroCwYVOQUWISiKK
	Gob21QlI7Qrq4AS8s/Zi+/jgNBZEeSS8G3did4BF6Q3LpWsHJEmhoNJ6DPp/Pk6i4rdWH4lrNFQ
	==
X-Gm-Gg: ASbGncs/28JXWqqMk7zuO6qogWS8pUzwX5OU6ZvqObc8RbRAhbMGts7Ci/f4OarTiSh
	VpvfwZG/77ia4MauqxQM1NLnSefBAuZF0/q5d6uTo4cSWUOhF2JbIlXJpk+tB0PCEeXyAmC98D5
	c1dceWX7hXUVGekmBWMssP/Y8iRhBPcc17+Q/+H3vEwrXf15yAmuSTdbXjqaKEc1MDIfaCdn4Oh
	SJYOaD1rk2V5V5QIqLrQKUdc3pG4bmQR91juw3sKy1Xg0FtzDb1Gvqf3cfdymwyeoVWJxD1ECDb
	vEMjPdemrrT9obsXAKjUCaainba/9NsApXI=
X-Received: by 2002:a05:6a20:c87:b0:1eb:3414:5d20 with SMTP id adf61e73a8af0-1eb34146046mr2873570637.25.1737210739770;
        Sat, 18 Jan 2025 06:32:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE15VqHHb2DN4YrNVN9JdCv+BZW7I/pMv7aUgYfp8J+DXmS+Iu6fLBTlKBHRLukxoPnyrzaQ==
X-Received: by 2002:a05:6a20:c87:b0:1eb:3414:5d20 with SMTP id adf61e73a8af0-1eb34146046mr2873545637.25.1737210739448;
        Sat, 18 Jan 2025 06:32:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bca47e6fbsm3658235a12.14.2025.01.18.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 06:32:18 -0800 (PST)
Date: Sat, 18 Jan 2025 22:32:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fstests: workaround for gcc-15
Message-ID: <20250118143214.gcrqvwfa4jnkawyj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250117043709.2941857-1-zlang@kernel.org>
 <20250117172736.GG1611770@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117172736.GG1611770@frogsfrogsfrogs>

On Fri, Jan 17, 2025 at 09:27:36AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 17, 2025 at 12:37:09PM +0800, Zorro Lang wrote:
> > GCC-15 does a big change, it changes the default language version for
> > C compilation from -std=gnu17 to -std=gnu23. That cause lots of "old
> > style" C codes hit build errors. On the other word, current xfstests
> > can't be used with GCC-15. So -std=gnu17 can help that.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > I send this patch just for talking about this issue. The upcoming gcc-15
> > does lots of changes, a big change is using C23 by default:
> > 
> >   https://gcc.gnu.org/gcc-15/porting_to.html
> > 
> > xfstests has many old style C codes, they hard to be built with gcc-15.
> > So we have to either add -std=$old_version (likes this patch), or port
> > the code to C23.
> > 
> > This patch is just a workaround (and a reminder for someone might hit
> > this issue with gcc-15 too). If you have any good suggestions or experience
> > (for this kind of issue) to share, feel free to reply.
> 
> -std=gnu11 to match the kernel and xfsprogs?

So you prefer using a settled "-std=xxx" to changing codes to match "gnu23"?

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> >  include/builddefs.in | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/builddefs.in b/include/builddefs.in
> > index 5b5864278..ef124bb87 100644
> > --- a/include/builddefs.in
> > +++ b/include/builddefs.in
> > @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
> >  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
> >  HAVE_FICLONE = @have_ficlone@
> >  
> > -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> > +GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu17 -Wall
> >  SANITIZER_CFLAGS += @autovar_init_cflags@
> >  
> >  ifeq ($(PKG_PLATFORM),linux)
> > -- 
> > 2.47.1
> > 
> > 
> 


