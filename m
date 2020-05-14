Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D9C1D3D55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 21:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgENTV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727840AbgENTV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 15:21:27 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21092C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 12:21:27 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49NLxc0FXZzlhNp2;
        Thu, 14 May 2020 21:21:24 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49NLxZ3CmQzljTrx;
        Thu, 14 May 2020 21:21:22 +0200 (CEST)
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
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
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <0e654c90-bec5-6ba1-771e-648da94ef547@digikod.net>
Date:   Thu, 14 May 2020 21:21:21 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202005131525.D08BFB3@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 14/05/2020 01:27, Kees Cook wrote:
> On Wed, May 13, 2020 at 11:37:16AM -0400, Stephen Smalley wrote:
>> On Tue, May 5, 2020 at 11:33 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>> Enable to forbid access to files open with O_MAYEXEC.  Thanks to the
>>> noexec option from the underlying VFS mount, or to the file execute
>>> permission, userspace can enforce these execution policies.  This may
>>> allow script interpreters to check execution permission before reading
>>> commands from a file, or dynamic linkers to allow shared object loading.
>>>
>>> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
>>> to enforce two complementary security policies according to the
>>> installed system: enforce the noexec mount option, and enforce
>>> executable file permission.  Indeed, because of compatibility with
>>> installed systems, only system administrators are able to check that
>>> this new enforcement is in line with the system mount points and file
>>> permissions.  A following patch adds documentation.
>>>
>>> For tailored Linux distributions, it is possible to enforce such
>>> restriction at build time thanks to the CONFIG_OMAYEXEC_STATIC option.
>>> The policy can then be configured with CONFIG_OMAYEXEC_ENFORCE_MOUNT and
>>> CONFIG_OMAYEXEC_ENFORCE_FILE.
>>>
>>> Being able to restrict execution also enables to protect the kernel by
>>> restricting arbitrary syscalls that an attacker could perform with a
>>> crafted binary or certain script languages.  It also improves multilevel
>>> isolation by reducing the ability of an attacker to use side channels
>>> with specific code.  These restrictions can natively be enforced for ELF
>>> binaries (with the noexec mount option) but require this kernel
>>> extension to properly handle scripts (e.g., Python, Perl).  To get a
>>> consistent execution policy, additional memory restrictions should also
>>> be enforced (e.g. thanks to SELinux).
>>>
>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> ---
>>
>>> diff --git a/fs/namei.c b/fs/namei.c
>>> index 33b6d372e74a..70f179f6bc6c 100644
>>> --- a/fs/namei.c
>>> +++ b/fs/namei.c
>>> @@ -411,10 +412,90 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>> <snip>
>>> +#if defined(CONFIG_SYSCTL) && !defined(CONFIG_OMAYEXEC_STATIC)
>>> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
>>> +               size_t *lenp, loff_t *ppos)
>>> +{
>>> +       int error;
>>> +
>>> +       if (write) {
>>> +               struct ctl_table table_copy;
>>> +               int tmp_mayexec_enforce;
>>> +
>>> +               if (!capable(CAP_MAC_ADMIN))
>>> +                       return -EPERM;
>>
>> Not fond of using CAP_MAC_ADMIN here (or elsewhere outside of security
>> modules).  The ability to set this sysctl is not equivalent to being
>> able to load a MAC policy, set arbitrary MAC labels on
>> processes/files, etc.
> 
> That's fair. In that case, perhaps this could just use the existing
> _sysadmin helper? (Though I should note that these perm checks actually
> need to be in the open, not the read/write ... I thought there was a
> series to fix that, but I can't find it now. Regardless, that's
> orthogonal to this series.)

OK, I'll switch to CAP_SYS_ADMIN with proc_dointvec_minmax_sysadmin().
