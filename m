Return-Path: <linux-fsdevel+bounces-25528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F694D1EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D48A1F2376D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5019755E;
	Fri,  9 Aug 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ODYrNe7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88319753F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212850; cv=none; b=sX5Q9NmGWoBshj49pQ9QasJfZCql8L5LCqOXGz3OaDk+6kn0oy8/g/fIjRjRKPkAsT6sZ4hLZjdvqCrq8jg+OVNyIyyH27w2sa+hGiR6MHGM9N0vn9TRWnSKTvJPLm7DFgFJH6QiYTtSNf32xlJfIADVi7Xntle/2bOYtUSprWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212850; c=relaxed/simple;
	bh=Qg6peh4W1uw0keiI+fBLVAXx38shr6oNqapP+0hqOSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5yIotNCNXMVn2XPFQHOl5CTufMgubTMquaDhec16k6uh4WzAxtUqqEZ9JbVlykefMUk5WovP0T84pUXwtyVt+r0lh4anxLcq99zQR+5IJNwFYhe2SIejlPwgMZCYndjxO8StzqERa7LEFHJB0xCrTovIZrBUo+UIxa7KoHF2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ODYrNe7g; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d3e93cceso290420385a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723212847; x=1723817647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqaU4YPFEFPDpzs7lhUNFHbREIXhMM3YN1rP0YBOnz0=;
        b=ODYrNe7gS+8FY/1cOHIY1BWqhxtCTjJKGW6zRGnFn4cQxcxl52cRpMHhjys3zoLIQ1
         BnkpePuBZWItU8F5lZM/JZ7uYfZaCSP6boqovwl56qlfc4kU6cDDYgb71JOpogQId0Hm
         iG7MIGaNtn0IXuha1h60DAmYW4r1Owu6LT16pXtGRqpDkdkwxDcR24jcrSWwMMHOzhCl
         wr7d4ze3yuZZftk3Rvazkaa5SDkMflx+TxZgvScXBX/Z6R8YIyzsTP0E9mvCL4M34Dt0
         n0iO2JOWH95kIgVR1YfmJqwEbIagE4sogAnN3J8DTmFcgMjpCH5C+x15/cUtKpR/NIq9
         OmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212847; x=1723817647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqaU4YPFEFPDpzs7lhUNFHbREIXhMM3YN1rP0YBOnz0=;
        b=Uc2g4UxDRrKmA/KwBSe/SeprPxajPVBnR1rZK65D49cYz9NE8j/W2CsyWvRnGaV8Dy
         7lDfKjKf7ETA8W9hilbI86kZ24wZEtTs7rxaG85ejuumMDdye0aB/U+N+9iOp6cxa/ni
         8OAgZ0v8trxAOYJuILNWWHLsKxkbs0KzEKYKQiIbiZPc1D+uvbhUln54rbKIVA/LkaW+
         dUFRJ8CHYMXajoWc8OdMxrfqkIVDA+iooojYNlcVTUOQk+RVYs+mHKEsoIjNmN0773Ib
         sL/xreGRWvthTipTy/HU90HFHkjcFLSgMQTH3dVWERmYO3BBEwidsJtY62ktJpMyWRr2
         q2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkS90cqSkKihKBXACIcc7Mt8RmKO7DeZJb/Pksb0zA6EXkMIcpU4KP1w+IlxBP8qB4BbUpylS2+8vewskZKQSlOBgWwjWNyGosda3WNQ==
X-Gm-Message-State: AOJu0Yz9rQOnDldmkMnHUkXjok8Tw0Rov8LkI5EJBlwF6eZ4TPdu/gZk
	7SDHNl09dTZmqDy7jRlWOP9Yb/z5Hk5tLZL9xKsDVU+Ct9GmElG4dUzFvM66PSI=
X-Google-Smtp-Source: AGHT+IFT+KF5iW1aowJACdjt8G3RckzwQvK6JrXZ1GVqd3fvEF1GJIW4kFtFzdJDQJxs+Zm/R8rhtw==
X-Received: by 2002:a05:620a:2991:b0:7a1:da71:e73a with SMTP id af79cd13be357-7a38245db34mr934984485a.2.1723212846746;
        Fri, 09 Aug 2024 07:14:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786f7680sm261656985a.133.2024.08.09.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:14:06 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:14:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for
 requests
Message-ID: <20240809141405.GA645452@perftesting>
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com>
 <20240808205006.GA625513@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808205006.GA625513@perftesting>

On Thu, Aug 08, 2024 at 04:50:06PM -0400, Josef Bacik wrote:
> On Thu, Aug 08, 2024 at 12:01:09PM -0700, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> > 
> > This commit adds a timeout option (in seconds) for requests. If the
> > timeout elapses before the server replies to the request, the request
> > will fail with -ETIME.
> > 
> > There are 3 possibilities for a request that times out:
> > a) The request times out before the request has been sent to userspace
> > b) The request times out after the request has been sent to userspace
> > and before it receives a reply from the server
> > c) The request times out after the request has been sent to userspace
> > and the server replies while the kernel is timing out the request
> > 
> > While a request timeout is being handled, there may be other handlers
> > running at the same time if:
> > a) the kernel is forwarding the request to the server
> > b) the kernel is processing the server's reply to the request
> > c) the request is being re-sent
> > d) the connection is aborting
> > e) the device is getting released
> > 
> > Proper synchronization must be added to ensure that the request is
> > handled correctly in all of these cases. To this effect, there is a new
> > FR_FINISHING bit added to the request flags, which is set atomically by
> > either the timeout handler (see fuse_request_timeout()) which is invoked
> > after the request timeout elapses or set by the request reply handler
> > (see dev_do_write()), whichever gets there first. If the reply handler
> > and the timeout handler are executing simultaneously and the reply handler
> > sets FR_FINISHING before the timeout handler, then the request will be
> > handled as if the timeout did not elapse. If the timeout handler sets
> > FR_FINISHING before the reply handler, then the request will fail with
> > -ETIME and the request will be cleaned up.
> > 
> > Currently, this is the refcount lifecycle of a request:
> > 
> > Synchronous request is created:
> > fuse_simple_request -> allocates request, sets refcount to 1
> >   __fuse_request_send -> acquires refcount
> >     queues request and waits for reply...
> > fuse_simple_request -> drops refcount
> > 
> > Background request is created:
> > fuse_simple_background -> allocates request, sets refcount to 1
> > 
> > Request is replied to:
> > fuse_dev_do_write
> >   fuse_request_end -> drops refcount on request
> > 
> > Proper acquires on the request reference must be added to ensure that the
> > timeout handler does not drop the last refcount on the request while
> > other handlers may be operating on the request. Please note that the
> > timeout handler may get invoked at any phase of the request's
> > lifetime (eg before the request has been forwarded to userspace, etc).
> > 
> > It is always guaranteed that there is a refcount on the request when the
> > timeout handler is executing. The timeout handler will be either
> > deactivated by the reply/abort/release handlers, or if the timeout
> > handler is concurrently executing on another CPU, the reply/abort/release
> > handlers will wait for the timeout handler to finish executing first before
> > it drops the final refcount on the request.
> > 
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 197 +++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h |  14 ++++
> >  fs/fuse/inode.c  |   7 ++
> >  3 files changed, 210 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 9eb191b5c4de..bcb9ff2156c0 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
> >  
> >  static struct kmem_cache *fuse_req_cachep;
> >  
> > +static void fuse_request_timeout(struct timer_list *timer);
> > +
> >  static struct fuse_dev *fuse_get_dev(struct file *file)
> >  {
> >  	/*
> > @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
> >  	refcount_set(&req->count, 1);
> >  	__set_bit(FR_PENDING, &req->flags);
> >  	req->fm = fm;
> > +	if (fm->fc->req_timeout)
> > +		timer_setup(&req->timer, fuse_request_timeout, 0);
> >  }
> >  
> >  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
> > @@ -277,7 +281,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >   * the 'end' callback is called if given, else the reference to the
> >   * request is released
> >   */
> > -void fuse_request_end(struct fuse_req *req)
> > +static void do_fuse_request_end(struct fuse_req *req)
> >  {
> >  	struct fuse_mount *fm = req->fm;
> >  	struct fuse_conn *fc = fm->fc;
> > @@ -296,8 +300,6 @@ void fuse_request_end(struct fuse_req *req)
> >  		list_del_init(&req->intr_entry);
> >  		spin_unlock(&fiq->lock);
> >  	}
> > -	WARN_ON(test_bit(FR_PENDING, &req->flags));
> > -	WARN_ON(test_bit(FR_SENT, &req->flags));
> >  	if (test_bit(FR_BACKGROUND, &req->flags)) {
> >  		spin_lock(&fc->bg_lock);
> >  		clear_bit(FR_BACKGROUND, &req->flags);
> > @@ -329,8 +331,104 @@ void fuse_request_end(struct fuse_req *req)
> >  put_request:
> >  	fuse_put_request(req);
> >  }
> > +
> > +void fuse_request_end(struct fuse_req *req)
> > +{
> > +	WARN_ON(test_bit(FR_PENDING, &req->flags));
> > +	WARN_ON(test_bit(FR_SENT, &req->flags));
> > +
> > +	if (req->timer.function)
> > +		timer_delete_sync(&req->timer);
> 
> This becomes just timer_delete_sync();
> 

Err ignore this, I had another comment about always initializing the timer, but
I realized why you're doing what you're doing and so this isn't relevant.
Thanks,

Josef

