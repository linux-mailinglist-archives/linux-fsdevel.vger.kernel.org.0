Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82B1D2CAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgENK1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 06:27:53 -0400
Received: from smtp-1908.mail.infomaniak.ch ([185.125.25.8]:52757 "EHLO
        smtp-1908.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbgENK1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 06:27:53 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49N75w45kTzlhj0J;
        Thu, 14 May 2020 12:27:48 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49N75t2qqnzljHmw;
        Thu, 14 May 2020 12:27:46 +0200 (CEST)
Subject: Re: [PATCH v17 02/10] landlock: Add ruleset and domain management
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200511192156.1618284-1-mic@digikod.net>
 <20200511192156.1618284-3-mic@digikod.net>
 <alpine.LRH.2.21.2005141302330.30052@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net>
Date:   Thu, 14 May 2020 12:27:45 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005141302330.30052@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 14/05/2020 05:09, James Morris wrote:
> On Mon, 11 May 2020, Mickaël Salaün wrote:
> 
>> + * .. warning::
>> + *
>> + *   It is currently not possible to restrict some file-related actions
>> + *   accessible through these syscall families: :manpage:`chdir(2)`,
>> + *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
>> + *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
>> + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`.
>> + *   Future Landlock evolutions will enable to restrict them.
> 
> I have to wonder how useful Landlock will be without more coverage per 
> the above.

This is the result of previous discussions (on mailing lists and
conferences) to minimize the code of Landlock to ease review. There is
also network and other subsystems which are not covered, the same way
other LSMs may not cover everything. However, Landlock is designed to be
extensible without breaking user space, so extending this access-control
will not be a problem. Previous versions of this patch series handled
much more.

Moreover, we can compare the current situation with seccomp. Indeed,
seccomp only enables to restrict system calls according to their number
and their raw arguments. seccomp is designed to limit the attack surface
of the kernel but it is also used to remove ways to access kernel
resources. Application developers willing to sandbox their products are
already using seccomp but there is limitations (e.g. file access
control). Landlock addresses such limitations, which improves the
current situation.

We can also view seccomp as a complementary solution to the current
limitations of Landlock. Indeed, seccomp filters can block or restrict
the use of syscall families which may not be currently handled by Landlock.

> 
> It would be helpful if you could outline a threat model for this initial 
> version, so people can get an idea of what kind of useful protection may
> be gained from it.

The main threat model may be seen as protecting from vulnerable (i.e.
malicious) code. But because Landlock policies are defined by
application developers, they also define their own threat model.

> 
> Are there any distros or other major users who are planning on enabling or 
> at least investigating Landlock?

I think the question should be: is there any distros which are not
interested to improve the security of their users? :)
Landlock is mainly designed for application developers, and most Linux
distros rely on applications which are not developed by themselves.

Some hardened distros such as CLIP OS and Chrome OS are interested to
extend the security of the whole system with tailored sandboxing (e.g.
internal and critical services, security brokers). For example, Chrome
OS folks investigated with a previous version of Landlock:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel-next/+/658517/
I'm sure there is other tailored distros which will be interested once
Landlock will be upstream (e.g. Tails, Qubes OS, Subgraph OS, etc.).

> 
> Do you have any examples of a practical application of this scheme?

We can start with applications with builtin sandboxing, like web
browsers, web services, email services, SSH, etc. There is also all
system services handled by an init system which provides security
features (e.g. systemd). There is also the security sandbox tools (e.g.
Minijail [1], Firejail [2], nsjail [3], Flatpak [4], etc.). And finally,
security-oriented APIs such as Sandboxed API [5]. Most of them should
welcome new Linux sandboxing features provided by Landlock.

[1] https://android.googlesource.com/platform/external/minijail
[2] https://firejail.wordpress.com/
[3] https://nsjail.dev/
[4] https://flatpak.org/
[5] https://github.com/google/sandboxed-api
