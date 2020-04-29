Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB51BD79C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 10:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD2Iuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 04:50:55 -0400
Received: from smtp-42a8.mail.infomaniak.ch ([84.16.66.168]:50285 "EHLO
        smtp-42a8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgD2Iuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:50:54 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49BsfQ1WB6zlhqlx;
        Wed, 29 Apr 2020 10:50:22 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49BsfM4z8bzmPw5b;
        Wed, 29 Apr 2020 10:50:19 +0200 (CEST)
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     Jann Horn <jannh@google.com>, Florian Weimer <fw@deneb.enyo.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200428175129.634352-1-mic@digikod.net>
 <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
 <87blnb48a3.fsf@mid.deneb.enyo.de>
 <CAG48ez2TphTj-VdDaSjvnr0Q8BhNmT3n86xYz4bF3wRJmAMsMw@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <ece281a5-8944-65fd-2a76-e4479a0cccaf@digikod.net>
Date:   Wed, 29 Apr 2020 10:50:19 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CAG48ez2TphTj-VdDaSjvnr0Q8BhNmT3n86xYz4bF3wRJmAMsMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 29/04/2020 00:01, Jann Horn wrote:
> On Tue, Apr 28, 2020 at 11:21 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>> * Jann Horn:
>>
>>> Just as a comment: You'd probably also have to use RESOLVE_MAYEXEC in
>>> the dynamic linker.
>>
>> Absolutely.  In typical configurations, the kernel does not enforce
>> that executable mappings must be backed by files which are executable.
>> It's most obvious with using an explicit loader invocation to run
>> executables on noexec mounts.  RESOLVE_MAYEXEC is much more useful
>> than trying to reimplement the kernel permission checks (or what some
>> believe they should be) in userspace.

Indeed it makes sense to use RESOLVE_MAYEXEC for the dynamic linker too.
Only the noexec mount option is taken into account for mmap(2) with
PROT_EXEC, and if you can trick the dynamic linker with JOP as Jann
explained, it may enable to execute new code. However, a kernel which
forbids remapping memory with PROT_EXEC still enables to implement a W^X
policy. Any JOP/ROP still enables unexpected code execution though.

> 
> Oh, good point.
> 
> That actually seems like something Mickaël could add to his series? If
> someone turns on that knob for "When an interpreter wants to execute
> something, enforce that we have execute access to it", they probably
> also don't want it to be possible to just map files as executable? So
> perhaps when that flag is on, the kernel should either refuse to map
> anything as executable if it wasn't opened with RESOLVE_MAYEXEC or
> (less strict) if RESOLVE_MAYEXEC wasn't used, print a warning, then
> check whether the file is executable and bail out if not?
> 
> A configuration where interpreters verify that scripts are executable,
> but other things can just mmap executable pages, seems kinda
> inconsistent...

As it is written in the documentation patch, this RESOLVE_MAYEXEC
feature is an important missing piece, but to implement a consistent
security policy we need to enable other restrictions starting with a
noexec mount point policy. The purpose of this patch series is not to
bring a full-feature LSM with process states handling, but it brings
what is needed for LSMs such as SELinux, IMA or IPE to extend their
capabilities to reach what you would expect.
