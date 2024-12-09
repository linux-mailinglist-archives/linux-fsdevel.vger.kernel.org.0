Return-Path: <linux-fsdevel+bounces-36806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA409E97F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B06D283BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676161ACED8;
	Mon,  9 Dec 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="t7qAZx8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F521A23B3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752595; cv=none; b=rbSyhFD0FQaiFX/SR/I5megvQG8va+B6Y2JbpK+Pfr8yDyzE+hJczkSUpcM7Xw5GVcBhNaWzW+BRzC7fqNR6+3/Eo50H15HyiQKK/24dlfSbySu11PRVOGWK+njP2bqMYKj3qG1tlsOFpwtJfWaiNPyhIuAh/+fqYEW5Itc2tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752595; c=relaxed/simple;
	bh=J9jxOUbKeDVRIEAOg1/n3B3WJk4NSvAISEJnw0CnrDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/lL13mdtZmtFJiqw737ZSLq/uUYzAI1BcJJE9zz6Ku+hwWnSs97EvFa1lcpKrG/QMLACcgv81YF3IKfamIWPzEiUeoB7YTHzEJ/WjTajWfYY0NOGxdf3FIT45zv6CtGIVR2oytp0dAhHPjIFC2txWtWr/1KUFtRCJV9lLFusAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=t7qAZx8O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b15d7b7a32so285648285a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733752592; x=1734357392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJFBpbu7HncFVbgy8VnoHa7EGDC6RKL4IX6ntGytemg=;
        b=t7qAZx8O3gSeoKTRfEG3rUqYX0I3eTcjZctqSGsFm2ELwm/EzPC4l30b1InzezBYby
         UzHX9gnCdxM/KjX6AinROfwr426IU6iiz2hc8xoaBbFp4yjh7yynNu6z5+CBMIoa5vT/
         WEGlJeLtKMIGCqjoVwI4eYMrzUt7Mp/+VN+HYN8CdjrBu4F3dxx7nCQ068PQNg4cplOM
         iDDwL0x8BHh+1+MNbDznYGWLwy2l6vLGfgiLW2o2+w33CTufPK5Nz0dS/qJhOL3piY/D
         RxvIPdkohA1Bmq8pjln5OFgismqlPQMwfJA83D1Wx151M8BKEKsyI8Z1xKhWMYU8XoCv
         5tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752592; x=1734357392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJFBpbu7HncFVbgy8VnoHa7EGDC6RKL4IX6ntGytemg=;
        b=k4EpQMYnhqIFMlpSReZvasZyV3ImfttQQ0Gf9a225zKBTv8u1m18M/bpmGwdNzVET8
         0C04l5+7hYG8dvtb/ec2DoxktlvJH5Hz1TJg3z9YoTFtImiKFMF9+uT1gZ8DKQBYvWFc
         za8TBwe9lgBOHzfmNakqCTq1a228mVtgYSlvO4qROddXAOETqaguLPzICplODnP7OU3p
         6tFaDjOlUttt1A/uU2nTYYwWJJ+f4hGbEiF0VlEOiPXJxu1L2w2+DkOheYj6rEV4J+0L
         ni4ncK9oQSysmYcQIxiU0CnXHMIymj/T9nVw27wyymWhLx7yzHUezkdZVQpG4V8oz6Sq
         qCvw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/u4QNyAEM/a7rN4VSu5lgS7ksWId561TRK9fOHT4nxvqtImR9Ab3ROtNKUqV1jZLyAeTW+iZAf5FQstZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7xJiwbiOj0RSsnocOizZOupFNSKPD657iFqGhVeTaoCOISl9
	ZURdUZVYF9pOhNnnSoxhhydil7mk0H+wLybwKff4UB68dDpkq4nYuYWmlnF4UPw=
X-Gm-Gg: ASbGncvvF13El0GT19478TvDkjFqNYGlJ41twlsh+hpg7bMboOKcxxrqOcwqGvxUDJi
	MlQcfeOytpbgWcjjfI4sPde9+WJICZMPh4ACk5r3cGyVe9yM2KlqZiqXa9VK0GFooh/y7wSMNyU
	hI0Jvy2qm+8JTQGZQAPVp/51FN8IFm1/kbvrD6KSGeU1R9oJmtTy2qP3Q6qZHFEnURun9c6tI9X
	H8i2LDhpcSsXYxBo7cqP6gIZO41IHjIhuIgA049t+3N5jRbqfYXA49ztedpGKHd+dzvPpesrnuV
	81rqWX/gWEw=
X-Google-Smtp-Source: AGHT+IEXq4VSWgAaOp5tDtVpx3ILtyO4wq8VMa/ktn63RpJmsoehGalGKqDzqoRPDw9NFi8Wec+A8w==
X-Received: by 2002:a05:620a:4150:b0:7b6:d2bb:25c4 with SMTP id af79cd13be357-7b6d2bb275cmr649788685a.62.1733752592567;
        Mon, 09 Dec 2024 05:56:32 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d907713550sm18084956d6.6.2024.12.09.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:56:31 -0800 (PST)
Date: Mon, 9 Dec 2024 08:56:30 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <20241209135630.GA2840216@perftesting>
References: <20241128142532.465176-1-amir73il@gmail.com>
 <20241205125543.gxqjzyeakwbugqwk@quack3>
 <CAOQ4uxjyFOy0JCPJ2y4Sm-goRK9xtf_6jkWEEq_vzxPO-FmnCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjyFOy0JCPJ2y4Sm-goRK9xtf_6jkWEEq_vzxPO-FmnCA@mail.gmail.com>

On Thu, Dec 05, 2024 at 02:28:25PM +0100, Amir Goldstein wrote:
> On Thu, Dec 5, 2024 at 1:55 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 28-11-24 15:25:32, Amir Goldstein wrote:
> > > Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
> > > the legacy behavior of getting ETXTBSY on attempt to open and executable
> > > file for write while it is being executed.
> > >
> > > This commit was reverted because an application that depends on this
> > > legacy behavior was broken by the change.
> > >
> > > We need to allow HSM writing into executable files while executed to
> > > fill their content on-the-fly.
> > >
> > > To that end, disable the ETXTBSY legacy behavior for files that are
> > > watched by pre-content events.
> > >
> > > This change is not expected to cause regressions with existing systems
> > > which do not have any pre-content event listeners.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > OK, I've picked up the patch to fsnotify_hsm branch with Christian's ack
> > and updated comments from Amir. Still waiting for Josef to give this a
> > final testing from their side but I've pulled the branch into for_next so
> > that it gets some exposure in linux-next as well.
> 
> Cool. I just pushed a test to my LTP fan_hsm branch for ETXTBSY.
> 
> It checks for the expected ETXTBSY with yes or no pre-content watchers,
> but it checks failure to execute a file open for write, not actually to open
> a file for write in the context of PRE_ACCESS event during execution.
> 
> So yeh, a test of the actual use case of large lazy populated
> executables from Josef
> is required, but at least we have basic sanity test coverage and now we will get
> some extra linux-next testing coverage which is great.

Sorry guys, holidays and then some PTO and other things conspired against me
being useful.  I just built and tested Jan's branch as of 10 minutes ago and
everything works.  Thanks for picking up my slack, I'll be actually responsive
for the next two weeks and then I'll disappear again until Jan 6th,

Josef

