Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17239A20B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH2QWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 12:22:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:20169 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfH2QWb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:22:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 09:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="205787728"
Received: from mbmcwil3-mobl.amr.corp.intel.com (HELO [10.252.203.249]) ([10.252.203.249])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2019 09:22:29 -0700
Subject: Re: [alsa-devel] mmotm 2019-08-27-20-39 uploaded
 (sound/hda/intel-nhlt.c)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <274054ef-8611-2661-9e67-4aabae5a7728@infradead.org>
 <5ac8a7a7-a9b4-89a5-e0a6-7c97ec1fabc6@linux.intel.com>
 <98ada795-4700-7fcc-6d14-fcc1ab25d509@infradead.org>
 <f0a62b08-cba9-d944-5792-8eac0ea39df1@linux.intel.com>
 <19edfb9a-f7b3-7a89-db5a-33289559aeef@linux.intel.com>
 <s5hzhjs102i.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c7c8fcde-40c7-8025-9fa7-e7e0daa8770c@linux.intel.com>
Date:   Thu, 29 Aug 2019 11:22:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <s5hzhjs102i.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/29/19 10:08 AM, Takashi Iwai wrote:
> On Thu, 29 Aug 2019 00:45:05 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>>>> I just checked with Mark Brown's for-next tree
>>>>> 8aceffa09b4b9867153bfe0ff6f40517240cee12
>>>>> and things are fine in i386 mode, see below.
>>>>>
>>>>> next-20190828 also works fine for me in i386 mode.
>>>>>
>>>>> if you can point me to a tree and configuration that don't work
>>>>> I'll look into this, I'd need more info to progress.
>>>>
>>>> Please try the attached randconfig file.
>>>>
>>>> Thanks for looking.
>>>
>>> Ack, I see some errors as well with this config. Likely a missing
>>> dependency somewhere, working on this now.
>>
>> My bad, I added a fallback with static inline functions in the .h file
>> when ACPI is not defined, but the .c file was still compiled.
>>
>> The diff below makes next-20190828 compile with Randy's config.
> 
> IMO, we need to fix the site that enables this config.  i.e.
> the "select SND_INTEL_NHLT" must be always conditional, e.g.
> 	select SND_INTEL_NHLT if ACPI

that would be nicer indeed, currently we don't have a consistent solution:
sound/pci/hda/Kconfig:  select SND_INTEL_NHLT if ACPI
sound/soc/intel/Kconfig:        select SND_INTEL_NHLT
sound/soc/sof/intel/Kconfig:    select SND_INTEL_NHLT

I can't recall why things are different, will send a patch to align.


> 
>> It looks like the alsa-devel server is down btw?
> 
> Now it seems starting again.
> 
> 
> thanks,
> 
> Takashi
> 
>> diff --git a/sound/hda/Makefile b/sound/hda/Makefile
>> index 8560f6ef1b19..b3af071ce06b 100644
>> --- a/sound/hda/Makefile
>> +++ b/sound/hda/Makefile
>> @@ -14,5 +14,7 @@ obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
>>   #extended hda
>>   obj-$(CONFIG_SND_HDA_EXT_CORE) += ext/
>>
>> +ifdef CONFIG_ACPI
>>   snd-intel-nhlt-objs := intel-nhlt.o
>>   obj-$(CONFIG_SND_INTEL_NHLT) += snd-intel-nhlt.o
>> +endif
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
