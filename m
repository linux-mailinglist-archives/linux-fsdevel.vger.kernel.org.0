Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B266CA0DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 00:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH1WpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 18:45:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:9511 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfH1WpI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:45:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 15:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="380566759"
Received: from amathu3-mobl1.amr.corp.intel.com (HELO [10.254.179.245]) ([10.254.179.245])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2019 15:45:06 -0700
Subject: Re: mmotm 2019-08-27-20-39 uploaded (sound/hda/intel-nhlt.c)
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
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
Message-ID: <19edfb9a-f7b3-7a89-db5a-33289559aeef@linux.intel.com>
Date:   Wed, 28 Aug 2019 17:45:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f0a62b08-cba9-d944-5792-8eac0ea39df1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> I just checked with Mark Brown's for-next tree 
>>> 8aceffa09b4b9867153bfe0ff6f40517240cee12
>>> and things are fine in i386 mode, see below.
>>>
>>> next-20190828 also works fine for me in i386 mode.
>>>
>>> if you can point me to a tree and configuration that don't work I'll 
>>> look into this, I'd need more info to progress.
>>
>> Please try the attached randconfig file.
>>
>> Thanks for looking.
> 
> Ack, I see some errors as well with this config. Likely a missing 
> dependency somewhere, working on this now.

My bad, I added a fallback with static inline functions in the .h file 
when ACPI is not defined, but the .c file was still compiled.

The diff below makes next-20190828 compile with Randy's config.

It looks like the alsa-devel server is down btw?

diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 8560f6ef1b19..b3af071ce06b 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -14,5 +14,7 @@ obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
  #extended hda
  obj-$(CONFIG_SND_HDA_EXT_CORE) += ext/

+ifdef CONFIG_ACPI
  snd-intel-nhlt-objs := intel-nhlt.o
  obj-$(CONFIG_SND_INTEL_NHLT) += snd-intel-nhlt.o
+endif

