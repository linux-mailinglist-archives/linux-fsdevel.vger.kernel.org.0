Return-Path: <linux-fsdevel+bounces-19471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2058C5C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 22:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311BC281576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789DA1DFFC;
	Tue, 14 May 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzkS6wQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F7365
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719311; cv=none; b=PrlU1WQtyg8hC2n/FE9XFFhquDGj2Xynk6rpsJhnqXeZ5Dee6XJ9VGnyRLLQi6GN5HbPBFh17fuYlIyXGXQ4KiIi7JzH+dF8rBZJlxG3NwoPkH4eI4TgLkkOoqJHkBWWNJ51g86Dbj325CMUBbUjUv/89ynPVZRTQ1O5nOHDYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719311; c=relaxed/simple;
	bh=g09/tZ2igEKVH5Uk9SfvQlovguzkCymGMVtoCVdKCPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9NhVrsiEG2i8kxAKjlinUm39mDrZDj5AnfsgpUCvO3ol/II1PCCgqPbbzes7MMzZUsUfghnFQZvIZZrhjk8L2wIiqou+2hZUbdPzPV1N/sNaPe3JlrVUliMi9M4It2flyOzEllt2XSA0WksOwi9WNIF9juV65Q8JOUm3jSE4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzkS6wQk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715719310; x=1747255310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g09/tZ2igEKVH5Uk9SfvQlovguzkCymGMVtoCVdKCPg=;
  b=mzkS6wQkJ1mI1cnA7ifZ/Iae8G5BYzgdNM7YQqBRuDrLJT1uKUjhZdiG
   Msj4mrSOgGU/yUivGuqqtSmWC7ctRJHEDu4NFDcsRpELeqJc/J+WHjjGY
   JJUTa551EyPSqyIIFQecz2v7xsI6RYKelLrzf5xku298PTIOkExpNH6dj
   G7s5/7m0gWmGpTX18JrRGrKu4AVTRD5zCux/5tPxY8Z9WyJlqDgtu04aG
   2XykB74dP/32Y7v4YLoohPV/qNMPyrfwJhTxlgs87jipiDsc0TDvoFXY+
   PgoBJYepAQ18ET8AlzH2+3HRpViH6fO7oqDexUYokcH5Q9+FEm23DaNUT
   g==;
X-CSE-ConnectionGUID: xgfXzSekRsulqW4Ph8gzKA==
X-CSE-MsgGUID: 9oQvC0P+RM+3iMGhjuSQUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11864169"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11864169"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 13:41:49 -0700
X-CSE-ConnectionGUID: nQa8K5a3RTyHuHK9iBZ6jg==
X-CSE-MsgGUID: yP9VI87nTHy9Pbdj0xj1Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35689159"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 14 May 2024 13:41:46 -0700
Received: from [10.245.82.128] (unknown [10.245.82.128])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C50A52879D;
	Tue, 14 May 2024 21:41:43 +0100 (IST)
Message-ID: <3c8ad7c7-c144-4045-a2a2-c33f54223623@intel.com>
Date: Tue, 14 May 2024 22:41:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/xe/guc: Expose raw access to GuC log over debugfs
To: John Harrison <john.c.harrison@intel.com>, intel-xe@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
 <20240512153606.1996-5-michal.wajdeczko@intel.com>
 <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
 <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
 <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <3127eb0f-ef0b-46e8-a778-df6276718d06@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14.05.2024 20:13, John Harrison wrote:
> On 5/14/2024 07:58, Michal Wajdeczko wrote:
>> On 13.05.2024 18:53, John Harrison wrote:
>>> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>>>> We already provide the content of the GuC log in debugsfs, but it
>>>> is in a text format where each log dword is printed as hexadecimal
>>>> number, which does not scale well with large GuC log buffers.
>>>>
>>>> To allow more efficient access to the GuC log, which could benefit
>>>> our CI systems, expose raw binary log data.  In addition to less
>>>> overhead in preparing text based GuC log file, the new GuC log file
>>>> in binary format is also almost 3x smaller.
>>>>
>>>> Any existing script that expects the GuC log buffer in text format
>>>> can use command like below to convert from new binary format:
>>>>
>>>>      hexdump -e '4/4 "0x%08x " "\n"'
>>>>
>>>> but this shouldn't be the case as most decoders expect GuC log data
>>>> in binary format.
>>> I strongly disagree with this.
>>>
>>> Efficiency and file size is not an issue when accessing the GuC log via
>>> debugfs on actual hardware.
>> to some extend it is as CI team used to refuse to collect GuC logs after
>> each executed test just because of it's size
> I've never heard that argument. I've heard many different arguments but
> not one about file size. The default GuC log size is pretty tiny. So
> size really is not an issue.

so it's tiny or 16MB as you mention below ?

> 
>>
>>> It is an issue when dumping via dmesg but
>>> you definitely should not be dumping binary data to dmesg. Whereas,
>> not following here - this is debugfs specific, not a dmesg printer
> Except that it is preferable to have common code for both if at all
> possible.

but here, for debugfs, it's almost no code, it's 1-liner thanks to using
generic helpers, so there is really nothing to share as common code

note that with this separate raw access to guc log over debugfs, you can
further customize xe_guc_log_dump() function for dmesg output [2]
without worrying about impact in generating output to debugfs

[2] https://patchwork.freedesktop.org/series/133349/

> 
>>
>>> dumping in binary data is much more dangerous and liable to corruption
>>> because some tool along the way tries to convert to ASCII, or truncates
>>> at the first zero, etc. We request GuC logs be sent by end users,
>>> customer bug reports, etc. all doing things that we have no control
>>> over.
>> hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?
> Because someone then tries to email it, or attach it or copy it via
> Windows or any number of other ways in which a file can get munged.

no comment

> 
>>
>>> Converting the hexdump back to binary is trivial for those tools which
>>> require it. If you follow the acquisition and decoding instructions on
>>> the wiki page then it is all done for you automatically.
>> I'm afraid I don't know where this wiki page is, but I do know that hex
>> conversion dance is not needed for me to get decoded GuC log the way I
>> used to do
> Look for the 'GuC Debug Logs' page on the developer wiki. It's pretty
> easy to find.

ok, found it

btw, it says "Actual log size will be significantly more (about 50MB) as
there are multiple sections."

> 
>>> These patches are trying to solve a problem which does not exist and are
>>> going to make working with GuC logs harder and more error prone.
>> it at least solves the problem of currently super inefficient way of
>> generating the GuC log in text format.
>>
>> it also opens other opportunities to develop tools that could monitor or
>> capture GuC log independently on  top of what driver is able to offer
>> today (on i915 there was guc-log-relay, but it was broken for long time,
>> not sure what are the plans for Xe)
>>
>> also still not sure how it can be more error prone.
> As already explained, the plan is move to LFD - an extensible,
> streamable, logging format. Any non-trivial effort that is not helping
> to move to LFD is not worth the effort.

which part from my series was non-trivial ?

> 
>>
>>> On the other hand, there are many other issues with GuC logs that it
>>> would be useful to solves - including extra meta data, reliable output
>>> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
>>> to generate it ~12 times for a single read, etc.
>> this series actually solves last issue but in a bit different way (we
>> even don't need to generate full GuC log dump at all if we would like to
>> capture only part of the log if we know where to look)
> No, it doesn't solve it. Your comment below suggests it will be read in
> 4KB chunks. 

chunks will be 4K if we stick to proposed here simple_read_from_iomem()
that initially uses hardcoded 4K chunks, but we could either modify it
to use larger chunks by default or extend it to take additional param,
or promote more powerful copy_to_user_fromio() from SOUND

> Which means your 16MB buffer now requires 4096 separate
> reads! And you only doing partial reads of the section you think you
> need is never going to be reliable on live system. Not sure why you
> would want to anyway. It is just making things much more complex. You
> now need an intelligent user land program to read the log out and decode

I don't need it. We can add it later. And we can add it on top what we
already expose without the need to recompile/rebuild the driver.

> at least the header section to know what data section to read. You can't
> just dump the whole thing with 'cat' or 'dd'.

only 'cat' wont work as it's binary file

> 
>>
>> for reliable output via dmesg - see my proposal at [1]
>>
>> [1] https://patchwork.freedesktop.org/series/133613/
> 
>>
>>> Hmm. Actually, is this interface allowing the filesystem layers to issue
>>> multiple read calls to read the buffer out in small chunks? That is also
>>> going to break things. If the GuC is still writing to the log as the
>>> user is reading from it, there is the opportunity for each chunk to not
>>> follow on from the previous chunk because the data has just been
>>> overwritten. This is already a problem at the moment that causes issues
>>> when decoding the logs, even with an almost atomic copy of the log into
>>> a temporary buffer before reading it out. Doing the read in separate
>>> chunks is only going to make that problem even worse.
>> current solution, that converts data into hex numbers, reads log buffer
>> in chunks of 128 dwords, how proposed here solution that reads in 4K
>> chunks could be "even worse" ?
> See above, 4KB chunks means 4096 separate reads for a 16M buffer. And
> each one of those reads is a full round trip to user land and back. If

but is this a proven problem for us?

> you want to get at all close to an atomic read of the log then it needs
> to be done as a single call that copies the log into a locally allocated
> kernel buffer and then allows user land to read out from that buffer
> rather than from the live log. Which can be trivially done with the
> current method (at the expense of a large memory allocation) but would
> be much more difficult with random access reader like this as you would
> need to say the copied buffer around until the reads have all been done.
> Which would presumably mean adding open/close handlers to allocate and
> free that memory.

as I mentioned above if we desperately need larger copies then we can
use the code promoted from the SOUND subsystem

but for random access reader (up to 4K) this is what this patch already
provides.

> 
>>
>> and in case of some smart tool, that would understands the layout of the
>> GuC log buffer, we can even fully eliminate problem of reading stale
>> data, so why not to choose a more scalable solution ?
> You cannot eliminate the problem of stale data. You read the header, you
> read the data it was pointing to, you re-read the header and find that
> the GuC has moved on. That is an infinite loop of continuously updating
> pointers.

I didn't say that I can create snapshot that is 100% free of stale data,
what I meant was that with this proposal I can provide almost real time
access to the GuC log, so with custom tool I can read pointers and and
log entries as small randomly located chunks in the buffer, without the
need to output whole log buffer snapshot as giant text file that I would
have to parse again.

> 
> John.
> 
>>
>>> John.
>>>
>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>>> Cc: John Harrison <John.C.Harrison@Intel.com>
>>>> ---
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> ---
>>>>    drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>> index d3822cbea273..53fea952344d 100644
>>>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <drm/drm_debugfs.h>
>>>>    #include <drm/drm_managed.h>
>>>>    +#include "xe_bo.h"
>>>>    #include "xe_device.h"
>>>>    #include "xe_gt.h"
>>>>    #include "xe_guc.h"
>>>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>>>        {"guc_log", guc_log, 0},
>>>>    };
>>>>    +static ssize_t guc_log_read(struct file *file, char __user *buf,
>>>> size_t count, loff_t *pos)
>>>> +{
>>>> +    struct dentry *dent = file_dentry(file);
>>>> +    struct dentry *uc_dent = dent->d_parent;
>>>> +    struct dentry *gt_dent = uc_dent->d_parent;
>>>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>>>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>>>> +    struct xe_device *xe = gt_to_xe(gt);
>>>> +    ssize_t ret;
>>>> +
>>>> +    xe_pm_runtime_get(xe);
>>>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>>>> log->bo->size);
>>>> +    xe_pm_runtime_put(xe);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const struct file_operations guc_log_ops = {
>>>> +    .owner        = THIS_MODULE,
>>>> +    .read        = guc_log_read,
>>>> +    .llseek        = default_llseek,
>>>> +};
>>>> +
>>>>    void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry
>>>> *parent)
>>>>    {
>>>>        struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>>>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>>>> struct dentry *parent)
>>>>        drm_debugfs_create_files(local,
>>>>                     ARRAY_SIZE(debugfs_list),
>>>>                     parent, minor);
>>>> +
>>>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>>>> &guc_log_ops);
>>>>    }
> 

