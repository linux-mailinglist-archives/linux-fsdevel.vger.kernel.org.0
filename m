Return-Path: <linux-fsdevel+bounces-47034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C6A97E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D9189E21C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089F265CAE;
	Wed, 23 Apr 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OIwcIGZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD37EAFA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387414; cv=none; b=D0tF4/kboeSn7Asx/QDHlzt/3raucb+8quX1hM0utCviasccORBfVPPjR3JEqMCJMkaf5zPy2tanWBTo01JJrLsnTReFdqH0VhNnUzOFx5jxEHrfToKh44qUdTAAk+XfNPU5dL+2xAHgNu1L4fMDd0AvpcU0E2qB/4+zbgSrxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387414; c=relaxed/simple;
	bh=O7A8C/C5iSMLbfnZBVli7mC9PowKZOC+BPYzHLM/glo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liImC4xiPJwT/juAAP1wwS2fwgBYTzIQMI7cDwOv9Pun1gPCT9IpA5svX9cF/7qn1oZ2NH9NSskpQzqr7mHU9Qjh1AUSY4eDejiQSLWIjjJTOWIUo8jfALL8vQmQKWBMcrfO0XNUBHv1C8SbNfKzBHLOVQz+I9HF4mOTpzqr/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OIwcIGZo; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745387402; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VHOIf0yHz7LV8ovB2wO7Gqyl5LS7GnuDmulrFm3IDRI=;
	b=OIwcIGZoFjqEvoHeRCTuY5RVJ+9dQCBlzy4tTwmlwvq+l9ueTMBcDubd1drDoJ61ifyGSZ8DtonafmASngQzGTerIobe+svfc+GWMNxgv/bCBQ6J/s4LZVup8EijfUHZqyLO1HEQHusNK5wOaHO+CeaxR2YESEcZo6vl2T5UKnA=
Received: from 30.221.149.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WXtHHsY_1745387401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 13:50:01 +0800
Message-ID: <aa430dfd-55dc-4079-8bc8-b63cc8a999bd@linux.alibaba.com>
Date: Wed, 23 Apr 2025 13:50:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: optimize struct fuse_conn fields
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20250418210617.734152-1-joannelkoong@gmail.com>
 <0cdd1c6a-ad51-48c5-846e-f61b811fc7ad@linux.alibaba.com>
 <CAJnrk1ZN3MwWX8gdR7bu5jX5BpDzS_hyTs_V8S_oMh1fcm0J1w@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZN3MwWX8gdR7bu5jX5BpDzS_hyTs_V8S_oMh1fcm0J1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/23/25 12:25 AM, Joanne Koong wrote:
> On Mon, Apr 21, 2025 at 7:07 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 4/19/25 5:06 AM, Joanne Koong wrote:
>>> Use a bitfield for tracking initialized, blocked, aborted, and io_uring
>>> state of the fuse connection. Track connected state using a bool instead
>>> of an unsigned.
>>>
>>> On a 64-bit system, this shaves off 16 bytes from the size of struct
>>> fuse_conn.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/fuse_i.h | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>> index b54f4f57789f..6aecada8aadd 100644
>>> --- a/fs/fuse/fuse_i.h
>>> +++ b/fs/fuse/fuse_i.h
>>> @@ -690,24 +690,24 @@ struct fuse_conn {
>>>        * active_background, bg_queue, blocked */
>>>       spinlock_t bg_lock;
>>>
>>> -     /** Flag indicating that INIT reply has been received. Allocating
>>> -      * any fuse request will be suspended until the flag is set */
>>> -     int initialized;
>>> -
>>> -     /** Flag indicating if connection is blocked.  This will be
>>> -         the case before the INIT reply is received, and if there
>>> -         are too many outstading backgrounds requests */
>>> -     int blocked;
>>> -
>>>       /** waitq for blocked connection */
>>>       wait_queue_head_t blocked_waitq;
>>>
>>>       /** Connection established, cleared on umount, connection
>>>           abort and device release */
>>> -     unsigned connected;
>>> +     bool connected;
>>
>> Why not also convert connected to bitfield?
> 
> fuse_drop_waiting() checks the connected state locklessly through
> READ_ONCE(fc->connected). The smallest size READ_ONCE supports is a
> byte, I don't think it works on bitfields.

Okay, that makes sense.  Thanks.

-- 
Thanks,
Jingbo

