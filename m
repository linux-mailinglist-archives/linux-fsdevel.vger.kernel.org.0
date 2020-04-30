Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FD31BF5D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3Kpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 06:45:45 -0400
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:47343 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgD3Kpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:45:44 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49CX912QbTzlhqlb;
        Thu, 30 Apr 2020 12:45:41 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49CX8y5zpZzll5m6;
        Thu, 30 Apr 2020 12:45:38 +0200 (CEST)
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
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
 <20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com>
 <20200430080746.n26fja2444w6i2db@wittgenstein>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <a7345fd6-ec2b-ac24-842d-8cded56df958@digikod.net>
Date:   Thu, 30 Apr 2020 12:45:38 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200430080746.n26fja2444w6i2db@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 30/04/2020 10:07, Christian Brauner wrote:
> On Thu, Apr 30, 2020 at 11:54:29AM +1000, Aleksa Sarai wrote:
>> On 2020-04-28, Mickaël Salaün <mic@digikod.net> wrote:
>>> The goal of this patch series is to enable to control script execution
>>> with interpreters help.  A new RESOLVE_MAYEXEC flag, usable through
>>> openat2(2), is added to enable userspace script interpreter to delegate
>>> to the kernel (and thus the system security policy) the permission to
>>> interpret/execute scripts or other files containing what can be seen as
>>> commands.
>>>
>>> This third patch series mainly differ from the previous one by relying
>>> on the new openat2(2) system call to get rid of the undefined behavior
>>> of the open(2) flags.  Thus, the previous O_MAYEXEC flag is now replaced
>>> with the new RESOLVE_MAYEXEC flag and benefits from the openat2(2)
>>> strict check of this kind of flags.
>>
>> My only strong upfront objection is with this being a RESOLVE_ flag.
>>
>> RESOLVE_ flags have a specific meaning (they generally apply to all
>> components, and affect the rules of path resolution). RESOLVE_MAYEXEC
>> does neither of these things and so seems out of place among the other
>> RESOLVE_ flags.
>>
>> I would argue this should be an O_ flag, but not supported for the
> 
> I agree.

OK, I'll switch back to O_MAYEXEC.
