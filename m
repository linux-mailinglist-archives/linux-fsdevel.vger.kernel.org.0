Return-Path: <linux-fsdevel+bounces-62394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEDB9127B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF09189E5EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81182307AF0;
	Mon, 22 Sep 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JIWNC9vW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FB3074BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544828; cv=none; b=ZCrokEHZzhHxTYNPagyTeriPtrpyGh8JinyLKyY/btwVifxFMigRTZuufbcVOl0I4Az4vdVlo25UfW3WCog5jqXzvK6wEm5sbJK2c3R5iF9UB9wFTgRVxT1tf7MwqIp9IpwEfeRuKac/UgZlsv5fgplMeD0oRWiYWsIcQZoyk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544828; c=relaxed/simple;
	bh=oLCLpX2jtMBtuMbPjtYboKL7moJwuIOjpinv3gJLa8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfwEVWdQFipfzX1F2V4tcGvDwV8w3M8tGb0FKDovAIfH+gjeBU+NlF0WeUT9L3aN/QoErHghYr6InLnZTh1I2ir7YOfFmW3qUulQSRYSpVTAOODlgWrmWpLrguCdYgAZA5Odhw0Fo1F/bTq5VVNNGRSXdYCX/0sVe2efPv/yW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JIWNC9vW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f581aeso42749775ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758544827; x=1759149627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=JIWNC9vWKgq4nJ4XGZi+fLxUA7972ER4xbpiw1wdSiQt/xQVsbuRznugYEUa90+ucv
         0ZSR4QsJq3Sp4n1xMAsuO1vsritkMSfdJVWafay0mc5hgnbakceN5gFTQfyoFqy0RFNb
         DfIgEmgLxplEHXMsXO7QYFRBq0GInJYD6bne/Z46WhrtK1PvhS6oNcgXaiM2xC9HOUPK
         rX5hSgfZ05NPDxUeCOCYj293GRgxjwdMuchbVNcQA5CmYxAdVjbAVRGEmrbCzKeTdRsm
         UThbeKOw1xZ15eo5ca+hyFN2152Y/VvHdhOFSLUP/2nnPkijbwbgtKOmeNYiwHBeASWO
         3nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544827; x=1759149627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=SXSyoYDFgYRMrAs7hoA7T/1gGLfhoADrMBvSMV8F6HmlP3RrKTGQHWSiJbemIuPDdI
         j2MT3te0WgfXHXwbTDkaq17KqIQA16N4v+5Qsb+36J5wsBcE5wCZwWW5MxxuaA1nSK+l
         eGcy7EbM1A9HdSwKqitAiV1uIJAeaYTnY5jU18Xt1t2U0pXBJ7uqqbu0IXo61PiBwZqm
         MjZ1US5FzrJ3oeyH7qpqa0sUc9Sv5k+BBBIjLz5E+Yf5mVLTwj0mKhVPl45VgtKzrfX7
         Hhjd9+8w4REXO2jNOKYXM4zHazZzF8d/fRoZ1lX8RhhNBiczrQ9yzErvydEN7o4du2SZ
         FIlw==
X-Forwarded-Encrypted: i=1; AJvYcCXyyxLIGknPlNZ8aq2qQKfVRDyJnbzs4yq8oeTvSc//ueKT1/1xPPXdJ7qg6LX7PEb7Nk04Z+Iq0+KWvDds@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaBTFhtFmuDccmnSSmAX3XGhwDB/7xX2mgWBdc60HfaLFh8ne
	gHfEhMWkcLw/X0I6iQEuulPBH+pL+iN4T+aesl5HYANfl0BCwZHRPdiIeAqj5gAEMnk=
X-Gm-Gg: ASbGnctc3R4hc7w5FNk1fHTOGLXunmB5gc2QU/PhwiP2cik67aaR4G39H3OGusHIxy1
	5xElwB2+O/WrMG+beJ/KRiiXHRxA+yDVpb5UdHPyBFkr9hWzm1XEaZmFYATUSmM7qeKwTFeIA4H
	ME/u43RU/PVsQQbbeQZIIucXh1hqayMU3CbFL50EI9IHyKB13Wz/Lpkv3AzZT/cES6LAgWccdim
	XfiAxa4ko/sc25gpuKYexZYnGTl2oeKmQfe6D8cIyzPM/ZvrvO9ts/1suETx1Yd9bhYIhK/hOcS
	ZSub0gITa3axBj/xMl6vnnxiT+DfpM7l4qEkmbgNaHMT69hucY9lb5m0GcofF+gTs52F0jj83dz
	aJmZoWTyZs7xXSh6SGNhvCsbChS75viKlDW2SnFkjgsimNZVesumrVegwD4nctCq+sT5B31rDxP
	DkiQ==
X-Google-Smtp-Source: AGHT+IEGBrT3SnJhTkV8mglXja6cN7Am5iY4FgOJYWx37m7MRPV6ezOU1/PoiKvENYX09R5NpTy6hA==
X-Received: by 2002:a17:902:bd87:b0:250:5ff5:3f4b with SMTP id d9443c01a7336-269ba467e97mr116112925ad.15.1758544826621;
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm131280655ad.54.2025.09.22.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Message-ID: <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
Date: Mon, 22 Sep 2025 20:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Lance Yang <lance.yang@linux.dev>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 7:38 PM, Lance Yang wrote:

Hi, Lance

Thanks for your review and comments.

> Hi Julian
> 
> Thanks for the patch series!
> 
> On 2025/9/22 17:41, Julian Sun wrote:
>> As suggested by Andrew Morton in [1], we need a general mechanism
>> that allows the hung task detector to ignore unnecessary hung
> 
> Yep, I understand the goal is to suppress what can be a benign hung task
> warning during memcg teardown.
> 
>> tasks. This patch set implements this functionality.
>>
>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
>> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
> and might mask real, underlying hangs.

The flag takes effect only when wait_event_no_hung() or 
wb_wait_for_completion_no_hung() is called, and its effect is limited to 
a single wait event, without affecting subsequent wait events. So AFAICS 
it will not mask real hang warnings.>
>>
>> Patch 2 introduces wait_event_no_hung() and 
>> wb_wait_for_completion_no_hung(),
>> which enable the hung task detector to ignore hung tasks caused by these
>> wait events.
> 
> Instead of making the detector ignore the task, what if we just change
> the waiting mechanism? Looking at wb_wait_for_completion(), we could
> introduce a new helper that internally uses wait_event_timeout() in a
> loop.
> 
> Something simple like this:
> 
> void wb_wait_for_completion_no_hung(struct wb_completion *done)
> {
>          atomic_dec(&done->cnt);
>          while (atomic_read(&done->cnt))
>                  wait_event_timeout(*done->waitq, !atomic_read(&done- 
>  >cnt), timeout);
> }
> 
> The periodic wake-ups from wait_event_timeout() would naturally prevent
> the detector from complaining about slow but eventually completing 
> writeback.

Yeah, this could definitely eliminate the hung task warning complained here.
However what I aim to provide is a general mechanism for waiting on 
events. Of course, we could use code similar to the following, but this 
would introduce additional overhead from waking tasks and multiple 
operations on wq_head—something I don't want to introduce.

+#define wait_event_no_hung(wq_head, condition) \
+do {                   \
+       while (!(condition))    \
+               wait_event_timeout(wq_head, condition, timeout); \
+}

But I can try this approach or do not introcude wait_event_no_hung() if 
you want.>
>>
>> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg
>> teardown to eliminate the hung task warning.
>>
>> Julian Sun (3):
>>    sched: Introduce a new flag PF_DONT_HUNG.
>>    writeback: Introduce wb_wait_for_completion_no_hung().
>>    memcg: Don't trigger hung task when memcg is releasing.
>>
>>   fs/fs-writeback.c           | 15 +++++++++++++++
>>   include/linux/backing-dev.h |  1 +
>>   include/linux/sched.h       | 12 +++++++++++-
>>   include/linux/wait.h        | 15 +++++++++++++++
>>   kernel/hung_task.c          |  6 ++++++
>>   mm/memcontrol.c             |  2 +-
>>   6 files changed, 49 insertions(+), 2 deletions(-)
>>
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

