Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A437791D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEIW7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 18:59:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59514 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIW7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 18:59:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lfsNX-00Bfev-Eb; Sun, 09 May 2021 16:58:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lfsNW-0007E1-CE; Sun, 09 May 2021 16:58:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210508122530.1971-1-justin.he@arm.com>
        <20210508122530.1971-2-justin.he@arm.com>
        <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
        <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
        <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
        <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
        <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
        <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
        <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk>
Date:   Sun, 09 May 2021 17:58:22 -0500
In-Reply-To: <YJcbkJxrFAheQ5yO@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Sat, 8 May 2021 23:15:28 +0000")
Message-ID: <m1r1ifzf8x.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lfsNW-0007E1-CE;;;mid=<m1r1ifzf8x.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tSme8j0LKpThFXtoRB35Tb0qwDIZQAOo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4244]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 730 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 16 (2.2%), b_tie_ro: 14 (1.9%), parse: 1.06
        (0.1%), extract_message_metadata: 13 (1.8%), get_uri_detail_list: 1.77
        (0.2%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 65 (8.9%), check_bayes: 63
        (8.6%), b_tokenize: 9 (1.3%), b_tok_get_all: 11 (1.5%), b_comp_prob:
        2.9 (0.4%), b_tok_touch_all: 35 (4.8%), b_finish: 1.24 (0.2%),
        tests_pri_0: 614 (84.1%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 1.32 (0.2%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, May 08, 2021 at 10:46:23PM +0000, Al Viro wrote:
>> On Sat, May 08, 2021 at 03:17:44PM -0700, Linus Torvalds wrote:
>> > On Sat, May 8, 2021 at 2:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > >
>> > > On Sat, May 08, 2021 at 01:39:45PM -0700, Linus Torvalds wrote:
>> > >
>> > > > +static inline int prepend_entries(struct prepend_buffer *b, const struct path *path, const struct path *root, struct mount *mnt)
>> > >
>> > > If anything, s/path/dentry/, since vfsmnt here will be equal to &mnt->mnt all along.
>> > 
>> > Too subtle for me.
>> > 
>> > And is it? Because mnt is from
>> > 
>> >      mnt = real_mount(path->mnt);
>> > 
>> > earlier, while vfsmount is plain "path->mnt".
>> 
>> static inline struct mount *real_mount(struct vfsmount *mnt)
>> {
>>         return container_of(mnt, struct mount, mnt);
>> }
>
> Basically, struct vfsmount instances are always embedded into struct mount ones.
> All information about the mount tree is in the latter (and is visible only if
> you manage to include fs/mount.h); here we want to walk towards root, so...
>
> Rationale: a lot places use struct vfsmount pointers, but they've no need to
> access all that stuff.  So struct vfsmount got trimmed down, with most of the
> things that used to be there migrating into the containing structure.
>
> [Christian Browner Cc'd]
> BTW, WTF do we have struct mount.user_ns and struct vfsmount.mnt_userns?
> Can they ever be different?  Christian?

I presume you are asking about struct mnt_namespace.user_ns and
struct vfsmount.mnt_userns.

That must the idmapped mounts work.

In short mnt_namespace.user_ns is the user namespace that owns
the mount namespace.

vfsmount.mnt_userns functionally could be reduced to just some struct
uid_gid_map structures hanging off the vfsmount.  It's purpose is
to add a generic translation of uids and gids on from the filesystem
view to the what we want to show userspace.

That code could probably benefit from some refactoring so it is clearer,
and some serious fixes.  I reported it earlier but it looks like there
is some real breakage in chown if you use idmapped mounts.

Eric
