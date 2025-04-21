Return-Path: <linux-fsdevel+bounces-46852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D394FA957A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509923AD9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DD202984;
	Mon, 21 Apr 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNF/ul5a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F51F03EF;
	Mon, 21 Apr 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269226; cv=none; b=VjW4EUR3WpvK3xEnrtaIcepD618R1ZSktfLQOTHmDFnMKCYlgrRWYEpr4jwy4XRTRcDwnWYb3IDwkybPulhj6jNrAgDaqUzcXzlXHaBZcIFHL1mjqX3IAijNGHkyC2cMum2aqmSqTEqfiewr7BaDdF17BJ16YaZOFjmnmOvRFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269226; c=relaxed/simple;
	bh=lGsrYSNcKG8qfiaikDbbRwogHHQDp6DKS6+nvftTpcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhh7c6x+FvuK7PJJ0f4FO7LAAZteTjCSxEwnJkBjXre7H/mnBDN20fwFxlYoLHkQ5kzZxOgowCrvtkc1fOl6dksR5z+N4FJVuQwtbSoJK6plpskP8Y9Dw6EQjn2hmD7DRwF2bdFhLp1XXkVUPcX4bOhfMU8twDEMzqq7FoYN28g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNF/ul5a; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60402c94319so2197690eaf.1;
        Mon, 21 Apr 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745269224; x=1745874024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POBPLlOljVBDgxUS6PxzvxfjfLb9G+KKgkGlb9c3n64=;
        b=KNF/ul5ay5nFFlP3uPYnkWkBxLD+q2ue0+v1Goi5mvYOVQr1esADDRnVuRQl0QcUdI
         s6/QEvml3NGusqkX6o8ITVBygPvBlyPROPZjQOAgz1h5ka6wS34UhZXhckv5wWUemjLx
         9/LrUlLExzlxn06XNsfE2Hv9ADxdTeuzh1m9UctP97fska/PUqVmV/iH/HrnqrnVk2/L
         vay7UN6u+L+1P0zrzVI0ook080KgkSuQNoWyOCWxuz6nNsdrpYPY77EbOgFoPCtB2xkL
         pQGQjfS5Mmudrnku7o0Dxuga6DMy6OIP/FOg8Z4IbOK+ZZkC1ztdtBwyz86L+3e7MMPC
         WgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269224; x=1745874024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POBPLlOljVBDgxUS6PxzvxfjfLb9G+KKgkGlb9c3n64=;
        b=lYe1PnUaPXKVmHncoA8Vxadr0TYdbId3YGOqmDGMQAVptkngBkJcIQ3VC/wm2OFzMM
         DEW5UNnT9ApJmygt5ULzapKInAZptKtKiA9upuHjvuqvNcuHvAJfkLaZXiKW2hQYjdkY
         44n7erWA8rxgo1s3cGnzGIrmFp9Psria/1uwJ60trp07F75PqXPFF0TqMYrVfbrSD3C2
         nzvUpd32Ssh3tbNwRhq9UtsOmJMN+eQZjt/FM9Igk32nrf67rzD6o3UbxtiybEYl19CH
         U8iNfUin088b921H4SZA5wysRuzZDSl1JFXf1ZXKakRSDQHesT8TRKAwLWrrroVe3+VA
         cu2g==
X-Forwarded-Encrypted: i=1; AJvYcCUKV9WBQGDEOIerqzxMrHzslx8/UOjAOTaiAjgElkPZlg7quAlNeOCtkVQOiQf7AqirQE5wgVwYxdgOvSXCQw==@vger.kernel.org, AJvYcCUw4fx54k3HF7hKGgXn6SdM95TNxoNJ9+JybJUs3ekyUxAozrxMwkkDgedpGShU6hYlXSoxGNV1fZAIAY8N@vger.kernel.org, AJvYcCVRex6v6LJ+uHomeg6IsbDlIQfsSSmkwvEp6E0SOhaO3/JSVosW/ES2s77oHUxU5btgzA8A3thvN5Q=@vger.kernel.org, AJvYcCVsvZ+eJeHzOFwMeZnokDtq81LyvUg9+cfSdvR/QZ2C08/Vz1d4rUXLC9kjvkV9lF9n9m71Cn8fUeoY@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGQZIUe/KzbsOnPMT8xHcof/xXpTgbJlNODbgtQp6HqkX9XHK
	JMKxlC3TizaULZI1QIDBdGcwvx5B2WxftRwk1fEn2VkUXPVcfj3L
X-Gm-Gg: ASbGnctEXtwQXRAyUZaQJ6sMektpIifSDYCQIOxzsW+EcAclbsIS760Aqz461uUZUoZ
	Dj6FzCYlQBv2CMx77VKCmtaJS+9JbAy5koPSUJFL6sLrSwN6B7m+McEkHKCAz0n5ONTGQfv1gDX
	EQGiW4lJxru+y49uyPe6HCFW+0ZoDrbp1o3cr/xboPHTKuJ6zfOsLMDqiMKPpd6YAXrOzQpopzh
	iDi6XOgzkagYc11N+32B22gDB5KcwFgRq6m8Tg6+vRU40iixwhoPyDWiVa5J8nTt4ZjYW5bJVzP
	Xzg5yHWd8A9YzTnxCD2i9okofrHLyQFZR2PScv85lnacxhyGB4Zf1nxiumSS
X-Google-Smtp-Source: AGHT+IFhWik0dvo5nbC73OtnpAgOzCCxlIuY5TcJavE3QjUL4HXTbUVWDwb/kdN4looh8mC60vBqqQ==
X-Received: by 2002:a05:6871:c70a:b0:2cc:3586:294f with SMTP id 586e51a60fabf-2d526a28b26mr7572447fac.9.1745269223691;
        Mon, 21 Apr 2025 14:00:23 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:c191:629b:fde5:2f06])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d52135b8b4sm2121868fac.17.2025.04.21.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 14:00:23 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 21 Apr 2025 16:00:21 -0500
From: John Groves <John@groves.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 17/19] famfs_fuse: Add famfs metadata documentation
Message-ID: <f27nf7ac2lopba4tnakkxx2zvnlmntfvk2olrxyz7yv4ywrufb@cwobadow6gxs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-18-john@groves.net>
 <f0b218f4-7379-4fa5-93e4-a1c9dd4c411c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b218f4-7379-4fa5-93e4-a1c9dd4c411c@infradead.org>

On 25/04/20 08:51PM, Randy Dunlap wrote:
> 
> 

good edits... 

Caching them into a branch for the next versions

Thank you!

John


