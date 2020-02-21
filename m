Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0AE167AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 11:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBUKfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 05:35:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:47673 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUKfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:35:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 02:35:12 -0800
X-IronPort-AV: E=Sophos;i="5.70,467,1574150400"; 
   d="scan'208";a="229811346"
Received: from jmiler-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 02:35:07 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] mmotm 2020-02-19-19-51 uploaded (gpu/drm/i915/ + HDRTEST)
In-Reply-To: <d8112767-4089-4c58-d7d3-2ce03139858a@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200220035155.PempH%akpm@linux-foundation.org> <d8112767-4089-4c58-d7d3-2ce03139858a@infradead.org>
Date:   Fri, 21 Feb 2020 12:35:13 +0200
Message-ID: <874kvkz0ri.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 Feb 2020, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/19/20 7:51 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2020-02-19-19-51 has been uploaded to
>> 
>>    http://www.ozlabs.org/~akpm/mmotm/
>> 
>> mmotm-readme.txt says
>> 
>> README for mm-of-the-moment:
>> 
>> http://www.ozlabs.org/~akpm/mmotm/
>> 
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>> 
>
> on x86_64:
> when GCOV is set/enabled:
>
>   HDRTEST drivers/gpu/drm/i915/display/intel_frontbuffer.h
> /dev/null:1:0: error: cannot open /dev/null.gcno
>   HDRTEST drivers/gpu/drm/i915/display/intel_ddi.h
> /dev/null:1:0: error: cannot open /dev/null.gcno
> make[5]: *** [../drivers/gpu/drm/i915/Makefile:307: drivers/gpu/drm/i915/display/intel_ddi.hdrtest] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[5]: *** [../drivers/gpu/drm/i915/Makefile:307: drivers/gpu/drm/i915/display/intel_frontbuffer.hdrtest] Error 1
>
>
> Full randconfig file is attached.

We're trying to hide that from the general population, only to be used
by our developers and CI, with e.g. "depends on !COMPILE_TEST". Can't
hide from randconfig it seems.

Does the below patch help?

BR,
Jani.


diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index b314d44ded5e..bc28c31c4f78 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -301,7 +301,7 @@ extra-$(CONFIG_DRM_I915_WERROR) += \
 		$(shell cd $(srctree)/$(src) && find * -name '*.h')))
 
 quiet_cmd_hdrtest = HDRTEST $(patsubst %.hdrtest,%.h,$@)
-      cmd_hdrtest = $(CC) $(c_flags) -S -o /dev/null -x c /dev/null -include $<; touch $@
+      cmd_hdrtest = $(CC) $(filter-out $(CFLAGS_GCOV), $(c_flags)) -S -o /dev/null -x c /dev/null -include $<; touch $@
 
 $(obj)/%.hdrtest: $(src)/%.h FORCE
 	$(call if_changed_dep,hdrtest)


-- 
Jani Nikula, Intel Open Source Graphics Center
