Return-Path: <linux-fsdevel+bounces-72690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD76D00349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 22:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3ECD3030911
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5D2E8DE3;
	Wed,  7 Jan 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k620oX6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0E2E8B61
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821452; cv=none; b=ka3+CzSR6urAxoQvkt8HATNJ8xQnfdipSIZ1ojD2gxKj5bTuUAtMiSCsY6XKeP76dueZnhiZ6IrveEjc+9HPl0t5/QBBAbqP5twOe7pOnftdjDxClnpc9WFa2VrqfalyxyIWgSjULrgmlVoGX5jrpOLd20fC4QQmXPc+/C0Qu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821452; c=relaxed/simple;
	bh=hJBhEZEn2IW0Qs8Ce9poSTsX2HFP1recNbm+Qx+TfOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGRpL/GIp1rqcLjyXp4DlyDp90yP0p6U6F5EmVsmLDojFjtyAAJrGJd9O+PiwDQxBFsq/f/jvr8Ex48JBEo8i1SILt+kEvcN+V1TzMb17mDKEREecoP5lkDdyXZ3Ii4g4USgcXN0xFLWfVcbEBn7JtfhUNW3HyYtdXo40rby4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k620oX6k; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e7f68df436so961517fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 13:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767821449; x=1768426249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgyJxKcUhgy66+q0k0EwvKHt6dTWi7O1SwlvNA4nT9c=;
        b=k620oX6kftWHDnDeRjmIEer/+zMgkbptqwQN/iMdDylr09K3ufPyVnfXo4YiSIh1uA
         37Q7ccohaGiHSeMyJPY3HpkSMeabsbyia9fxbcPZWbXYa/y057+G/CU/usYGfIr3LwHU
         v94gAyZs2dUGI4cUoKL1DEcP/6HZVRLfPR8BJ5ItqNThR2onBRZnfnAr4W4uilFDuPQB
         yXd2El8PgA7qNs1hZTkDtPIUjd3G3MnWRpUTzgB0CxiRDfTSYRl2OF03yjawJkIqQ/MC
         lV91klAR4LJVkvTetxZv5qeSxSngJBJBhwgskucop3zv5gS0gqh2PlEWbsshAVOq9KUI
         IRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767821449; x=1768426249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PgyJxKcUhgy66+q0k0EwvKHt6dTWi7O1SwlvNA4nT9c=;
        b=juT29CjrY2399WT2OZrP6p8pzfGVAXGQVIZdUpE8geqFHFz8K6IsC4mkpCeCerBiTE
         7l0x8W+33UaX2FEzeQzxWP0POa3cCR0dW8crZ975UMarxIKXsQueC9WDWdaLMoZjuXWE
         olKV7o8ACAQ1diTE87wbmcbJ4dSzGOaWC4FVjWTUUa6rTzSZmEnjc+faNGjGdf5b4160
         7fND3zX9VmZpvdmo+e58WXEXCwmkdqgIqUvR6yX+QSIjyrOkmR2/Cmo4jKC62IIRlrCb
         YuXFC0axkBwdKISYLyGrvN5WFci9vhun056vcOg+mh7pwZgnxHipiISCW8ExPoASBAv3
         A4nw==
X-Forwarded-Encrypted: i=1; AJvYcCW5mueSg0y7I9EORCkrCEfCm4QAljQQhsIydgStYH1nnXW7cEPXWDu5Ap0K0zQmGYAFilsILqCSiECcjXdF@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO2Lii8ScPsi8Q1sGnqSxyU7D07yZYjqAQn8ONQeAo7cMTb1x
	Ks4TE0uP2pexnEpdahixtHCy55dQv9eWuWPTUlPhLimm0x3/4OjKxVBc
X-Gm-Gg: AY/fxX4XnCamPWLrKaEPW0wQnUpjtgNmtiWiyg4GzSJIaE4ROAKCbExJm/ctQAFzoIK
	2plqZ4bUCaQ06r/Pyr5N4SmjSFS3UNKBL6KVFUnplcbGX7mnzhPZjd+spa2qY3TCVSZmhNkZ9n5
	dj1BcQpjbrBycMb2z08eEluU93eYNwmW0mB17iZPDdEdzHLyCuXkE4Ns67gAdefwDw5BrHuWnoI
	+ABQkEpAYnMOaGf38Xhl9xLO8Z/estVyoaZUw3MVZ6/9Fte+JpA+X2EgS2ja/8m0jT9a6mpJ7sR
	jsGkHFrisXsrFH8ZOHeLT7lTPNjbmQEKnQfcfCHqpBIXvT5J6ioE0eqbVKhepZRmD8P4YENIp+V
	NLX2orW+ny+a4REWRb4l5kssYU5paRANsQuv3LLsPLyBDDrQddRsGWdsceTOHwbZx40eKXmVz5+
	QSPSXLcPvbO2wkpkRdM9w9y0pr4sG8aStbkgsSitSD
X-Google-Smtp-Source: AGHT+IGBpBXjThN1EPukRyzeQDjnIkWKrC19wevk+xy19Ke7HdDQYha50/3EOc1Su9/w3oCaFtcjKw==
X-Received: by 2002:a05:6870:4191:b0:3e8:92f2:caa2 with SMTP id 586e51a60fabf-3ffbed0d56dmr2067280fac.5.1767821449438;
        Wed, 07 Jan 2026 13:30:49 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3e844sm3874317fac.9.2026.01.07.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:30:48 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 7 Jan 2026 15:30:46 -0600
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 15/21] famfs_fuse: Create files with famfs fmaps
Message-ID: <smqodjljwvhnssmq4ho3hicnomzyrpsawy65ykxhigrjl7yawu@xwtbxjamivk7>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-16-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107153332.64727-16-john@groves.net>

On 26/01/07 09:33AM, John Groves wrote:
> On completion of GET_FMAP message/response, setup the full famfs
> metadata such that it's possible to handle read/write/mmap directly to
> dax. Note that the devdax_iomap plumbing is not in yet...
> 
> * Add famfs_kfmap.h: in-memory structures for resolving famfs file maps
>   (fmaps) to dax.
> * famfs.c: allocate, initialize and free fmaps
> * inode.c: only allow famfs mode if the fuse server has CAP_SYS_RAWIO
> * Update MAINTAINERS for the new files.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS               |   1 +
>  fs/fuse/famfs.c           | 355 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/famfs_kfmap.h     |  67 +++++++
>  fs/fuse/fuse_i.h          |  22 ++-
>  fs/fuse/inode.c           |  21 ++-
>  include/uapi/linux/fuse.h |  56 ++++++
>  6 files changed, 510 insertions(+), 12 deletions(-)
>  create mode 100644 fs/fuse/famfs_kfmap.h
> 

[ ... ]

> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9e121a1d63b7..391ead26bfa2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -121,7 +121,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>  		fuse_inode_backing_set(fi, NULL);
>  
>  	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> -		famfs_meta_set(fi, NULL);
> +		famfs_meta_init(fi);
>  
>  	return &fi->inode;
>  
> @@ -1485,8 +1485,21 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  				timeout = arg->request_timeout;
>  
>  			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> -			    flags & FUSE_DAX_FMAP)
> -				fc->famfs_iomap = 1;
> +			    flags & FUSE_DAX_FMAP) {
> +				/* famfs_iomap is only allowed if the fuse
> +				 * server has CAP_SYS_RAWIO. This was checked
> +				 * in fuse_send_init, and FUSE_DAX_IOMAP was
> +				 * set in in_flags if so. Only allow enablement
> +				 * if we find it there. This function is
> +				 * normally not running in fuse server context,
> +				 * so we can do the capability check here...
                                         ^^^
Oops: this should be "can't" - we can't do the capability check here since we're not in
fuse server context. Will fix before merge...

[ ... ]

John


