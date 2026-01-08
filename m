Return-Path: <linux-fsdevel+bounces-72961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A635D0689B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1AFD300F242
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AE33D4F5;
	Thu,  8 Jan 2026 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jzSeMPKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242133D4E5
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914744; cv=none; b=Ewo5uoMwcs3HcdBKWY2bQmTzxF2qjAAVGJsxPIKsGUHEYZAhkLbRzJ89JtpXPAZpeNRyhYDQggdrON8OGGOXmVFrlRRLKS4pmay/6RBmoQIIXGl+xSd7lTKfFtk3uMVmkAu9C5YCEw45LsUZDjU/jFwXH7wkyg9FTpi16v5EDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914744; c=relaxed/simple;
	bh=obLYyhrFsoB9oBqm7xL6fDhdB8wxBGKxiOySCPXnFrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYsmhSvcmsN4kT4GJsBEz3SurvAZxZoyoqbut0G3F3HVDqUJw7WowzRjCv0oWrUNYt1wt9I5SgH3D5DXXu6DUgZS1nhjt663asWUE23E/pSZyZfPgOGBMgCvVsJiW4TEkMpI+ZVxaR0TP5q1ssKTV/pRJFl5Gxf1jVBgGj9mEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jzSeMPKY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88fdac49a85so38903486d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767914741; x=1768519541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=055cXnB91pz5e1+jow3wyxxEvRh6YPpDHe6f2UW3p44=;
        b=jzSeMPKY3rCpFqvzX79jd1jMCr1j1i5WwNHfa7dCqNQLbt+yEWIOJLKUznHAsbWMLu
         21oyoEs4p12FZMXFkKAI8Fsec+X2NQfiNdN7Cuvjj6cDwjrZnog5g80W0CJ/YZ0Oj5Bf
         f7b+RtP/phsREFUXsrfbNnA6NB1VhnWHZFaFRoAiiRTBcyijNPFuXpjaRdLSJXL0YV/2
         fjetK3dfjmvm79EpW9DYI64r3DbEE5BhN07L6SvsFwkinLLBv33SXz9D7Q3IaYBQtCrW
         acgw9oqkis7F8T9K7uJGbe3Lv8ZW+Ek3QbulZu0VUP/pikT067JStRKEskChNs42/vvZ
         F+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914741; x=1768519541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=055cXnB91pz5e1+jow3wyxxEvRh6YPpDHe6f2UW3p44=;
        b=ISPegrkL/1Bpb78Xt+bQ9nXC6YfGWz6Uan5Yn6Ac4O1J6XSNTZjqIweiyMiQaaY/7T
         MHBPl6g+sVP1VppnXjofaxrcJU2KFl+IGcyNaEs1wVsabXKUtXFU+99K+a6IEF1v1rY3
         RfNZFd2t5V3TEdDsyBo2idXaQqHcBcwQBX8sgCzLg3QbNbkmJi0vk1GrBjTVsHEwhWGA
         G62av7vMVkaOcP+2/EjB2iWAUKuvfV5pIiGLZgtD1U3mdYWMGQAX9N7CHmpplP95ySJb
         UsERpMnCbw49NiED9jLvE+89cQ7hnzCcKesuzfFz89nfG3JFzl8q/+i3rW6hLx5hJkht
         xrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj/BSi2x4FHiPtbKHUz3+Cfs86Gnf1KQeYqdltnjwPDXZHBhtF/cmLXUubtm/rMMEwmOTddbh07kg76eIE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+X23dFprScfTxtdAegoIfy4cgCPVLFUXzdF++VX63WByRuEd
	UJtjci1gcpdUeNUs9MgExjET7VebnA/9lUCks/kPtN6TvwNT1/zRNK00ztu+JLjKe28=
X-Gm-Gg: AY/fxX5Y26BkXpLeTqis+1gWW5cBodtrANFpwbUZt8JAOZ1vPaMBtWd68WJhAd5VisU
	AAS1LjSwGi6Pe9kSW5o5f1bG6NSqhexPMiwlSd1i4amg70BBSrzXoX3h9guONwS+4fAKXMZ/Jbg
	+Rvl0NfOZiuLRoEtQzrJBKBct1P0V7vL5gdqs/8dYiV/WHtTxoBiQR11eVdga8U2/dNm/YyDUiw
	b2EWmYCjTHHrhpvPqlsxzB6VZwZul9ZZCe6NZmlblBw4AWqlUkqEAx8UmmOj5DsjyuL8/35xcU7
	keu1aO7TJPFm8wRSLJuFndG4OyqJ+KKEjPlPzhwSJqcEBSJCyR3qB196jD7pJbeJLKIOBqT3tFZ
	Z1CVi/T7CE+bNS6rslFp4BjemKrq+PUrp9WKZ4B5uWR4/8V/XqvGo87ROtQzRZ/v0Kaxsj41y3U
	B/mC7Y/Sc1WoWig1CA4eqq0+2j6mEqOLM1ZV5A0JyNwh3ufYefk01uMjGE/RHut526a131zg==
X-Google-Smtp-Source: AGHT+IH58K2fkRuNeCFONQo5PN3X5lTd6kkVRVrUL8HrgTghUwX32Msen1mn/KH+JIVLSLRjRmPpIQ==
X-Received: by 2002:a05:6214:d0f:b0:88a:342f:32a with SMTP id 6a1803df08f44-89084185ec7mr128066396d6.14.1767914741275;
        Thu, 08 Jan 2026 15:25:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346e2sm66493856d6.33.2026.01.08.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:25:40 -0800 (PST)
Date: Thu, 8 Jan 2026 18:25:05 -0500
From: Gregory Price <gourry@gourry.net>
To: John Groves <John@groves.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 02/21] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <aWA80edCywOLw0li@gourry-fedora-PF4VCD3F>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-3-john@groves.net>
 <20260108113134.000040fd@huawei.com>
 <6ibgx5e2lnzjqln2yrdtdt3vordyoaktn4nhwe3ojxradhattg@eo2pdrlcdrt2>
 <5hswaqyoz474uybw33arwtkojxrtyxrvlk57bdwnu2lnpao4aa@4vxygh226knw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5hswaqyoz474uybw33arwtkojxrtyxrvlk57bdwnu2lnpao4aa@4vxygh226knw>

On Thu, Jan 08, 2026 at 03:15:10PM -0600, John Groves wrote:
> On 26/01/08 09:12AM, John Groves wrote:
> > On 26/01/08 11:31AM, Jonathan Cameron wrote:
> > > On Wed,  7 Jan 2026 09:33:11 -0600
> > > John Groves <John@Groves.net> wrote:
> 
> [ ... ]
> 
> > > > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > > > index d656e4c0eb84..491325d914a8 100644
> > > > --- a/drivers/dax/Kconfig
> > > > +++ b/drivers/dax/Kconfig
> > > > @@ -78,4 +78,21 @@ config DEV_DAX_KMEM
> > > >  
> > > >  	  Say N if unsure.
> > > >  
> > > > +config DEV_DAX_FS
> > > > +	tristate "FSDEV DAX: fs-dax compatible device driver"
> > > > +	depends on DEV_DAX
> > > > +	default DEV_DAX
> > > 
> > > What's the logic for the default? Generally I'd not expect a
> > > default for something new like this (so default of default == no)
> > 
> > My thinking is that this is harmless unless you use it, but if you
> > need it you need it. So defaulting to include the module seems
> > viable.
> > 
> > [ ... ]
> 
> On further deliberation, I think I'd like to get rid of 
> CONFIG_DEV_DAX_FS, and just include the fsdev_dax driver if DEV_DAX
> and FS_DAX are configured. Then CONFIG_FUSE_FAMFS_DAX (controlling the
> famfs code in fuse) can just depend on DEV_DAX, FS_DAX and FUSE_FS. 
> 
> That's where I'm leaning for the next rev of the series...
> 
> John
>

Please do that for CXL_DAX or whatever because it's really annoying to
have CXL and DAX configured but not have your dax device show up because
CXL_DAX wasn't configured.

:P

~Gregory

