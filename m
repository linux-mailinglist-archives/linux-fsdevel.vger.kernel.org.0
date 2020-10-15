Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3928EC61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 06:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgJOEqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 00:46:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:4839 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgJOEqd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:46:33 -0400
IronPort-SDR: iOGxpW3ZQR4HfO8xHvHsk8Cy1gC6KkMpHACDDNcWlw3m4LygWg5NoX0a+jv1TtIzZpBjSYUl19
 yxUC4bcTFz8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="154088398"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="154088398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:46:32 -0700
IronPort-SDR: okZevJNyFoB0pDRj0graDCFAGBe85RU4H4aY8F5klmxXZx1X/fo3dQRhH8k0J0Lzctn9GCjeCZ
 aeWfHIgGHVcw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="531105799"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:46:32 -0700
Date:   Wed, 14 Oct 2020 21:46:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 9/9] x86/pks: Add PKS test code
Message-ID: <20201015044632.GT2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-10-ira.weiny@intel.com>
 <3f9ebe3b-5c1c-6a69-3779-6f90d66227bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9ebe3b-5c1c-6a69-3779-6f90d66227bd@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:02:07PM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> >  #ifdef CONFIG_X86_32
> >  	/*
> >  	 * We can fault-in kernel-space virtual memory on-demand. The
> > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > index cc3510cde64e..f9552bd9341f 100644
> > --- a/include/linux/pkeys.h
> > +++ b/include/linux/pkeys.h
> > @@ -47,7 +47,6 @@ static inline bool arch_pkeys_enabled(void)
> >  static inline void copy_init_pkru_to_fpregs(void)
> >  {
> >  }
> > -
> >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> 
> ^ Whitespace damage

Done.

> 
> >  #ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 0c781f912f9f..f015c09ba5a1 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2400,6 +2400,18 @@ config HYPERV_TESTING
> >  	help
> >  	  Select this option to enable Hyper-V vmbus testing.
> >  
> > +config PKS_TESTING
> > +	bool "PKey(S)upervisor testing"
> 
> Seems like we need a space in there somewhere.

heheh...  yea...

> 
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
> > +		if (fd < 0) {
> > +			printf("cannot open file\n");
> > +			return -1;
> > +		}
> > +
> 
> Will this return code make anybody mad?  Should we have a nicer return
> code for when this is running on non-PKS hardware?

I'm not sure it will matter much but I think it is better to report the missing
file.[1]

> 
> I'm not going to be too picky about this.  I'll just ask one question:
> Has this found real bugs for you?

Many, especially regressions as things have changed.

> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

Thanks,
Ira

[1]

diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 8037a2a9ff5f..11be4e212d54 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -11,6 +11,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+#define PKS_TEST_FILE "/sys/kernel/debug/x86/run_pks"
+
 int main(void)
 {
        cpu_set_t cpuset;
@@ -25,9 +27,9 @@ int main(void)
 
        pid = fork();
        if (pid == 0) {
-               fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+               fd = open(PKS_TEST_FILE, O_RDWR);
                if (fd < 0) {
-                       printf("cannot open file\n");
+                       printf("cannot open %s\n", PKS_TEST_FILE);
                        return -1;
                }
 
@@ -45,9 +47,9 @@ int main(void)
        } else {
                sleep(2);
 
-               fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+               fd = open(PKS_TEST_FILE, O_RDWR);
                if (fd < 0) {
-                       printf("cannot open file\n");
+                       printf("cannot open %s\n", PKS_TEST_FILE);
                        return -1;
                }
 

