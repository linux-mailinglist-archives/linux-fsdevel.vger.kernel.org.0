Return-Path: <linux-fsdevel+bounces-30861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C95698EEA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEFC1C21032
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82715666C;
	Thu,  3 Oct 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oByZ/skT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1B17579
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956957; cv=none; b=Vhg+CjHDMi7yQbWQ2q/0MPskIEj8rUgYJdllc96NtqLQQTuwfOyXcMM3XIOULNupxPobyypnC7tQkh5tnnr/kApnggQ6VTYqd1c4GIMWHyN7+T7DJxtT6JSHBv+5Rjy93hM4q/uIedu8ad9zj6rCrDh/yuEoBgafT37gFReac/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956957; c=relaxed/simple;
	bh=MwBRkQVMA059ArdhoBATjqQ1EBHyVGWCZr6V486UA8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I70Jtr8jqUHAsvCgDryGT4J7l7/tt7ug5aKA9r1mC0JtJSNIvfLzL8V8yeo+DlN0NiDytaKlM+JUeJApmskYEmMFVCVI09znnHBgzlpHhhHodFveg1bbAyKvohkB7Rngz29gvfUsjITrscj+8o4SLnGNBaMR+EVT7G1SO1rY7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oByZ/skT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a910860e4dcso138564066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 05:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727956952; x=1728561752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5zUXd+73PywcdvRL9Y/jUECY80zho2i6MMJdTvlxdaE=;
        b=oByZ/skT+u4oLeb5aSQsOhEDpwk2M89PTH7rF0CpkGy0slxnsnnF3xxPnEDsKUht8F
         OwTKpEbm6ccwsRDiytIo1xAyJ4jqMiZ6wUKH7QVFBYda804DPCRgE+RgPt9l3fOZXGZo
         Y8sRQmOel22aB2Jl1EGxBKKB8S3Hu27JZhAdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956952; x=1728561752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zUXd+73PywcdvRL9Y/jUECY80zho2i6MMJdTvlxdaE=;
        b=SWepDNgFvVc7lPNnrDB5cMucrmFFD9GP6wLxJi8tbbS/G4++D+C0lN7Ey9y/wdCjPL
         9Hq9CyVbdpbqveD5q7XLqeFq8k6z4lYRLFKUes8SqXLJowALDu/Bp86Ble1rUTrfWvr/
         3zy8TFbEh8fygLbe6eyp48aGLtgL1HgTVNj/7Tb96pgQbOQu61/PslRWnV+z7K+lBY89
         S8j5g7BW7b5mYN0wKlkLTUH21ItAa5UfDgS2PmjPpQDjfTng6WJIdmBcfOE3hlsIxnrB
         rVm6OkAdQlv8MzgjngKhl3m1KNUgpE29lO/DyZw/wVuqk0mJcOSlHYaf769z91e7fMC3
         RxKQ==
X-Gm-Message-State: AOJu0Yy4NhYPMC8Mp7kmZFjzJtN93LQhi9FTnD/50M17DuggNw8csncR
	ZLFBWuwykHo2eP5GZucSRhqS3jILI7R9b5Ds2T3zptra2WLju5oZPeZBus5qee6EbvJeFrixhIi
	/SF1lw7S0N7oFftMzPpXNDTqhFFGFRMeFV9VIhg==
X-Google-Smtp-Source: AGHT+IELW7EIJB7hc+zCLs5JBccb5ma2OqkXpyMu1ARyBQwLVDTUab2+t51hylxhrIir9fBLmsOzojyWBRmRt/UGjyI=
X-Received: by 2002:a17:907:783:b0:a8d:2c3e:7ed3 with SMTP id
 a640c23a62f3a-a98f825824fmr670375166b.35.1727956952584; Thu, 03 Oct 2024
 05:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com> <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm>
In-Reply-To: <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Oct 2024 14:02:20 +0200
Message-ID: <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 12:10, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> What I mean is that you wanted to get rid of the 'tag' - using any kind of
> search means we still need it. I.e. we cannot just take last list head
> or tail and use that.
> The array is only dynamic at initialization time. And why spending O(logN)
> to search instead of O(1)?

Because for sane queue depths they are essentially the same.  This is
not where we can gain or lose any significant performance.

> And I know that it is an implementation detail, I just would like to avoid
> many rebasing rounds on these details.

I think the logical interface would be:

 - pass a userspace buffer to FETCH (you told me, but I don't remember
why sqe->addr isn't suitable)

 - set sqe->user_data to an implementation dependent value, this could
be just the userspace buffer, but it could be a request object

 - kernel allocates an idle request and queues it.

 - request comes in, kernel takes a request from the idle queue and fills it

 - cqe->user_data is returned with the original sqe->user_data, which
should be sufficient for the server to identify the request

 - process request, send COMMIT_AND_FETCH with the userspace buffer
and user data

 - the kernel reads the header from the userspace buffer, finds
outh->unique, finds and completes the request

 - then queues the request on the idle queue

...

What's wrong with that?

Thanks,
Miklos

