Return-Path: <linux-fsdevel+bounces-43144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA41A4EA44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF015421DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EB2620DE;
	Tue,  4 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SP/m4BJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77282294F14
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109780; cv=none; b=iHNjc6F3s62FFEznKTidbjf8r8JaXhILEvYtC3RT8G0Ohy5x9WHYYGHptLwdUex3uyOqE9Cw3ImQmj2txtoXZVFtDi3XIX2vNvUJFgINzg7VIfm3kLUcloJBlIehqjepE687lFaPo+PNaB9x8W1oW8sYklOLg2gPamEIWO0NUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109780; c=relaxed/simple;
	bh=cGve03eM0mfVSh/dijJxn0ZZN3AFYvT2CAf0OZTk0ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8O3mzV7JGRfuQ4bCfwngvv3wvPi0mYlpxF3f/CYOMmBTRjpphldmImTbtFUQbE2t+Md4vlRCO2unUTVSglJwOIjFgOHfGmrJFVqT3AiVlX+sHMM2cCvJfO2qlXH950kcAcNZJ1BbhijUm2dvHZd7kKXZFJ0QeocKjQZEKZANsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SP/m4BJx; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so21566285ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741109777; x=1741714577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTw0QZTXxBViPg+OztJZ1wyTVYMoQYR/h//Gd3FEvPk=;
        b=SP/m4BJxmPj2tQpIVxtGFMbfrkQsrvNx4G74kVcG9WUZ+FnKN7ZBsLv0mvksnJC2ih
         ndCxcUI+pW6qhjsbUm2tnVRlfmj17x7r3WtybwMy+g18tGGgwj6h6IPkZJmjzX07OAWD
         A1rRjUx20VbbJgaa1YCxQbFRgfuEOfxPzVM4Jv5THjg33V04nBvQXN93tFcJXeEw3b/Q
         /X3pGmcEVZ0vy3L4KKlN0dJQ+pmGxrYcxlJuxxi2DdKv2dptHeSGsuHloc0KI4gbDH9Q
         9iK0WApQJILLnl8lebaAPA0/ZRuE8LFI0BuXtA2XdQKXEQ6FAeb+iwA/VmW0x//rM9v4
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109777; x=1741714577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTw0QZTXxBViPg+OztJZ1wyTVYMoQYR/h//Gd3FEvPk=;
        b=My4cTunvITJ+Dh97wbTXj581mBaE8aCUlTggqk5c7tcRLOjRZyLcIafiKy+LfmEeYH
         PTcF9TnCG/W5ztGirGjjfW6elAxupnhUlqf1BuZkg7M24V5ras0kCYurSdixoPjo+ic4
         lBiu7o1oX5MYwIV7mUEdl89uCngD1sVZPcUm65BrxYhf6TqH0mulqJ10uZLMLcaQV7Ha
         nTyIo7UxrIyyVgkzHU79QqcFCtuVeYqIipWkcoJgAzz4mtGIoV7BDvnN2pPOkUPm1Nt7
         rKRmqPpaXAq8hGXCVJ5FWgrvIqUqWWxXd1XTn/6ojlSAQ8DuVribcDJ0i2k9DFi6lfK4
         vKwA==
X-Forwarded-Encrypted: i=1; AJvYcCUydSNKFWhveTEb4Cls0L/UxnoboK5tCzqtslpR7FIy/+Rv/gFQH28lFUlUVuh1c/ijp4vqisz2xgN6OpOT@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHNY6qeNTud5jajhkPu9q4M2nMWJO/NOCDeAcXuUaRhhfE6lN
	DDnDeRAzH8IDYx/k1Nr4D9SjNYzl1ESwzDVDVNzzecIjJrRi1gjSLUbrbiPBLDw=
X-Gm-Gg: ASbGnctNS8P/PThjyWt7bgdpxGYhTLWw7YLvnTJ3a9iCW25QwBbKG1KArdAcVUUAvLt
	ml3qmG4t1aO7x+J9s/Bf2q+O7VavNF/lkEHgqmwuuNrO6CvwGRGroJ9LqN8TQQ32vARY6MHdi08
	jAunEAxOI0C5fTBiEot9L0Zf+yHjlOl9vESIHr3f53iPMOCNtDpHLhUDcPMKoTkirdPcE5xzjTD
	hyzRpZ1AoBmQGj2sI4srUWpdrP+8zvT1dSU2eCRxlzLorlyYAAQPPB1sEa8krOz6fpW2s+V2mrC
	zgIJSXYJGbzD8dHOu1eSeOnjW85yK3KEvaT7uXNX
X-Google-Smtp-Source: AGHT+IEl/2lIWs82Nv24HzYA9GHvLqSrtH2R7AH+4lb9o2W0G/5k1g2vm+bZNB8ReCXdDLPCo54h1Q==
X-Received: by 2002:a05:6e02:194b:b0:3d1:78f1:8a9e with SMTP id e9e14a558f8ab-3d3e6f565b3mr167094265ab.20.1741109777525;
        Tue, 04 Mar 2025 09:36:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3dee67953sm31940025ab.19.2025.03.04.09.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:36:16 -0800 (PST)
Message-ID: <1e7bbcdf-f677-43e4-b888-7a4614515c62@kernel.dk>
Date: Tue, 4 Mar 2025 10:36:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iomap: propagate nowait to block layer
To: Christoph Hellwig <hch@infradead.org>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, io-uring@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 wu lei <uwydoc@gmail.com>
References: <f287a7882a4c4576e90e55ecc5ab8bf634579afd.1741090631.git.asml.silence@gmail.com>
 <Z8clJ2XSaQhLeIo0@infradead.org>
 <83af597f-e599-41d2-a17b-273d6d877dad@gmail.com>
 <Z8cxVLEEEwmUigjz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z8cxVLEEEwmUigjz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 9:59 AM, Christoph Hellwig wrote:
> Stop whining.  Backporting does not matter for upstream development,
> and I'm pretty sure you'd qualify for a job where you don't have to do
> this if you actually care and don't just like to complain.

Sorry, but wtf is this? Can we please keep it factual.

You may not need to care about backporting, but those of us supporting
stable and actual production certainly do. Not that this should drive
upstream development in any way, it's entirely unrelated to the problem
at hand.

-- 
Jens Axboe

