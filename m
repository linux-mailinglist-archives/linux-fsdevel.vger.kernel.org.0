Return-Path: <linux-fsdevel+bounces-15773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA43892CFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D1F1C21561
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFBD2C6B2;
	Sat, 30 Mar 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uA+km6Tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D01E885
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Mar 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830581; cv=none; b=BcJQ0kB01Wnn+EtL0Q1YR8zbhqROIjBZ5bGGe3EaXBlMbQ36E501yEgJxp4woq7BrGpOVOlJftSh2/GMF3jl1QGXkYwa7fny/vRIq87S969jb66ge8GOztEhf3t51kjh3JAxsRnjyefByJk34aUdC64ZwK78TLLkW/azY3I4j/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830581; c=relaxed/simple;
	bh=4agRjPMzG1/XtmQuWYKpTl8EdRGg6eblVES2ZO+0SlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYrhZy/tuAe8IdRD62UusEVk13FUHrNvZm3Qh7yZ+LvN/F8A+oc9lON0taacS9rCUdR3mzp4Ko4hUsKLsB6x4ljDBNq5vLTwGDiYTqfmxOR1QNOSngjtjvvhbMn1cGmyNoxGEk1+msjUs8CHLL+bYjVdJln8kajoy16ZQ1tA1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uA+km6Tl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 30 Mar 2024 16:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711830576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyuuX/CAzaYww5VoFTY8UcWmpR1otbpj2QC6MHiOP6Y=;
	b=uA+km6TlvUg6jRtUMOEQuGan9xTSoi3SOnOH3q82vcwT/289LwZIYTRTxXA4xhtkFmvseo
	Zl3beFxh4b1qDY8quO5wtU3v0xwmCpR0XwYHRTlvkAN/5rulDDsg3Y/nhl4RrlhZOlYTbB
	uIiPGG/tnr8VzI7qMkC6rQ/XyQDDUTc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-aio@kvack.org, brauner@kernel.org, bcrl@kvack.org, 
	linux-fsdevel@vger.kernel.org, colin.i.king@gmail.com, 
	dann frazier <dann.frazier@canonical.com>, Ian May <ian.may@canonical.com>
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
Message-ID: <kgkn6pklnafahldqznbf3zgqch3dyoxgsvmse4xfcz5rdgilxf@veery7hzv3zf>
References: <b8e4d93c-f2f2-4a0e-a47f-15a740434356@mitchellaugustin.com>
 <CAHTA-ubfwwB51A5Wg5M6H_rPEQK9pNf8FkAGH=vr=FEkyRrtqw@mail.gmail.com>
 <u7o6c74dsi3fxewhguinoy77dxgscsnmix5zzqqm2ckdcdiv2j@2g5zuy5vsudc>
 <CAHTA-uaQRS4E=hPsqf0V01x3ycd9LyCP5-Auqs1cP77bUpAEmg@mail.gmail.com>
 <CAHTA-uZo15smL6f=S7kMcJiGMNjUQ7fZMj7-5e6is=2HUeYr-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHTA-uZo15smL6f=S7kMcJiGMNjUQ7fZMj7-5e6is=2HUeYr-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 29, 2024 at 12:09:10PM -0500, Mitchell Augustin wrote:
> I was able to reproduce this panic with the following ktest:
> 
> ~/ktest/tests/stress_ng.ktest:
> 
> #!/usr/bin/env bash
> 
> . $(dirname $(readlink -e "${BASH_SOURCE[0]}"))/test-libs.sh
> 
> test_stressng()
> {
>     apt install stress-ng
>     count=15
>     for i in $(seq $count); do
>         echo "Starting Stress #${i}/${count} for $(uname -r)"
>         mkdir /tmp/kerneltest
>         stress-ng --aggressive --verify --timeout 240 --temp-path
> //tmp/kerneltest --hdd-opts dsync --readahead-bytes 16M -k --aiol 0
>         rm -rf /tmp/kerneltest
>         echo "Completed Stress #${i}/${count} for $(uname -r)"
>     done
> }
> 
> main "$@"
> 
> by running ~/ktest/build-test-kernel run -I ~/ktest/tests/stress_ng.ktest
> 
> Note that the panic may not necessarily happen on the first run of
> that stress-ng command, so you might have to wait several iterations.
> 
> Panic:
> Running test stress_ng.ktest on gunyolk at /home/ubuntu/upstream/linux
> building kernel... done
> Kernel version: 6.9.0-rc1-ktest-00061-g8d025e2092e2

Thanks for the quick reproducer.

I got it to pop - a few times, actually - but now that I've added debug
code (cookie values to check for some sort of a stray write), it's now
decided not to pop anymore, after 24 hours of testing, with and without
my debug changes.

Hmm.

We may just have to revert this for now, unless anyone else has any
bright ideas.

