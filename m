Return-Path: <linux-fsdevel+bounces-32621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783F9AB958
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149F3B23AC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563451CCEE9;
	Tue, 22 Oct 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PW1rkLr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3713B58A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635014; cv=none; b=RjpvHnSZObyHt2hYO8k9Z2e7kdcDN5rvdOHYrm2QW7pPCrgTUwPl9KgmR6hhG+teSt7hfuypAaO6gjg/mef/5DGMuO30we0qs1NskTlTXO0XEtqueaTp0EswCXIjSzOwTPitn8jh356m0nhBiBGZCr0NrC1zQCPxO9YgYrUfAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635014; c=relaxed/simple;
	bh=i5Dux+tu36s4j3bjtGaxVlsWNTwVxG8Li7ytEIfbz3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuzt4f33XzJH//vecscNwPOHvP++QDp+OFjx3HAzR0Ydsw9Jz89jr6brpDvE9lNiDuptEQ1JpJXRXX7ze4UQotAM5HnxO2sD2glI/zC0paJlAZl2eQj2VyIPvbBp1zLRkzj0lC7119ztU9rr5/JsoLn7Y5YXnMM6IU8wIV6PCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PW1rkLr2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e6981ca77so45889865ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729635012; x=1730239812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBS9NGU/A5YlWZkorpJxAKD2D/OcgCE8QaEbQhOrhzQ=;
        b=PW1rkLr2EoiyWTplnh1D5R8C0RY1wt8U2b//1ZpwqX6sHaOVUkiGmHZxoUuqjltMhR
         4+KeJEydSLY2nYwKb4+hya4k5Up7g7oMoW9ELRPHFKoHrqa4YgQdsjD6nSqglUJICbxW
         Khgrgf6K8h1yHj8Er29/++ud/mfvFH2xojJPccEm6Q1MkXE8sac13ZrB+Jvog0dIDXku
         /RS8Tyj8kQp9v8/3V/ZEVXgEExYgGVoe9OMYRuqRHZzSofWnN9zx1/D2a+Xga3GkD59y
         9tTWqW5d+bBF3S8SUtGxb34F7AwDNFzm7k/JsRc6k4iQ7wMbQg+UpmYA/7JkfP2cwYmB
         XRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635012; x=1730239812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBS9NGU/A5YlWZkorpJxAKD2D/OcgCE8QaEbQhOrhzQ=;
        b=no6sT7+HmrdBt6HWMjILodloOEK5J0SjK4YJz82o8bGVK7L92fXPYgJqID+yEHbDN7
         XeGvS5KuBaDlj1d4+OfnOWB6RRqvkhXxk3Cku2akCRAZrrEDQIA9QKzS9tETa6wV8nLk
         FeUgmYWtg9WRH8MZ0122942pMYcwfP7W7ZjLkNemSiwnmlwWfAg+pZVVxIxbYnTYUYc3
         PT/4Qa0jYTogsmyVQcVb9LV6H/WXiPtmsqUwnoyKA/V8P34A2hKUr2stN0bOsI59IW+i
         FPC6Gw3kWXPVmNQGks6zP6jb73XwYzsXIH02G2d7JoSyTzpkT9apGvuB3wsCP2x94/kQ
         zcbg==
X-Forwarded-Encrypted: i=1; AJvYcCXr31D7S+Vljy3c3iEoe8LL7Lrzq8GLatokXPP8+80AbB1S5OvDC7U1jJEITiTmT+Afr6Io6KdDYn4QtG01@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9ONal/COFX1H6lpT579G7mYqioPeQ6AWWOe/FRwasOgm6jTk
	/eQjKeQ8JW3YCmVzJWdmEoitpTExlvsZW5yhBy2yo599iYLX7eOQ4D3C+IQBLMw=
X-Google-Smtp-Source: AGHT+IHYps5wy4yAP8JFwwnJ26Kg47RekaD9ISPH6q5Ssg2xxBuIMWOnmkAyFQ7ndX6rNgjJEMaZPA==
X-Received: by 2002:a17:902:ccc9:b0:205:68a4:b2d8 with SMTP id d9443c01a7336-20fa9deb634mr7955565ad.11.1729635012431;
        Tue, 22 Oct 2024 15:10:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::4:56f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e9b0b33adsm16091475ad.237.2024.10.22.15.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:10:11 -0700 (PDT)
Message-ID: <070c7377-24df-4ce1-8e80-6a948b59e388@davidwei.uk>
Date: Tue, 22 Oct 2024 15:10:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 00/15] fuse: fuse-over-io-uring
Content-Language: en-GB
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
 Ming Lei <tom.leiming@gmail.com>, Josef Bacik <josef@toxicpanda.com>
References: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241016-fuse-uring-for-6-10-rfc4-v4-0-9739c753666e@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-15 17:05, Bernd Schubert wrote:
> RFCv1 and RFCv2 have been tested with multiple xfstest runs in a VM
> (32 cores) with a kernel that has several debug options
> enabled (like KASAN and MSAN). RFCv3 is not that well tested yet.
> O_DIRECT is currently not working well with /dev/fuse and
> also these patches, a patch has been submitted to fix that (although
> the approach is refused)
> https://www.spinics.net/lists/linux-fsdevel/msg280028.html

Hi Bernd, I applied this patch and the associated libfuse patch at:

https://github.com/bsbernd/libfuse/tree/aligned-writes

I have a simple Python FUSE client that is still returning EINVAL for
write():

with open(sys.argv[1], 'r+b') as f:
    mmapped_file = mmap.mmap(f.fileno(), 0)
    shm = shared_memory.SharedMemory(create=True, size=mmapped_file.size())
    shm.buf[:mmapped_file.size()] = mmapped_file[:]
    fd = os.open("/home/vmuser/scratch/dest/out", O_RDWR|O_CREAT|O_DIRECT)
    with open(fd, 'w+b') as f2:
        f2.write(bytes(shm.buf))
    mmapped_file.close()
    shm.unlink()
    shm.close()

I'll keep looking at this but letting you know in case it's something
obvious again.

