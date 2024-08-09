Return-Path: <linux-fsdevel+bounces-25556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B0B94D665
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1508C1F229A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DAF155CBD;
	Fri,  9 Aug 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nx2xh8pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156014B96C
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228724; cv=none; b=XvJyoQSXvjQElPplY/9xbF3QTG3amnstftbVH0pCwxtG7Morsev580lw1YDgtEEXjKXh+ylIqaU/NxWrgk7w6iCzmZHS58BYuEmwGrbw2ZfdgnnxiWpkgNDRkHlVyAvXlmomGr/3QV0lcIaboeQNjOVZvNxAWCK7ZW5QScXDF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228724; c=relaxed/simple;
	bh=SqPaoMqAV/lzwNv3TXMxlK5QRMuTdQXKpRoCCE6KWhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq3ULZuhHqAcDvv6M9MJc2HGm/Q3jdXTluZBC5KGRxmAV8p9mbIBAoK5pSgObSymuvwHJW6uOEAAUS5CbLLbokLLJwKQ9Cofa672iQ0s3j1XgLut8v8n752lsNrAbPvV8XQtRORjuOzoQ1mAKKSBEI3Ic6shObftsqoW1IQXCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nx2xh8pt; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f50d8ce6e0so853970e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723228721; x=1723833521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/uUx2VRWC0xFbQoxbc5T31lvIjaIYAf3b0g29Y7uEM=;
        b=nx2xh8ptYnc1b71uwb9ICfBkUcwV2GFKpiei1aMyXu/1r7OphaacJY0lCWwmmjM8LN
         +FazHje17U4UVTgCkubiPXSAyzbzqxUPHv2LbzmhQo6ElDJ70cDor74Sx0TTujRkDzwb
         hjiyLSsxds807/tffYt67HtWV3GPsMHVrff2udBs+UE0iTARKh8Zh/n9zsfoYZrQJ5CI
         vEyssnNvZhuHX7nMAT8+Z8pgp4gh4Nr9hCPxU+fAxATlZutjDK9OYn1kWRfo47MdqiB4
         u4UwGIvzMYx25sD621zQdC6qxPASyHOpXGXVEefPPbVI2BCeN1sh75ztTI/CNBZeuSaU
         xa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228721; x=1723833521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/uUx2VRWC0xFbQoxbc5T31lvIjaIYAf3b0g29Y7uEM=;
        b=MgDHGUm1uNVXkxl+OAlj2+IlFNUng/XSJQ4i5rDIBVKezcw4rUWp9FNYzKakuoHF3f
         ZaUOJvdR8CHBPmwjx8qWYsEmQXTtlRMYLe5qcymxV6Jx0ByEZbxIuoCuCYxygexbKFFG
         5Nz/5owV+yULXi9/r1czeyT+sSqnWqnIRd+QNL3h4446UwES6YKeZGjzq8rZaAGjAehu
         Piz6ZzglrCxv1J+p29F8cpboN3mwG5MDAyummE+aXpfV5STN2D44C5ovunS8O31JJAht
         Cmziy+ZfMi35byGed8bOM9k3BS7mrfWiP8MfMNZCJitLflnGQOtCK8tK0FxHUtUz7iJm
         B9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX/z9QG2LJQAvgmXpK1ThEOZivu5l0N+FJdpxI1aX1Z+Xoi147EsxIKWTXwznSvxm0Ya4vZd0ynq1Sd85vY1N/vIE75UjZia4fvoQOxuA==
X-Gm-Message-State: AOJu0Yx6FqGY2ONsKT/fVtsjP97mCqTCEahE/16349AduEchaCpZ9u2l
	GPpS7ns/yUwgBW3LNB9Tci77i25Jrd00FHBFG2sqtUvMGkqS5MMw9MeO4/ax+ZM=
X-Google-Smtp-Source: AGHT+IEUgjWxiR6dkM9lZFiJAOmzDsXGGIyhZG7pFpddaDZFMmMnfvsNvFqf3/9xUfjGeq0ImOU3WA==
X-Received: by 2002:a05:6122:181e:b0:4f5:261a:bdc4 with SMTP id 71dfb90a1353d-4f912bc71efmr2958100e0c.2.1723228721244;
        Fri, 09 Aug 2024 11:38:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c291bc6sm294421cf.96.2024.08.09.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:38:40 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:38:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 09/16] fanotify: allow to set errno in FAN_DENY
 permission response
Message-ID: <20240809183839.GB772468@perftesting>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <a28e072cd17de44133b5bce5b8ee6db880523ebb.1723144881.git.josef@toxicpanda.com>
 <20240809-seemeilen-rundum-2096794f9851@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-seemeilen-rundum-2096794f9851@brauner>

On Fri, Aug 09, 2024 at 02:06:56PM +0200, Christian Brauner wrote:
> On Thu, Aug 08, 2024 at 03:27:11PM GMT, Josef Bacik wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> > 
> > With FAN_DENY response, user trying to perform the filesystem operation
> > gets an error with errno set to EPERM.
> > 
> > It is useful for hierarchical storage management (HSM) service to be able
> > to deny access for reasons more diverse than EPERM, for example EAGAIN,
> > if HSM could retry the operation later.
> > 
> > Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
> > to permission events with the response value FAN_DENY_ERRNO(errno),
> > instead of FAN_DENY to return a custom error.
> > 
> > Limit custom error values to errors expected on read(2)/write(2) and
> > open(2) of regular files. This list could be extended in the future.
> > Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
> > writing a response to an fanotify group fd with a value of FAN_NOFD in
> > the fd field of the response.
> > 
> > The change in fanotify_response is backward compatible, because errno is
> > written in the high 8 bits of the 32bit response field and old kernels
> > reject respose value with high bits set.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c      | 18 ++++++++++-----
> >  fs/notify/fanotify/fanotify.h      | 10 +++++++++
> >  fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++++++-----
> >  include/linux/fanotify.h           |  5 ++++-
> >  include/uapi/linux/fanotify.h      |  7 ++++++
> >  5 files changed, 65 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 4e8dce39fa8f..1cbf41b34080 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -224,7 +224,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
> >  				 struct fanotify_perm_event *event,
> >  				 struct fsnotify_iter_info *iter_info)
> >  {
> > -	int ret;
> > +	int ret, errno;
> > +	u32 decision;
> >  
> >  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> >  
> > @@ -257,20 +258,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
> >  		goto out;
> >  	}
> >  
> > +	decision = fanotify_get_response_decision(event->response);
> >  	/* userspace responded, convert to something usable */
> > -	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
> > +	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
> >  	case FAN_ALLOW:
> >  		ret = 0;
> >  		break;
> >  	case FAN_DENY:
> > +		/* Check custom errno from pre-content events */
> > +		errno = fanotify_get_response_errno(event->response);
> 
> Fwiw, you're fetching from event->response again but have already
> stashed it in @decision earlier. Probably just an oversight.
> 

Decision is the part that has the errno masked off, event->response is the full
mask which will have the errno set in the upper bits, so we have to do the
separate call with event->response to get the errno.  Thanks,

Josef

