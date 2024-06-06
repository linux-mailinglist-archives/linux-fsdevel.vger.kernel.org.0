Return-Path: <linux-fsdevel+bounces-21119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3A78FF301
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477B0291297
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC561990A5;
	Thu,  6 Jun 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yx0lbTnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADAA198E98
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692803; cv=none; b=F6tF2SV/Ae5hX3vazUwCvKlYyEjRcsr/qrgPfi7+S9MwBNMJhIEc51fRjbTIpk/TJE8BKdld0QyxoxQdlP0NAb96aunB9cWTHLzN5zVCbEdybmXRnL52OF7iEEIrByUTALbdjXModpIHBhb2yBG2e/MWduMtxIu53ZJn8+Oy1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692803; c=relaxed/simple;
	bh=33Lr+Fgz2JdFKSmgSpp1LKmPL7/qtpD+579xNjyX0uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnVB1sZTrqNntclB0xoY3qX7hm7OWPy4lgTPx6Fv80MF7MsYkpljftv241DWPl3zz/6xxqS3ELaMdgjmKx9yQB3g8EA86WfmVMMkydFfwQiT5VFf7N2LsIPXeUHTQf0OqeOKL2rMykSXsw4j1ter+KwrkSqdpNppMyC8uxAyjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yx0lbTnK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7951f67e88bso69555985a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717692799; x=1718297599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAos8J0tLNdYoQThcWMldxRDeAUbPUYjKQJicRpXiAo=;
        b=yx0lbTnKX8aKX/6QHwmx0xxGqMqBlJ1dulDKqHwtD1cHL5GoKCQ9pzd76It5vB8VuH
         FH2MzfHuTDo9SsoMiw/79v3eavzBOpDMiUd8+/8ROqXbO9vCit7g7XV1V0BsVY5rEPIC
         DPGJG6eIr1+4ZxU8DCAynxp1eEd3R18Y4u+3xoS/Lkkn2CDvM63WJoY9dq9gjeDiLBZF
         3AqeL9oP5uFzoA8A3BBETrWjN0V547NOot7wGUXmBc8SP/4tJJhQ0QAhJNNVDj6PO2dS
         R/DgeU5oxvufa25B6XOjr67M+xDVNtlg59qXypQzUdtPWdxuMfW4E+f7zQ3suyQAOrth
         PRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692799; x=1718297599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAos8J0tLNdYoQThcWMldxRDeAUbPUYjKQJicRpXiAo=;
        b=dPSYvWpsczGJK1OVf/ncwsIWvslZ6tHg8FvgauyHj+L1XbPou5dZApZHGohHm1KCtE
         DSIRNMFeE5sWHpnRVc9GR/m8Av+VYoDVwoupJMPv5nKoqKEnUl9OZ4IQBcZ2NprUjWkm
         nrWhvt0KknS9vIJEXf2wmwdvb4zgyZgJME5PUo9g9RTpIv9Uqpqv6SRJD1z382K+3mvu
         rKwLTwBRDEfwTCcI9FxvMogggj8oOAczm2Xcpw9+wkkcyFMZg88UcW4+iDxKLx+Ewv92
         c3wN5JILxajeKGEuNgEIJ5FcvK71nB+RNfK+SYqP7GeNjA3osBS0AGby6EkQujDBirV5
         C/8w==
X-Forwarded-Encrypted: i=1; AJvYcCUAK84dkqLBoRqOWvi6wYz/l5STN5QGeDK72z8j8DGME1yiTqZ1OpG1nz15aQb6e+/2TtXp7BkLMrG6DOXRN7/DSU55AB98xsXILq68Ww==
X-Gm-Message-State: AOJu0YzI+3/z8X6PM3p1VbCb8x4zvAXQ6VRULzkYq70v5lPhfh0amz52
	rmv0DN6QrlnbV/ZkQBveXzhcyWSkN3RF4j7tlz+XuQjFmtrGLwoIrLFxBA875Ys=
X-Google-Smtp-Source: AGHT+IF7zcbpRU8H/HHtv+vOIdSt3/L0Nx6HYJ2PHRZzP1uP+i39oqO8/5/NB4XrGfeE6DzoOleEBg==
X-Received: by 2002:a05:6214:3982:b0:6ab:99df:4106 with SMTP id 6a1803df08f44-6b059bdb228mr855806d6.36.1717692799536;
        Thu, 06 Jun 2024 09:53:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04fa18abdsm7895616d6.130.2024.06.06.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:53:19 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:53:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, david@fromorbit.com, hch@lst.de,
	Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
Message-ID: <20240606165318.GB2529118@perftesting>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
 <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>

On Thu, Jun 06, 2024 at 04:37:49PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:
> > On 31/05/2024 14:01, Christian Brauner wrote:
> 
> > > Back in 2021 we already discussed removing deny_write_access() for
> > > 
> > > executables. Back then I was hesistant because I thought that this might
> > > 
> > > cause issues in userspace. But even back then I had started taking some
> > > 
> > > notes on what could potentially depend on this and I didn't come up with
> > > 
> > > a lot so I've changed my mind and I would like to try this.
> 
> > LTP test "execve04" is failing when run against
> > next-master(next-20240606) kernel with Arm64 on JUNO in our CI.
> 
> It's also causing the LTP creat07 test to fail with basically the same
> bisection (I started from next/pending-fixes rather than the -rc so the
> initial phases were different):
> 
> tst_test.c:1690: TINFO: LTP version: 20230929
> tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
> creat07.c:37: TFAIL: creat() succeeded unexpectedly
> Test timeouted, sending SIGKILL!
> tst_test.c:1622: TINFO: Killed the leftover descendant processes
> tst_test.c:1628: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1630: TBROK: Test killed! (timeout?)
> 
> The code in the testcase is below:
> 
> static void verify_creat(void)
> {
>         pid_t pid;
> 
>         pid = SAFE_FORK();
>         if (pid == 0) {
>                 SAFE_EXECL(TEST_APP, TEST_APP, NULL);
>                 exit(1);
>         }
> 
>         TST_CHECKPOINT_WAIT(0);
> 
>         TEST(creat(TEST_APP, O_WRONLY));
> 
>         if (TST_RET != -1) {
>                 tst_res(TFAIL, "creat() succeeded unexpectedly");
>                 return;
>         }
> 
>         if (TST_ERR == ETXTBSY)
>                 tst_res(TPASS, "creat() received EXTBSY");
>         else
>                 tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
> 

These tests will have to be updated, as this patch removes that behavior.
Thanks,

Josef

