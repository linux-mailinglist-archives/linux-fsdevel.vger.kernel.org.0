Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4179629F1AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgJ2Qhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:37:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52912 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgJ2Qhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:37:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kYAvU-00C748-2E; Thu, 29 Oct 2020 10:37:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kYAvS-0008Bk-Sf; Thu, 29 Oct 2020 10:37:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
        <87pn51ghju.fsf@x220.int.ebiederm.org>
        <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
Date:   Thu, 29 Oct 2020 11:37:23 -0500
In-Reply-To: <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com> (Aleksa
        Sarai's message of "Fri, 30 Oct 2020 02:51:48 +1100")
Message-ID: <87361xdm4c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kYAvS-0008Bk-Sf;;;mid=<87361xdm4c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180W5DqIedhnPmHhxEi5hPqd4yVVQ9Dudw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Aleksa Sarai <cyphar@cyphar.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 703 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.76
        (0.3%), extract_message_metadata: 27 (3.9%), get_uri_detail_list: 3.4
        (0.5%), tests_pri_-1000: 29 (4.2%), tests_pri_-950: 1.71 (0.2%),
        tests_pri_-900: 1.59 (0.2%), tests_pri_-90: 164 (23.3%), check_bayes:
        143 (20.3%), b_tokenize: 23 (3.2%), b_tok_get_all: 13 (1.9%),
        b_comp_prob: 5 (0.8%), b_tok_touch_all: 97 (13.7%), b_finish: 1.01
        (0.1%), tests_pri_0: 448 (63.8%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 7 (1.0%), poll_dns_idle: 0.33 (0.0%), tests_pri_10:
        3.2 (0.4%), tests_pri_500: 9 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/34] fs: idmapped mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2020-10-29, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> 
>> > Hey everyone,
>> >
>> > I vanished for a little while to focus on this work here so sorry for
>> > not being available by mail for a while.
>> >
>> > Since quite a long time we have issues with sharing mounts between
>> > multiple unprivileged containers with different id mappings, sharing a
>> > rootfs between multiple containers with different id mappings, and also
>> > sharing regular directories and filesystems between users with different
>> > uids and gids. The latter use-cases have become even more important with
>> > the availability and adoption of systemd-homed (cf. [1]) to implement
>> > portable home directories.
>> 
>> Can you walk us through the motivating use case?
>> 
>> As of this year's LPC I had the distinct impression that the primary use
>> case for such a feature was due to the RLIMIT_NPROC problem where two
>> containers with the same users still wanted different uid mappings to
>> the disk because the users were conflicting with each other because of
>> the per user rlimits.
>> 
>> Fixing rlimits is straight forward to implement, and easier to manage
>> for implementations and administrators.
>
> This is separate to the question of "isolated user namespaces" and
> managing different mappings between containers. This patchset is solving
> the same problem that shiftfs solved -- sharing a single directory tree
> between containers that have different ID mappings. rlimits (nor any of
> the other proposals we discussed at LPC) will help with this problem.

First and foremost: A uid shift on write to a filesystem is a security
bug waiting to happen.  This is especially in the context of facilities
like iouring, that play very agressive games with how process context
makes it to  system calls.

The only reason containers were not immediately exploitable when iouring
was introduced is because the mechanisms are built so that even if
something escapes containment the security properties still apply.
Changes to the uid when writing to the filesystem does not have that
property.  The tiniest slip in containment will be a security issue.

This is not even the least bit theoretical.  I have seem reports of how
shitfs+overlayfs created a situation where anyone could read
/etc/shadow.

If you are going to write using the same uid to disk from different
containers the question becomes why can't those containers configure
those users to use the same kuid?

What fixing rlimits does is it fixes one of the reasons that different
containers could not share the same kuid for users that want to write to
disk with the same uid.


I humbly suggest that it will be more secure, and easier to maintain for
both developers and users if we fix the reasons people want different
containers to have the same user running with different kuids.

If not what are the reasons we fundamentally need the same on-disk user
using multiple kuids in the kernel?

Eric
