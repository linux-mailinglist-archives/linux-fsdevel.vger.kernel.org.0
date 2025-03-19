Return-Path: <linux-fsdevel+bounces-44452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8049A693A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54638460DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB51D7E5C;
	Wed, 19 Mar 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VHEtRE82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E341C3BF1
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398347; cv=none; b=VhkNX+3ImnGdT73QjWKsRzVB3+pjWnzGUbayIQ091iRjPZV0pQ85jH9bTCrVdSumKxpPpdG7qAmldwo7XvKhgvgDiGbWYIJmIyjDrFUQi6iN3iZTiF1CoNUBBo44DRvFYSJ6WQMbEJUrxV3JM8EXAMmiE+6gBEULo7/lBavcMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398347; c=relaxed/simple;
	bh=DecHoeVvuZPf1798B6ofl0KEVe3MSa1ULHgC3f/pgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twqEsUUtGlYOTpBzBqFk9tnKKPa4CLpCiUhDF9Fvq6rSXdc4qA3mqkmaCHqez8YDC+swxHHwX3qETtUfgF7jjaHhihaGcvpCKOfWTNaYMSd88kDnKbmUMQsvKE5cjNd5ufCxNBB2zjhkPQ6qie5Wv6CRJgX+1YSYhEn4tVGnLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VHEtRE82; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22359001f1aso27942955ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742398343; x=1743003143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=VHEtRE82dpW80KhRY2ibVphmyZxSCwFrNEb47iibxNFEoqgYfCoeXH/9f1C+JxXAbT
         PkNtN2RH9ixJHgDd4g2ZrCjIHzNSfTmQkkSzMR6hR2OcmL3z96OUpkeVdVjnkLkJRjuH
         YqVxFgFMdB3x7wAuV0MHrb7qir5rwBztA8CPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398343; x=1743003143;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn9F1c5LdYViJ/xCFgH69JHzYJf0t1bW8IYQTve3Il0=;
        b=IWGFvy04w+QsESZfe58Hz10y/d9yqBoiXlFoX0UGq82AS2ulm+OkoksY08VLhabcFx
         THGywwBKJfjc1UlFcYFnLfS3ReCpXknSCclZ7rdIZRVM8AybCclprntPmsFUhrAy6o6B
         qzFEOX+RuMCpnoi6XK04cRvUvqEuqU31l2u5HiiUTMlqCNBdLrXo3qefRFZ+I9zvsijz
         T0G6BHw5vfk4PpKBZAHqX3oCSQAU7R/tqDopPU+P1JnKqR+XjOtemD1t6GS/0K6Gl1w1
         oOAjDxR0DDA9znGqJb3MF29TQBkvNrXmDVpJW8gRMeu97Sg+BFZs09VKSfCC+RrZlmnj
         oPPg==
X-Forwarded-Encrypted: i=1; AJvYcCWe/0Q5GYt/RtTjcHaBoMXWEvZMJyFkviGk8me18sSZOdCbbwB5MIa/JDjAKYzigxxj0uOKJxjdOt1dCjt+@vger.kernel.org
X-Gm-Message-State: AOJu0YysBcBCj0mCvER5FRD0x4e40Jva3przAGNe3EvtvwHwElmG4bm9
	cJmP+Fs/Hoch1HsPwJZrhMIS/gSa4w/ZZsA4/MKFTyOltiv8v28sjFpn4PGOlR8=
X-Gm-Gg: ASbGnctwikFkkPxwtyHzNzn3/rAuKmHvA/p9jUX5aoXREhaSTgVMM+AY3Th2yajXmWl
	REjGgL1yyxNLfH82elDubEB54pV5r5whkOFlOM6qr7KCWWQ/LZZuQenz0nHHoFjJOpmdEHu8A+t
	kNZqYKSrMnOhcaP43F/nmpqbZh3NBDxr6+0FOHeKjzfMuV3O+/aSWuk7IPOyO9I6G1b1icrQ1u2
	reRaQ0abIjFrA1LSwZeto0yu/RxKCQbZX20RUZtGEIWnKBklvD/vFr74d4UlPsEklJZJ1C9vyGI
	8Z5ANT3sSGQKGO3vlVnmXLZuxS1mzPfoD3RH3m+LpFCXqWJZvIIT1sH1cfUfE1lqd/nuD0jPF1c
	7HaZckKj93Ic6bKcC8ZsR7DWlkyo=
X-Google-Smtp-Source: AGHT+IE928EvL/A0pSVSiRkpQ590uJxm0F/MyNYT3ARIPaWUxA9t+V2zDq6An5Z8ZPQuHl4hSSFFbg==
X-Received: by 2002:a05:6a20:a111:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fbed315b41mr5956837637.36.1742398343445;
        Wed, 19 Mar 2025 08:32:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea96e58sm11106959a12.78.2025.03.19.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:32:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:32:19 -0700
From: Joe Damato <jdamato@fastly.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9p6oFlHxkYvUA8N@infradead.org>

On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> > One way to fix this is to add zerocopy notifications to sendfile similar
> > to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> > extensive work done by Pavel [1].
> 
> What is a "zerocopy notification" 

See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
sendmsg and passes MSG_ZEROCOPY a completion notification is added
to the error queue. The user app can poll for these to find out when
the TX has completed and the buffer it passed to the kernel can be
overwritten.

My series provides the same functionality via splice and sendfile2.

[1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html

> and why aren't you simply plugging this into io_uring and generate
> a CQE so that it works like all other asynchronous operations?

I linked to the iouring work that Pavel did in the cover letter.
Please take a look.

That work refactored the internals of how zerocopy completion
notifications are wired up, allowing other pieces of code to use the
same infrastructure and extend it, if needed.

My series is using the same internals that iouring (and others) use
to generate zerocopy completion notifications. Unlike iouring,
though, I don't need a fully customized implementation with a new
user API for harvesting completion events; I can use the existing
mechanism already in the kernel that user apps already use for
sendmsg (the error queue, as explained above and in the
MSG_ZEROCOPY documentation).

Let me know if that answers your question or if you have other
questions.

Thanks,
Joe

