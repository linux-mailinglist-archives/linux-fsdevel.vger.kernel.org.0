Return-Path: <linux-fsdevel+bounces-41209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78CA2C543
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C261677B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791023ED6D;
	Fri,  7 Feb 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xlHiBUBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947722069A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938600; cv=none; b=gnL06vxsLJYf4QDXNUluT2aa602DC/y0TxO7laiyGoDtMOxNZ1Ejhsrs2JkLLSTA+DScmHZp1jb6eD1QR6tDgS7JYc1v0k1SjuJhQIkSJcODx+JSiI3VZySLR0xusHYuKtD0MVQDfyZ4wHl96Sb/s266QPrFoEtNR7hHopYr6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938600; c=relaxed/simple;
	bh=YTa6ov9b5XOK3EO+RwdO9zZmT4AW4O8xTz2pzZj6Tgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bH2MlLr2knnWYjX/vQ8UVX86/F4QK4Gryh/UjvCM21qPJ/K+GU78FsT1T6zpnPXpzUxeR4GcOxgWNp6cl9iiOlGPg1wUsFG7PXQxfPVoXzf++RS54xHNF7wFBmYaT4L0qXAoJl4YtsoefakWzAzb3bJ7cagJcd0djEywLmaY/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xlHiBUBs; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce87d31480so6462365ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738938598; x=1739543398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK9iHfXVPyKgVAcRe+WC3DkXEmQ7j6QGi4OQ4+GyxIo=;
        b=xlHiBUBsmYUt0oIdH4PV8ThYokKgBvsaDFef1OY44DAD4d9rGLUPmMtCDDngkVTz40
         5Vi5knJE74erKIqb5BjmbsPS226ZTiDXWSfLlm0NWokO0sYSZC/mrEzJyjoYEMlnPHSv
         UnR3g+T7nkfkNLKLmKPkltYkZbrsEEzWjqmp0Gg2sgQJ71x/rFsxT5mlSVWD8J3BqiAS
         zaSFVfAcBsADlHsguGNYBLzzb5aKu4Gmoy3MI3wIzciKp88XAzfqICV4HOWtZ3Up34BL
         3l5Ns8fz7llSAGBhk1ZcNku+OFt0SkqkeLm55x2vOoR2LO5Qj85L+MK/WCYcz/0OxazE
         7dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938598; x=1739543398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK9iHfXVPyKgVAcRe+WC3DkXEmQ7j6QGi4OQ4+GyxIo=;
        b=FEjaHgIx6IqJNY7yUwHr4eZ9YUmQ7RAnO26Alk7IuTIxsiSqQz2U6kHGesA7I5rk8o
         gfzzdP7GMq8A8N7t+sGg78vZinrKIWNcwdf+UD8Rl1MRTNYUn+i7gW3+GlwE/At9oNb5
         Rhy2XhtDwSsnnlv5VKMFTawC+URJjtiCAh2L58EERSNUWjtkgYBWaJp4325RCMN6u784
         6dE4DptlhwOtKgPe/kqqb1HXLLNy1PNSJ4O5lVF7pZ4g/n2XN/fuMPkewCM8blo6lpvr
         7YgJh9xFjSMRaSCgHnqeBqUXr8uSDRPQ/Xa/6i2LNWd6x+lNV6cKvzuW/XlDf+dleguu
         LZ6g==
X-Gm-Message-State: AOJu0YxKtO5rw1nfsZXMb+s1OkROGX5uv81ioH8wyRuxv/WomAPHwaWf
	E9wrT3fyfAi6pxi8JntFLyXOKrugmlG74pXzECOzhBFTikp90+4121diWdyYgcE=
X-Gm-Gg: ASbGncud27lLfroDrDLB3f60c2Vr6T8l+q37u1N83aAveCl1I1S6CEdksuxRJh+G+D6
	kaUTgXj5SaPbG7rvRcScMzpm346Csi7WpEEkNtUW2GkPHVkavvqFc7/yJc8gzmOSz9CW2Bi9EJ+
	5KUWBJwosqzYFjubra5O15p8cPntVkJVv3gDYa39kJZE4rnEhptCyAY3zDIYLhJEPn1ytPsY/XG
	+wpps1yD0VDOypYvXCpQL8hyCNnh8030aIX8OauSYQC1U99lvkyll7KbMkoTV6VpRQrCXGhuYAF
	DZOuJz3kRfU=
X-Google-Smtp-Source: AGHT+IGd7DnH33tkyJ8hxgyBPzgMaU05BkKvDWzJ0ikrIgFeRyaEdmsS2P+eeDbT7hlwKO1GFFjQvA==
X-Received: by 2002:a05:6e02:2163:b0:3d0:2331:f809 with SMTP id e9e14a558f8ab-3d13dcde9e4mr29029665ab.2.1738938597885;
        Fri, 07 Feb 2025 06:29:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccf9dfa95sm779444173.41.2025.02.07.06.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 06:29:57 -0800 (PST)
Message-ID: <6b27f9ee-290f-4905-a929-82d68f80ab2a@kernel.dk>
Date: Fri, 7 Feb 2025 07:29:56 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] io_uring/poll: add IO_POLL_FINISH_FLAG
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20250204194814.393112-1-axboe@kernel.dk>
 <20250204194814.393112-9-axboe@kernel.dk>
 <42382d54-4789-42dc-af17-79071af48849@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <42382d54-4789-42dc-af17-79071af48849@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 5:15 AM, Pavel Begunkov wrote:
> On 2/4/25 19:46, Jens Axboe wrote:
>> Use the same value as the retry, doesn't need to be unique, just
>> available if the poll owning mechanism user wishes to use it for
>> something other than a retry condition.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   io_uring/poll.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/io_uring/poll.h b/io_uring/poll.h
>> index 2f416cd3be13..97d14b2b2751 100644
>> --- a/io_uring/poll.h
>> +++ b/io_uring/poll.h
>> @@ -23,6 +23,7 @@ struct async_poll {
>>     #define IO_POLL_CANCEL_FLAG    BIT(31)
>>   #define IO_POLL_RETRY_FLAG    BIT(30)
>> +#define IO_POLL_FINISH_FLAG    IO_POLL_RETRY_FLAG
> 
> The patches use io_poll_get_ownership(), which already might set
> the flag and with a different meaning put into it.

Oh true, I totally missed that. I'll just add another flag for it
instead and shrink the ref mask.

-- 
Jens Axboe


