Return-Path: <linux-fsdevel+bounces-31519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A84C998049
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEBD28362B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2C1C9DC5;
	Thu, 10 Oct 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SYjb8vou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6218C03D
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548514; cv=none; b=f4xLMAyGPBx6RnUAxA2AiadM0cf2AxnX4UsBJSQ3HdfQDeTpSpFRgmfNoe/TSccITTu0IhTB12e/A9QTpuImk8zss65rnXr95YGsv87vrWiAvRzmI7sXwdJWRMWmmPEvG8HeR+lKz9TpfOD3rj5qjez0eLeVegV4+UiLcUyrPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548514; c=relaxed/simple;
	bh=B+3leXEteHJj769PLjVvVQILszERPKma2zh3NxsxWDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9bVQIlXhDhZwvZpRKzIS+UbHj8kNDAi8Vu+hoPfRw2Dsp5Ddi1yUgk8fS7mUFsM5/H3b2eOs4eOlQjiTzaR8joujdCEKVvFs5PUpBQgdTiuS4qyeLhcaKJ2TMlA0Zf9cT0PGdmOIfK8PGXTyqRCJjwgx2nBmccybBq7+S6NloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SYjb8vou; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c90333aaf1so595626a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728548509; x=1729153309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giL8WS08f6ZLQ0K+PmKLdFj8M5B2n+3tze+7rW03gSI=;
        b=SYjb8vougtgWA3Lu1Xgk8oCho7wK9WIb5/njiGdB5oHb74+pQ5I4uS4uRJTP5vu1gd
         nUihwANEcM8qiyM6MbFyBzGCQTcA5ad5QBmYEs0SshLIfx7LAIJaTyuAQ0vn2DSZ/OhI
         +wLnEBRadK6EaCJODPH2vNqrmEf/kvQfJuxZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548509; x=1729153309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giL8WS08f6ZLQ0K+PmKLdFj8M5B2n+3tze+7rW03gSI=;
        b=kJHFpnSJBhbzZFdQqujPvdt2INbL6kFjULco+d7xuB70RuKlR0LDYWfxz+mnrJCoU6
         kdVl/ICrBvpbVq7l4Xc5X2hWjNlaYvTGNdnAfU/2VQgj+eTgQTodJHWZuswS07t6PjNE
         0loHW+BrR67tUvrZSnK5d/M/1E3fbtanqzFVe9N77zoVpmo5q+9UibKoAxw9ZZbCkTtf
         nuj/6mESdROn6VDpLcqDojpYvYPMv8yByztGPei+YBYmq/3+ahQUVt9QqzR/IjPqTW1m
         rgHN2nY3mpl2349En7tSHCTqGNG56OC6nUyKqYOPhTWYZzQvkRYwvUOnIYBFda2yuUqG
         3HrQ==
X-Gm-Message-State: AOJu0Yz2c43P7P5lomDz/998n45ZoOWmPLKDgVOf2VI1DdHcOKctPeEB
	01kDKWfzR6TN2HwGHtUovGj+yxZFvyftMwlPtGrN8bwdF682xmFCwyPdhqDrGshlbQw8a0wlEpT
	n7rWNQUHQjqzIn9F13ygPheIZPKUr6XJhCOPOZw==
X-Google-Smtp-Source: AGHT+IHd9Oc5f4uOUZCI220+hmVEnha90pNgAZtx+RXBwuEs8ks3L7Q17vyFIRmMklk2C6DVksvye8VfAPbKXy+kbhc=
X-Received: by 2002:a05:6402:358e:b0:5c8:8652:dfd1 with SMTP id
 4fb4d7f45d1cf-5c91d526420mr5477668a12.1.1728548509158; Thu, 10 Oct 2024
 01:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
 <20241007184258.2837492-3-joannelkoong@gmail.com> <CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com>
 <CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com>
In-Reply-To: <CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 10 Oct 2024 10:21:37 +0200
Message-ID: <CAJfpeguB9zgc5zFtsf6t4WYuLntQ5w8y9P3qP3oNFjohA7VCMA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] fuse: add optional kernel-enforced timeout for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 02:45, Joanne Koong <joannelkoong@gmail.com> wrote:
> I think it's fine for these edge cases to slip through since most of
> them will be caught eventually by the subsequent timeout handler runs,
> but I was more worried about the increased lock contention while
> iterating through all hashes of the fpq->processing list. But I think
> for that we could just increase the timeout frequency to run less
> frequently (eg once every 5 minutes instead of once every minute)

Yeah, edge cases shouldn't matter.  I think even 1/s frequency
wouldn't be too bad, this is just a quick scan of a (hopefully) not
too long list.

BTW, the cumulative lock contention would be exactly the same with the
separate timeout list, I wouldn't worry too much about it.

> Alternatively, I also still like the idea of something looser with
> just periodically (according to whatever specified timeout) checking
> if any requests are being serviced at all when fc->num-waiting is
> non-zero. However, this would only protect against fully deadlocked
> servers and miss malicious ones or half-deadlocked ones (eg
> multithreaded fuse servers where only some threads are deadlocked).

I don't have a preference.  Whichever is simpler to implement.

Thanks,
Miklos

