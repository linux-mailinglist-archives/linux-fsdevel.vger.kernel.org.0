Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79368264B1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIJRXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:23:17 -0400
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8]:52119 "EHLO
        smtp-bc08.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgIJRWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:22:10 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BnQfr608ZzlhcF4;
        Thu, 10 Sep 2020 19:21:56 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BnQfp4Lxmzlh8T3;
        Thu, 10 Sep 2020 19:21:54 +0200 (CEST)
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200910164612.114215-1-mic@digikod.net>
 <20200910170424.GU6583@casper.infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net>
Date:   Thu, 10 Sep 2020 19:21:37 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200910170424.GU6583@casper.infradead.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/09/2020 19:04, Matthew Wilcox wrote:
> On Thu, Sep 10, 2020 at 06:46:09PM +0200, Mickaël Salaün wrote:
>> This ninth patch series rework the previous AT_INTERPRETED and O_MAYEXEC
>> series with a new syscall: introspect_access(2) .  Access check are now
>> only possible on a file descriptor, which enable to avoid possible race
>> conditions in user space.
> 
> But introspection is about examining _yourself_.  This isn't about
> doing that.  It's about doing ... something ... to a script that you're
> going to execute.  If the script were going to call the syscall, then
> it might be introspection.  Or if the interpreter were measuring itself,
> that would be introspection.  But neither of those would be useful things
> to do, because an attacker could simply avoid doing them.

Picking a good name other than "access" (or faccessat2) is not easy. The
idea with introspect_access() is for the calling task to ask the kernel
if this task should allows to do give access to a kernel resource which
is already available to this task. In this sense, we think that
introspection makes sense because it is the choice of the task to allow
or deny an access.

> 
> So, bad name.  What might be better?  sys_security_check()?
> sys_measure()?  sys_verify_fd()?  I don't know.
> 

"security_check" looks quite broad, "measure" doesn't make sense here,
"verify_fd" doesn't reflect that it is an access check. Yes, not easy,
but if this is the only concern we are on the good track. :)


Other ideas:
- interpret_access (mainly, but not only, for interpreters)
- indirect_access
- may_access
- faccessat3
