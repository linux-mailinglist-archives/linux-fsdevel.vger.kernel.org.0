Return-Path: <linux-fsdevel+bounces-12825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF688679BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99F629DADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00785135A44;
	Mon, 26 Feb 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhYgae0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755C12F585;
	Mon, 26 Feb 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959639; cv=none; b=Znq7eK8KEsg7JvTpNGVvXRe0LKFdrRG7lEvVXtecKyw0sFGtowNb/IwTNKMm5YdgvCdHITHyuzVAY2X87TrSWhL17mRNnA+3VURb9yD2IYs13EQQzU+NpuIHcHu7wf9k9x9qaGvF+RXororlGZT5jMPR9QMY15Rrf8UC7h/AbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959639; c=relaxed/simple;
	bh=pDJ+S710TU3tYtsI7/uIBNbjN3ZFzSKvc9q9SE7JkjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAxypBRHLMZmeILJPa35ne2ROSGMCJFsFB7WrM2uM9rJHDopxRkvn2dQPu1QfX+ckRmBg0gYx5kDbsmkHMhR51mCBYV2CLGtiLenlXzK/2d0HrcZdENfQrPTAnh8qoraRZ+Z7v7xPtBrfiqerjG8XZq3F5h/TpnkWBiBM6zUJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhYgae0g; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd72353d9fso2099166b6e.3;
        Mon, 26 Feb 2024 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708959636; x=1709564436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H53FQFuV0tEvJqPL0XJbu4yTTLUCR5gSsoYwOTRibBQ=;
        b=IhYgae0g3nZG9oAIkAQ1fcWtFDwjwQ5YB/dFwO0sjO/hgkjp/HRkO97oNNhHU7hP3p
         aR1Zakobi9+hCNdYjeLoAx143L5J81GeNCkla4Hy0Q6MZ7ug1TryMpmXZkcc0LTcJFh2
         FEqZCpNDJShU0tCuXGYBx9roJgJ4UpVkBswMTx8JLKtuAQ4CMMU0IOGLw1VltS7VrbaZ
         +9ghOdE2dyHRWdt54E8F/gES0GcRiDoyUT4/DfrxxgVi87P+vlJ3cu83l8GOu9DVxgzK
         9/QutbESqXz4fwOqSNf5+Kxjqx43KQuSz9mPIfR35xbbIPksvthRVWofCAc8clsvz1J1
         iICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959636; x=1709564436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H53FQFuV0tEvJqPL0XJbu4yTTLUCR5gSsoYwOTRibBQ=;
        b=hxT1bTksG6MD9uc1qBihv0CsbIll5Knu+vOJmDaj7syvYhaeSylygKz2tnXHV9gWJL
         UMiJFB/NPfQvt8ftWE23YKTDsb14+d4T7m+RdJekLq2wJ9tF/TupKspsKOoEGVQsjJII
         EEzFiksDKUW4A9U1MUtei9XS+VO0mhY7we2i8nINqIw7nsuXmM3CRE4nmcuZyj45s7xA
         iQ3EkzutKjslstNIZaJewfVf9DR6VbhqFHvvqu5h2jHCyqWXCXzqsfClyzRMDX9AMFCb
         pwbnf9EDqdfX12JGyRwY4kFmAWaJqX7Erf/ux/s8jsxlE/4NZm8UFE3uJT9/v/nYVqkT
         lbAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxU65RefR1rmV+zGoO+9K58gV7W3aONR6nTOK0xA1Adk6VzpUr3Lcsr+HaBqBwGwNDK9XwQJSqmkcBESKDj2ihZAQEXj51x8lWalS7kMoYe3t39jhFsxvneRqqqVyBuft3+dLJBllvXFEIg69fYJqcWAZzAIKmg80hGK68FIhqqz4odPppx4OUmdOJl3Hn83fZKGMB320E+FZ0yT5deBWixA==
X-Gm-Message-State: AOJu0YzUAGXqtf4R1Pb8jYdJbZZ/Zo4C1MueE1KNQ9/xw8laS7xc5j1h
	EA857RiJEuPTswX9XgBz7/KKj/yefh63qjgbMZH3rQTdB2p2SboR
X-Google-Smtp-Source: AGHT+IG3Fep9vB9m/AS0yL5tfec4E03KG7h5aS3ZZXhDql7c01JJ95Pj439VYSHJQzyLahhR1xXnIw==
X-Received: by 2002:a05:6808:10ce:b0:3c1:3215:1881 with SMTP id s14-20020a05680810ce00b003c132151881mr9820277ois.7.1708959635473;
        Mon, 26 Feb 2024 07:00:35 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id ca22-20020a056808331600b003c1a9ed75casm59821oib.18.2024.02.26.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:00:34 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 09:00:31 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 02/20] dev_dax_iomap: Add fs_dax_get() func to
 prepare dax for fs-dax usage
Message-ID: <7t6n6c4cycu2hqh4ajsl4egtu2womq54unj4ikqeu3rehmxwzw@64ydmjh5x2ga>
References: <cover.1708709155.git.john@groves.net>
 <69ed4a3064bd9b48fd0593941038dd111fcfb8f3.1708709155.git.john@groves.net>
 <20240226120535.00007a36@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226120535.00007a36@Huawei.com>

On 24/02/26 12:05PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:46 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This function should be called by fs-dax file systems after opening the
> > devdax device. This adds holder_operations.
> > 
> > This function serves the same role as fs_dax_get_by_bdev(), which dax
> > file systems call after opening the pmem block device.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> A few trivial comments form a first read to get my head around this.
> 
> Yeah, it is only an RFC, but who doesn't like tidy code? :)

Hope your eyes don't burn too much ;)
> 
> 
> > ---
> >  drivers/dax/super.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/dax.h |  5 +++++
> >  2 files changed, 43 insertions(+)
> > 
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index f4b635526345..fc96362de237 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -121,6 +121,44 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
> >  EXPORT_SYMBOL_GPL(fs_put_dax);
> >  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> >  
> > +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> > +
> > +/**
> > + * fs_dax_get()
> 
> Smells like kernel doc but fairly sure it needs a short description.
> Have you sanity checked for warnings when running scripts/kerneldoc on it?

Right, and there were other cases. Randy pointed one out, and I've already
gone through and "fixed" them.

> 
> > + *
> > + * fs-dax file systems call this function to prepare to use a devdax device for fsdax.
> Trivial but lines too long. Keep under 80 chars unless there is a strong
> readability arguement for not doing so.

I was under the impression the "kids these days" have a 100 column standard.
But I will go through and limit line to 80 except where it gets too awkward.

> 
> 
> > + * This is like fs_dax_get_by_bdev(), but the caller already has struct dev_dax (and there
> > + * is no bdev). The holder makes this exclusive.
> 
> Not familiar with this area: what does exclusive mean here?

The holder_ops are set via cmpxchg, in such a way that if there are already
holder_ops, the call to fs_dax_get() will fail. (as it should)

> 
> > + *
> > + * @dax_dev: dev to be prepared for fs-dax usage
> > + * @holder: filesystem or mapped device inside the dax_device
> > + * @hops: operations for the inner holder
> > + *
> > + * Returns: 0 on success, -1 on failure
> 
> Why not return < 0 and use somewhat useful return values?

Good idea, will do.

> 
> > + */
> > +int fs_dax_get(
> > +	struct dax_device *dax_dev,
> > +	void *holder,
> > +	const struct dax_holder_operations *hops)
> 
> Match local style for indents - it's a bit inconsistent but probably...
> 
> int fs_dax_get(struct dad_device *dev_dax, void *holder,
> 	       const struct dax_holder_operations *hops)

Done

> 
> > +{
> > +	/* dax_dev->ops should have been populated by devm_create_dev_dax() */
> > +	if (WARN_ON(!dax_dev->ops))
> > +		return -1;
> > +
> > +	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> 
> You dereferenced dax_dev on the line above so check is too late or
> unnecessary

Good catch, thank you!

> 
> > +		return -1;
> > +
> > +	if (cmpxchg(&dax_dev->holder_data, NULL, holder)) {
> > +		pr_warn("%s: holder_data already set\n", __func__);
> 
> Perhaps nicer to use a pr_fmt() deal with the func name if you need it.
> or make it pr_debug and let dynamic debug control formatting if anyone
> wants the function name.

Sounds good.

> 
> > +		return -1;
> > +	}
> > +	dax_dev->holder_ops = hops;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(fs_dax_get);
> > +#endif /* DEV_DAX_IOMAP */
> > +
> >  enum dax_device_flags {
> >  	/* !alive + rcu grace period == no new operations / mappings */
> >  	DAXDEV_ALIVE,
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index b463502b16e1..e973289bfde3 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -57,7 +57,12 @@ struct dax_holder_operations {
> >  
> >  #if IS_ENABLED(CONFIG_DAX)
> >  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
> > +
> > +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> > +int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
> line wrap < 80 chars

Roger that

> 
> > +#endif
> >  void *dax_holder(struct dax_device *dax_dev);
> > +struct dax_device *inode_dax(struct inode *inode);
> 
> Unrelated change?

Kinda, but I'm not sure there is a better home for this one. Patch 18,
which is a famfs patch, calls inode_dax(). It was already exported but not
prototyped in dax.h.

Mixing it in with other dev_dax_iomap content seems better than mixing it
with famfs content. Could make it a separate patch, but I was trying to
some old docs that said keep patch sets <=15 - which I deemed impossible here.

What say others?

> 
> >  void put_dax(struct dax_device *dax_dev);
> >  void kill_dax(struct dax_device *dax_dev);
> >  void dax_write_cache(struct dax_device *dax_dev, bool wc);
> 

Thanks Jonathan!


