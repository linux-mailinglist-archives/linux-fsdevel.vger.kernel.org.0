Return-Path: <linux-fsdevel+bounces-44631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B103DA6ACCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9760980ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84A22A4E5;
	Thu, 20 Mar 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ajRjGUQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFD229B0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493948; cv=none; b=UJZCRqRc3IYcbVK2pq3nplwCckGPTz6uUJ9V0yxzAurxN9P1toyFNzKhEpppXbHU3KwQH1RJ0/kxKws4t+Wcv2oAsUT58c7gLnofgxIEuLx/e+TFEa2wx3Itxo2wugD8q7agDmE2BI4kD1YM5ao6aJiaGKFVfon7tVYQ/N4o6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493948; c=relaxed/simple;
	bh=eSRjWYWO4yxvYztB0ncS8vovMEhY+BbOB3dCMJ7BgSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/EQQSuL6uwkNqB7MH5/J+c4ceFn1/MVwGGwWAwsXd0CEV9K50A/noqkfSHTTVDtGWbDmvA+vCFsXyogWPvqKHlW9a7IKcBfcoEQP+5gRW2VQ7ou+N2e4QbK+UWMKJZMMlwkqP1ZvFGIV+R6qIeOonfQHz+6YWyZzGNPBtpdZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ajRjGUQX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso27958465ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742493946; x=1743098746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM/OqN7Oy0ivRWEL6tEbo+CUHh5BBsQYtWvf3MvSx6w=;
        b=ajRjGUQXyGVvsgtPaeQJmQu+Wsg70IKSHxrTMYZBn6eRX1UAm6V2gHcmTuZTV9REPV
         1up0vNoQjtiVlGu4f207Mfv9yyryEWL08XFDtXjT9e/BencAUtujgH9hRlNWy7QpdhtN
         dLPMa/+rqjHN+huFyT6bpvFUP2OUnRGCi/5Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493946; x=1743098746;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM/OqN7Oy0ivRWEL6tEbo+CUHh5BBsQYtWvf3MvSx6w=;
        b=ma72l37sg4ZvPWsHnYHDzGHzsMv6QQg0D01AVhNuFpCXgK/PYSgKLl/DZ2IOGEtojJ
         TezTRsxT4H0g93mPaWf8Lb9xTkWXVxACcLCWGqsSl7NhAdYdceLhAvzdW1sAufXtOl6E
         gDDryJbVPfndm4EOHJX7Achd7+CesLDe5/or7M8lmDWFyW/nIGh1zMhQ4/RTCL4ySQJm
         JnzzbUZNxxPCIY3xOkZFt0fAOkIGesuXqqIbt1HxxHmbWKlbmiS+uzXFx/LbvEA1CvEf
         wPSw1/HliS4fXigd03rhDb/faxSd2Oo78AaFZXq2zqtP7CdrS8DgCukj+rTnO4Zx/ntV
         95zg==
X-Forwarded-Encrypted: i=1; AJvYcCWKVXBdkirThTMuZqMVlp9U1U8JwmDoQe9J16QznRvi6KplAaP/p8xCCY9YjXCOyCAJqD6yOoicZ5wtMQrm@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLnQ1tHLJ8bxOEcTN+3SAu6SSyxkrmBjcz5/fT29TrTJX169H
	OEAu1VIhU2k8ZEYPwZ1uAgix04vlFQzC37kKsZEWkerlJ2UR7R0qSggb7Jd4VKY=
X-Gm-Gg: ASbGncs0a692H3moST0KfyPnNggSLbktF7IlOzX7P9INPliPY+3FPlA9hXu1QZepPCB
	6XevqWpgcVEgOn4QJU7FYz5zSBEnqLyxLcoy8t0Jb8EK+lazty9+NSUWxgQeyYzCWmPIHna2WIV
	eG6d6VDGAOP7fsMpwB4PTK7VIjxavaouwt2WeacrLgA/Mq7lIfog77oAh8lcaN3y6CKJhNehycp
	Fh2BER8MAIVLXSAqyrSt9Ywnj0E3LKYZfxmAFSxqlYCXwTeetQfiQtaoBAOxq2nab/Bh5D1xbJt
	9MpEZw2fMLhDvzD25KXzqmJ4t2xVrTtD+Rvg74PcI7t7Sqm42Q8+n3jsuSzuW23bs216ZgLus69
	0MZRG/2soZ5/8hc19
X-Google-Smtp-Source: AGHT+IFkG9txbev4JCYggmYZhNgAMBuFDffjPJdvIx8M6hPHeRaY1eSW3KdhJ6WDYT270hXE0myOaQ==
X-Received: by 2002:a05:6a00:2d84:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-739059a3471mr465905b3a.9.1742493945615;
        Thu, 20 Mar 2025 11:05:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618f1d1sm87958b3a.173.2025.03.20.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:05:45 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:05:41 -0700
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
Message-ID: <Z9xY9d2hOc6hOlda@LQ3V64L9R2>
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
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <Z9usmpFw7y75eOhk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9usmpFw7y75eOhk@infradead.org>

On Wed, Mar 19, 2025 at 10:50:18PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 08:32:19AM -0700, Joe Damato wrote:
> > See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> > sendmsg and passes MSG_ZEROCOPY a completion notification is added
> > to the error queue. The user app can poll for these to find out when
> > the TX has completed and the buffer it passed to the kernel can be
> > overwritten.
> 
> Yikes.  That's not just an ugly interface, but something entirely
> specific to sockets and incompatible with all other asynchronous I/O
> interfaces.

I don't really know but I would assume it was introduced, as Jens
said, as a work-around long before other completion mechanisms
existed.

> > > and why aren't you simply plugging this into io_uring and generate
> > > a CQE so that it works like all other asynchronous operations?
> > 
> > I linked to the iouring work that Pavel did in the cover letter.
> > Please take a look.
> 
> Please write down what matters in the cover letter, including all the
> important tradeoffs.

OK, I will enhance the cover letter for the next submission. I had
originally thought I'd submit something officially, but I think I'll
probably submit another RFC with some of the changes I've made based
on the discussion with Jens.

Namely: dropping sendfile2 completely and plumbing the bits through
for splice. I'll wait a bit to hear what Jens thinks about the
SO_ZEROCOPY thing (basically: if a network socket has that option
set, maybe the existing sendfile can generate error queue
completions without needing a separate system call?).

I agree overall that sendfile2 or sendmsg2 or whatever else could
likely be built differently now that better interfaces and
mechanisms exist in the kernel - but I still think there's room to
improve existing system calls so they can be used safely.

