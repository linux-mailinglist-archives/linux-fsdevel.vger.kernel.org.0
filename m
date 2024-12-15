Return-Path: <linux-fsdevel+bounces-37433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24449F2299
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 09:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4F18868F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1245028;
	Sun, 15 Dec 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBeG7yW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B014A90
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734251109; cv=none; b=rZiPou1SvQe6aieNW06aWKYNKjD2yBjYqqZajJr3jyx6J8DX1a4NZkFNot0TtXh/iJl0TSKDkYC4gFNr1mEd9D8Qowh7iKU7cLgVx0J0GuN3hE0QYwrls7PsM92W8u64AfFj/eKQUcnl43+u26sFiy95ugoPaIGMq3vNulxrjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734251109; c=relaxed/simple;
	bh=/RRpAIorrR9W8qiFE/VsFRHK0jM3KdYJOXov5bG4Opo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coxcsm9SUPvgvsK8GXMd1AqZBx53zUfnJAeoYDpPB7x4uw4/nsszkMCJG6El5HMADEyf+mwZRepEZ0gOiMSWvLSvbH5Kc2ryRxgTZwffPE+iSL4NJ9ITkBwTJpZ/BK+ekyM85C6f+aIcAZAsDDRIooRfLcszP1IAIx2pXpY3YdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dBeG7yW9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so28536955ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734251107; x=1734855907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvUY+0mLgbM2oUc35BKRlXe/ANqfeVep8x6O5EGMn3k=;
        b=dBeG7yW9o3OWxQF+pvLQMT85xA0z1gZ5uFudTpbvNCW4MeIpaC+H+3uXQ69J/xqjwB
         UQUrpy/vElQ6Z/LWSodULfx1FjHO2x9WRlSOW5O1H1BqkGPDErC1+HJUi888O2EZRYUK
         l3QRLXVd5rLYLd+gYzeafuAG9hXv8TralKL6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734251107; x=1734855907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvUY+0mLgbM2oUc35BKRlXe/ANqfeVep8x6O5EGMn3k=;
        b=kCbe8lBLeZJluy8/dWi2CTywwIFVQOc9tiCx+sO0P/ewE4yWrQAFMsrFe3TTHZG3If
         HhSBB61zzPxjSvk3o99GX1NYHYNyKq0T0SX7VqMdkqTivfuBKPh8zaH5AnC9BKMG7Lwc
         WkMXWpn046V0ZnPitLpKQmXtSyXeK9PU7n3CkB6iNYrjgrN/vFjqURlclSvD65H0FQye
         LrD/Y+smuchim8MjExGt0Qe8MvTXnuLTq6UaO+8oBQw1Up2PN061SlaDZC7QQmcX6o0y
         6OJeEnhyIAW0SeM88kS44gDczNBFuUNpXjzrIwFRvrElLy/eEP01+5rnKI5tMm3+RXnn
         EYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVhjPovJDYeeegG0RFMkVIE2N1isVZ2lWpi5GW9SLFaMBku1glu+Bhg8AUOjf3U0J+BTv6VQGHs4MjmCcPl@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPHTIMmJNZZyOg+ImynUW2F5JZD9KUuMJ5rW2eSYgISoKicP2
	7FpkgrNoj6A2zyCG8tRiefQRoM1S59FmD3rUIfdHa050xpuQJ2swcsxq9PMzqg==
X-Gm-Gg: ASbGncuNS8A/X/qs41RdF15DWulq8nGxYhnJYWstGBTyHN0/W/PnB4Kx4Du9NnSyRfd
	6KXsVOo+QDQO73BLcV8A9lNsyYXP7z9NGnH9IysKVdrN23ib9oG6OSr7jjFGgjiupRaVBnU5SH3
	ec8YwdAuiMbgeyiOqJ17UXw6P1HYbAdGmsDF7oKrMOpa83UDNo3vQkZ9kWNjO3r9RgY3E6p9ama
	1THq67CChROab0Y3HUfbb6cdAQfeMRsGoKHntcCrflgsAJu2dPK+la7hR70zjO5u7QblIZVLXSl
	7wl6j3cHd5P2hdkbZ6/28w==
X-Google-Smtp-Source: AGHT+IHW7mt39wsDZPeZJPrYAAozbu2piw4GdY/OYseI5/OXp61rSey+1M69iB0GvnnPsKmOjZhPmw==
X-Received: by 2002:a17:902:cccb:b0:218:a4ea:a786 with SMTP id d9443c01a7336-218a4eaaaadmr64268935ad.53.1734251107148;
        Sun, 15 Dec 2024 00:25:07 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e68587sm22857035ad.249.2024.12.15.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 00:25:06 -0800 (PST)
Date: Sun, 15 Dec 2024 17:25:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, senozhatsky@chromium.org, 
	tfiga@chromium.org, bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for
 requests
Message-ID: <rw7ictyycbqrxuosmr2irzqgtxyfv2pprgvps6tjihbypnxcyc@qqkpoiq65ly3>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com>
 <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>

On (24/12/14 07:09), Jeff Layton wrote:
> > +void fuse_check_timeout(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(work);
> > +	struct fuse_conn *fc = container_of(dwork, struct fuse_conn,
> > +					    timeout.work);
> > +	struct fuse_iqueue *fiq = &fc->iq;
> > +	struct fuse_req *req;
> > +	struct fuse_dev *fud;
> > +	struct fuse_pqueue *fpq;
> > +	bool expired = false;
> > +	int i;
> > +
[..]
> > +
> > +fpq_abort:
> > +	spin_unlock(&fpq->lock);
> > +	spin_unlock(&fc->lock);
> > +abort_conn:
> > +	fuse_abort_conn(fc);
> > +}
> > +
> > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >  		spin_unlock(&fc->lock);
> >  
> >  		end_requests(&to_end);
> > +
> > +		if (fc->timeout.req_timeout)
> > +			cancel_delayed_work(&fc->timeout.work);
> 
> As Sergey pointed out, this should be a cancel_delayed_work_sync().

My worry here is that fuse_abort_conn() can also be called from the
deferred work handler, I'm not sure if we can cancel_delayed_work_sync()
from within the same WQ context, sounds deadlock-ish:

WQ -> fuse_check_timeout() -> fuse_abort_conn() -> cancel_delayed_work_sync()

When fuse_abort_conn() is called from somewhere else (umount, etc.) then
we can safely sync(), but fuse_check_timeout() is different.

Maybe fuse_abort_conn() can become __fuse_abort_conn(), which
fuse_check_timeout() will call directly, for the rest fuse_abort_conn()
can be something like:

	static void __fuse_abort_conn()
	{
		....
	}

	void fuse_abort_conn()
	{
		cancel_delayed_work_sync()
		__fuse_abort_conn();
	}

