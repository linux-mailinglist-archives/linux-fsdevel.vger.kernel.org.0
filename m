Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B11C17CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgEAOcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgEAOcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 10:32:24 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6DAC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 07:32:23 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49DF8659L7zlhH6x;
        Fri,  1 May 2020 16:32:22 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49DF850BX5zlvJFk;
        Fri,  1 May 2020 16:32:20 +0200 (CEST)
Subject: Re: [PATCH v3 3/5] fs: Enable to enforce noexec mounts or file exec
 through RESOLVE_MAYEXEC
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200428175129.634352-1-mic@digikod.net>
 <20200428175129.634352-4-mic@digikod.net>
 <alpine.LRH.2.21.2005011409570.29679@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d1a81d06-7530-1f2b-858a-e42bc1ae2a7e@digikod.net>
Date:   Fri, 1 May 2020 16:32:20 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005011409570.29679@namei.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/05/2020 06:22, James Morris wrote:
> On Tue, 28 Apr 2020, Mickaël Salaün wrote:
> 
>> Enable to either propagate the mount options from the underlying VFS
>> mount to prevent execution, or to propagate the file execute permission.
>> This may allow a script interpreter to check execution permissions
>> before reading commands from a file.
> 
> I'm finding the description of this patch difficult to understand.
> 
> In the first case, this seems to mean: if you open a file with 
> RESOLVE_MAYEXEC from a noexec mount, then it will fail. Correct?

Yes.

> 
> In the second case, do you mean a RESOLVE_MAYEXEC open will fail if the 
> file does not have +x set for the user?

Yes, and this is still in the hands sysadmins.

As explain in the documentation patch, the sysctl takes a bitfield
consisting of "mount !noexec" or "file exec permission". It is not an
exclusive OR. The "file exec permission" could be seen as a more strict
restriction than only the mount one.

> 
> 
>> The main goal is to be able to protect the kernel by restricting
>> arbitrary syscalls that an attacker could perform with a crafted binary
>> or certain script languages.
> 
> This sounds like the job of seccomp. Why is this part of MAYEXEC?

The initial goal of O_MAYEXEC (in CLIP OS 4) is to prevent untrusted
code execution. Code execution leads to system calls, which could lead
to data access/modification, and kernel attacks. seccomp can't enable
execution of only some files, it only enables an on/off execution policy
(i.e. by filtering execve(2) ).

> 
>>  It also improves multilevel isolation
>> by reducing the ability of an attacker to use side channels with
>> specific code.  These restrictions can natively be enforced for ELF
>> binaries (with the noexec mount option) but require this kernel
>> extension to properly handle scripts (e.g., Python, Perl).
> 
> Again, not sure why you're talking about side channels and MAYEXEC and 
> mount options. Are you more generally talking about being able to prevent 
> execution of arbitrary script files included by an interpreter?

Yes, I explain the thread model, especially the risk of scripts.
Multilevel isolation can be bypassed simply by using CPU instructions
(e.g. side channel attacks), not even syscalls. The ability to execute
arbitrary code, including advanced scripting languages, can lead to this
kind of CPU attacks.

> 
>> Add a new sysctl fs.open_mayexec_enforce to control this behavior.
>> Indeed, because of compatibility with installed systems, only the system
>> administrator is able to check that this new enforcement is in line with
>> the system mount points and file permissions.  A following patch adds
>> documentation.
> 
> I don't like the idea of any of this feature set being configurable. 
> RESOLVE_MAYEXEC as a new flag should have well-defined, stable semantics.

Unfortunately, as discussed in the v2 email thread [1], if we impose
such restrictions with the O_MAYEXEC flag, then almost no userspace
application will use it because it could cause unexpected behavior.
Indeed, the application developers may not know the configuration of the
system their applications will be run on. Only sysadmins know the mount
points configuration (either they are have noexec or not), and if the
set of application installed on the system works well with the set of
files (e.g. according to their permissions). It is the same issue as
with a system-wide LSM policy configuration. Processes should be able to
tell their use of a file, but the sysadmin using common distro binaries
should be able to control the execution policy according to the maturity
of the current system installation.

However, for fully controlled distros such as CLIP OS, it make sense to
enforce such restrictions at kernel build time. I can add an alternative
kernel configuration to enforce a particular policy at boot and disable
this sysctl.

[1]
https://lore.kernel.org/lkml/1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr/
