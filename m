Return-Path: <linux-fsdevel+bounces-19454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5778C5864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971CCB22C35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEABB17EB81;
	Tue, 14 May 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1x5lk/a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062017BB3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698715; cv=none; b=nIbz1aRaCYbQYeIxkeWOJ3DFK9+gfTfBoy0iGhw9BH243q5i1B0NSFAtfNDe6TGml55cajbNaEztov6+/xq/fRTCP9FcCQaVpnjYWJbYOXsQzgVqJkEnoF1dMMLW0mw1y4NxIUIO4r4pRhtcY/nQyneQeuyXIOe8/uBI8MMiqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698715; c=relaxed/simple;
	bh=tCIznBYL7VBT3NTFD0EYPgh35OWdYpxDWnE0xEb3Hkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zd4ekCOraO6MIb5ODV4620JcMZfskTJfdIfnmjZw9UPx4QbG4UZyOv8FURihxeWCIbcfGUFMOlHJiifAxQUEaOYGlPFTKRRBAByiHnZ72OURcCPOiTOeRIEQtp8pMQg8wcfdMz71JDfiNKmBHDuTfhHESyf8jumEbg/KG2Q1CFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1x5lk/a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715698712; x=1747234712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tCIznBYL7VBT3NTFD0EYPgh35OWdYpxDWnE0xEb3Hkc=;
  b=F1x5lk/a1FMw5WG0spEztfU9ux1wrDTLcyQzEtppl2FAcibmV5K4rPEK
   I/SeI4R1jmmWqOona0HpguUZNWFiPMFP0l9MKrtYnNvXEnIabeQoN6yDf
   I/OpcX9Jt/Fgbf/YOs43OqhCQrbGRTUGIyfvD7nFoPgBJbd5+OJwgbCm/
   EFY5gMTbZytVw4dTYralzUVUL6YZJ5OcJ0/JG7MKnwwmg+oAaaFCZNyv1
   m5GhL3ABzya14WzLT2CKXU0RAzscsme4Knwy/Azm+uRAo8uSG04wHoRkF
   h+GbFCYLM9bEJMsIOIFtH2Z8Pdh6avENKzen+LhXG5RVcwQgX/R8IVc89
   Q==;
X-CSE-ConnectionGUID: 8DTd/p5ERUiz5OwUkikEkg==
X-CSE-MsgGUID: BJUbMVEDS/Gvifu+Q83uRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15473695"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="15473695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 07:58:32 -0700
X-CSE-ConnectionGUID: xpNCci66RAevQxZWi3/Rog==
X-CSE-MsgGUID: fw3muRCxQ1edYYMgAtrA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35173990"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2024 07:58:28 -0700
Received: from [10.246.1.253] (mwajdecz-MOBL.ger.corp.intel.com [10.246.1.253])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B772728775;
	Tue, 14 May 2024 15:58:26 +0100 (IST)
Message-ID: <83484000-0716-465a-b55d-70cd07205ae5@intel.com>
Date: Tue, 14 May 2024 16:58:25 +0200
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
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <d0fd0b46-a8ac-464b-99e7-0b5384a79bf6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13.05.2024 18:53, John Harrison wrote:
> On 5/12/2024 08:36, Michal Wajdeczko wrote:
>> We already provide the content of the GuC log in debugsfs, but it
>> is in a text format where each log dword is printed as hexadecimal
>> number, which does not scale well with large GuC log buffers.
>>
>> To allow more efficient access to the GuC log, which could benefit
>> our CI systems, expose raw binary log data.  In addition to less
>> overhead in preparing text based GuC log file, the new GuC log file
>> in binary format is also almost 3x smaller.
>>
>> Any existing script that expects the GuC log buffer in text format
>> can use command like below to convert from new binary format:
>>
>>     hexdump -e '4/4 "0x%08x " "\n"'
>>
>> but this shouldn't be the case as most decoders expect GuC log data
>> in binary format.
> I strongly disagree with this.
> 
> Efficiency and file size is not an issue when accessing the GuC log via
> debugfs on actual hardware. 

to some extend it is as CI team used to refuse to collect GuC logs after
each executed test just because of it's size

> It is an issue when dumping via dmesg but
> you definitely should not be dumping binary data to dmesg. Whereas,

not following here - this is debugfs specific, not a dmesg printer

> dumping in binary data is much more dangerous and liable to corruption
> because some tool along the way tries to convert to ASCII, or truncates
> at the first zero, etc. We request GuC logs be sent by end users,
> customer bug reports, etc. all doing things that we have no control over.

hmm, how "cp gt0/uc/guc_log_raw FILE" could end with a corrupted file ?

> 
> Converting the hexdump back to binary is trivial for those tools which
> require it. If you follow the acquisition and decoding instructions on
> the wiki page then it is all done for you automatically.

I'm afraid I don't know where this wiki page is, but I do know that hex
conversion dance is not needed for me to get decoded GuC log the way I
used to do

> 
> These patches are trying to solve a problem which does not exist and are
> going to make working with GuC logs harder and more error prone.

it at least solves the problem of currently super inefficient way of
generating the GuC log in text format.

it also opens other opportunities to develop tools that could monitor or
capture GuC log independently on  top of what driver is able to offer
today (on i915 there was guc-log-relay, but it was broken for long time,
not sure what are the plans for Xe)

also still not sure how it can be more error prone.

> 
> On the other hand, there are many other issues with GuC logs that it
> would be useful to solves - including extra meta data, reliable output
> via dmesg, continuous streaming, pre-sizing the debugfs file to not have
> to generate it ~12 times for a single read, etc.

this series actually solves last issue but in a bit different way (we
even don't need to generate full GuC log dump at all if we would like to
capture only part of the log if we know where to look)

for reliable output via dmesg - see my proposal at [1]

[1] https://patchwork.freedesktop.org/series/133613/

> 
> Hmm. Actually, is this interface allowing the filesystem layers to issue
> multiple read calls to read the buffer out in small chunks? That is also
> going to break things. If the GuC is still writing to the log as the
> user is reading from it, there is the opportunity for each chunk to not
> follow on from the previous chunk because the data has just been
> overwritten. This is already a problem at the moment that causes issues
> when decoding the logs, even with an almost atomic copy of the log into
> a temporary buffer before reading it out. Doing the read in separate
> chunks is only going to make that problem even worse.

current solution, that converts data into hex numbers, reads log buffer
in chunks of 128 dwords, how proposed here solution that reads in 4K
chunks could be "even worse" ?

and in case of some smart tool, that would understands the layout of the
GuC log buffer, we can even fully eliminate problem of reading stale
data, so why not to choose a more scalable solution ?

> 
> John.
> 
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> ---
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>   drivers/gpu/drm/xe/xe_guc_debugfs.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>> b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>> index d3822cbea273..53fea952344d 100644
>> --- a/drivers/gpu/drm/xe/xe_guc_debugfs.c
>> +++ b/drivers/gpu/drm/xe/xe_guc_debugfs.c
>> @@ -8,6 +8,7 @@
>>   #include <drm/drm_debugfs.h>
>>   #include <drm/drm_managed.h>
>>   +#include "xe_bo.h"
>>   #include "xe_device.h"
>>   #include "xe_gt.h"
>>   #include "xe_guc.h"
>> @@ -52,6 +53,29 @@ static const struct drm_info_list debugfs_list[] = {
>>       {"guc_log", guc_log, 0},
>>   };
>>   +static ssize_t guc_log_read(struct file *file, char __user *buf,
>> size_t count, loff_t *pos)
>> +{
>> +    struct dentry *dent = file_dentry(file);
>> +    struct dentry *uc_dent = dent->d_parent;
>> +    struct dentry *gt_dent = uc_dent->d_parent;
>> +    struct xe_gt *gt = gt_dent->d_inode->i_private;
>> +    struct xe_guc_log *log = &gt->uc.guc.log;
>> +    struct xe_device *xe = gt_to_xe(gt);
>> +    ssize_t ret;
>> +
>> +    xe_pm_runtime_get(xe);
>> +    ret = xe_map_read_from(xe, buf, count, pos, &log->bo->vmap,
>> log->bo->size);
>> +    xe_pm_runtime_put(xe);
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct file_operations guc_log_ops = {
>> +    .owner        = THIS_MODULE,
>> +    .read        = guc_log_read,
>> +    .llseek        = default_llseek,
>> +};
>> +
>>   void xe_guc_debugfs_register(struct xe_guc *guc, struct dentry *parent)
>>   {
>>       struct drm_minor *minor = guc_to_xe(guc)->drm.primary;
>> @@ -72,4 +96,6 @@ void xe_guc_debugfs_register(struct xe_guc *guc,
>> struct dentry *parent)
>>       drm_debugfs_create_files(local,
>>                    ARRAY_SIZE(debugfs_list),
>>                    parent, minor);
>> +
>> +    debugfs_create_file("guc_log_raw", 0600, parent, NULL,
>> &guc_log_ops);
>>   }
> 

