Return-Path: <linux-fsdevel+bounces-46392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075FA885B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4209819081AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D892296D0E;
	Mon, 14 Apr 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W6FdC4D/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE642A92
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640980; cv=none; b=Ub/OadQ+UYnfYtk0hkr2DoNyV1W3e6EOJOgl7EVdnRpYTU6APaYt1M9fBedrMi7GeAXj7yGMYjbBXcT9vFqKQza1iw2o5GQDWSwm5t0hLvkWJDqSw66SnHDGiZR+RApWUKLXVEzKnXdwwV79mow7iaiGzYEUVxzXCQXfvAQ9uEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640980; c=relaxed/simple;
	bh=xrn5wfYhTrS14m3EcQUIIlXCmc+aQ3BjPvdH9k2BM7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5IoPnkGi8zQmtUbWhE8nbNqi130lGurix0SpvWfZfF/MgjmWbVrussDKC0ujL6nOJ2P7DinHntNQR7bY3bHhxRFjNYOGAcJ9zlCEki0H3AHqJdmOzZS7N/Q74GgJq6kF2wktZcOBOmn7YCeq4M59G01gxY/QcApbYtxsIKoePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W6FdC4D/; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d7f4cb7636so4335145ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744640977; x=1745245777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1yYu8yQXLwEhLZXB69bga+C1rfzPofidjpYU39w4VI=;
        b=W6FdC4D/EtDU6mrXG8WyvRLIs/9PNzhOHxSEI89kNCJsqZCTmjpI7oEH8stZsujaES
         LyKAYzIeG/LNi0GGbr10EaYNNl/7Bwwmvon4Z62Le9vhc/sKbB9zwA5uXbsTRCxtWVKx
         ZXIPgF9+ydIw1JOlH2OjI6gugVNHIZ0h9eO4dxuMnbaxyhR6s9ffMkiFjdWysOg6yj40
         fabMhtxrjXvQKme11XnK3B3FXNPGCKojgUG4t/v7ziriPkdPoXjwMinvLl6M5iP+iNu0
         u9zzZxvq8h6xk8fkDwox0V+MwxmlHpgU+HBowaj+jm0uNKfjaIbu6VgpuOOTDjvu+Ry1
         Z3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640977; x=1745245777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1yYu8yQXLwEhLZXB69bga+C1rfzPofidjpYU39w4VI=;
        b=pDpSMTDHbWATPw8ZBkkR79H43e0knLfArSNAXgZTFbVnpbMkwuAOOb9KkTtM15qiPp
         /mJDYD6e/+RekTYDptDXzL6LWZMp6leV/OS/M9udce5vBnbbPaqU117Ml1/DYIR6ME81
         spoQl3vXgdcwdmMvufriZSx+hGfqBh7s+SGnJHkiPFPVb5BA8+IL7ZbRAx/T/vmC35ih
         RwR4qlbROtZQDvKUm3VHEbvopuQNqFzi5yTemMFYgn6ZMMducSNKQ6zQKn+jZKzxZjdW
         zWvR4AhLi85LBvoux2H0hqw/fFxf3TlAhlJoaO8MaAarCjFDJBIT6mkep+O9G16APId6
         LjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHQSDbGZW3x/fmrcBjqlI54oGSY9aDkzReR1XU9Iz3AXgw74aVV7bqy/evFR1yLh3hwysvpRwkj1lYJBKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfrkPBh/YmyM+w3GuwdbAEjwNdzQBxKrj824gUmsCk2+JSdrS
	4Lr71R/8T6ZiC5T22NFXvWa5drXvEWVVPEN0ywCT2GALBfi99Kx4JhBRV4uoBv0=
X-Gm-Gg: ASbGncsVP6r+XnJZkNVSczSIBVEyFPGaGvZamryf+QOHwMRkMDkySVe8Yj0mhuecAQ9
	0rWEQyZfypNzivRNJJqvz62L7YHD/W7OtmGuZmw773G7qNiDAYomzB++LJ6Uo06q2g8J5Lp/1HK
	spevK3UYh/2M5sZyxiuOKO3/I86Imc+2g00e+aUtiSpmco+XVYrFDstXGN+37SbRut5ujGU6475
	ZZ4LNvfId+UIt1s2G7xgABfrg+k9KUjP6DIzxNjmWmPpwUlQ4i2ZssQq9Uo66uA7LKp1eKxRhZv
	j5xLI+Zf945Pn2RTAkOPL1FDx09G+E3/sa+wSw==
X-Google-Smtp-Source: AGHT+IHgTb9OceURQXdiw9lwy+AMm5msOzwoMDpCHAEMkovZJ6nZ8AbWOE6ZRjIkVixcOUjTYcnLQQ==
X-Received: by 2002:a05:6e02:3f05:b0:3d1:966c:fc8c with SMTP id e9e14a558f8ab-3d7ec27c9a3mr124172185ab.17.1744640977074;
        Mon, 14 Apr 2025 07:29:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba85487sm27743155ab.23.2025.04.14.07.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 07:29:35 -0700 (PDT)
Message-ID: <85587075-1d54-4b79-94d4-39f615eeee24@kernel.dk>
Date: Mon, 14 Apr 2025 08:29:35 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs: gate final fput task_work on PF_NO_TASKWORK
To: Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org
References: <20250409134057.198671-1-axboe@kernel.dk>
 <20250409134057.198671-2-axboe@kernel.dk>
 <20250411-teebeutel-begibt-7d9c0323954b@brauner>
 <87fcae79-674c-4eea-8e65-4763c6fced44@kernel.dk>
 <20250414-unwiderruflich-daheim-8e14b89e7845@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250414-unwiderruflich-daheim-8e14b89e7845@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 4:10 AM, Christian Brauner wrote:
> On Fri, Apr 11, 2025 at 08:37:51AM -0600, Jens Axboe wrote:
>> On 4/11/25 7:48 AM, Christian Brauner wrote:
>>> Seems fine. Although it has some potential for abuse. So maybe a
>>> VFS_WARN_ON_ONCE() that PF_NO_TASKWORK is only used with PF_KTHREAD
>>> would make sense.
>>
>> Can certainly add that. You'd want that before the check for
>> in_interrupt and PF_NO_TASKWORK? Something ala
>>
>> 	/* PF_NO_TASKWORK should only be used with PF_KTHREAD */
>> 	VFS_WARN_ON_ONCE((task->flags & PF_NO_TASKWORK) && !(task->flags & PF_KTHREAD));
>>
>> ?
> 
> Yeah, sounds good!

I used the usual XOR trick for this kind of test, but placed in the same
spot:

https://git.kernel.dk/cgit/linux/commit/?h=io_uring-exit-cancel.2&id=d5ab108781ccc2f0f013fe009a010a1f29a4785d


-- 
Jens Axboe


