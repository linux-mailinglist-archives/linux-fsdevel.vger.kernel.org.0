Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD25426794
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhJHKWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 06:22:35 -0400
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15]:39275 "EHLO
        smtp-bc0f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236118AbhJHKWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:22:34 -0400
X-Greylist: delayed 57419 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 06:22:34 EDT
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HQkjL0bwrzMqF8X;
        Fri,  8 Oct 2021 12:20:38 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HQkjJ0zTjzlhP4V;
        Fri,  8 Oct 2021 12:20:36 +0200 (CEST)
Subject: Re: [PATCH v13 3/3] selftest/interpreter: Add tests for
 trusted_for(2) policies
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20211007182321.872075-1-mic@digikod.net>
 <20211007182321.872075-4-mic@digikod.net> <202110071227.669B5A91C@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b1599775-a061-6c91-03a4-c82734c7f58c@digikod.net>
Date:   Fri, 8 Oct 2021 12:21:12 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202110071227.669B5A91C@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/10/2021 21:48, Kees Cook wrote:
> On Thu, Oct 07, 2021 at 08:23:20PM +0200, Mickaël Salaün wrote:

[...]

>> diff --git a/tools/testing/selftests/interpreter/Makefile b/tools/testing/selftests/interpreter/Makefile
>> new file mode 100644
>> index 000000000000..1f71a161d40b
>> --- /dev/null
>> +++ b/tools/testing/selftests/interpreter/Makefile
>> @@ -0,0 +1,21 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +CFLAGS += -Wall -O2
>> +LDLIBS += -lcap
>> +
>> +src_test := $(wildcard *_test.c)
>> +TEST_GEN_PROGS := $(src_test:.c=)
>> +
>> +KSFT_KHDR_INSTALL := 1
>> +include ../lib.mk
>> +
>> +khdr_dir = $(top_srcdir)/usr/include
>> +
>> +$(khdr_dir)/asm-generic/unistd.h: khdr
>> +	@:
>> +
>> +$(khdr_dir)/linux/trusted-for.h: khdr
>> +	@:
>> +
>> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/asm-generic/unistd.h $(khdr_dir)/linux/trusted-for.h ../kselftest_harness.h
>> +	$(LINK.c) $< $(LDLIBS) -o $@ -I$(khdr_dir)
> 
> Is all this really needed?

Yes, all this is needed to be sure that the tests will be rebuild when a
dependency change (either one of the header files or a source file).

> 
> - CFLAGS and LDLIBS will be used by the default rules

Yes, but it will only run the build command when a source file change,
not a header file.

> - khdr is already a pre-dependency when KSFT_KHDR_INSTALL is set

Yes, but it is not enough to rebuild the tests (and check the installed
files) when a header file change.

> - kselftest_harness.h is already a build-dep (see LOCAL_HDRS)

Yes, but without an explicit requirement, changing kselftest_harness.h
doesn't force a rebuild.

> - TEST_GEN_PROGS's .c files are already build-deps

It is not enough to trigger test rebuilds.

> 
> kselftest does, oddly, lack a common -I when KSFT_KHDR_INSTALL is set
> (which likely should get fixed, though separately from here).
> 
> I think you just want:
> 
> 
> src_test := $(wildcard *_test.c)
> TEST_GEN_PROGS := $(src_test:.c=)
> 
> KSFT_KHDR_INSTALL := 1
> include ../lib.mk
> 
> CFLAGS += -Wall -O2 -I$(BUILD)/usr/include
> LDLIBS += -lcap
> 
> $(OUTPUT)/%_test: $(BUILD)/usr/include/linux/trusted-for.h
> 
> 
> (untested)
> 
Yep, I re-checked and my Makefile is correct. I didn't find a way to
make it lighter while correctly handling dependencies.
I'll just move the -I to CFLAGS.
