Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560A428913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhJKIsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 04:48:18 -0400
Received: from smtp-bc0a.mail.infomaniak.ch ([45.157.188.10]:43037 "EHLO
        smtp-bc0a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235311AbhJKIsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:48:16 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HSXT32QDgzMq0TS;
        Mon, 11 Oct 2021 10:46:15 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4HSXT10Jtzzlh8TC;
        Mon, 11 Oct 2021 10:46:13 +0200 (CEST)
Subject: Re: [PATCH v14 0/3] Add trusted_for(2) (was O_MAYEXEC)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        Kees Cook <keescook@chromium.org>,
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
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20211008104840.1733385-1-mic@digikod.net>
 <20211010144814.d9fb99de6b0af65b67dc96cb@linux-foundation.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <457941da-c4a4-262f-2981-74a85519c56f@digikod.net>
Date:   Mon, 11 Oct 2021 10:47:04 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20211010144814.d9fb99de6b0af65b67dc96cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/10/2021 23:48, Andrew Morton wrote:
> On Fri,  8 Oct 2021 12:48:37 +0200 Mickaël Salaün <mic@digikod.net> wrote:
> 
>> The final goal of this patch series is to enable the kernel to be a
>> global policy manager by entrusting processes with access control at
>> their level.  To reach this goal, two complementary parts are required:
>> * user space needs to be able to know if it can trust some file
>>   descriptor content for a specific usage;
>> * and the kernel needs to make available some part of the policy
>>   configured by the system administrator.
> 
> Apologies if I missed this...
> 
> It would be nice to see a description of the proposed syscall interface
> in these changelogs!  Then a few questions I have will be answered...

I described this syscall and it's semantic in the first patch in
Documentation/admin-guide/sysctl/fs.rst
Do you want me to copy-paste this content in the cover letter?

> 
> long trusted_for(const int fd,
> 		 const enum trusted_for_usage usage,
> 		 const u32 flags)
> 
> - `usage' must be equal to TRUSTED_FOR_EXECUTION, so why does it
>   exist?  Some future modes are planned?  Please expand on this.

Indeed, the current use case is to check if the kernel would allow
execution of a file. But as Florian pointed out, we may want to add more
context in the future, e.g. to enforce signature verification, to check
if this is a legitimate (system) library, to check if the file is
allowed to be used as (trusted) configuration…

> 
> - `flags' is unused (must be zero).  So why does it exist?  What are
>   the plans here?

This is mostly to follow syscall good practices for extensibility. It
could be used in combination with the usage argument (which defines the
user space semantic), e.g. to check for extra properties such as
cryptographic or integrity requirements, origin of the file…

> 
> - what values does the syscall return and what do they mean?
> 

It returns 0 on success, or -EACCES if the kernel policy denies the
specified usage.
