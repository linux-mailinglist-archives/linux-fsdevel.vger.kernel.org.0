Return-Path: <linux-fsdevel+bounces-43415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEDA565AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 11:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99D6177B92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406720B81E;
	Fri,  7 Mar 2025 10:47:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC0382
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344474; cv=none; b=XFtv83mN44Le8Y/Z84xjI5oqudQwvjkOxJq3bNSzbPeW7SJfrmUcKkzOSeKZlMAi5NlP5R/Tr5IudT3sHxUaq/9Qx38pKDiDV/eUkB4efoxSP5SMBksbDPpJFaq+pds8W/QLu4SBZf248awYtlcyAPbFuGL0hXUomc2ZGJwDMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344474; c=relaxed/simple;
	bh=66LIJRgvtmb82m4Prv1VGMy3lyra4Xy0ff/krbhsFuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTePhwTlruAUX/RGjuGU+GbkHUCMCUMWTRcTJJNCdpL3qZ3IBErKJIN3scPf1ebcDv7CkGLhJ6l/uFRYl5VLQtBlbjIFB7wdQU+/7CSCXW1YxnHi5rSjg/1Gal9eH1BY9p/v1vUta8jYsR20z4KObmLJFjudZ20cj7Kt6Pg1WfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.28])
	by sina.com (10.185.250.22) with ESMTP
	id 67CACEA60000032F; Fri, 7 Mar 2025 18:47:05 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2029257602334
X-SMAIL-UIID: 6D67943474CD4499AA6E9DE897B1B042-20250307-184705-1
From: Hillf Danton <hdanton@sina.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Hillf Danton <hdanton@sina.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Fri,  7 Mar 2025 18:46:53 +0800
Message-ID: <20250307104654.3100-1-hdanton@sina.com>
In-Reply-To: <6ff2e489-7289-4840-868e-9401f26033c6@amd.com>
References: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com> <20250307060827.3083-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
On 3/7/2025 11:38 AM, Hillf Danton wrote:
>> On Thu, 6 Mar 2025 10:30:21 +0100 Oleg Nesterov <oleg@redhat.com>
>>> On 03/06, Hillf Danton wrote:
>>>> On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
>>>>> On 03/05, Hillf Danton wrote:
>>>>>> See the loop in  ___wait_event(),
>>>>>>
>>>>>> 	for (;;) {
>>>>>> 		prepare_to_wait_event();
>>>>>>
>>>>>> 		// flip
>>>>>> 		if (condition)
>>>>>> 			break;
>>>>>>
>>>>>> 		schedule();
>>>>>> 	}
>>>>>>
>>>>>> After wakeup, waiter will sleep again if condition flips false on the waker
>>>>>> side before waiter checks condition, even if condition is atomic, no?
>>>>>
>>>>> Yes, but in this case pipe_full() == true is correct, this writer can
>>>>> safely sleep.
>>>>>
>>>> No, because no reader is woken up before sleep to make pipe not full.
>>>
>>> Why the reader should be woken before this writer sleeps? Why the reader
>>> should be woken at all in this case (when pipe is full again) ?
>>>
>> "to make pipe not full" failed to prevent you asking questions like this one.
>> 
>>> We certainly can't understand each other.
>>>
>>> Could your picture the exact scenario/sequence which can hang?
>>>
>> If you think the scenario in commit 3d252160b818 [1] is correct, check
>> the following one.
>> 
>> step-00
>> 	pipe->head = 36
>> 	pipe->tail = 36
>> 	after 3d252160b818
>> 
>> step-01
>> 	task-118762 writer
>> 	pipe->head++;
>> 	wakes up task-118740 and task-118768
>> 
>> step-02
>> 	task-118768 writer
>> 	makes pipe full;
>> 	sleeps without waking up any reader as
>> 	pipe was not empty after step-01
>> 
>> step-03
>> 	task-118766 new reader
>> 	makes pipe empty
>
>Reader seeing a pipe full should wake up a writer allowing 118768 to
>wakeup again and fill the pipe. Am I missing something?
>
Good catch, but that wakeup was cut off [2,3]

[2] https://lore.kernel.org/lkml/20250304123457.GA25281@redhat.com/
[3] https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/

>> 	sleeps
>> 
>> step-04
>> 	task-118740 reader
>> 	sleeps as pipe is empty
>> 
>> [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]
>> 
>> 
>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/pipe.c?id=3d252160b818045f3a152b13756f6f37ca34639d
>
>-- 
>Thanks and Regards,
>Prateek

