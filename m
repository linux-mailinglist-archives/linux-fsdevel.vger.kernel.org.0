Return-Path: <linux-fsdevel+bounces-63435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BDBB8FAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210C3189B3C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C327E058;
	Sat,  4 Oct 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1aES74q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4127E04F
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594505; cv=none; b=p2M0Fvn6lQhVYoDt6FiEs3ezjESbRx9L6n0MzxNiZEmHTe1EqvzCvFlFZd66spShC/qECMLyLsajSLFYruGhed0A8Yf2tnJZFkwLXShx610cBUEHYoBNCR5YvhDQ10bpOjY8DDF7bF6Vz+BeVZVFvvh8DYQLwkiHi3QDsACEvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594505; c=relaxed/simple;
	bh=8o6UQf+gZU1yTFkaOSCz+N2+6NM/LJ0GmW6jYusoJmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnkFSV8lSP2zrcQNthSxervWSqPJkzKjVM0hz8Jqlob58mWBLYkq6STifYfKLAwUFJoSkEaIrSGln745vugcmo6pImkWEsXoi+FGmG83KSfUKHv+H2nBb7tQ4jV/NY8eyPZOegCeOdIU6cIFMRh5ippsZxyI8vbEHt4qr+LXndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1aES74q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f5d497692so4191254b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Oct 2025 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759594503; x=1760199303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYj820t12DuT/Y3GHE/koJeP+yNK86CimN/bpcr4Dww=;
        b=K1aES74qTP40KTvUiLJM0zZhVG8djUVvVJqkHmhB/ArPWtyiyrVPxFyph8ci65JMeQ
         k+H56e8DBk0IpONMBtD+YpDQuQFi5T1TOHwpfoMCNd/UjLw8cLQL4i9B/vwPJw4Y9Uhp
         K+yGms1mq9lditqZjPb4E3eAEEJ3FxLufvuSawg3Kh0PfVjdVW77DPSQ7f8n+xSLiPyw
         t++rbHlt6cJjdGddYtXBYVHmntzMIa8xvzrAnQHHfmmsWvfvd2wThkEtCHahIp6kA/cL
         SDhsbm9ownR4Q/t9/mnpZVBhB5g0fUA7Xu5YPAZjtcRT8xyAsrKhXUARsKbadsjLI7g0
         +6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759594503; x=1760199303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYj820t12DuT/Y3GHE/koJeP+yNK86CimN/bpcr4Dww=;
        b=GQF/HzLawk9S7PizeROWNKEb7TdVH4dJ1jEuM8Ew2KM0l7Yj7lksnlEin1mYgbYAx/
         zjKyqG/EerItCLlGKb+jdIJVNsuY4uACrz4CQ5aSnxLTJHjEL8EIYtlMKd8rJhhOv4mD
         iZm2Nr/rJ6vIpRFT47U9BN4k8j+/o34xKeBA2z3sDBjiKyRMpsZpVOSKwejuL464qwTz
         15gRvov5+PNFZ8lJpkn0HdTq7iuof3YPu8PsOSumud2vyYIsdgRuUqsL1nz3leqhfBww
         446RMaa+X9qdlIPnmjs1ijDEx/kt+9AR484eEYgzvcsFOJSSE0u/Ef77TxklLhMfnbsp
         VngA==
X-Forwarded-Encrypted: i=1; AJvYcCWju1OvuXy9ih8FCdLt9tKkT02gEexV9zD1/3yUPkB7PDd3gogx1btJI0W663nJ1UQxWmhZ5HDahqEdfc/j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ETmFZFhaxJgg5FuaPdyizpCcpQcKzMPJeE+E4Y8BrPP76mJz
	7+Dq8nv+BRNTZi5JSBzD4n+pIaxqJ4lGSnN+DtdULdX0d6X8qUrsKiZoAecSvQ==
X-Gm-Gg: ASbGncvI+E+hcK5JCpQo9WZ8S31Fg3Xkae3fGcgoByW6u3PEwbQhqwLhKzfSqNm83KF
	7bf1nyio//F2OzJqNcrIDFIC8UxdPmsKP2qT8gfzTCuboDG3BHmPPw17x6WDeAmAL2mJ6+LiCRE
	qiBaPLDznezL8Bw9G6Got6SRrI/t1uPY3ZUW2POTbXMeOI5/k/UdosmrlCcjsE74iFoimybax7k
	TKI/TrQ4BBAX8TsdgYLJFRpr5VUlhP83ZR8pIxSkat+Lz3N/Ts+y+j/hUEvR/6KFmCV7su0uOCd
	ObGMFgmLYm7pZp5NHrsWKu9RCgei4p8J5duhTkZzBSrAv1TRSs+NQRbcOKawNzXzV686ErWX9Ks
	RFKhE4XTHGpf3HftPASBi0d40Q4gXPQE7ig3pCc8fiCNEk9Xv/IQqLWaNRevWjmu9TNF9jVDlAX
	KWzlyYEggmRjoGKzPqY1xE
X-Google-Smtp-Source: AGHT+IF5mMKQuy9GbvEclpfP5REvAas2+KA/9E9J64gOa1xJUCOWS7yTi4xFt+uA0ZVQvUiQ8KofXw==
X-Received: by 2002:a05:6a00:b54:b0:781:9f2:efb1 with SMTP id d2e1a72fcca58-78c98caeeb6mr7980762b3a.15.1759594502888;
        Sat, 04 Oct 2025 09:15:02 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2001:558:600a:7:f9d8:fc98:ee10:581e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206ea2fsm7848831b3a.66.2025.10.04.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 09:15:02 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:15:00 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, rongtao@cestc.cn, 
	bpf@vger.kernel.org
Subject: Re: [git pull] pile 6: f_path stuff
Message-ID: <7dhno3gp6f6wkgzndanvzyiwzwfkccgahx7bmlqzr65zytupnr@2r3v2lxvgyyc>
References: <20251003221558.GA2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003221558.GA2441659@ZenIV>

On Fri, Oct 03, 2025 at 11:15:58PM +0100, Al Viro wrote:
> ----------------------------------------------------------------
> file->f_path constification
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ----------------------------------------------------------------
> Al Viro (24):
>       backing_file_user_path(): constify struct path *
>       constify path argument of vfs_statx_path()
>       filename_lookup(): constify root argument
>       done_path_create(): constify path argument
>       bpf...d_path(): constify path argument

This commit broke bpf, since you didn't update include/uapi/linux/bpf.h
and other places.

bpf mailing list was never cc-ed :(

Pushed the fix to bpf tree:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=de7342228b7343774d6a9981c2ddbfb5e201044b


