Return-Path: <linux-fsdevel+bounces-53853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7AAF83CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA6D4E4DE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 22:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD32BF3D7;
	Thu,  3 Jul 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvdkEn3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F29239E65;
	Thu,  3 Jul 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582754; cv=none; b=miMxLZBcVWa3AAaaylk19VralqiDBVTg1ijrenAxbbbrPCbx0UkN4iRthJBdTWHNkEr5eYwV1fURSY75ieQE5bV1VAbXgngRYCpc5xl8quTFppi9Hcf2koGL6KCuUFL3O9DeKXKtIGwFQPRSUpC9Rqcq/iKf2It1WGIxcd+eC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582754; c=relaxed/simple;
	bh=HPiHsjtsNUgZ0EFVulpD9xRBLiID8ZLRDhdfVW3IdsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1TvvoHGE80OzhPjheOnTJ3lYp36HfwJ6ZEfEl8O/hs3l2ee1GLvqWftD/+J20jGvXNqwvm0vcYGG/hFkknEG5RyrDFAmJu3MEbIdc1x+HrYK8Wn1nBytK4s8cumN60bBXj5BMxsu8n8Cl0C+tMRSuDPcwsSRufNkQOy9YuiEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvdkEn3U; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73b1fbe64a6so142015a34.1;
        Thu, 03 Jul 2025 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751582751; x=1752187551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YPfgimj3TTDyL48vSPqdxv4VejexqVlnC8mgGOjy00=;
        b=UvdkEn3U3hv60QoHKFN6gVJq+mcJwFG08bBw4VpT/z2xIfpTe3CugfPNFkv2gAJ3mE
         xDIhPPYvZQDHjnvcCjwZclLkqShxNDHo5EehkCh4gFIsNfE6UHuS1DCpolaOym0Y1Fud
         kgCBJJSursGSVmc190ZMmzeGHctQ5O44atZr3KjbJGxfaTCjP3SHrDhg3F8TZ3POS4Ue
         Bt3ZTZyIJc15yPmdhu8SsdGjLuxvMZPBiAlvWfMp6NR2Wd6H8H0KOpZzsdLcQLQMHe8r
         VdF+Y/6I1C96fx1fHheF9HiULnbTJXJ3J71PMqrXnVjhxzuenYhcH1o4Rw1UgOVhypR1
         DzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751582751; x=1752187551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YPfgimj3TTDyL48vSPqdxv4VejexqVlnC8mgGOjy00=;
        b=j8W0uxkGIrjIJnpx8fBgNEk+I41KXV+6CaSr7rAEtRwU/yFsMmYOlwIb0dUqZmxtaO
         iweFRmDG+dz1uhkBMj20c5lzfd5k6FmDvMIxCQ1y6b2zvGccK1XVMsiTLv6wqIQLNPv4
         O5+/PKatRqBDvCO4GvhDV3Ha/K4wiEzkq+DQuv1AocIGDA/GL0F0PIE2fAXYS4o7joyH
         RTxPwcrTKu4aVW/vH86DWxX39DeR6sEFqFnLQ3MBc27SOZnmu3mrqjK1+TktMOJvvFw6
         B3T63jf9bU7ll7+Qa1ifJyzE2eWzl4N57EzqYZlZql8JyqoxL1zbQaivpT/I02oyXdpB
         qLDA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ns5kGxkSQyvdXAeoo7Xju8at84HhJt0rlHTJkeC9BCPXBR5Ia23F58lx0J+vBOJTK4QKy03EVt0=@vger.kernel.org, AJvYcCUv3TgFbLSNZkwelLbp7U4qAK/d6eiAfYco+21caGe84CctdutCe9Ju8+dOVxmjBSER4a3VgKgvkYgx4Kes@vger.kernel.org, AJvYcCWplqpz8Rv1pIAk7xKfgZKD32uRPXi08Fb+ZTPLmOuHF2BmNHra0MU9aH/SUmbj4P44Z8Rs7MRfVSic@vger.kernel.org, AJvYcCXpN4KBIRzm9JAuUy/23UPsx9SPyhCQSl1d6+++0AasqKOoWZN3J/Prfzw4RXkzPm19azRrWDrx6IOGEBl8mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnx3tdmZobwdLdbFmuVR4qwcCBhC10BjUVGkq5I/z0P+lDaVMg
	kaxfC/8HhARVpJhFPQG9GxV8ntpGv5D5l8AoOAKU/c8kXRZPZGSuhiRIvtzVrvc2
X-Gm-Gg: ASbGncvHYD/6+nsFtiNxKhJe/sRGZaqL/gzLzyoRsx4HhLsi4l5d3WIIeRJceQ8cYJp
	8/9ba69fMrQDB9PrX1/OvjU79QYudZtraiYJNvLWcQtOXS5ZQ/oZz/Cfcig9w7SyacIJiWi9ckW
	27GVZ2/xRczRWeuwXKYa1GMU2FV6ZOFFq+3rlJldKTFqDdOXaHReZ1jmnVhuFnQye/B9CmZQQFE
	IX64DPZvpUOo3zRF5wD4PBVg1nKqN6k8/nlddHZrdnjJBYP2rVAOBLQwTIt2CPMGE196YW6WQDt
	6Cb7k2InpgPABO8MXg5MRk4GJpIdxJeah23EynroJ/UAJ7/6IH2WAVf70FcDUVhAKw5bJpFXbRe
	MrdJJA8dp9A==
X-Google-Smtp-Source: AGHT+IHgGLtiiEgL7LDQ1Ih8w/gzruS2hdwVBLtgvJrCpoHNfH4Jij5JOMCtHWIqD9KxgQY4KtoqHA==
X-Received: by 2002:a05:6830:2d81:b0:72b:89ca:5120 with SMTP id 46e09a7af769-73ca124817bmr592721a34.8.1751582750775;
        Thu, 03 Jul 2025 15:45:50 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f75356fsm159877a34.26.2025.07.03.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:45:50 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 3 Jul 2025 17:45:48 -0500
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
Message-ID: <aimijj4mxtklldc3w6xpuwaaneoa7ekv5cnjj7rva3xmzoslgx@x4cwlmwb7dpm>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185032.46568-11-john@groves.net>

On 25/07/03 01:50PM, John Groves wrote:
> * FUSE_DAX_FMAP flag in INIT request/reply
> 
> * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h          |  3 +++
>  fs/fuse/inode.c           | 14 ++++++++++++++
>  include/uapi/linux/fuse.h |  4 ++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9d87ac48d724..a592c1002861 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -873,6 +873,9 @@ struct fuse_conn {
>  	/* Use io_uring for communication */
>  	unsigned int io_uring;
>  
> +	/* dev_dax_iomap support for famfs */
> +	unsigned int famfs_iomap:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 29147657a99f..e48e11c3f9f3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			}
>  			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
>  				fc->io_uring = 1;
> +			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> +			    flags & FUSE_DAX_FMAP) {
> +				/* XXX: Should also check that fuse server
> +				 * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> +				 * since it is directing the kernel to access
> +				 * dax memory directly - but this function
> +				 * appears not to be called in fuse server
> +				 * process context (b/c even if it drops
> +				 * those capabilities, they are held here).
> +				 */
> +				fc->famfs_iomap = 1;

I think there should be a check here that the fuse server is 
capable(CAP_SYS_RAWIO) (or maybe CAP_SYS_ADMIN), but this function doesn't 
run in fuse server context. A famfs fuse server is providing fmaps, which 
map files to devdax memory, which should not be an unprivileged operation.

1) Does fs/fuse already store the capabilities of the fuse server?
2) If not, where do you suggest I do that, and where do you suggest I store
that info? The only dead-obvious place (to me) that fs/fuse runs in server
context is in fuse_dev_open(), but it doesn't store anything...

@Miklos, I'd appreciate your advice here.

Thanks!
John


