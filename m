Return-Path: <linux-fsdevel+bounces-47546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5018A9FD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AC57AB275
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCB212B1F;
	Mon, 28 Apr 2025 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="a2frI5ub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545420B7FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880082; cv=none; b=IKYsTbz75l4tIYRMmsiaawHm7QiGRRsUrY8SN8GMF754C4pRpx8BrKZ0IGWu4yN+7Uug69SnOoUSWE7OF24V5o+BrHGG2pRGeiw5rKqd4ZkUxlMt6KVmKBvYw7WwO0IMRenQtRBibOI6KUAPoIiWD0erSYNcbpzHvJgX3gBmvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880082; c=relaxed/simple;
	bh=AlvOVXFXCRCq8I8E0me/Q1kPoZ1O1bXqgITfhcvz9gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvyqki35HtcEDvRTEuoLQ3Ngq7jXsXl/kAlNzdyWcKIcM9GPszCvlVsA2/YtaklBT2srMevGua77Mi8UcI7h7UHwhb5GdLp6MPzBsah6gcP08Enbmxzxj4dOyVm/IEyoerdQBH/WODzTOtF6jpBeyhBVtxnZqoKAj0T8ItOh8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=a2frI5ub; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227914acd20so54341165ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745880080; x=1746484880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1zF7iiKiJhxVauo67vkFbkwxJz6M/6/Hp9e+j/XY2M=;
        b=a2frI5ubmyU9Fp1/j9NfmDmV+CfZ3cjU9Hh1jSHcBQSnZb8bjBahBQa4YH5iFO/XCh
         urS7Ug1dSL+wvCnhvHH0X+jx3W97JZG8Ce+lRj8Da27rVAby0w6WZ//xuFy0xpoDrsLe
         gdLM4fG+Ivdk28eH1siPa0DYHf54mwG75DdOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745880080; x=1746484880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1zF7iiKiJhxVauo67vkFbkwxJz6M/6/Hp9e+j/XY2M=;
        b=XsJz9z/KWoq06IZAl4Vzhm616SEx+smgz0gs5D/A/eTvtNw6ThLieR4Sy1+ubQlHU0
         i5TzUruH0k9JNg+H4MmE5FwGHebdUuGUUpOLtv/FGru5JXtYN20eJQRGCM/mlM2Wv3OU
         W+XQviR1KslcPhwyIW4lkxn+hJi+EJVs5t9eyDVZ4rTURphq74ClhsRbiaLE5L6cpVd3
         D15nqIUe1GWHBcQCiphPvUTlBrtuhgM0v0J8pPVR14SHIvg/XK566zBCb6cHVt4P/4eo
         pX5qs2TsUtExw+20k/K1zAgvM7LBaN2R6/hKrtCpdUxDjDiF76pMOyc6G2a6e//wnL8x
         /p7w==
X-Forwarded-Encrypted: i=1; AJvYcCVPOZPBdHaNx4IqilgJdwzD40sjlOTHUIL1rirEPyg90NezMlbba2weQHZYM3mp68/eW8NNx8980CTiGXSF@vger.kernel.org
X-Gm-Message-State: AOJu0YxHl84Nr35jKktVraEAVSgCG/fKTgzfXWeKIum0r8z0Jofe7E9i
	fT+oS04tjq1mlvokvBOEvzgsN+IPamBNJAxL9W4Jv4J7lJNXCjXUkFSOnS/sjpE=
X-Gm-Gg: ASbGncv96SRlshOyQXwNrNrl4U9JZjm1CZgQFnh1GocUeLcs+MxFFhpZEIsWYC4AgpZ
	oM9e3+pcWiBbYzoeMEpAyYstHKkfflDgaSyN/s+nQiWwKJBZGBKK1NqVegG/uYvvb4GIYEQav8j
	XfO2P/gMqbVibDcTrgcfYmBDGbXYIoK0v4isMWRw8Y6KH+B/NBYhcNudxCVVCVpSabh+XfFysCK
	ykTy0A4HhER4ZWEaB/xzmoSTGgCrnCv8nn8x+negIyKsQJ1BZCzNbylGP9SvWMgPtcGvQhw4zgb
	PtON1Wa6VGNBcnvNJxN/9MRdACVcMqw69sJsCfm5pnhsK8RymqQHBS6/ofMCClCfjZsovBecPMP
	ez6Ka9jE=
X-Google-Smtp-Source: AGHT+IGs8v7qFjLt5uguqm0k7RJ6lOeFhXTFHUcr3VX560dCyFuGMIu3yj7cSKfJemZbK13XI+wmKA==
X-Received: by 2002:a17:902:f143:b0:223:607c:1d99 with SMTP id d9443c01a7336-22de6b650e2mr14854735ad.0.1745880080181;
        Mon, 28 Apr 2025 15:41:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4e0cb15sm89249515ad.106.2025.04.28.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:41:19 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:41:17 -0700
From: Joe Damato <jdamato@fastly.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <aBAEDdvoazY6UGbS@LQ3V64L9R2>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
 <aA-xutxtw3jd00Bz@LQ3V64L9R2>
 <aBAB_4gQ6O_haAjp@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAB_4gQ6O_haAjp@google.com>

On Mon, Apr 28, 2025 at 10:32:31PM +0000, Carlos Llamas wrote:
> On Mon, Apr 28, 2025 at 09:50:02AM -0700, Joe Damato wrote:
> > Thank you for spotting that and sorry for the trouble.
> 
> This was also flagged by our Android's epoll_pwait2 tests here:
> https://android.googlesource.com/platform/bionic/+/refs/heads/main/tests/sys_epoll_test.cpp
> They would all timeout, so the hang reported by Christian fits.
> 
> 
> > Christian / Jan what would be the correct way for me to deal with
> > this? Would it be to post a v3 (re-submitting the patch in its
> > entirety) or to post a new patch that fixes the original and lists
> > the commit sha from vfs.fixes with a Fixes tag ?
> 
> The original commit has landed in mainline already, so it needs to be
> new patch at this point. If if helps, here is the tag:
> Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
> 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 4bc264b854c4..1a5d1147f082 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> > 
> >                 write_unlock_irq(&ep->lock);
> > 
> > -               if (!eavail && ep_schedule_timeout(to))
> > +               if (!ep_schedule_timeout(to))
> > +                       timed_out = 1;
> > +               else if (!eavail)
> >                         timed_out = !schedule_hrtimeout_range(to, slack,
> >                                                               HRTIMER_MODE_ABS);
> >                 __set_current_state(TASK_RUNNING);
> 
> I've ran your change through our internal CI and I confirm it fixes the
> hangs seen on our end. If you send the fix feel free to add:
> 
> Tested-by: Carlos Llamas <cmllamas@google.com>

Thanks, will do.

I was waiting to hear back from Christian / Jan if they are OK with
the proposed fix before submitting something, but glad to hear it
fixes the issue for you. Sorry for the trouble.

