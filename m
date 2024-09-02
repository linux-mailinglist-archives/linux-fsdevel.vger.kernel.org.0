Return-Path: <linux-fsdevel+bounces-28222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486A968371
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FFD2818EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25C1D2797;
	Mon,  2 Sep 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DKMsorey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861C1D1F6E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269987; cv=none; b=fyNHGFLuYllbWWeTVeJbrefK2sLU1N1l+AXiKyHumOhF//3UabsEe3YU6ZiE3bT6ekbvRpdTr/rkoi18pGPs2PgnKGyRerJ3OLO6LnQzH0AQEEhXysQXP3XIL9r1ulAC8jDSfskVn01xCoyn9phD8/mFZ7OUU2/nVmKDMr6poiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269987; c=relaxed/simple;
	bh=+vKy5Bgi2ilsJQBOHU1T90A5J7NRotgh5xEpOxt0vFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq8ta2UbHwxfcV5YliNABhXv7BsZPAcv3yb9LMLsl07usFk5FuS/UTqpJKt1KZAwDX8SyuWTZsgg0mv9mufyo9fmR0U1cmpQOIMMooc6xgDj4vGqVVKF+9AMjqc9xGSNest60S/bcaocoIUqW5jrnUOpL8CIGMNTO+FOTki03Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DKMsorey; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53343bf5eddso5284109e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725269983; x=1725874783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+b2Tu1YlvpDpDetKigSg2I/Ak7ZaGYzocV3AQmvxK6U=;
        b=DKMsorey3xyKISF0wmzSkFnSm59ZijqpUHAERajTyFwQuzkbzBRUzePo9fP4GQgEaG
         x3tLHeiw8IuTzeYKTuEXcOLHokqhmyANzBNXwH5bs6lSdN+Nmvk3WzEdGAUVzw6/i3A1
         DhxQhrfYdAqAVhrjZt1JUdw/hZoLEe/+mmPqzqXNLZ+cw/AtX1Ai+KDK82XC2JFQMFJD
         IIDOdq4YRBALJysNDkmjmBEHNTEGdUHY9Ja/AgiOKUsq74B+1yKFbaA+GerrZoLnnu/M
         +bwT/j+JChCtRghEOOZPXdWXADyNKybi6zYqIEycLYwdUXPqwasyNSK+gX0P/aDRcxZl
         3LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269983; x=1725874783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b2Tu1YlvpDpDetKigSg2I/Ak7ZaGYzocV3AQmvxK6U=;
        b=oetS56Eff7OMCyU2mwteNyXmhLHSH99qsgyO25E2FEdh52EgwK/4JYRZjo5UaBjNXe
         /niAV6kv6Bew2tmpJ0NJUq5rHMI4hDg7UPW7qDRJiDPB2QzyfZR6PPh0at7jMGpUa4vr
         oxCwiz6JtPdFuAMW/1Pyl383LsK/b6q+3md7EKpagDv9QdGlvnOk7Da56pPFXb0rYgIL
         7rPI1hFhBBcnXcrQM9TOfS+JsSJYwkYJwd3pxT/pjDOAqm/cPtc5QGRPsmqEd9GT0VRG
         OzI1BLHxNUs5cpFC5QrSz0E6Qewui4NPTOjg0h+RG6hChv8IXW2Mot4rv9TyxSlWihSO
         3FJw==
X-Forwarded-Encrypted: i=1; AJvYcCXfWX2ADWPeNmsU4jWtZmslqu9TZ6sDa4TUfInu4/YkIHcazGTjkWIFXv7e0RjSe3HiIv+n06OcTsck0qtY@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaHw6jZal2xM6OhGZEkfhstBIqy3EQhfpQ4PlpxugaHK8xXtX
	/mAaMw8weSi0CJSXFfvaqzbbI6/ptidbTzCcoorAeLpBtNNVgOTStkMHvAP/bm8=
X-Google-Smtp-Source: AGHT+IHZM5waMu+X5FhE3mW4B0crx++9U1PxnK3hjmktHHYE/8KgZSZDyo13u7RHZxzfN09KFJCN9Q==
X-Received: by 2002:a05:6512:ea0:b0:52e:97dd:327b with SMTP id 2adb3069b0e04-53546b38f94mr5722464e87.23.1725269982952;
        Mon, 02 Sep 2024 02:39:42 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891da22bsm533179266b.182.2024.09.02.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:39:42 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:39:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtWH3SkiIEed4NDc@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>

On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > [...]
> > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > something that we can't guarantee won't happen in the wild - we WARN()
> > > and try to handle the error as best we can.
> > 
> > We have discussed that in a different email thread. And I have to say
> > that I am not convinced that returning NULL makes a broken code much
> > better. Why? Because we can expect that broken NOFAIL users will not have a
> > error checking path. Even valid NOFAIL users will not have one because
> > they _know_ they do not have a different than retry for ever recovery
> > path. 
> 
> You mean where I asked you for a link to the discussion and rationale
> you claimed had happened? Still waiting on that

I am not your assistent to be tasked and search through lore archives.
Find one if you need that.

Anyway, if you read the email and even tried to understand what is
written there rather than immediately started shouting a response then
you would have noticed I have put actual arguments here. You are free to
disagree with them and lay down your arguments. You have decided to

[...]

> Yeah, enough of this insanity.

so I do not think you are able to do that. Again...
-- 
Michal Hocko
SUSE Labs

