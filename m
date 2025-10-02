Return-Path: <linux-fsdevel+bounces-63313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223FCBB498E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1DD321C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0F326B085;
	Thu,  2 Oct 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FY3HUZKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA910243374
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424059; cv=none; b=b4k7jzUS9pVBV8STzkFOWbpAIbRtdcH5LTL8MXk65/OeVvTQxInuooyXHD0/d2CoZa2I1QElKyLMofpfAPKacRfng5ppD0GmQiksaDeYgaRFyd+9wJyK5yZY4X81GfPGfyKFIkUxbPrpeobz/w2X7Z3JNaF35g7rGWO7nqj6VjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424059; c=relaxed/simple;
	bh=DWu5dR4Lz86S2AgggcpTnA6S7OA/C7uP7lj7+WsDpqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfPYGtIj4ZPwwZq5v1bYbUmday0jEOlSJm0i1N3jRvlWc0rl0FXxk2x4Xc0gN7WI8WdVQDpcHiD7UdE8pvfjOI9ZyAHcSEkEpxsTE5or+p+lHmLDeHno/I3r0QMoovw9A00DUedrYCUmdYBCYP4cc6kIpNkYRnHvoQmUfRcGvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FY3HUZKr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-938bf212b72so41733939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759424056; x=1760028856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=FY3HUZKrjXbRq3WYTVv67dRMW4u+ydDODm4vlKWtOezuDNistJfyte0yLQxdnNZd6b
         YkC3zOH9GvXEw2+wHvVFepKTMLuoKjLOn4GAnX/NXX1whdFh2dFWk/HTrlBSZj+33PT9
         MpZfbbwKDViQq42JVyog79bW9VCbdpXO5Rg09uPl18x4vATRlwriw+tkvE6PWxKpydKI
         wKMkQQ4GTWYaGVyFAtSEHh0doLB2XdnR7WoPZedm5ihdmfHIpcUhgGzToQLOz5heMnBK
         AEyrruTVurB1HI6tHWc5sn+VUJXdaPizc3SCwQNY2wcZ+MV8Jyq1XIMskQHo+d/1MynD
         BkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424056; x=1760028856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=nJ6bAHYRsmU12DnQ4GAEapyR4Nk1syDDHDIn2k669JOioxSI/Cv83jmznnJBeatJZO
         kCsvn/05NItu/pWLz9SeFrygxtlbJcGAbKG49m6f0i6G+Z9XVzyVg/oNpYtjPtycc+EB
         1nupw5K4ZqcWoBMPCJwf96v6x1m8mVDUFqoSWBPTggyorbeL+jSNBHJ661wnbvNdxkif
         +QcbAfNgsQSZgTgP9KKwIYd2a3j72Gba45QzCybcu+vlR9d04C9xuWhcHGjllUakolgP
         Pz9/3KOJDZvG1QzNM1q/CtlQnaj1vkilzb74dVZKZUrO9Kvfyg6/2pcIo/ENO1H3L5CV
         gZXw==
X-Forwarded-Encrypted: i=1; AJvYcCXfXr9X/7jNsLirKg/C+7aQBFT9KuthtlZ2mj8I3O3GTir+OZmUz03SbzMmxz9xWtoLxjjJ0wFxW/vfwSOC@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrp4G2gkdH9cXL/1iyGkpTYYscNuLdjlvGiVdC8pmeBMkk9/J
	yz9gR3YkYsvZjc8adZxdg8APlofyCwZ0c9pbfOyKH4bSZQ5lHxIZsiRBN8ne/mOpeeTiOU+Qn4f
	Xui4MVJA=
X-Gm-Gg: ASbGncvr3dGfF/Vazi3r12nMYKESgcSZs+oF66A4u9ZFrsBdJrEOW4vo0rkXx8hZLuS
	1JCZZNwYX9TOeM0vv34w/NyXFJbahMSPQNKmlvIQZJSuVOhDqvq0slJj74bQsiKfRbHIsoEGmbn
	6hgWPO76yVHDT7bagxPYfxYjnvZTgxdnmV8wigjGGcN6FfVJti730ZYuk08+5Gdxu9w8uZIxmKY
	v0zlxCsXukEjyebUyADypzP3QITq4ec2/HUTbOlLQ/PILL8BeTiYpaPIkqzDvR4zoW9cCARRXKt
	EUVN0kHXbhsnxuTCt7PdWbyvLexbVfng7Qg2NglnUf9jNSpp5ReaDo4wqtgox3oRICpYmnYmrWg
	j2QU8qeL1E1Fu10xvkAGzCMJD9cp2fvOb11uTCoWals2T
X-Google-Smtp-Source: AGHT+IHH+bU75feOc3kd43cHHM5DdNH15l/a1Pxl+MA4svn7zHgpfz9FVBhHlZNAnl8YqGJNYlTTlQ==
X-Received: by 2002:a05:6e02:1988:b0:424:80f2:2a8 with SMTP id e9e14a558f8ab-42e7acef8bdmr2852995ab.3.1759424055705;
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea805c7sm1005335173.32.2025.10.02.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Message-ID: <4054d4b9-29ca-4164-933a-49143755089f@kernel.dk>
Date: Thu, 2 Oct 2025 10:54:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
 sth@linux.ibm.com, gjoyce@ibm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
 <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
 <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 10:49 AM, Linus Torvalds wrote:
> On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Sorry missed thit - yes that should be enough, and agree we should get
>> it into stable. Still waiting on Linus to actually pull my trees though,
>> so we'll have to wait for that to happen first.
> 
> Literally next in my queue, so that will happen in minutes..

Perfect, thanks! That's what I get for not being able to send things
out early :-)

-- 
Jens Axboe


