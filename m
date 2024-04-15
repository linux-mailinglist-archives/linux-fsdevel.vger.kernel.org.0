Return-Path: <linux-fsdevel+bounces-16962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACC8A590E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8891D1C20D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B083CDD;
	Mon, 15 Apr 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9p9lRAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA682D69;
	Mon, 15 Apr 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201829; cv=none; b=l7CGORh0IDbH6rXKQCX4y3QwfXxENjt2RkZi0ABdyy/Nc+c4WPgX873k1rY12Bh+S/N8dJevlLKKJtVPW1VefebtNB2i9cl8uLsBgqIoJ+5HXDPlra/dklKZDbMNsdjf5CdsFmMFTq+NogEgUuJV56E0SAboQXS69up/g/qkjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201829; c=relaxed/simple;
	bh=XghqsD/3pOgYP0EA5HsN9vwQrCMSAJUdZw3nglyGOAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgAK3Xs4s2vwtEHYGXbaIb0ahxeCdXfl+6JL5QvGobZVFqpWc6auUM5B6hpii+XqbpZ6KfcumvT7mZ/+HKqEqdmX1CRBPApELjzcRyeqgcfFE8Yad9t8VBtt3Dc2prJmRri/22/HGL1RHL30OPnqoPntfmcPK/FxBicVEsOEnWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9p9lRAu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34782776b19so1284095f8f.0;
        Mon, 15 Apr 2024 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201826; x=1713806626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAQHdV/dGa1CgJuqaWPz4Z25FYR5vxGuEea/Z0mz/6A=;
        b=H9p9lRAuuffAQSsNpx77/LIpDXO9nt5o7twUxhf2ni852ifakBSAZVyAFV3DzBRaYU
         BDz+UthLS1McNHqaocglKQVGLoVQrPO9bgxuWoxtVxOM6Uy49cOfrTtpcmaFmOeyhUZa
         ZvaRX6YUUiYGILhp9LcaSENAWkI5X0MK68ERIoN8bzofBpQXN5u1N7uMpI/HDlZKDc41
         M8H4B3mnd2JNNZ6Mu7DFYxbpkBrbZ7pV2QbrWVE63NeeOlOz3l/jJC5h7jywtQzc3MOL
         Hpdmq9BMzf0vdKxE/FfRgyPi5uh6w9rh8Tds5T0jSh4uvsMiYoNofzwzlzSDy/ebDYPT
         1K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201826; x=1713806626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAQHdV/dGa1CgJuqaWPz4Z25FYR5vxGuEea/Z0mz/6A=;
        b=UwclZ8hBa2Am9J4ynBIejRNViFZ2yaZALOTnFGKxQ/bAhRK4Z2MVFkOJMTAdN7tAXm
         GUqAHa4bTdJUoOYMKsZIPGba80QJmCjngKoG8tgIi1GuyfeoAuqQvn66hwqzLsRkUaH3
         I7NGX6q8FudRWbIE3yIr7M+mvULuJFJkjaEbt7Wb0bKyjHMcNEqYskwCLuGVZHy0CES9
         +FXDNRXCVSNvi3Ej7BU9H9ZZSRHFaleSbf7I1gDVO4SgV9XHL4loR3lXcgaRawzW4Qsa
         jh9hL2n3/nBUGIJDwjUzS6JaE8xnkfYVxRY950IwVnMhcxk0wAD3gL826nnua9vrTdDb
         a1vw==
X-Forwarded-Encrypted: i=1; AJvYcCUcuT2E96NLyec6dMaVmY8FyTbGik6KhxwoEr6JmlbCGKLKh/jjrKoqPq4dLd+haLxfqU9xux6ma2CX0QTQqfL+9onv6PL7HfByqfUK8jOshkyN3eiOwz2kY5lbmzZHnHLHBJp/jQ/2F2qve9vsDIY6oHMkZD767OicHiiFE2D/CClrTUojBrVS1Rg=
X-Gm-Message-State: AOJu0Yy1yPoZjqc592LtESadQFyokxX+tJhdZIREYhvzVtyOrzRasJMv
	dvSwaDADjmrzd6RZyWo7HDOGqq/LZcS2hqqfSc7RnPtUCmdGAq4=
X-Google-Smtp-Source: AGHT+IHYzXt2V6x4P7IzY6gQUjvSJTk4x1goJEs+3JyHo+AAHgTv36lTgIH+czG21fKdtB8EV6Tvhw==
X-Received: by 2002:a5d:6087:0:b0:346:6c9b:4f9f with SMTP id w7-20020a5d6087000000b003466c9b4f9fmr6871105wrt.9.1713201825986;
        Mon, 15 Apr 2024 10:23:45 -0700 (PDT)
Received: from p183 ([46.53.253.150])
        by smtp.gmail.com with ESMTPSA id q10-20020adffeca000000b0033dd2a7167fsm12668899wrs.29.2024.04.15.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:23:45 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:23:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <e770923a-6719-403c-a9f2-1f7ac4313474@p183>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
 <ZhxDj3vQFLy62Yow@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhxDj3vQFLy62Yow@bombadil.infradead.org>

On Sun, Apr 14, 2024 at 01:58:55PM -0700, Luis Chamberlain wrote:
> On Sun, Apr 14, 2024 at 10:05:05PM +0300, Alexey Dobriyan wrote:
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3616,4 +3616,12 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
> >  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
> >  			   int advice);
> >  
> > +/*
> > + * Use this if data from userspace end up as directory/filename on
> > + * some virtual filesystem.
> > + */
> > +static inline bool string_is_vfs_ready(const char *s)
> > +{
> > +	return strcmp(s, ".") != 0 && strcmp(s, "..") != 0 && !strchr(s, '/');
> > +}
> >  #endif /* _LINUX_FS_H */
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2893,6 +2893,11 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >  
> >  	audit_log_kern_module(mod->name);
> >  
> > +	if (!string_is_vfs_ready(mod->name)) {
> > +		err = -EINVAL;
> > +		goto free_module;
> > +	}
> > +
> 
> Sensible change however to put string_is_vfs_ready() in include/linux/fs.h 
> is a stretch if there really are no other users.

This is forward thinking patch :-)

Other subsystems may create files/directories in proc/sysfs, and should
check for bad names as well:

	/proc/2821/net/dev_snmp6/eth0

This looks exactly like something coming from userspace and making it
into /proc, so the filter function doesn't belong to kernel/module/internal.h

