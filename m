Return-Path: <linux-fsdevel+bounces-25707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCC94F609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8B1F22A83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E01189511;
	Mon, 12 Aug 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="P+xa8Mr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9016EB54
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484782; cv=none; b=gCnXlMo0MvDrW3OGlj4KjfCVphexOXBr7almPeKGbUY/6ozNq3KYZaMED1sN3MKT+JLmK51u368f6hG9IFc5eI6gzf6zIUnrdTZYwzkERkDmfB0yJOGUJI2chU10eMmdGDM+Kgfbft9V2YAjMFPvOB86hlpT76kLE6bw4yZ5lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484782; c=relaxed/simple;
	bh=8l2gricLljthAnZTTnctVq1KM/p9N8Gxlk87y2mpoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAqPnB4MF4MXGn7nVzg+VXlJmQsefOvzNDhUUDCGLVSm60OWirKdSj0Zj7UP6J1BlLrIaonvraVJghMlIKb2I4aq9xxK9lJlWXd28SfVNlk9Cei+7AWrAz2hlQl8AxkH/9n752VprKgypWW2+ry+SATvpoqEvVi7MD3lfZRACPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=P+xa8Mr9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2cb7d562so46720271fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723484779; x=1724089579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1jyChJiJKCmkSfgrnMvnEFtALUoiz6H3cwnuWBsxT8=;
        b=P+xa8Mr9PiH3Nil8jp2JLLgICAYfWDve/2yv0PmdZyCAPikpSuNszGwM5ten48IGNP
         gn+qJ5OT8YaKu4Kze8GdxhRSlJiVyfktV2GD8HDpTh4KCDDLghb+fouJU3+zVpTBkCDs
         0yn8DBAhofHanygwGo7TmmO8DKvH6LKa551Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484779; x=1724089579;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1jyChJiJKCmkSfgrnMvnEFtALUoiz6H3cwnuWBsxT8=;
        b=d9WV191qA2eV9VHP67JdXowbv/9n0qSMFhwmKjo6IPAZVxwrYx5++X375RPlp+vj6w
         mjXUxXATawc5DzbLDQv+EIlBGwuprbN0khHfLfImjOEIdN3puegG9IW8QFgUym3WAE9+
         yIcn0TS+LdDBJkhdcIaivS4fRtWcu1O4SHmvwnA/yyORzja2gvyBhyw16jg6F5cUR2Bt
         gLSilm39XAFQOSR+rMG7dFFpLIwBJg9869xk5sSFKVJO6+daYttW3zYnjX2lFIXh838C
         pPy96EL4HZELgTTQIaMR1rpXxdPkejDkVP8S76Jd8XXwO0ybws/u4WXYW4dHs4eMkmSL
         AqMw==
X-Forwarded-Encrypted: i=1; AJvYcCXoeqMY5KsBBX2xD2pwI6P8grenhEhIlQUpertKfJ93cWJJv6f18t2sUGIsf/vwM/zpN2gt3JrI2sFDlZ8CbusUKLE/GXPETUKaL+HhyQ==
X-Gm-Message-State: AOJu0YxJd1+F9WxMdqV3zzFWzPLrzgV/S+1U0hEoL+rTh5ic+jHaWHF7
	nEmSPkiIPBV7aMmdhS7dDpRbRtsIECmDQLMA+l0QttMzI28BxXkxGQnqsKylZbw=
X-Google-Smtp-Source: AGHT+IF1vOhqNLNMr5sJRpH4hayHHgjsz6++vKRWoz1iFhdnqkOWUKnsI4efNLThl3n6KHNk41H/xA==
X-Received: by 2002:a2e:9d0a:0:b0:2f0:1b87:9090 with SMTP id 38308e7fff4ca-2f2b7156fedmr7522451fa.29.1723484778635;
        Mon, 12 Aug 2024 10:46:18 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4293e41496dsm173490805e9.23.2024.08.12.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:46:18 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:46:16 +0100
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
Message-ID: <ZrpKaPcAow7vvClC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-5-jdamato@fastly.com>
 <ZroL54bAzdR-Vr4d@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZroL54bAzdR-Vr4d@infradead.org>

On Mon, Aug 12, 2024 at 06:19:35AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 12:57:07PM +0000, Joe Damato wrote:
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > 
> > Setting prefer_busy_poll now leads to an effectively nonblocking
> > iteration though napi_busy_loop, even when busy_poll_usecs is 0.
> 
> Hardcoding calls to the networking code from VFS code seems like
> a bad idea.   Not that I disagree with the concept of disabling
> interrupts during busy polling, but this needs a proper abstraction
> through file_operations.

Thanks for the feedback; the code modified in the this patch was
already calling directly into the networking stack; we didn't add
that call. We added a check on another member of the eventpoll
structure, though.

In general: it may be appropriate for a better abstraction to exist
between fs/eventpoll.c and the networking stack as there are already
many calls into the networking stack from this code.

However, I think that is a much larger change that is not directly
related to what we're proposing, which is: a mechanism for more
efficient epoll-based busy poll which shows significant performance
improvements.

- Joe

