Return-Path: <linux-fsdevel+bounces-53881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33AAF861D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 05:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88036E20D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 03:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F61E9B2F;
	Fri,  4 Jul 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOfG5h+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751A3FD4;
	Fri,  4 Jul 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751601211; cv=none; b=oREfn3xbk3KVJni4fxBJbJiTkzXMnXArzNJfHyEOr50ZRQ/I8DWuJDViw4GlRNLMYF6MfDEpr+6jNCrXmqo8WBWRPI1p0jJ4HQtFMQCK2ZjRKitlnlcwgfUmWHoLS1X/wGlXrBJT3UQnmRGYKU0cSPV9SRDzi0Q+UpA5RwX/b+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751601211; c=relaxed/simple;
	bh=zwRLPwT2eQg168Wfug2SYslZnKArpTcPqpw6Tg/LhSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmtI8RFKY9eOUVr9zTy5UmpkLImj192Yyby2bIKxlB2/AwY6TPtIEMVq/3M8M8pD03ryqfCYzdAktJVRvSAKmGjDRs/8/8L1JR4jz06WDCxzvhP8W3lTpwpMzgh6yvHBPjBH/5G4YQRJ7vgQCxWoUHiNUXm4HRzbwsePoVik410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOfG5h+b; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso644615a91.3;
        Thu, 03 Jul 2025 20:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751601210; x=1752206010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V98NwQHZpZ1xGgxUD4OMgi+d8tY5VWQjICNCxbkdWoI=;
        b=iOfG5h+bSX6OrSMJMoTzhV6idn02WCZQFpJtui13jmF+3FH+q45o6Mb+RYprv3Rt4k
         GhKYd8M6XeDGMSMxteo93Qhv8lDaI0tJ3fkyqwwKFeVI7BdkLcvoFRKm8kul3VbBMTF6
         Vtzz/vdaipnUdwVNakkSa0QtJE8a3Cc6mZu1ANDy3ymulJrn5b3ASolGcQoXbJFXMsFr
         zz33+/5oxgr53Sbsuantv9DHBQ8easWAavB7isC/RVGslu4gBC/amXr9F+SGf8U9p0O/
         wcfAErfvsiKFQmzedG/1SjNAMeoMZyPUptbleiqGUI9eQBVsGYd2Xt2kjzWTl9cSCzo3
         L2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751601210; x=1752206010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V98NwQHZpZ1xGgxUD4OMgi+d8tY5VWQjICNCxbkdWoI=;
        b=sconyij02+O9pHhLicNnp08cHX+ccnt1a63aPzfFa7DUoXFEhwfXaf+o/+LSuGKLYs
         Pecqm7nCK67GKheOzx3QcyKwADjNiGeDnwIx94Kvqu6/vlVtS6yL9RwXk58uT4qZWlas
         ZMyUZo+5la2fGZrM3jqQLui5VXsOf5/k5MaDMQAbhaHF0LLvRAe3VCCSwXPxuA/yjZDH
         +2Rm0tzM2Sb1Pd6XpprcSaWKiq8MmxQ2Q8TUxeip2/QEuvxofhFttK1mviQoiO8QpXCv
         xfG7PKowkm4BefzvJDJR/osXJrgKH62mXvMbvu78pThXU/tXJ/0ISjdV01uL3dWCbhvY
         NjhA==
X-Forwarded-Encrypted: i=1; AJvYcCVvaN8yA1IEQxXKxI9W3FIafd37fdUdzs0I0QPmkLpXTQV5FUnwMgqm1rO+5oAF6nYO6rZIBoEwnEQK@vger.kernel.org, AJvYcCXOgRndqkTYiFzPXbkGW2cULdecDWvFPMKMULL+tEGuO8pJRarobU1nHWJDB+bnOtIot7TPKH99hBXE256U@vger.kernel.org, AJvYcCXlCjFY82//bDCEdbqyyPKWGH4jIMZ1PbhSlL7A/Tsz4lp7xxxZA6YMByDOxepE/KiLobwCvb7sSyc=@vger.kernel.org, AJvYcCXvWwgnxIMvIOJVPTV1BwU48VjG3va/x7M7uch/B2G/MRxRNTS4l4Y0a+ZKy94jw+IMCHmrb86M9Lx3j1QXyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwj3wGTCef+e9A2au1RxLHeRX+9MFPox7pQ4P9WGKuNNIFHmv4
	3YwxlY9xE0h9YcL/i0lsCZsFtmV8fJTA41BsR9GX0aIeQ6nBYXLxVcBB
X-Gm-Gg: ASbGnct5Z8urcNNsATWO/CYEygMAeOsg/jyvSqjOzviUkKp51mK2E7a2jZ9F5FUR0Bk
	UuNJF2x05D46t6ex5lZYP21cV1zl8RZdsEc4SomSbU8/TaaD8HldryCftAAdvKpFjS0PxrfCeNE
	t8CwKspratOx3+Ed58U1lqwulQJhQLTxvGQZ+BrKG/XgDa4A+IhV9jCj46fGipk2ogqzmimW2Mv
	PXQzRaKA3gRRJ9kC+FhpvWHLSZDRe9wA5SQRhN+uB4SUO2pPveUMnYrf879g97rCQEY0O+iEcwr
	3MnFVxsvofpwPIfRrgig602xiTwb4SH12OuXWLCBZMWnxsSxcRTG/uHvrm4wjw==
X-Google-Smtp-Source: AGHT+IHogvr66NhGLX5buUAq1Mw27chMolznrtFETznmKR2+R2UdttsZVVX9IjUimzMH84E5+HrBtA==
X-Received: by 2002:a17:90b:3e8e:b0:311:eb85:96ea with SMTP id 98e67ed59e1d1-31aadd231c8mr890732a91.9.1751601209705;
        Thu, 03 Jul 2025 20:53:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf2cd54sm831381a91.23.2025.07.03.20.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 20:53:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1E7564206885; Fri, 04 Jul 2025 10:53:24 +0700 (WIB)
Date: Fri, 4 Jul 2025 10:53:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, John Groves <John@groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGdQM-lcBo6T5Hog@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <aGcf4AhEZTJXbEg3@archie.me>
 <87ecuwk83h.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecuwk83h.fsf@trenco.lwn.net>

On Thu, Jul 03, 2025 at 08:22:58PM -0600, Jonathan Corbet wrote:
> Bagas.  Stop.
> 
> John has written documentation, that is great.  Do not add needless
> friction to this process.  Seriously.
> 
> Why do I have to keep telling you this?

Cause I'm more of perfectionist (detail-oriented)...

-- 
An old man doll... just what I always wanted! - Clara

