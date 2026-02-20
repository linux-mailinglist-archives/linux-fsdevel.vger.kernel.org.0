Return-Path: <linux-fsdevel+bounces-77800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CEMN+qDmGnKJQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:55:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC37169141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 007F63018E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE433D4FA;
	Fri, 20 Feb 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqrrNLFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E234DB48;
	Fri, 20 Feb 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602907; cv=none; b=KM7l5IupFxMsAJ8h1/84OqQgHFfH1iIzU1S5WKQqyD5KvJAgtKJPIytgf6DOmGh2pDJO1WOw3ab7GzZ39YhfQR/FlFhGlGCVEQ+Bm/4kuIuTjhugZxI1nTSxI7h4FoTCLHx3Tfro5D5AWjqze/7YHxo6l3SouevqwEeQ7xN4yoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602907; c=relaxed/simple;
	bh=TNAwc4bN+gdZnNY9DlBqYik5zqX6LZBfVTFFf/fjt+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajT7cDHfIvmqQwRdgBDFcj2o5hpYnvWfklnGRlqDc2Rf2CwNmGJib0MZfgf6aaX5pUfTqHsDmQHnhJbEN1QijQUQ5fFXla5tPTvYrxIEwKFrcLlcZA8Nq+JFHMbkAWF8rumQWOwbLUUkQ4S4MBkuRNzUhl4GoGYaQZsqUAxtHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqrrNLFo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771602906; x=1803138906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TNAwc4bN+gdZnNY9DlBqYik5zqX6LZBfVTFFf/fjt+I=;
  b=fqrrNLFoewZcbcvOgj5jpvTsGEeBE9UW91a1+d1lrDR7a1B6vbTV5GNH
   +NFMjIn2TEhizghIaY+govh04h5PsWE1d6RmlklcT2wT2bA7M5eYz6dRP
   2UST3+Lp4p3+mxq92Dgh0RRC3JItFe6Yyx1LJHZ5RoM3DCfh6lt+dxUvD
   EK9TlB7mn0lni/z/uAt0QKB/DG6/GBsXHjv7uAEA4QtNA6VLAmYIshEqS
   UUVKPc4VXwkkWxwnHvthPSyP667ftPc2EbJQ68JxA2MLwpOqqm4Dc39Rf
   G94aMDxemgBMGRJuj37/+vBiYngSY0QoRW0w62kpqUWeXMlTZFg8Cuf2n
   A==;
X-CSE-ConnectionGUID: ig7gjOZqTd6JPNxZYYSl0g==
X-CSE-MsgGUID: 4PDTh675Tti2HAHCiayX3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="84057103"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="84057103"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:55:05 -0800
X-CSE-ConnectionGUID: Z22wXQvOSY6+DvjpXIPJRA==
X-CSE-MsgGUID: DyzgI+7cRBmJGEbceuo8xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213432501"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.83]) ([10.125.110.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 07:55:03 -0800
Message-ID: <00813ddb-e737-4b61-9ebd-07ca2d02fd6c@intel.com>
Date: Fri, 20 Feb 2026 08:55:02 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] dax: Add deferred-work helpers for dax_hmem and
 dax_cxl coordination
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-8-Smita.KoralahalliChannabasappa@amd.com>
 <0c464a2c-3722-45e5-9023-5a2fce8aa096@intel.com>
 <9b54bd0a-86dd-493b-92be-680c99b23479@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <9b54bd0a-86dd-493b-92be-680c99b23479@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77800-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: EDC37169141
X-Rspamd-Action: no action



On 2/19/26 5:02 PM, Koralahalli Channabasappa, Smita wrote:
> Hi Dave,
> 
> On 2/18/2026 9:52 AM, Dave Jiang wrote:
>>
>>
>> On 2/9/26 11:44 PM, Smita Koralahalli wrote:
>>> Add helpers to register, queue and flush the deferred work.
>>>
>>> These helpers allow dax_hmem to execute ownership resolution outside the
>>> probe context before dax_cxl binds.
>>>
>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>> ---
>>>   drivers/dax/bus.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/dax/bus.h |  7 ++++++
>>>   2 files changed, 65 insertions(+)
>>>
>>> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
>>> index 5f387feb95f0..92b88952ede1 100644
>>> --- a/drivers/dax/bus.c
>>> +++ b/drivers/dax/bus.c
>>> @@ -25,6 +25,64 @@ DECLARE_RWSEM(dax_region_rwsem);
>>>    */
>>>   DECLARE_RWSEM(dax_dev_rwsem);
>>>   +static DEFINE_MUTEX(dax_hmem_lock);
>>> +static dax_hmem_deferred_fn hmem_deferred_fn;
>>> +static void *dax_hmem_data;
>>> +
>>> +static void hmem_deferred_work(struct work_struct *work)
>>> +{
>>> +    dax_hmem_deferred_fn fn;
>>> +    void *data;
>>> +
>>> +    scoped_guard(mutex, &dax_hmem_lock) {
>>> +        fn = hmem_deferred_fn;
>>> +        data = dax_hmem_data;
>>> +    }
>>> +
>>> +    if (fn)
>>> +        fn(data);
>>> +}
>>
>> Instead of having a global lock and dealing with all the global variables, why not just do this with the typical work_struct usage pattern and allocate a work item when queuing work?
>>
>> DJ
> 
> Thanks for the feedback.
> 
> Just to clarify, are you hinting towards a statically allocated struct
> with an embedded work_struct, something like below? Rather than the typical kmalloc + container_of pattern?
> 
> +struct dax_hmem_deferred_ctx {
> +    struct work_struct work;
> +    dax_hmem_deferred_fn fn;
> +    void *data;
> +};
> 
> +static struct dax_hmem_deferred_ctx dax_hmem_ctx;
> 
> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
> +{
> +    if (dax_hmem_ctx.fn)
> +        return -EINVAL;
> 
> +    INIT_WORK(&dax_hmem_ctx.work, hmem_deferred_work);
> ..
> 
> My understanding is that Dan wanted this to remain a singleton deferred work item queued once and flushed from dax_cxl. I think with kmalloc + container_of approach, every call would allocate and queue a new independent work item..
> 
> Regarding the mutex: looking at it again, it may not be necessary I think. If we can rely on the call ordering (register_work() before queue_work()), and if flush_work() in kill_defer_work() ensures the work has fully completed before unregister_work() NULLs the pointers, then the static struct above would be sufficient without additional locking. If I'm missing a scenario or race here, please correct me.

Ok I missed the history on the single issue work item. Yes what you proposed above should work if it's single issue. and if we are only sending 1 item, a statically declared work context should be sufficient I think. 

DJ

> 
> Thanks,
> Smita
> 
>>
>>> +
>>> +static DECLARE_WORK(dax_hmem_work, hmem_deferred_work);
>>> +
>>> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
>>> +{
>>> +    guard(mutex)(&dax_hmem_lock);
>>> +
>>> +    if (hmem_deferred_fn)
>>> +        return -EINVAL;
>>> +
>>> +    hmem_deferred_fn = fn;
>>> +    dax_hmem_data = data;
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dax_hmem_register_work);
>>> +
>>> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data)
>>> +{
>>> +    guard(mutex)(&dax_hmem_lock);
>>> +
>>> +    if (hmem_deferred_fn != fn || dax_hmem_data != data)
>>> +        return -EINVAL;
>>> +
>>> +    hmem_deferred_fn = NULL;
>>> +    dax_hmem_data = NULL;
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dax_hmem_unregister_work);
>>> +
>>> +void dax_hmem_queue_work(void)
>>> +{
>>> +    queue_work(system_long_wq, &dax_hmem_work);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dax_hmem_queue_work);
>>> +
>>> +void dax_hmem_flush_work(void)
>>> +{
>>> +    flush_work(&dax_hmem_work);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dax_hmem_flush_work);
>>> +
>>>   #define DAX_NAME_LEN 30
>>>   struct dax_id {
>>>       struct list_head list;
>>> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
>>> index cbbf64443098..b58a88e8089c 100644
>>> --- a/drivers/dax/bus.h
>>> +++ b/drivers/dax/bus.h
>>> @@ -41,6 +41,13 @@ struct dax_device_driver {
>>>       void (*remove)(struct dev_dax *dev);
>>>   };
>>>   +typedef void (*dax_hmem_deferred_fn)(void *data);
>>> +
>>> +int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
>>> +int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data);
>>> +void dax_hmem_queue_work(void);
>>> +void dax_hmem_flush_work(void);
>>> +
>>>   int __dax_driver_register(struct dax_device_driver *dax_drv,
>>>           struct module *module, const char *mod_name);
>>>   #define dax_driver_register(driver) \
>>
> 


