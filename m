Return-Path: <linux-fsdevel+bounces-18656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7D8BB01A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4041C2244B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF5154432;
	Fri,  3 May 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kniFtGSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110A1BF31;
	Fri,  3 May 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750692; cv=none; b=ZLWJ2PYkqBNwrL8SEWBFa1fLAlZX1+sKyDYxHbK9dLIIMMBnkfChhKtLqRxucLEdS9cl0eU6dOARXIDiDagWLlUqjVzq5JP7SNclFRGSYBX1LEq4qmqEiWcX60ShGRpt3FgILuDpKA4hg5RqHuDJru08sGdIpsUQ8WtubNPjJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750692; c=relaxed/simple;
	bh=cDQ3u/CXaUY5Of/Cl26YkTLnL8uhLQ6U1jCRpoQi9ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFD5KNWMg8+xmYoYJwOC4p30guB55rYbw9loVbt8xSdlXGuOBL9crlEChRcR1o1Yz3hwduMPLOMVkVBtwb+aMqmSY0idroDYnqQvoepQExJAyGBEi/yG5dkf1orcsS1tg64d9OOn/+NLx08N0R4vQqJRcd3aphDNAWKBwSTFQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kniFtGSZ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa20adda1dso5743301eaf.1;
        Fri, 03 May 2024 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714750690; x=1715355490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/B6VoK43BAi8AR2X/X4aT3bzABV07D0UCLRCGFiZBM=;
        b=kniFtGSZk6N1GDHT88FZb+E/9pn8DtHmUhg2wctci1Ivgx2HT1mNWpQk3R8XLXRCzz
         SAWymFu4TZuhrxkGlFII1fU/1kLwyeveg9vZepY7kCTp7NVHHjT3lGbV8BaHHywJ9pN3
         wawcklBfgC0tywZuuaRTftXE1zJ3E299oKMepYsG+G+pETU8A/fwOABSrGpvUdAbzkUs
         Zy6+vONaxmJ7Volvtq+yGYKQZub+8FkClEP5xftmwsNdmZh+xgli2Gf22EMRFgtwfa8W
         AhGo27Xx1KkOfQ06MJSEZHiDuhlyLzDDBOGAUXDmeDi3SHWIgNcIwgWdDqrVLOQlmtXe
         fgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750690; x=1715355490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/B6VoK43BAi8AR2X/X4aT3bzABV07D0UCLRCGFiZBM=;
        b=oT/v82hdDd06JQ79tUHsGAU3tNDDoVKsKLz+PCrTVkoe/vBPXgHEuoCS9skY2hRUlE
         fkXtJyMyPoELojy3Nhv76eu5YKTNdMRtSQH5RohmI3M27/FU/wxpuAGFHU5qZkf2RTHC
         vJry49I5Rg5s3CeFvdGYtzayUc9g06Ky0nlFfq1i/jjOic4jwUhYryTEJM6BrN6qDQ8p
         Y8gQ0Gi0blKOg3SNdG8/eczdKTbqTwJQUMgFLyrxbwkaZfFs2aOc6K+tzYAyW0M3lQvA
         W7uXrKkU5KKk1q/7kLgW1HNS84ndYE+muv+fmV68jKUM0+g28n8He8lPGbL5Nudby/4o
         8w3g==
X-Forwarded-Encrypted: i=1; AJvYcCVNwlHRTDiaKeLyejWWAint8idU+W1BwPspsAc1U+nlJcyDWWqVW8bW7e3JVkM5Vq5OE9sfYcQHrw+ddRkimtCAcwGFl9eKFvEAngIRPfB7aMrHW8FcUeW4PZ8uQlw3GbG79XJ4sMlcPQ==
X-Gm-Message-State: AOJu0Yy+Kkh3UOnDZRY2UIhks2hkS1wgav8yOAOX8A9g+E4DWgpSVDL2
	5XPxCJOonZcUiBiw+VN7a+oVmkFx8XK2a/U/VSTTbiXcPwMSIJWK
X-Google-Smtp-Source: AGHT+IEFu9BR0ISADGxJbE24i5mw/wIXgLL+GRAWkh90N+Ksp2ghyt7cJKEfDnfpwFO5lNH0gx5osg==
X-Received: by 2002:a4a:ae42:0:b0:5aa:4e19:39aa with SMTP id a2-20020a4aae42000000b005aa4e1939aamr3144492oon.2.1714750689801;
        Fri, 03 May 2024 08:38:09 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id s19-20020a9d7593000000b006ee4db9f637sm660586otk.52.2024.05.03.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:38:09 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 3 May 2024 10:38:07 -0500
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, John Groves <jgroves@micron.com>, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com, Randy Dunlap <rdunlap@infradead.org>, 
	Jerome Glisse <jglisse@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>, 
	Ravi Shankar <venkataravis@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Chandan Babu R <chandanbabu@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steve French <stfrench@microsoft.com>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Stanislav Fomichev <sdf@google.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 07/12] famfs prep: Add fs/super.c:kill_char_super()
Message-ID: <fqothg6pcgsmuctiydtyfmcwbmkr3uxd2h6rpbfchtfu5a3caj@dy5u7xlwqtt3>
References: <cover.1714409084.git.john@groves.net>
 <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
 <20240502181716.GG2118490@ZenIV>
 <eiobix2ovov5gywodc4bqyhhv7mshe7bvbp2ekewrvpdlnz5gh@6ryuna2lfpt7>
 <20240503-vorstadt-zehren-caf579725c2a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-vorstadt-zehren-caf579725c2a@brauner>

On 24/05/03 11:04AM, Christian Brauner wrote:
> On Thu, May 02, 2024 at 05:25:33PM -0500, John Groves wrote:
> > On 24/05/02 07:17PM, Al Viro wrote:
> > > On Mon, Apr 29, 2024 at 12:04:23PM -0500, John Groves wrote:
> > > > Famfs needs a slightly different kill_super variant than already existed.
> > > > Putting it local to famfs would require exporting d_genocide(); this
> > > > seemed a bit cleaner.
> > > 
> > > What's wrong with kill_litter_super()?
> > 
> > I struggled with that, I don't have my head fully around the superblock
> > handling code.
> 
> Fyi, see my other mail where I point out what's wrong and one way to fix it.

No luck with that, but please let me know if I did it wrong.

https://lore.kernel.org/linux-fsdevel/cover.1714409084.git.john@groves.net/T/#m98890d9b46d9c83d2d144c07e6de7ae7f64a595d

Thank you,,
John


