Return-Path: <linux-fsdevel+bounces-14106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9025877A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 06:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B626281C49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF56FC2E6;
	Mon, 11 Mar 2024 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZigxOb/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1E8F77
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135036; cv=none; b=fbK05H/OYLnC0/NGgdvVRANbIsm0fTeYuR4VIa3N5kkpobevb4FZZLk3TD0XE8aUJEt5MRLJDZWhD1Oe6r9FZOz/lBSVE1Cz3lv1E4DIyL48I8D9JOUSbPRJIox3oioJeP9/YdNMN66lp4OEgHMV8w5ui5Y+TYdSTmxTDDj1KTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135036; c=relaxed/simple;
	bh=QSULCMgM4RBYyGQMMGu8HEaWE6kxcqd/HD0+6A0t17I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bq+Em7OUOY9APxUbZFb/Bmzp0WnHtgJF3p6bB/JxmwN/IKlCr6/zPrHhyuzaxu0EyU3CGz3Zrk9mFKy/XUiFqJibrOA6sDlEarnBxrAau/xj3JANAUv4NHKXuaqteQFXZjyrdPukDlJXxHrHOtuX0EuJSqJzRjicBpAPt/QA/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZigxOb/w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45c006ab82so454048166b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710135032; x=1710739832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rizr8l7uC7l+AymItuBELPZGqhV97QKiNctOnrHH7eM=;
        b=ZigxOb/wYr7pH3fQe3EPwOBrgZ2shDNnr19MYFw85rRJ+0F+hHDarSBBwzClZQzqs6
         BuDrQ7gWA4nZybFg9jMExlYlhap2s9OTc/f7wWsfbtl41TKNYqpJuysgTEyVeRs5vww/
         QlZg419zeQfYE8j8QLPcDoPbn7vjdz8/L5IdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135032; x=1710739832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rizr8l7uC7l+AymItuBELPZGqhV97QKiNctOnrHH7eM=;
        b=AGsd6iSorrzcD4kFbkF6+AyK4UJQR42dOKea53P0Rwp8mTRSu6MbT4C+ccpd0QAv5w
         JKnAI3OrQ0HqLwbPRfWcQErZlKWHR3FWkyZzrQuKPX5Avo1/BZto5C8JFIFuy7ffGflx
         DhHufSccm/lbx+lHNgeuIRE/Uu32rcZAGvVCnyWHfIaAU4M/TLnfLqx+4bo7vUzOMyIN
         TS4hf2TyrjP5wlD0rpoQXts+E9i1CxgK7VwwrOcLftJfyqXUGrweiITA/60S0BoNVL43
         THSAMSrIojgd+9AGgziGV+WU27xg2b1+RV1833/wDyV28zBQMu5Hi91iVXx6VlWrMkq7
         Dy2g==
X-Forwarded-Encrypted: i=1; AJvYcCV/c10JHKdqHs7JnCbb2sIrYbkDuum6Bh5S1GXyfOQU+AcxIfiIu2QzrJT5D+JpSu/9BREuUPUWG704m3t4NWKKr32qImW5Zijs4jGX4Q==
X-Gm-Message-State: AOJu0Yyt/KJQBJP4/E5ceA0H4fEh4l36E4tWzEzs9/L69ZudaPSMj7Ea
	DjU9fIte177lVd0GiAUsay50FJI5sRvOQeFL7WkwYN/D+a0noaACZo0B/aR4GEKSv1ibj8K8wuC
	ngDf7GrmzRiWW4+QOtMUa97kzOZIrrGizEmzlxA==
X-Google-Smtp-Source: AGHT+IEMzJDuggzv7sHUtfohuk8woRgSDOegoleOLiiwUp4QOgsp/WyrYcegRbxhUuQa31Ax6KbOGKsTOTJvi0UK244=
X-Received: by 2002:a17:906:1398:b0:a45:f5e1:1050 with SMTP id
 f24-20020a170906139800b00a45f5e11050mr3259326ejc.18.1710135032450; Sun, 10
 Mar 2024 22:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs> <Ze5ppBOFpVm1jyb+@dread.disaster.area>
In-Reply-To: <Ze5ppBOFpVm1jyb+@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 06:30:21 +0100
Message-ID: <CAJfpeguu=DCvtU7dudXNncbxvy5joqS1Xp0Yf590UFPna6qZ2A@mail.gmail.com>
Subject: Re: [PATCH v2] statx: stx_subvol
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Neal Gompa <neal@gompa.dev>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 03:17, Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> > Should the XFS data and rt volumes be reported with different stx_vol
> > values?
>
> No, because all the inodes are on the data volume and the same inode
> can have data on the data volume or the rt volume. i.e. "data on rt,
> truncate, clear rt, copy data back into data dev".  It's still the
> same inode, and may have exactly the same data, so why should change
> stx_vol and make it appear to userspace as being a different inode?

Because stx_vol must not be used by userspace to distinguish between
unique inodes.  To determine if two inodes are distinct within a
filesystem (which may have many volumes) it should query the file
handle and compare that.

If we'll have a filesystem that has a different stx_vol but the same
fh, all the better.

Thanks,
Miklos

