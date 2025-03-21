Return-Path: <linux-fsdevel+bounces-44683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0EA6B592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30B43B55C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A21EF0AA;
	Fri, 21 Mar 2025 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="wH9jo+0c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8526ACB;
	Fri, 21 Mar 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543772; cv=none; b=BGUxTCqXOuzWT2k4rHjXIfGkuBBHq8clpy7QPKW8PpDnAQEuIKhvHfFhoHKD4yn5KgXgiDLhVxu9KMDlGUpq2qiLFooTXocvopHqTZhUUnn3OTnNkEzW0ygm5D7HKKnreYJQXh/kqH0RB5npjwWRU1nAtOoiFDjN+eePBQVsMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543772; c=relaxed/simple;
	bh=O7zthI6xGCKRlOvN8fVyhphd8wmtwfCyQyQcqNnGvs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IN3/5NJrHtbm489kkT8/ODgOa6SKdCFpehVKFlW9QZK9m5FpxdEUhftY0pY5grVRBlXKcG7ZO6OiDv8BPl7P4OeKzt2YV0leEx7LH3gsqSJPtaBG50cLe0Kn8/OUuPrscSTgVinjhQcM6gFhdx2iJufmoAPQOpyEw6eSrDg2/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=wH9jo+0c; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=OBxjNrd6hcTR//R8RH8pAAyEucot3xHc00neUSfAF80=; b=wH9jo+0cwMrmdpUrnXDCQ5ITTj
	yjTLD0wJIEocyiU8G8rBT5DSf6LNGU23XiCTmqAq4ByfrxBPvuxy62xWcxcuG0BJhjOTLUP3NZ01c
	1JTSMWdGpfkBlXE+W99xrSaNKb6Gp/Hs3UIqZH5dqQaUGru5Kf7XFINYc9uCKGJTJG+UQbIdtiTNT
	QQjZeQ6qTGmUQL2Sb5SokCso6Czee3noq3LtJFeixQB/XdmAFEJAEX/KgKwhvQbYDvnrWNmZMM/x7
	qQ3WV7ynXq97fTB3wOx6JMjNJiLjotKHHrE3E+8RAcFXA1yDGGdvRyRU5VYW/JJ7RMsdmqb/aXbbP
	1tiHFC9Rp3cY/Pr9lHU1JAGEWK/3Tk649NllVAZTuFimvIe5N0orFOtR7Mls2KplAPQ82ZQiMZ3GQ
	0VJv8Rn6Dt+pJ8654iR+HrWOI5w70sr9xp6lhmdQKSoR8ih+HlGJBo2wTFcfGKAYFpfbQQ1rdjyj4
	HkjdYz357PbFXitr0VHtgWVm;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tvXEV-0062FN-2N;
	Fri, 21 Mar 2025 07:55:59 +0000
Message-ID: <0fc1032f-908c-4e59-8f64-f22b380ae639@samba.org>
Date: Fri, 21 Mar 2025 08:55:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
 <356ce660-fc2e-4016-a0d9-6896936669c2@samba.org>
 <fbcd759e-2453-4570-a2a0-c9ad67ae9277@gmail.com>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <fbcd759e-2453-4570-a2a0-c9ad67ae9277@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.03.25 um 11:46 schrieb Pavel Begunkov:
> On 3/19/25 19:15, Stefan Metzmacher wrote:
>> Am 19.03.25 um 19:37 schrieb Jens Axboe:
>>> On 3/19/25 11:45 AM, Joe Damato wrote:
>>>> On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
> ...
>>> My argument would be the same as for other features - if you can do it
>>> simpler this other way, why not consider that? The end result would be
>>> the same, you can do fast sendfile() with sane buffer reuse. But the
>>> kernel side would be simpler, which is always a kernel main goal for
>>> those of us that have to maintain it.
>>>
>>> Just adding sendfile2() works in the sense that it's an easier drop in
>>> replacement for an app, though the error queue side does mean it needs
>>> to change anyway - it's not just replacing one syscall with another. And
>>> if we want to be lazy, sure that's fine. I just don't think it's the
>>> best way to do it when we literally have a mechanism that's designed for
>>> this and works with reuse already with normal send zc (and receive side
>>> too, in the next kernel).
>>
>> A few month (or even years) back, Pavel came up with an idea
>> to implement some kind of splice into a fixed buffer, if that
>> would be implemented I guess it would help me in Samba too.
>> My first usage was on the receive side (from the network).
> 
> I did it as a testing ground for infra needed for ublk zerocopy,
> but if that's of interest I can resurrect the patches and see
> where it goes, especially since the aforementioned infra just got
> queued.

Would be great!

Have you posted the work in progress somewhere?

Thanks!
metze


