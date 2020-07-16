Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20E622251D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGPOS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:18:59 -0400
Received: from smtp-190b.mail.infomaniak.ch ([185.125.25.11]:55351 "EHLO
        smtp-190b.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728412AbgGPOS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:18:59 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B6xFW2DSnzlhJYD;
        Thu, 16 Jul 2020 16:18:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B6xFN4zMgzlh8TM;
        Thu, 16 Jul 2020 16:18:48 +0200 (CEST)
Subject: Re: [PATCH v6 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
To:     Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-5-mic@digikod.net> <202007151304.9F48071@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b209ea10-5b7f-c40e-5b6a-3da9028403d5@digikod.net>
Date:   Thu, 16 Jul 2020 16:18:27 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202007151304.9F48071@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/07/2020 22:06, Kees Cook wrote:
> On Tue, Jul 14, 2020 at 08:16:35PM +0200, Mickaël Salaün wrote:
>> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
>> additional restrictions depending on a security policy managed by the
>> kernel through a sysctl or implemented by an LSM thanks to the
>> inode_permission hook.  This new flag is ignored by open(2) and
>> openat(2) because of their unspecified flags handling.
>>
>> The underlying idea is to be able to restrict scripts interpretation
>> according to a policy defined by the system administrator.  For this to
>> be possible, script interpreters must use the O_MAYEXEC flag
>> appropriately.  To be fully effective, these interpreters also need to
>> handle the other ways to execute code: command line parameters (e.g.,
>> option -e for Perl), module loading (e.g., option -m for Python), stdin,
>> file sourcing, environment variables, configuration files, etc.
>> According to the threat model, it may be acceptable to allow some script
>> interpreters (e.g. Bash) to interpret commands from stdin, may it be a
>> TTY or a pipe, because it may not be enough to (directly) perform
>> syscalls.  Further documentation can be found in a following patch.
>>
>> Even without enforced security policy, userland interpreters can set it
>> to enforce the system policy at their level, knowing that it will not
>> break anything on running systems which do not care about this feature.
>> However, on systems which want this feature enforced, there will be
>> knowledgeable people (i.e. sysadmins who enforced O_MAYEXEC
>> deliberately) to manage it.  A simple security policy implementation,
>> configured through a dedicated sysctl, is available in a following
>> patch.
>>
>> O_MAYEXEC should not be confused with the O_EXEC flag which is intended
>> for execute-only, which obviously doesn't work for scripts.  However, a
>> similar behavior could be implemented in userland with O_PATH:
>> https://lore.kernel.org/lkml/1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net/
>>
>> The implementation of O_MAYEXEC almost duplicates what execve(2) and
>> uselib(2) are already doing: setting MAY_OPENEXEC in acc_mode (which can
>> then be checked as MAY_EXEC, if enforced), and propagating FMODE_EXEC to
>> _fmode via __FMODE_EXEC flag (which can then trigger a
>> fanotify/FAN_OPEN_EXEC event).
>>
>> This is an updated subset of the patch initially written by Vincent
>> Strubel for CLIP OS 4:
>> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
>> This patch has been used for more than 12 years with customized script
>> interpreters.  Some examples (with the original name O_MAYEXEC) can be
>> found here:
>> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
>>
>> Co-developed-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
>> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
>> Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Deven Bowers <deven.desai@linux.microsoft.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>>
>> Changes since v5:
>> * Update commit message.
>>
>> Changes since v3:
>> * Switch back to O_MAYEXEC, but only handle it with openat2(2) which
>>   checks unknown flags (suggested by Aleksa Sarai). Cf.
>>   https://lore.kernel.org/lkml/20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com/
>>
>> Changes since v2:
>> * Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).  This change
>>   enables to not break existing application using bogus O_* flags that
>>   may be ignored by current kernels by using a new dedicated flag, only
>>   usable through openat2(2) (suggested by Jeff Layton).  Using this flag
>>   will results in an error if the running kernel does not support it.
>>   User space needs to manage this case, as with other RESOLVE_* flags.
>>   The best effort approach to security (for most common distros) will
>>   simply consists of ignoring such an error and retry without
>>   RESOLVE_MAYEXEC.  However, a fully controlled system may which to
>>   error out if such an inconsistency is detected.
>>
>> Changes since v1:
>> * Set __FMODE_EXEC when using O_MAYEXEC to make this information
>>   available through the new fanotify/FAN_OPEN_EXEC event (suggested by
>>   Jan Kara and Matthew Bobrowski):
>>   https://lore.kernel.org/lkml/20181213094658.GA996@lithium.mbobrowski.org/
>> ---
>>  fs/fcntl.c                       | 2 +-
>>  fs/open.c                        | 8 ++++++++
>>  include/linux/fcntl.h            | 2 +-
>>  include/linux/fs.h               | 2 ++
>>  include/uapi/asm-generic/fcntl.h | 7 +++++++
>>  5 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index 2e4c0fa2074b..0357ad667563 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -1033,7 +1033,7 @@ static int __init fcntl_init(void)
>>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>>  	 */
>> -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
>> +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
>>  		HWEIGHT32(
>>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>>  			__FMODE_EXEC | __FMODE_NONOTIFY));
>> diff --git a/fs/open.c b/fs/open.c
>> index 623b7506a6db..38e434bdbbb6 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -987,6 +987,8 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>>  		.mode = mode & S_IALLUGO,
>>  	};
>>  
>> +	/* O_MAYEXEC is ignored by syscalls relying on build_open_how(). */
>> +	how.flags &= ~O_MAYEXEC;
>>  	/* O_PATH beats everything else. */
>>  	if (how.flags & O_PATH)
>>  		how.flags &= O_PATH_FLAGS;
>> @@ -1054,6 +1056,12 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>>  	if (flags & __O_SYNC)
>>  		flags |= O_DSYNC;
>>  
>> +	/* Checks execution permissions on open. */
>> +	if (flags & O_MAYEXEC) {
>> +		acc_mode |= MAY_OPENEXEC;
>> +		flags |= __FMODE_EXEC;
>> +	}
> 
> Adding __FMODE_EXEC here will immediately change the behaviors of NFS
> and fsnotify. If that's going to happen, I think it needs to be under
> the control of the later patches doing the behavioral controls.
> (specifically, NFS looks like it completely changes its access control
> test when this is set and ignores the read/write checks entirely, which
> is not what's wanted).

__FMODE_EXEC was suggested by Jan Kara and Matthew Bobrowski because of
fsnotify. However, the NFS handling of SUID binaries [1] indeed leads to
an unintended behavior. This also means that uselib(2) shouldn't work
properly with NFS. I can remove the __FMODE_EXEC flag for now.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f8d9a897d4384b77f13781ea813156568f68b83e
