Return-Path: <linux-fsdevel+bounces-27463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA159619F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAED82827CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADB1D3629;
	Tue, 27 Aug 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wV6IjtkI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE484D34
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797089; cv=none; b=fiuujuYDCnsAwwwz7lsrCk7dCDMTDdY5slJR7rzJsgo/vcvAnGAYmRxD7PJAtkGB/f2uBSKQbT9r/R8AJIWLX9pTZwEqTsy40gdIqgpumPzcTjooUeA95BxmBEK0D7gupgMlBcfUjYAMC20XH2Jo++RG8ivCV0rSis6rxJNp6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797089; c=relaxed/simple;
	bh=3ljrpAXMzv2KJ+1/XEP0FcBbu/d/FGo00BKweohWfm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYUhWde4i/ULviiH3EF8bP4i3FHqM42svkpX94O+RjxJw1Qu/V7fk6/O6Uj2kWuXuhxKkxVNDSzorqjDqmGYZNR6FCkUVnf/SmdeloMqDhTG38ubo9S+IaH8ko7hawJFdWzSur/Mk1xG4+LmTIkm2L8SgTMWMUGWNuVe/d+BjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wV6IjtkI; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-709485aca4bso4246847a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724797086; x=1725401886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKzA9H9GCvbQWsz4KPKiTq5rdb4iMQmFg661OaXa3e4=;
        b=wV6IjtkIWDWEbCsDusQp4QarR+JfOhKOji3BXoV3m6hMQPd4qZSRAAq8XQervhBlZJ
         DKegPjg/f9TNlo09FPGGKRcITO1Lx9sulIpQCMBPZyXwjN7RLWCE6K7b0T1PDdW2+r2B
         OgzUb5k/SvoTqKwZnbMI8g62NmWXf+4Tta6TjmtvhV8anG7CDdRfEwZW5Dpa+tPUGU5W
         6+jIou1AOgzA4mAT5g3edOo+ZBKaokojnwiy+i4HLLt1/fkITHCJZiUyqAIbwydvfgfo
         Dtf5vYWuRaELDi3Xit3VyyFP81UmTUOWeKvXbwhF74gOT26NbfPkUhIhL5IBpR3tQliw
         hu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724797086; x=1725401886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKzA9H9GCvbQWsz4KPKiTq5rdb4iMQmFg661OaXa3e4=;
        b=drEfjRTYfUqIzvOqRzcdHDYNbRy3qoQyB01O41nJQj7EDHjtoZe00DQOrAbVEHxNkG
         Khmf4Ckp3PyBVskLKKQFvkDpZKSxq1+qvV+W4F2Ohv3+O1lD3A8Vq7v1/6DFuZxGUUiE
         ghQl+mPkfsj5F4bxgTWRFpxqWsMR/95WsKYS6LqOH+8DygP4OOM78Xx0E4nYR4vpGBDk
         fMvpIHM/D5T9NbCkkd6CPP4oVbu4sRyPFW1FHdnnffMozTQZ6VrBetIBvU+mv7PzSLUP
         C07m5D5GZHmA7o6F6z3W+WUEqOdDEnzOQ+OLQPsr9hqLLpLYrMVB/h1MfiFJT1rl5Onf
         g4rA==
X-Gm-Message-State: AOJu0Yw79WGluh6yqNj4QcrEdaExRf3a2qRbNyWctVgqPcQF6444PZMc
	zI2w0SwX73o16xcYArSjwjY5g/wM7JPSp+IG1+NwyxZbkDnrWWlqrxGNWGdvvtw=
X-Google-Smtp-Source: AGHT+IEPxTShdZhxb0EduPKOSSoiDP1TGuQUskWTpG+52zTMqLjvabPTpMH7BqACWiGOp8JFrc8n0g==
X-Received: by 2002:a05:6830:9c7:b0:708:7dae:7f44 with SMTP id 46e09a7af769-70f53ac3ddfmr3193a34.26.1724797086319;
        Tue, 27 Aug 2024 15:18:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfc2835sm56536911cf.19.2024.08.27.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:18:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:18:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com
Subject: Re: [PATCH 00/11] fuse: convert to using folios and iomap
Message-ID: <20240827221804.GA2597336@perftesting>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <1f36f129-fdd3-4992-87f6-e05943a376c1@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f36f129-fdd3-4992-87f6-e05943a376c1@ddn.com>

On Tue, Aug 27, 2024 at 11:36:56PM +0200, Bernd Schubert wrote:
> Hi Josef,
> 
> On 8/27/24 22:45, Josef Bacik wrote:
> > Hello,
> > 
> > This is a prep series for my work to enable large folios on fuse.  It has two
> > dependencies, one is Joanne's writeback clean patches
> > 
> > https://lore.kernel.org/linux-fsdevel/20240826211908.75190-1-joannelkoong@gmail.com/
> > 
> > and an iomap patch to allow us to pass the file through the buffered write path
> > 
> > https://lore.kernel.org/linux-fsdevel/7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com/
> > 
> > I've run these through an fstests run with passthrough_hp --direct-io,
> > everything looks good.
> 
> why with --direct-io? It is not exactly O_DIRECT, but also not that far
> away - don't you want to stress read-ahead and page cache usage on write?
> I typically run with/without --direct-io, but disable passthrough.
> 

I got distracted halfway through writing this email, I meant to write "with
passthrough_hp with and without --direct-io".  I have to run with --direct-io
otherwise generic/097 hangs because of a fio bug (I really need to go fix that).
Thanks,

Josef

