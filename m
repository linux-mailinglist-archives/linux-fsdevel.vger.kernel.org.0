Return-Path: <linux-fsdevel+bounces-27481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C88961B60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE131F24901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33C288B1;
	Wed, 28 Aug 2024 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WJNzdFvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5317C7C;
	Wed, 28 Aug 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807998; cv=none; b=hZl+3eZ2DQUFB5uUUEsO2n75caNn7GdyDdk1H6PXd0/pysaeNCAd2v/WT3jQsYo2o5m9N00OlYD5azwVa8aRXlroN0W+tZloIhpo7Cx6p6WI7q7OTmkSHyMYVReaYl7CfTrwAbXR0zt20+/w0h1d6T8NHMRmkKH0J/e44An4euQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807998; c=relaxed/simple;
	bh=HkTJ4Z02ayqIUPhojcsjUl5UoyOWUAcRVHBJ6olPfuQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xa32QbmEbpWKU1OzvfhmajQORHJzhHkgHaF3dExiWd+lFvyETtyRNd3LI4o+hi09z5pMKAxVcP2J2GalodBRtEcbcNR5FFRO5bdppz/1mf6X/nWhT3Mmbk38tO11x9pQOZ3S12Uk+cQ9IHLO8TGYI5EMJbxtLtnjwF223iky1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WJNzdFvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB8BC4AF09;
	Wed, 28 Aug 2024 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724807997;
	bh=HkTJ4Z02ayqIUPhojcsjUl5UoyOWUAcRVHBJ6olPfuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJNzdFvVwu6bdkbAexFJCp4o3xRs3N2XVgbg7dWfYc8oKkS1bGy3wp08pzoD04Ddi
	 KD9aCsG9Qn2KIcc/d508cy8wgLYsrMSorJeUt6j5clVoffTPvg5CptfFEW1q8IOr1w
	 Cko2CkjE/Elw/vYXQL6TuLRVPMXDuoP+ETZqaeeU=
Date: Tue, 27 Aug 2024 18:19:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, alx@kernel.org, justinstitt@google.com,
 ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 0/8] Improve the copy of task comm
Message-Id: <20240827181956.73484860efe34e550f35db7a@linux-foundation.org>
In-Reply-To: <CALOAHbA7VW3_gYzqzb+Pp2T3BqWb5x2sWPmUj2N+SzbYchEBBA@mail.gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
	<CALOAHbA7VW3_gYzqzb+Pp2T3BqWb5x2sWPmUj2N+SzbYchEBBA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 10:30:54 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> Hello Andrew,
> 
> Could you please apply this series to the mm tree ?

Your comment in
https://lkml.kernel.org/r/CALOAHbA5VDjRYcoMOMKcLMVR0=ZwTz5FBTvQZExi6w8We9JPHg@mail.gmail.com
led me to believe that a v8 is to be sent?

