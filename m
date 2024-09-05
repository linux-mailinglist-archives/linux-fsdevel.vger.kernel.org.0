Return-Path: <linux-fsdevel+bounces-28785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F096E334
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB6B1F222A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9418F2FF;
	Thu,  5 Sep 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Z3/T92iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112533CFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564604; cv=none; b=j763hKwLUHcnWPenmvTjOpMgRjzo5ZkUEv0f9OiCHL5FrQ6szuksOKmZDlt9VkQ7qAxydWq8Sc9A+oktnII2SKvoxbCghApV+wMtjThEreiRwP1QLJjSimLFBkI38ZY4s9pnzDnuV5ZY8DJTN+eUnZkNredMvMPQhshaxbpwvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564604; c=relaxed/simple;
	bh=h+GztmK06ua0ItOo5xyNb+uFSPQwlQl1O+khIF189xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS8jcOuwaAWAqbzAXkOzUOxzNkpmFoOUx5UwHVuzOStOOPS/x/oEOAvrN5yfP+IX8v2YFLhT9TYL4S9j+gjbnWuWr8NDNxGydlENA+JiwZXVRUs5CBayYSRxSfB0qHGHekpPNrtZj9Pvgpy26eN88/ZhDkezHhALFTRZwN4QyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Z3/T92iC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a8134aefe8so86119385a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725564601; x=1726169401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLq88qKC5eEOv6jE9dMcoyRYpwT+k6ZKS0lrxy9sSsE=;
        b=Z3/T92iC/Fj+/Cia06bnr5Xwx1xqgKpVwu0CnncHmhc/EuaCDuXE1YbsTZT0gknmM2
         Ku1Y8gBvzZTsGRFAmeATiWCoh5PVX1h2cORqMX2Ii57fV4Juetf9BuPjEThIET2wV2Yb
         G7I+Wq+sLEpo2sd6hGboa45C3vYQP89JbLNlkKt+1p9bd0o9Pwq2g8eMSEtlMqwPa53Q
         e9FeFzxH3dJQoGNYjUxg7AH2jY4+W6nCrKVWACOQyH/QxpRZ0VEnh7sJnE0+9oeXQBNc
         hcwD83qYlCjnUz6PMtyk/iBJ2u0XNtRQeeBOWPNnI/pM3Dy0AbGtIR8eJGk4bBCy5jX/
         k3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564601; x=1726169401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLq88qKC5eEOv6jE9dMcoyRYpwT+k6ZKS0lrxy9sSsE=;
        b=plXb7DM3lsxHIpGvxxRL5ilL8bbRiwJ3EDa/IDLiMZLUcoIeJLxxQtVueNOKO/+XXA
         PQuPtJ4F2mmjlhQH2znnZnmiganVgEFyeFw09afG3K9KsCKlGWjsAQmWomqCUTE3gKgU
         sLdMuiQMbLyb0XaWzSkbW3ISt/1usSP1e4LQj/hkOyjk/cnNu+hqssp1BYasuW1Ee69u
         4xUa3qVNkWLvFmiVDVFaBWjgPDQ9DRvUpTYd11743vajYdTAzwnphWqbq2gimxh1mhn8
         RMwFIaqM4defarsI2PDRpA7/K1ocw//VhJqyhvdo6wO7E480LXY9B4HQgkdCh88PLa4P
         Y+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXIUuSawOANcexp7SFbqKwVwnwTXqMQdzGsty1/io5ed7Fj8fdMrvydxM8IwlXbcjU0cgcMJ9GjXwhP70tH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/NX3cUveYw2eqi2kqsEx3BnVd0Ef9bLo1fimJ40aG72BXpp8V
	MwTDF+gEVMxnuAE3O+HiFYOtyUfj70b0j7dckWrUz8UG3i0UgKvFGhJ/vBjMOes=
X-Google-Smtp-Source: AGHT+IH/jKRTwmHj2A0Fw8hBIQQEYZheGvncMyz59vEBTim/gY8yU8p+bmOgT7GJ5npitcpK4cA+uw==
X-Received: by 2002:a05:620a:29d0:b0:7a2:275:4841 with SMTP id af79cd13be357-7a99733aef1mr14265285a.34.1725564601247;
        Thu, 05 Sep 2024 12:30:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1f9a4sm101960785a.2.2024.09.05.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:30:00 -0700 (PDT)
Date: Thu, 5 Sep 2024 15:29:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 00/18] fanotify: add pre-content hooks
Message-ID: <20240905192959.GA3710628@perftesting>
References: <cover.1725481503.git.josef@toxicpanda.com>
 <20240905120808.7fcsnv7nslqsq4t6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905120808.7fcsnv7nslqsq4t6@quack3>

On Thu, Sep 05, 2024 at 02:08:08PM +0200, Jan Kara wrote:
> Hello!
> 
> On Wed 04-09-24 16:27:50, Josef Bacik wrote:
> > These are the patches for the bare bones pre-content fanotify support.  The
> > majority of this work is Amir's, my contribution to this has solely been around
> > adding the page fault hooks, testing and validating everything.  I'm sending it
> > because Amir is traveling a bunch, and I touched it last so I'm going to take
> > all the hate and he can take all the credit.
> > 
> > There is a PoC that I've been using to validate this work, you can find the git
> > repo here
> > 
> > https://github.com/josefbacik/remote-fetch
> 
> The test tool seems to be a bit outdated wrt the current series. It took me
> quite a while to debug why HSM isn't working with it (eventually I've
> tracked it down to the changes in struct fanotify_event_info_range...).
> Anyway all seems to be working (after fixing up some missing export), I've
> pushed out the result I have to:

Eesh sorry, I updated it for the fstests and used that as the source of truth
for this stuff, which is how I validated all of the fs'es that got the
FS_ALLOW_HSM flag.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> 
> and will push it to linux-next as well so that it gets some soaking before
> the merge window. That being said I'd still like to get explicit ack from
> XFS folks (hint) so don't patches may still rebase due to that.
> 

Awesome, thanks!

Josef

