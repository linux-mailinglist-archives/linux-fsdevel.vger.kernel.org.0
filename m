Return-Path: <linux-fsdevel+bounces-18527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FE8BA296
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565B62842B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5D57C85;
	Thu,  2 May 2024 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe6C8x02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8157C86;
	Thu,  2 May 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714686637; cv=none; b=uylV/jhsdRLlv3gqAcHe+wbyPszHjnBj3s6E1cRH8vt5fitrpvqBMd7lQQCsHsY0olAuxW3BvDNRrVV6OOk27vL3nEQ3PzkjTMFIe0u0aE3GPTGMnmNl7tqc7cEIkrxEYYXfT6VBn2OEfpUs4xobTBjQrBrX6OsqCIIhFqnCXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714686637; c=relaxed/simple;
	bh=ppkbUoqzUdCyJMzb+MHcpfiSoVPs9MiIWRRGyMb2feg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV+C2s/+fR7mgErPtWVxMXK/RsoIz+eCEz22/0vdGS1bUqJsvBdwCfC61NNiFkkgavyjGtWAVBBzSoYgJ2F5MnU+kGK2C2imgT4jYD2aLf02+pN27Zcn8DwdB1wICDtLR9LHGOwT/rUpGX8m335rXjRgtwSLrwafusp4Ognk4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe6C8x02; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b1a5bb2353so1572123eaf.3;
        Thu, 02 May 2024 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714686634; x=1715291434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49WcWh+p27/ejxTovkH/mAW5dOxEBm4H0Oa3Am0HCjU=;
        b=Qe6C8x02XkDhfCbH5XClWccy1EDf2Gbw5qXv9OL5TK7DMpYWQVu+wp9b1fNnSroMBs
         cWPXExJdKfujkPyAkVJ5aXM+4Vwwe7r6JFvcgdWoynH3mp1g6ugAXwud5Rrbrs5OU4Dd
         UrU6cV84lbMeqZLatWCk2BF5T+zQSBOf/zMBCd0WaRCgCpI21AE/9y6Ce/EqGTpe/fjz
         jQS4AE57xqlod2eoDkRdcweCUNfVpkn/E1ZkOb8jPkEghjM6hZOBMnV3E5WGwoO0iFOK
         oz144VBKIEf0yUJKv6b4LRyWA9AETjkvZH620noH3OdeGzg74EkI5IF5XGQcc3oFtwJ/
         7ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714686634; x=1715291434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49WcWh+p27/ejxTovkH/mAW5dOxEBm4H0Oa3Am0HCjU=;
        b=IS5uuBBZTPYYZBgA/PGXSrl3Kam6xYJP5dwk6ovNSn8gB1zGNiRtgt0B+wwXDH/AQF
         LC7JmK4ugjpWEj5zQQgdA3Ng4opB4kI69iDG1H2EVQs+jYODsQri/4f41rpAITc2Djcg
         6TYB4eu1ZXwwmcsQQO4njt8FyJoO1CoagjeUj1k8GPWsLg121UBnFY2ZwmDny05sbrOl
         4aoJZIeOvzJpPYbfrBVMm+oli2xdu7XeRpy/7wBNudrNpIvWR/izyK14zRW9EL5rm52d
         48H2ryspgCh3TP07Ieml83jkf+VC8QVhvwK2yyPk+nfG4gklD+AZG2G0TIhp8tgs2DAz
         l3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6Va1w7hX/oX9+r0zzzaFRmtu0jfeoKeNCX7o58KepJtuDh9Ni7XQuPjNlOXzdGbScgcPBWhLzxLJqSYrr18n6UwPAj8betdthZKeh/zihAWfckDxH0otTqYjvfMmpO19Vxfj8QTE2A==
X-Gm-Message-State: AOJu0Yz62qU0DGM5MlWthDBQgnAP/qMFFnhpjM9V3FHK3tteeljBbDDU
	DRh+79UPoywXXJKnSUhw568LV/yqpGsjptr+KVE4VJJyLD3Zw+bX
X-Google-Smtp-Source: AGHT+IF1Ab972Fvtr2pTGuAATvcdTTRtSMOQsbazlcO9vxsi+v5E37xNoBbsZWTP/zprxkgQMcB9tw==
X-Received: by 2002:a4a:aec2:0:b0:5a4:75f2:54d0 with SMTP id v2-20020a4aaec2000000b005a475f254d0mr1188681oon.9.1714686634325;
        Thu, 02 May 2024 14:50:34 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id bx24-20020a4ae918000000b005a4799f5428sm349526oob.21.2024.05.02.14.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:50:33 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 2 May 2024 16:50:28 -0500
From: John Groves <John@groves.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	John Groves <jgroves@micron.com>, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Randy Dunlap <rdunlap@infradead.org>, Jerome Glisse <jglisse@google.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ravi Shankar <venkataravis@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chandan Babu R <chandanbabu@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Steve French <stfrench@microsoft.com>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>, 
	Stanislav Fomichev <sdf@google.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 08/12] famfs: module operations & fs_context
Message-ID: <ks3b664olycgyaee3cepaekhaj4qyi2an7cu647xjt2mfwhafn@qzz6ih64zord>
References: <cover.1714409084.git.john@groves.net>
 <86694a1a663ab0b6e8e35c7b187f5ad179103482.1714409084.git.john@groves.net>
 <20240502182354.GH2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502182354.GH2118490@ZenIV>

On 24/05/02 07:23PM, Al Viro wrote:
> On Mon, Apr 29, 2024 at 12:04:24PM -0500, John Groves wrote:
> > +	case S_IFREG:
> > +		inode->i_op = NULL /* famfs_file_inode_operations */;
> > +		inode->i_fop = NULL /* &famfs_file_operations */;
> 
> Don't.  We should never, ever store NULL in either.  
> 	inode->i_op = &empty_iops;
> 	inode->i_fop = &no_open_fops;
> in inode_init_always() is there precisely to avoid doing that.
> 
> IOW, the right thing would be something along the lines of
> 		/* inode->i_op = famfs_file_inode_operations */;
> if you want a placeholder for a patch later in the series - or
> simply /* methods will be set here in a commit or two */

OK, will do - thanks.

John


