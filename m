Return-Path: <linux-fsdevel+bounces-2058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBE7E1DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4977728132F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6F171B6;
	Mon,  6 Nov 2023 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F94168DB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 09:57:25 +0000 (UTC)
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CFA3
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 01:57:24 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VGGZLFo_1699264639;
Received: from 30.46.227.128(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VGGZLFo_1699264639)
          by smtp.aliyun-inc.com;
          Mon, 06 Nov 2023 17:57:20 +0800
Message-ID: <2a2bf87a-87ba-40d2-8d10-c4960efbd11f@antgroup.com>
Date: Mon, 06 Nov 2023 17:57:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] fuse: Introduce sysfs APIs to flush or resend
 pending requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20231031144043.68534-1-winters.zc@antgroup.com>
 <CAJfpegtjNj+W1F4j_eBAij_yYLsC9A3=LgNvUymSykHR5EvvoA@mail.gmail.com>
From: "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
In-Reply-To: <CAJfpegtjNj+W1F4j_eBAij_yYLsC9A3=LgNvUymSykHR5EvvoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/2 下午11:17, Miklos Szeredi 写道:
> On Tue, 31 Oct 2023 at 15:41, 赵晨 <winters.zc@antgroup.com> wrote:
>>
>> After the fuse daemon crashes, the fuse mount point becomes inaccessible.
>> In some production environments, a watchdog daemon is used to preserve
>> the FUSE connection's file descriptor (fd). When the FUSE daemon crashes,
>> a new FUSE daemon is restarted and takes over the fd from the watchdog
>> daemon, allowing it to continue providing services.
>>
>> However, if any inflight requests are lost during the crash, the user
>> process becomes stuck as it does not receive any replies.
>>
>> To resolve this issue, this patchset introduces two sysfs APIs that enable
>> flushing or resending these pending requests for recovery. The flush
>> operation ends the pending request and returns an error to the
>> application, allowing the stuck user process to recover. While returning
>> an error may not be suitable for all scenarios, the resend API can be used
>> to resend the these pending requests.
>>
>> When using the resend API, FUSE daemon needs to ensure proper recording
>> and avoidance of processing duplicate non-idempotent requests to prevent
>> potential consistency issues.
> 
> Do we need both the resend and the flush APIs?  I think the flush
> functionality can easily be implemented with the resend API, no?
> 
> Thanks,
> Miklos

Thank you for your response, Miklos.

Yes, it is possible to implement flush functionality using the resend 
API. However, flush offers additional convenience.

For instance, some fuse daemons that allow discarding requests to 
prevent user process io-hang but do not want to handle duplicate 
requests, may require extra effort in persistent record if using resend. 
In such cases, using the flush API would provide more convenience.

So, based on my understanding, resend is adequate, but flush can offer 
more convenience. I would like to inquire about your preference 
regarding the two APIs. Should I do some verification and remove the 
flush API, and then resend this patchset?

Best Regards,
Zhao Chen

