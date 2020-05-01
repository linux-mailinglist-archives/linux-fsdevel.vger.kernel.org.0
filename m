Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0B1C0D30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 06:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgEAEXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 00:23:25 -0400
Received: from namei.org ([65.99.196.166]:56544 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgEAEXZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 00:23:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0414MTSS031613;
        Fri, 1 May 2020 04:22:29 GMT
Date:   Fri, 1 May 2020 14:22:29 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
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
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
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
Subject: Re: [PATCH v3 3/5] fs: Enable to enforce noexec mounts or file exec
 through RESOLVE_MAYEXEC
In-Reply-To: <20200428175129.634352-4-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2005011409570.29679@namei.org>
References: <20200428175129.634352-1-mic@digikod.net> <20200428175129.634352-4-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-573384471-1588306338=:29679"
Content-ID: <alpine.LRH.2.21.2005011412230.29679@namei.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-573384471-1588306338=:29679
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.2005011412231.29679@namei.org>

On Tue, 28 Apr 2020, Mickaël Salaün wrote:

> Enable to either propagate the mount options from the underlying VFS
> mount to prevent execution, or to propagate the file execute permission.
> This may allow a script interpreter to check execution permissions
> before reading commands from a file.

I'm finding the description of this patch difficult to understand.

In the first case, this seems to mean: if you open a file with 
RESOLVE_MAYEXEC from a noexec mount, then it will fail. Correct?

In the second case, do you mean a RESOLVE_MAYEXEC open will fail if the 
file does not have +x set for the user?


> The main goal is to be able to protect the kernel by restricting
> arbitrary syscalls that an attacker could perform with a crafted binary
> or certain script languages.

This sounds like the job of seccomp. Why is this part of MAYEXEC?

>  It also improves multilevel isolation
> by reducing the ability of an attacker to use side channels with
> specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g., Python, Perl).

Again, not sure why you're talking about side channels and MAYEXEC and 
mount options. Are you more generally talking about being able to prevent 
execution of arbitrary script files included by an interpreter?

> Add a new sysctl fs.open_mayexec_enforce to control this behavior.
> Indeed, because of compatibility with installed systems, only the system
> administrator is able to check that this new enforcement is in line with
> the system mount points and file permissions.  A following patch adds
> documentation.

I don't like the idea of any of this feature set being configurable. 
RESOLVE_MAYEXEC as a new flag should have well-defined, stable semantics.


-- 
James Morris
<jmorris@namei.org>
--1665246916-573384471-1588306338=:29679--
