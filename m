Return-Path: <linux-fsdevel+bounces-19472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326038C5CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF11F1F22A38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C9181B9F;
	Tue, 14 May 2024 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPB8949O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFA7E77B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721364; cv=none; b=UiQWxXwmaaBqu7dvNPs3/TCy/lcXsTn2jx22hDnOye9v/zMxbJAlqlbiPNnl/LCjMTAsLePNKRu5JltsM5vh5iHQXkcquE//UVHWEB3IjYp8PsW7ZXUHjAt1wGhMJbEUZYjnRkUnzbo9i7gFDB9+XDIH+AAh4zsL/RpKqSByOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721364; c=relaxed/simple;
	bh=ekiwj7QRULcGLHnHBng2FURlUqBxT3WifXZA3b5gW+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXwidUZWh3vzyZfO3u0PxpxxlxAsESnySuZmy6g9K9i8moxqmiEJ78RAD84+zjrSTUSRJd6yACdLQOQClLPedFL9x8MoVQyxqmqQnbCTMc9ewXWZ3sF62z5RZq5QD2RgPi/yPwfopOgBmuhraXPbLYlbnSM0IXypoJqcirK9v7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPB8949O; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715721362; x=1747257362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ekiwj7QRULcGLHnHBng2FURlUqBxT3WifXZA3b5gW+Y=;
  b=XPB8949OW6q5k4SDRHmxyv/pj0F1EKSeiIlaCqWndJSph8E5iS+24brn
   WNy503Ud72d+5YqL7oKnF/tPEfxGcShLo84dOivaCNwJG4tjpVccwkTKH
   seIPWBNsH2dBnzLZ2+EPzttP31iYYc3oZbLC1WcbjT5Ko+0Y5qIfwDoBY
   7/hzc2U6SEEBtWYs+JXTcvkceOj8bL1s/MpOwMzv0mQqTFEPe1rR8GQyz
   ZVGODQZi5ccOYQoDNCRF+M8GgYEwHc5vDi/7PTvK7hO2ffxORikxuL8Uz
   Hra3T9UEslEkC4kYtALm6J8bTL7c8l304S7T3CfesR4bV/eL/JiS9FU6B
   A==;
X-CSE-ConnectionGUID: 5tqYbj3AR3yVECBkHxfTbQ==
X-CSE-MsgGUID: TAn91LK6SeKTz7tnsBg8gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29256578"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29256578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 14:16:01 -0700
X-CSE-ConnectionGUID: ucxs9h7FRjmIiJagls2KBA==
X-CSE-MsgGUID: VK1zborATIyY6SJvssNO+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30940044"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2024 14:15:59 -0700
Received: from [10.245.82.128] (unknown [10.245.82.128])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9E8A32878B;
	Tue, 14 May 2024 22:15:56 +0100 (IST)
Message-ID: <1c2dd2d5-1e55-4a7d-8a38-0fe96b31019e@intel.com>
Date: Tue, 14 May 2024 23:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: Matthew Brost <matthew.brost@intel.com>,
 John Harrison <john.c.harrison@intel.com>
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi
 <lucas.demarchi@intel.com>, linux-fsdevel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
 <ZkPKM/J0CiBsNgMe@DUT025-TGLU.fm.intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZkPKM/J0CiBsNgMe@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14.05.2024 22:31, Matthew Brost wrote:
> On Tue, May 14, 2024 at 11:13:14AM -0700, John Harrison wrote:
>> On 5/14/2024 07:58, Michal Wajdeczko wrote:
>>> On 13.05.2024 18:53, John Harrison wrote:
>>>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>>>>> We already provide the content of the GuC log in debugsfs, but it
>>>>> is in a text format where each log dword is printed as hexadecimal
>>>>> number, which does not scale well with large GuC log buffers.
>>>>>
>>>>> To allow more efficient access to the GuC log, which could benefit
>>>>> our CI systems, expose raw binary log data.  In addition to less
>>>>> overhead in preparing text based GuC log file, the new GuC log file
>>>>> in binary format is also almost 3x smaller.
>>>>>
>>>>> Any existing script that expects the GuC log buffer in text format
>>>>> can use command like below to convert from new binary format:
>>>>>
>>>>>      hexdump -e '4/4 "0x%08x " "\n"'
>>>>>
>>>>> but this shouldn't be the case as most decoders expect GuC log data
>>>>> in binary format.
>>>> I strongly disagree with this.
>>>>
>>>> Efficiency and file size is not an issue when accessing the GuC log via
>>>> debugfs on actual hardware.
>>> to some extend it is as CI team used to refuse to collect GuC logs after
>>> each executed test just because of it's size
>> I've never heard that argument. I've heard many different arguments but not
>> one about file size. The default GuC log size is pretty tiny. So size really
>> is not an issue.
>>
>>>
>>>> It is an issue when dumping via dmesg but
>>>> you definitely should not be dumping binary data to dmesg. Whereas,
>>> not following here - this is debugfs specific, not a dmesg printer
>> Except that it is preferable to have common code for both if at all
>> possible.
>>
>>>
>>>> dumping in binary data is much more dangerous and liable to corruption
>>>> because some tool along the way tries to convert to ASCII, or truncates
>>>> at the first zero, etc. We request GuC logs be sent by end users,
>>>> customer bug reports, etc. all doing things that we have no control over.
>>> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
>> Because someone then tries to email it, or attach it or copy it via Windows
>> or any number of other ways in which a file can get munged.
>>
>>>
>>>> Converting the hexdump back to binary is trivial for those tools which
>>>> require it. If you follow the acquisition and decoding instructions on
>>>> the wiki page then it is all done for you automatically.
>>> I'm afraid I don't know where this wiki page is, but I do know that hex
>>> conversion dance is not needed for me to get decoded GuC log the way I
>>> used to do
>> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty easy
>> to find.
>>
>>>> These patches are trying to solve a problem which does not exist and are
>>>> going to make working with GuC logs harder and more error prone.
>>> it at least solves the problem of currently super inefficient way of
>>> generating the GuC log in text format.
>>>
>>> it also opens other opportunities to develop tools that could monitor or
>>> capture GuC log independently on  top of what driver is able to offer
>>> today (on i915 there was guc-log-relay, but it was broken for long time,
>>> not sure what are the plans for Xe)
>>>
>>> also still not sure how it can be more error prone.
>> As already explained, the plan is move to LFD - an extensible, streamable,
>> logging format. Any non-trivial effort that is not helping to move to LFD is
>> not worth the effort.
>>
>>>
>>>> On the other hand, there are many other issues with GuC logs that it
>>>> would be useful to solves - including extra meta data, reliable output
>>>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
>>>> to generate it ~12 times for a single read, etc.
>>> this series actually solves last issue but in a bit different way (we
>>> even don't need to generate full GuC log dump at all if we would like to
>>> capture only part of the log if we know where to look)
>> No, it doesn't solve it. Your comment below suggests it will be read in 4KB
>> chunks. Which means your 16MB buffer now requires 4096 separate reads! And
>> you only doing partial reads of the section you think you need is never
>> going to be reliable on live system. Not sure why you would want to anyway.
>> It is just making things much more complex. You now need an intelligent user
>> land program to read the log out and decode at least the header section to
>> know what data section to read. You can't just dump the whole thing with
>> 'cat' or 'dd'.
>>
> 
> Briefly have read this thread but seconding John's opinion that anything
> which breaks GuC log collection via a simple command like cat is a no

hexdump or cp is also a simple command and likely we can assume that
either user will know what command to use or will just type the command
that we say.

> go. Also anything that can allow windows to mangle the output would be
> less than idle too. Lastly, GuC log collection is not a critical path
> operation so it likely does not need to optimized for speed.

but please remember that this patch does not change anything to the
existing debugfs files, the guc_log stays as is, this new raw access is
defined as another guc_log_raw file that would allow develop other use
cases, beyond what is possible with naive text snapshots, like live
monitor for errors, all implemented above kernel driver

> 
> Matt
> 
>>>
>>> for reliable output via dmesg - see my proposal at [1]
>>>
>>> [1] https://patchwork.freedesktop.org/series/133613/
>>
>>>
>>>> Hmm. Actually, is this interface allowing the filesystem layers to issue
>>>> multiple read calls to read the buffer out in small chunks? That is also
>>>> going to break things. If the GuC is still writing to the log as the
>>>> user is reading from it, there is the opportunity for each chunk to not
>>>> follow on from the previous chunk because the data has just been
>>>> overwritten. This is already a problem at the moment that causes issues
>>>> when decoding the logs, even with an almost atomic copy of the log into
>>>> a temporary buffer before reading it out. Doing the read in separate
>>>> chunks is only going to make that problem even worse.
>>> current solution, that converts data into hex numbers, reads log buffer
>>> in chunks of 128 dwords, how proposed here solution that reads in 4K
>>> chunks could be "even worse" ?
>> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And each
>> one of those reads is a full round trip to user land and back. If you want
>> to get at all close to an atomic read of the log then it needs to be done as
>> a single call that copies the log into a locally allocated kernel buffer and
>> then allows user land to read out from that buffer rather than from the live
>> log. Which can be trivially done with the current method (at the expense of
>> a large memory allocation) but would be much more difficult with random
>> access reader like this as you would need to say the copied buffer around
>> until the reads have all been done. Which would presumably mean adding
>> open/close handlers to allocate and free that memory.
>>
>>>
>>> and in case of some smart tool, that would understands the layout of the
>>> GuC log buffer, we can even fully eliminate problem of reading stale
>>> data, so why not to choose a more scalable solution ?
>> You cannot eliminate the problem of stale data. You read the header, you
>> read the data it was pointing to, you re-read the header and find that the
>> GuC has moved on. That is an infinite loop of continuously updating
>> pointers.
>>
>> John.
>>
>>>
>>>> John.
>>>>
>>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>>> ---
>>>>> Cc: linux-fsdevel@vger.kernel.org
>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>> ---
>>>>>    drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>>>>    1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> index d3822cbea273..53fea952344d 100644
>>>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>>> @@ -8,6 +8,7 @@
>>>>>    #include <drm/drm_debugfs.h>
>>>>>    #include <drm/drm_managed.h>
>>>>>    +#include "xe_bo.h"
>>>>>    #include "xe_device.h"
>>>>>    #include "xe_gt.h"
>>>>>    #include "xe_guc.h"
>>>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>>>>        {"guc_log", guc_log, 0},
>>>>>    };
>>>>>    +static ssize_t guc_log_read(struct file *file, char __user *buf,
>>>>> size_t count, loff_t *pos)
>>>>> +{
>>>>> +    struct dentry *dent = file_dentry(file);
>>>>> +    struct dentry *uc_dent = dent->d_parent;
>>>>> +    struct dentry *gt_dent = uc_dent->d_parent;
>>>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>>>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>>>>> +    struct xe_device *xe = gt_to_xe(gt);
>>>>> +    ssize_t ret;
>>>>> +
>>>>> +    xe_pm_runtime_get(xe);
>>>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>>>>> log->bo->size);
>>>>> +    xe_pm_runtime_put(xe);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct file_operations guc_log_ops = {
>>>>> +    .owner        = THIS_MODULE,
>>>>> +    .read        = guc_log_read,
>>>>> +    .llseek        = default_llseek,
>>>>> +};
>>>>> +
>>>>>    void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>>>>>    {
>>>>>        struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>>>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>>>>> struct dentry *parent)
>>>>>        drm_debugfs_create_files(local,
>>>>>                     ARRAY_SIZE(debugfs_list),
>>>>>                     parent, minor);
>>>>> +
>>>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>>>>> &guc_log_ops);
>>>>>    }
>>

