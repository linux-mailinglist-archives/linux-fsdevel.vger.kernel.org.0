Return-Path: <linux-fsdevel+bounces-12826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062408679F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CBD1F3077B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0112F5A2;
	Mon, 26 Feb 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISDNb3Io"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C912F589;
	Mon, 26 Feb 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960424; cv=none; b=HImsCP2mVEjvaP/cx5bpXdEpUH7m1Og0RSHzxG3/e+x5gHSkNEGC81jmjYmyzLjP3kDsJ3o4+JEc4lugKZTAiyxGQDz4NN425dlQq49V1yNnixYJJAkSkUumQHdpdaYF57r4SyP1HJk283Y+c3IcRnCRHeNdfy9AMo0SVYWzGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960424; c=relaxed/simple;
	bh=rURmSkgy6eHeKznPm4mjLqjD6+kyDlL2P61qzNpDTF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfJ4w8dUc63FCFX76LK1uHLg6m+YcJlmw25a+UGDx18LynX4F5uxdR906LfOrocdtQK4Z4s+zhPBgF8z3s6l7wDVmC6cjfdhk5GD6bEuJPS0QVSJf8SkqTQjWNYKx+PKSblH2Eh12LNKvBkiXsgvd0SJxB6SI+42h9YpMrQNy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISDNb3Io; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21fa6e04835so1178160fac.1;
        Mon, 26 Feb 2024 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708960421; x=1709565221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2RNYfbXtpUIs/lXlGZGdjPvaKF4hrHLK1yFYk95gmg=;
        b=ISDNb3Io/NlbvAMiA1c8Cs0Mo5oRUVwRyB3UHDCfSGCUMqw/EPrh4vPypN2BXRNuIm
         65sI3rv11vV5dwG+77krYCPsyvq/APrtNaYhC10/SW3IIfY+E9gMUOhw/6MfUY2wTs7n
         3aVgXGxhQchBtJrXTmFxmeMfIJXoOUwXsgLbMhNLB5NSvDcs+tbASq1oSkjEAJ9GsYVJ
         X0tb+n7nQDiXUsMDtoJXFHCrvW9TZLOfA8PqAKecf30BqZtp9lKZtY18KFsQwrzYNju3
         RLIn6sO1kRTVnly2TygVySiTYxapbNz2UJtU8wBoqJhFpCQK7gDRY9pZhebAc9ZOoAmY
         5lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708960421; x=1709565221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2RNYfbXtpUIs/lXlGZGdjPvaKF4hrHLK1yFYk95gmg=;
        b=dTIPc/ur486t7lc0lGQIAzb/SVYZI4RfjcclRZrY4i3LbsPHWxd7dExYWVMrHcFeU5
         8H+fxwnYQMTVWswOcYxxQ6xsXEYCN1fBeiO8mpaELo2npP38ng5YoZg4oSxNlnRA7etf
         6qqbwXUwVIO9nTfdZcE1v05CU377qVoEFuQ54lBssDXadzv3xig3WJ8XfcVgESYjoRPu
         6Chif4lZzQxDfWHY6daddxT7AivjyQ6eUkRjpm+hwnjP+UheVStr/J0C3wbtoaV/TDKD
         Dy5zHceHX/frM3BkjcIQ6wjWBOsSEK0WK9WPOWSZQx8jKVjhxWQmNVkzO/ZAyGKzESsi
         Qphg==
X-Forwarded-Encrypted: i=1; AJvYcCXD829AoOI46IhjqIb7T0S/6braTuEfJyeSCP/ECfDw/AZYWQnvllGxYWquKNa54hB6lDlrcPyQKb1X3dunAMZrPxukg23QhmghL2sb7ngWivVmooOJbBajJjovRE/zeBMPQ46mHvTEIDC8KsvMv9KDb2zbuAXfnOuATL4DK5onbBmUhyQo9vGkHfm7gLRkepw3bxkiwKjekBLNVfF+rf9DSg==
X-Gm-Message-State: AOJu0YwvX4knzQUo59oa5IqZEtOJ1xwwSwoITJgNURYNo9GDw57jaYze
	5Fi9GrpSHTGfF5e+2UEqRsqEFX7Pn/bssup02CeT0dfiu2AosV6DmdNT6nxR+T8=
X-Google-Smtp-Source: AGHT+IGqrIvwue3yE+w57GRzW34rC7ys6T+9FsFecJygkZyFOJPKOETxUuiD8wmEbKYVyj2NQ94Z/g==
X-Received: by 2002:a05:6871:587:b0:21e:a9d3:6470 with SMTP id u7-20020a056871058700b0021ea9d36470mr6414831oan.22.1708960421372;
        Mon, 26 Feb 2024 07:13:41 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id j19-20020a056870531300b0021fd26da430sm1549113oan.4.2024.02.26.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:13:41 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 09:13:38 -0600
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
Subject: Re: [RFC PATCH 03/20] dev_dax_iomap: Move dax_pgoff_to_phys from
 device.c to bus.c since both need it now
Message-ID: <3rr7b2qjwxcc57ynzyo35vvw3buaxpkwum4d4swrz7nsdb6clr@ssc4yupwatww>
References: <cover.1708709155.git.john@groves.net>
 <8d062903cded81cba05cc703f61160a0edb4578a.1708709155.git.john@groves.net>
 <20240226121035.00007ca4@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226121035.00007ca4@Huawei.com>

On 24/02/26 12:10PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:47 -0600
> John Groves <John@Groves.net> wrote:
> 
> > bus.c can't call functions in device.c - that creates a circular linkage
> > dependency.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> This also adds the export which you should mention!
> 
> Do they need it already? Seems like tense of patch title
> may be wrong.

I added "Also exports dax_pgoff_to_phys() since both bus.c and
device.c now call it."

The export is necessary because bus.c and device.c are not in the same .ko

Let me know if it seems like I'm misunderstanding...

> 
> > ---
> >  drivers/dax/bus.c    | 24 ++++++++++++++++++++++++
> >  drivers/dax/device.c | 23 -----------------------
> >  2 files changed, 24 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 1ff1ab5fa105..664e8c1b9930 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -1325,6 +1325,30 @@ static const struct device_type dev_dax_type = {
> >  	.groups = dax_attribute_groups,
> >  };
> >  
> > +/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */
> > +__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
> > +			      unsigned long size)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> > +		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
> > +		struct range *range = &dax_range->range;
> > +		unsigned long long pgoff_end;
> > +		phys_addr_t phys;
> > +
> > +		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
> > +		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
> > +			continue;
> > +		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
> > +		if (phys + size - 1 <= range->end)
> > +			return phys;
> > +		break;
> > +	}
> > +	return -1;
> 
> Not related to your patch but returning -1 in a phys_addr_t isn't ideal.
> I assume aim is all bits set as a marker, in which case
> PHYS_ADDR_MAX from limits.h would make things clearer.

Perhaps Dan or the other dax people can comment on this? I just moved the
function verbatim, but Jonathan makes a good point!

Thanks,
John


