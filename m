Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B2337051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhCKKnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 05:43:13 -0500
Received: from smtp-8fab.mail.infomaniak.ch ([83.166.143.171]:58005 "EHLO
        smtp-8fab.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232415AbhCKKm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:42:59 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Dx5BT525BzMqPvZ;
        Thu, 11 Mar 2021 11:42:57 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Dx5BS2NHZzlh8Tb;
        Thu, 11 Mar 2021 11:42:56 +0100 (CET)
Subject: Re: [PATCH v1 0/1] Unprivileged chroot
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biederman <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20210310161000.382796-1-mic@digikod.net>
 <4b9a1bb3-94f0-72af-f8f6-27f1ca2b43a2@schaufler-ca.com>
 <e0b03cf2-8e37-6a41-5132-b74566a8f269@digikod.net>
 <0dfd4306-8e7c-239b-2829-d4103395ea44@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <a28100f5-19ca-adbf-7056-575f6bfc9dc6@digikod.net>
Date:   Thu, 11 Mar 2021 11:42:55 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <0dfd4306-8e7c-239b-2829-d4103395ea44@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/03/2021 21:59, Casey Schaufler wrote:
> On 3/10/2021 10:17 AM, Mickaël Salaün wrote:
>> On 10/03/2021 18:22, Casey Schaufler wrote:
>>> On 3/10/2021 8:09 AM, Mickaël Salaün wrote:
>>>> Hi,
>>>>
>>>> The chroot system call is currently limited to be used by processes with
>>>> the CAP_SYS_CHROOT capability.  This protects against malicious
>>>> procesess willing to trick SUID-like binaries.  The following patch
>>>> allows unprivileged users to safely use chroot(2).
>>> Mount namespaces have pretty well obsoleted chroot(). CAP_SYS_CHROOT is
>>> one of the few fine grained capabilities. We're still finding edge cases
>>> (e.g. ptrace) where no_new_privs is imperfect. I doesn't seem that there
>>> is a compelling reason to remove the privilege requirement on chroot().
>> What is the link between chroot and ptrace?
> 
> The possibility of sophisticated interactions with no_new_privs.

Would you mind giving some practical examples?

> 
>> What is interesting with CAP_SYS_CHROOT?
> 
> CAP_SYS_CHROOT is specific to chroot. It doesn't give you privilege
> beyond what you expect, unlike CAP_CHOWN or CAP_SYS_ADMIN. Making chroot
> unprivileged is silly when it's possibly the best example of how the
> capability mechanism is supposed to work.

Why would it be silly to make the use of this feature safe for any
processes instead of giving the right (with CAP_SYS_CHROOT) to some
processes to use it unsafely?

> 
>>
>>>> This patch is a follow-up of a previous one sent by Andy Lutomirski some
>>>> time ago:
>>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
>>>>
>>>> This patch can be applied on top of v5.12-rc2 .  I would really
>>>> appreciate constructive reviews.
>>>>
>>>> Regards,
>>>>
>>>> Mickaël Salaün (1):
>>>>   fs: Allow no_new_privs tasks to call chroot(2)
>>>>
>>>>  fs/open.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 61 insertions(+), 3 deletions(-)
>>>>
>>>>
>>>> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> 
