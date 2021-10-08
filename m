Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA74D426776
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhJHKRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhJHKRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:17:42 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507FC061570
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 03:15:47 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HQkbj1pTMzMqD8t;
        Fri,  8 Oct 2021 12:15:45 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HQkbd2lkGzlh8Tv;
        Fri,  8 Oct 2021 12:15:41 +0200 (CEST)
Subject: Re: [PATCH v13 1/3] fs: Add trusted_for(2) syscall implementation and
 related sysctl
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
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
 <20211007182321.872075-2-mic@digikod.net> <202110071217.16C7208F@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <92b01e4f-2bc3-8ba2-997b-5757058fe184@digikod.net>
Date:   Fri, 8 Oct 2021 12:16:17 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202110071217.16C7208F@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/10/2021 21:25, Kees Cook wrote:
> On Thu, Oct 07, 2021 at 08:23:18PM +0200, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> The trusted_for() syscall enables user space tasks to check that files
>> are trusted to be executed or interpreted by user space.  This may allow
>> script interpreters to check execution permission before reading
>> commands from a file, or dynamic linkers to allow shared object loading.
>> This may be seen as a way for a trusted task (e.g. interpreter) to check
>> the trustworthiness of files (e.g. scripts) before extending its control
>> flow graph with new ones originating from these files.
>> [...]
>>  aio-nr & aio-max-nr
>> @@ -382,3 +383,52 @@ Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
>>  on a 64bit one.
>>  The current default value for  max_user_watches  is the 1/25 (4%) of the
>>  available low memory, divided for the "watch" cost in bytes.
>> +
>> +
>> +trust_policy
>> +------------
> 
> bikeshed: can we name this "trusted_for_policy"? Both "trust" and
> "policy" are very general words, but "trusted_for" (after this series)
> will have a distinct meaning, so "trusted_for_policy" becomes more
> specific/searchable.

Ok, I'll rename this sysctl.

> 
> With that renamed, I think it looks good! I'm looking forward to
> interpreters using this. :)
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
