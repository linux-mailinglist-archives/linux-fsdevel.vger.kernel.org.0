Return-Path: <linux-fsdevel+bounces-44726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1ACA6C00A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECE61894153
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87D22C35D;
	Fri, 21 Mar 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MZHWkbQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42A13B59B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575000; cv=none; b=gmwzkM76QPyE4Ac26ER8ES+/CmwriAE0WO5bILoazP/SCuI9gMsBGLk2MwTkGewnrFWcbtzye/NYZBOtRntUR3QrQky7VjPoReC13j70zcqIOH2Du5GRAJAZFnV8YO4WlFQ6Yhu+9Pv7xeGbAWjY72pLCXi2Tp2YfnpoxvIKuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575000; c=relaxed/simple;
	bh=Hjm+6X18HfhpHIGsOF0Wa+HjL7J2VCrd/SOk7TvJe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwL/5JTR2wb0SmC3G7XKROJVQm+he+OoShpp5eN2E276h9HqLbdydkreJ+MTxqH0Lvt/fLaqtIBMlbGRr1j1AJscPy2+FMAyI4FRQIOneZBQkanESnW5/P8wAkYRk3w+NsvZ+yGO3VAhBd0OdPwI3hrtLQb4esb7wk/B2c5HfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MZHWkbQV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22398e09e39so47542055ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742574999; x=1743179799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=MZHWkbQV4x7bg/O4wFFFfRPlZtESaA0v8NXS4bwNrJ6AjgL6ju53tkdph3LJaiNMme
         Uzvt2rfsKBGYwXhkxusFMsVdUZtocME/uedeyElNWYuFM0pXYRhGn+chWuHm1avPkY+e
         bLTWDD3vMSIqEuSER+745abq7dnQ3YJWC0/HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574999; x=1743179799;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YALLnLfNqwU57i7wtFxN8i/4pwzBbw+w8xRGUYxzetU=;
        b=YaFUKEIftzBd9NPhQLjv1ToM/5+6CyW4j9KCtoYJMBJZBKviecfpDVkOa969jBxFGS
         wml7gG4nTD7dEn2XoYFEPerDIuBE9ndli2eLDgy0JMcw+nkmnB0InKw7AwnbFo4XCYYz
         mMTHPJgcCEuNXI2E84Rt0H/sgSfOF8DegRJu04VW5ksU1ci0dHcoE19gLSB22ISDN/zv
         zHyJPkSqNeGwhrPMM1KL5XESK4AUvFMHKW1trydGoZrDuWuexD7fb6VUe9A11vxrJJVH
         nPS1+MMx7t/Jg74EEsYyw2rCkhf0WlmZWBgzCDqdkH9l/H+Cq7QTV1W+pwpFpZ6MtfUu
         28aA==
X-Forwarded-Encrypted: i=1; AJvYcCXfG/3Nhcyeu7pnRO9xmTBJLPTS1J+0QpKxDFwUXaJQw0R7TNQN4PC8QeuTerLKEcHca//AEeNHfS4qrFk6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv52GvjUdMWVmu2VE4onM7Uxgb9CM5dXlmfxWd15p1gryxRbOn
	TvFjPPBpgRE1SYWzR60/gDESPEbhEA0Sp7AnJv2X0U93dWMu5x1DAZQIsG21AW8=
X-Gm-Gg: ASbGncv9XwUe62egprAw+xWsgkZVJZxUk0Hee05Xu5API9IQdujd9SpScLoHZ+hELrz
	RVXtsb5ir4X1eSESLgnLo0csaepuC5j1AlfwY1i8ewDJtfHhFOlWIBBk1f4HZUO6A55eyrIe/0c
	HdKK7BfQQXlM0d6/tlyK6Om6xkdLjlKDhJ08Z/K/o/Mov1IpGe+f1WRu8yazXqdbFMhnba8iOHI
	75mik1YvFJ21Qn+mkMRXkambE+PXSWyVUKyV5ZiMO8RLgcnQeDqNe6N4Xmv0SqlhVSqpmiAbz5G
	rgu/AFbx7mstUOs8qcdSY+0qU5YEUOpOmWC0acKew3q4Vt2lAxFrsna2ck9JH3gvi502SynAk1X
	CYhB0yjXnxDr4xHVq
X-Google-Smtp-Source: AGHT+IHqu8khKPmdrz5ZxNhApg6woYn1wpjz3geiCjpfYxV9ENASu0IFRk3+3jTmUaVHH2l595zxFg==
X-Received: by 2002:a17:903:46d0:b0:224:160d:3f54 with SMTP id d9443c01a7336-22780da858bmr63728105ad.31.1742574998924;
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39772sm19205225ad.25.2025.03.21.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:36:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:36:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>

On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> >> I don't know the entire historical context, but I presume sendmsg
> >> did that because there was no other mechanism at the time.
> > 
> > At least aio had been around for about 15 years at the point, but
> > networking folks tend to be pretty insular and reinvent things.
> 
> Yep...
> 
> >> It seems like Jens suggested that plumbing this through for splice
> >> was a possibility, but sounds like you disagree.
> > 
> > Yes, very strongly.
> 
> And that is very much not what I suggested, fwiw.

Your earlier message said:

  If the answer is "because splice", then it would seem saner to
  plumb up those bits only. Would be much simpler too...

wherein I interpreted "plumb those bits" to mean plumbing the error
queue notifications on TX completions.

My sincere apologies that I misunderstood your prior message and/or
misconstrued what you said -- it was not clear to me what you meant.

It is clear to me now, though, that adding a flag to splice as
previously proposed and extending sendfile based on the SO_ZEROCOPY
sock flag being set are both unacceptable solutions.

If you happen to have a suggestion of some piece of code that I
should read (other than the iouring implementation) to inform how I
might build an RFCv2, I would appreciate the pointer.

Thanks for your time and energy,
Joe

