Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376111D1103
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbgEMLSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:18:05 -0400
Received: from smtp-190f.mail.infomaniak.ch ([185.125.25.15]:35075 "EHLO
        smtp-190f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730975AbgEMLSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:18:05 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49MXGL6nZBzlhDCt;
        Wed, 13 May 2020 13:18:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49MXGJ55kJzlhFDc;
        Wed, 13 May 2020 13:18:00 +0200 (CEST)
Subject: Re: [PATCH v5 4/6] selftest/openat2: Add tests for O_MAYEXEC
 enforcing
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-5-mic@digikod.net> <202005121452.4DED41A@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <6fc6bbe4-da18-1b8d-a61c-558f5a4a4908@digikod.net>
Date:   Wed, 13 May 2020 13:18:00 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202005121452.4DED41A@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/05/2020 23:57, Kees Cook wrote:
> On Tue, May 05, 2020 at 05:31:54PM +0200, Mickaël Salaün wrote:
>> Test propagation of noexec mount points or file executability through
>> files open with or without O_MAYEXEC, thanks to the
>> fs.open_mayexec_enforce sysctl.
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Shuah Khan <shuah@kernel.org>
> 
> Yay tests! :) Notes below...
> 
>> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
>> index 4b93b1417b86..cb98bdb4d5b1 100644
>> --- a/tools/testing/selftests/openat2/Makefile
>> +++ b/tools/testing/selftests/openat2/Makefile
>> @@ -1,7 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0-or-later
>>  
>>  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>> -TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>> +LDLIBS += -lcap
>> +TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test omayexec_test
> 
> I realize the others have _test in their name, but that feels intensely
> redundant to me. :)

It is redundant in the path name but it is useful to match the generated
files e.g., in gitignore.

> 
>> [...]
>> diff --git a/tools/testing/selftests/openat2/omayexec_test.c b/tools/testing/selftests/openat2/omayexec_test.c
>> new file mode 100644
>> index 000000000000..7052c852daf8
>> --- /dev/null
>> +++ b/tools/testing/selftests/openat2/omayexec_test.c
>> [...]
>> +FIXTURE_DATA(mount_exec_file_exec) { };
> 
> For each of these, Please use "FIXTURE" not "FIXTURE_DATA". See:
> 1ae81d78a8b2 ("selftests/seccomp: Adjust test fixture counts")

Indeed.

> 
>> +FIXTURE_SETUP(mount_exec_file_exec)
>> +{
>> +	create_workspace(_metadata, 1, 1);
> 
> Maybe save the system's original sysctl in create_workspace() instead
> of always restoring it to 0 in delete_workspace()?

Right.

> 
> Otherwise, looks good!
> 

Thanks.
