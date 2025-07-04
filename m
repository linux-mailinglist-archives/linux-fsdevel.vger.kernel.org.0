Return-Path: <linux-fsdevel+bounces-53962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB04AF9336
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 14:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CD41750E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D292DE718;
	Fri,  4 Jul 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMytGmPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDD2D9EDB;
	Fri,  4 Jul 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633690; cv=none; b=Ar0AV+X6L5N75I0yx6+GgaxVZZvuootb1uMPpB3fr+7j9Z6HyLEe3ARKqfGC9+TbdjAQDdOkW/cBODsBImhXGZkfKc66BPXuj5qLa9Lrl9dDfFZ5dcQKLrRbpHeoGViOlk3wXbbuTvijqiGu544cQBkXjIzRjZbDOKGE4gJS5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633690; c=relaxed/simple;
	bh=WFTveO6q4/9I10ER4OzIRFRhszAcOJqSl6IAE70OKT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuKw1QM+JYJWGLelZ9sto66gZqjKLiIw44ar1cb2HEZGA6YJHwdJolMv7SMcOHRr14CqyrA61vouanz1Uf1nZON1iHZ9FQ5ZPKqJUfwCAYSQUc4DO4/rKFQMCg3pI2ZJC1G0/Z7VXHkFyoBniap/HaGRXBZGdP83a0qQmwZ+BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMytGmPv; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60402c94319so574055eaf.1;
        Fri, 04 Jul 2025 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633686; x=1752238486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWEiBexGknF9z9JpON4CDuydmvoVyHEn0sWhDagRzsw=;
        b=XMytGmPv6zJQ1N7jQmAzGbLjTAvsCju/5+M8Fk0T1DnJhS7gvB/acjbJgaFvSftDsr
         jV1kY0eyFUtj/M+3hDRy5W3sPdefMstroDxMOq21jLMj8NZ6EHvBY9W0KFvNtLFRZhvI
         QYcZbfyisEFQlKT/El0gDQqM5IODrxZDwFwR+Z31iLwmjyUiE2Hb8aA0sMmlRo1NGYg3
         jvjTtuoRvxsGy80dTGzI1TAS+nvkDRhltMXa56IRsEqYe2R0PTN6p2V6oM+kcnsQJ3Cr
         nj/rAy3RelXQ3UnfU3Q0y6iVZLWBLzMXfSuTlQU/kecqbKILO9fSUWUUzdr/fwn9mi/9
         NWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633686; x=1752238486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWEiBexGknF9z9JpON4CDuydmvoVyHEn0sWhDagRzsw=;
        b=xEHU9jll3HRqejcj7r0AFZ5BCHOYFmsNfprdhOZAMibiy0eBeLq7fSWSroDsT7W8+3
         wx+52TL/O/3ckm2jiAuXpghhdNmNogQv6ZFbcycemUTq+6Guqc3zvqxkubr9Xg6h8Ww0
         ucpxdefh1U4mXe5rGzn3EgxAIzYNShoygFIQq9N/fzLZ9UiLpFTTvhvA00xwwBNyw3yW
         B56Xky0jThC0rylhUk7bST5iRjrhRcwgK3I8Ihyl67VRCOlMw1HzuN4pJW6uYgOQXEGw
         x6lDX8i1C8m8BhO6Xq4LYqDw52+9nNpGGccMmwXfEnTrJd9pbUswmlanWl0N1VfKK5Wh
         QfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUckJIaeT8m4BaMaHj7MG31F3Cox6FtveyIw+2LywpTtCpT7uO0KXQLZjYdTBHu6rJAg/cGwwI0JiM=@vger.kernel.org, AJvYcCWCQi72JKwJnJl6QbUIehG5XX3QmuSiztIzLU4SZC9GBfZgknKfGhoUqwLlBX9iBcjl/85wnk//XdUhZELzzA==@vger.kernel.org, AJvYcCXC/oUFnCKP63nypKJisbXvXAJps1oOPt60NFfMoNv+SkqaO2hXjBP9iECRNU45AsMLP7DUxk9YKX5KlK8H@vger.kernel.org, AJvYcCXce96OFcK+Ciabuc7E7GqZnFxRVbwOli16ocZvJc856/ZOMybYJx35/rAfk8BAySJI7Ac1Zpjf+Xho@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCimePdhL1MYaogu1n4QyWwzukDdIDgshiR543pI9TUFpK/KN
	Bvu1mw3edYBKH8OyMxciriioeeiJ9XE5n26Bk88nFshaZxyIf2WNAqo4
X-Gm-Gg: ASbGncsaHThxz1oi5M0rMryWk93AR0Sf4mMWSOaat0pDKz5VSfdF9uiPH9WPBvzvpIj
	TiFxvQ2csJViKAexFkThkjVJyXOhZmmQntI+s5x6Ka/a+c63Lu62nXYnb6M9lTO9z0ABAKe0Hif
	Ng6d39J38a34Ru0yUe+DdcEXbZYRcrQFnpuRv3xaDufCtgP2qHIVbKhTH2tYcvlYm18eHcsP0gp
	k8M7uWo0LjG126B/pa8Umryc7f27oJmhIZhvMHwk7ZdxvYSAWH+6EnWDGHLR9MZ/7mCvCqdTIpp
	STNRcD6V+aBpA9uIIw1rQmYhOrzJsnE9lZwjduv5JasQ4K5Oxe8TH+NQ+nZ51IxrKWNgzss8HOc
	=
X-Google-Smtp-Source: AGHT+IEQCt6EzoQ1S/rGkyJCcVERY+DBQiFOXPfhObXBAnuO2Eb6V1GMOP7z4zut5KZK3JQFhWGgIg==
X-Received: by 2002:a05:6820:1986:b0:611:b85f:b159 with SMTP id 006d021491bc7-6138ffa3919mr1751955eaf.1.1751633686279;
        Fri, 04 Jul 2025 05:54:46 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:2db1:5c0d:1659:a3c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6138e5c1db3sm304526eaf.35.2025.07.04.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:54:43 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 4 Jul 2025 07:54:38 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 02/18] dev_dax_iomap: Add fs_dax_get() func to prepare
 dax for fs-dax usage
Message-ID: <or7rm2n4syer4uxaubtotarjtmmilhedih4odgiwvqb4cfkvsl@5w66of2xms5l>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-3-john@groves.net>
 <20250704113935.000028cf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704113935.000028cf@huawei.com>

On 25/07/04 11:39AM, Jonathan Cameron wrote:
> On Thu,  3 Jul 2025 13:50:16 -0500
> John Groves <John@Groves.net> wrote:
> 
> > This function should be called by fs-dax file systems after opening the
> > devdax device. This adds holder_operations, which effects exclusivity
> > between callers of fs_dax_get().
> > 
> > This function serves the same role as fs_dax_get_by_bdev(), which dax
> > file systems call after opening the pmem block device.
> > 
> > This also adds the CONFIG_DEV_DAX_IOMAP Kconfig parameter
> > 
> > Signed-off-by: John Groves <john@groves.net>
> Trivial stuff inline.
> 
> 
> > ---
> >  drivers/dax/Kconfig |  6 ++++++
> >  drivers/dax/super.c | 30 ++++++++++++++++++++++++++++++
> >  include/linux/dax.h |  5 +++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > index d656e4c0eb84..ad19fa966b8b 100644
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -78,4 +78,10 @@ config DEV_DAX_KMEM
> >  
> >  	  Say N if unsure.
> >  
> > +config DEV_DAX_IOMAP
> > +       depends on DEV_DAX && DAX
> > +       def_bool y
> > +       help
> > +         Support iomap mapping of devdax devices (for FS-DAX file
> > +         systems that reside on character /dev/dax devices)
> >  endif
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index e16d1d40d773..48bab9b5f341 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -122,6 +122,36 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
> >  EXPORT_SYMBOL_GPL(fs_put_dax);
> >  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> >  
> > +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> > +/**
> > + * fs_dax_get()
> 
> Trivial but from what I recall kernel-doc isn't going to like this.
> Needs a short description.

Right you are. I thought I'd checked all those, but missed this one.
Queued to -next.

> 
> > + *
> > + * fs-dax file systems call this function to prepare to use a devdax device for
> > + * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
> > + * dev_dax (and there  * is no bdev). The holder makes this exclusive.
> 
> there is no *bdev?  So * in wrong place.

I think that's a line-break-refactor malfunction on my part. Aueued to -next.

Thanks,
John


