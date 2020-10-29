Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A81829F24B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgJ2Qye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:54:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58342 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgJ2Qye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:54:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kYBBs-00C8yU-V2; Thu, 29 Oct 2020 10:54:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kYBBq-00ASIA-75; Thu, 29 Oct 2020 10:54:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Lennart Poettering <lennart@poettering.net>
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
        Aleksa Sarai <cyphar@cyphar.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
        <87pn51ghju.fsf@x220.int.ebiederm.org>
        <20201029160502.GA333141@gardel-login>
Date:   Thu, 29 Oct 2020 11:54:18 -0500
In-Reply-To: <20201029160502.GA333141@gardel-login> (Lennart Poettering's
        message of "Thu, 29 Oct 2020 17:05:02 +0100")
Message-ID: <87ft5xas79.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kYBBq-00ASIA-75;;;mid=<87ft5xas79.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1886Q3MQQJMqg2DBxLY3bm+bKTupsh1iUo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Lennart Poettering <lennart@poettering.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1616 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (0.6%), b_tie_ro: 8 (0.5%), parse: 1.36 (0.1%),
        extract_message_metadata: 17 (1.1%), get_uri_detail_list: 3.0 (0.2%),
        tests_pri_-1000: 20 (1.2%), tests_pri_-950: 1.25 (0.1%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 152 (9.4%), check_bayes:
        150 (9.3%), b_tokenize: 16 (1.0%), b_tok_get_all: 13 (0.8%),
        b_comp_prob: 3.9 (0.2%), b_tok_touch_all: 112 (6.9%), b_finish: 0.93
        (0.1%), tests_pri_0: 393 (24.3%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 1002 (62.0%),
        tests_pri_10: 2.0 (0.1%), tests_pri_500: 1016 (62.9%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 00/34] fs: idmapped mounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lennart Poettering <lennart@poettering.net> writes:

> On Do, 29.10.20 10:47, Eric W. Biederman (ebiederm@xmission.com) wrote:
>
>> Is that the use case you are looking at removing the need for
>> systemd-homed to avoid chowning after lugging encrypted home directories
>> from one system to another?  Why would it be desirable to avoid the
>> chown?
>
> Yes, I am very interested in seeing Christian's work succeed, for the
> usecase in systemd-homed. In systemd-homed each user gets their own
> private file system, and these fs shall be owned by the user's local
> UID, regardless in which system it is used. The UID should be an
> artifact of the local, individual system in this model, and thus
> the UID on of the same user/home on system A might be picked as 1010
> and on another as 1543, and on a third as 1323, and it shouldn't
> matter. This way, home directories become migratable without having to
> universially sync UID assignments: it doesn't matter anymore what the
> local UID is.
>
> Right now we do a recursive chown() at login time to ensure the home
> dir is properly owned. This has two disadvantages:
>
> 1. It's slow. In particular on large home dirs, it takes a while to go
>    through the whole user's homedir tree and chown/adjust ACLs for
>    everything.
>
> 2. Because it is so slow we take a shortcut right now: if the
>    top-level home dir inode itself is owned by the correct user, we
>    skip the recursive chowning. This means in the typical case where a
>    user uses the same system most of the time, and thus the UID is
>    stable we can avoid the slowness. But this comes at a drawback: if
>    the user for some reason ends up with files in their homedir owned
>    by an unrelated user, then we'll never notice or readjust.


The classic solution to this problem for removable media are
uid=XXX and gid=XXX mount options.

I suspect a similar solution can apply here.

I don't think you need a solution that requires different kuids
to be able to write to the same filesystem uid.

>> If the goal is to solve fragmented administration of uid assignment I
>> suggest that it might be better to solve the administration problem so
>> that all of the uids of interest get assigned the same way on all of the
>> systems of interest.
>
> Well, the goal is to make things simple and be able to use the home
> dir everywhere without any prior preparation, without central UID
> assignment authority.
>
> The goal is to have a scheme that requires no administration, by
> making the UID management problem go away. Hence, if you suggest
> solving this by having a central administrative authority: this is
> exactly what the model wants to get away from.

For a files that can be accessed by more than a single user this is
fundamentally necessary.  Otherwise group permissions and acls can not
work.  They wind up as meaningless garbage, because without some kind of
synchronization those other users and groups simply can not be
represented.

> Or to say this differently: just because I personally use three
> different computers, I certainly don't want to set up LDAP or sync
> UIDs manually.

If they are single users systems why should you need to?

But if permissions on files are going to be at all meaningful it is
a fundamentally a requirement that there be no confusion about which
party the other parties are talking about.  To the best of my knowledge
syncing uids/usernames between machines is as simple as it can get.

Eric
