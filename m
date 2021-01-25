Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C718C302822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbhAYQlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 11:41:44 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55430 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbhAYQld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:41:33 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l44ua-000JK6-HB; Mon, 25 Jan 2021 09:40:20 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l44uY-005na2-OS; Mon, 25 Jan 2021 09:40:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
        <20210121131959.646623-24-christian.brauner@ubuntu.com>
Date:   Mon, 25 Jan 2021 10:39:01 -0600
In-Reply-To: <20210121131959.646623-24-christian.brauner@ubuntu.com>
        (Christian Brauner's message of "Thu, 21 Jan 2021 14:19:42 +0100")
Message-ID: <875z3l0y56.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l44uY-005na2-OS;;;mid=<875z3l0y56.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xzi6ZD1Y1LahVVXJQCa6ijNXolO+AIc8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,
        XM_Multi_Part_URI autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1103 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.8%), parse: 1.03 (0.1%),
         extract_message_metadata: 24 (2.2%), get_uri_detail_list: 2.3 (0.2%),
        tests_pri_-1000: 13 (1.2%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 76 (6.9%), check_bayes: 74
        (6.7%), b_tokenize: 15 (1.3%), b_tok_get_all: 11 (1.0%), b_comp_prob:
        3.0 (0.3%), b_tok_touch_all: 42 (3.8%), b_finish: 0.85 (0.1%),
        tests_pri_0: 662 (60.0%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 19 (1.8%), poll_dns_idle: 292 (26.4%), tests_pri_10:
        2.0 (0.2%), tests_pri_500: 308 (27.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v6 23/40] exec: handle idmapped mounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> When executing a setuid binary the kernel will verify in bprm_fill_uid()
> that the inode has a mapping in the caller's user namespace before
> setting the callers uid and gid. Let bprm_fill_uid() handle idmapped
> mounts. If the inode is accessed through an idmapped mount it is mapped
> according to the mount's user namespace. Afterwards the checks are
> identical to non-idmapped mounts. If the initial user namespace is
> passed nothing changes so non-idmapped mounts will see identical
> behavior as before.

This does not handle the v3 capabilites xattr with embeds a uid.
So at least at that level you are missing some critical conversions.

Eric

> Link: https://lore.kernel.org/r/20210112220124.837960-32-christian.brauner@ubuntu.com
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
>
> /* v3 */
> unchanged
>
> /* v4 */
> - Serge Hallyn <serge@hallyn.com>:
>   - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
>     terminology consistent.
>
> /* v5 */
> unchanged
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
>
> /* v6 */
> base-commit: 19c329f6808995b142b3966301f217c831e7cf31
>
> - Christoph Hellwig <hch@lst.de>:
>   - Use new file_mnt_user_ns() helper.
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index d803227805f6..48d1e8b1610b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1580,6 +1580,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
>  static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
>  {
>  	/* Handle suid and sgid on files */
> +	struct user_namespace *mnt_userns;
>  	struct inode *inode;
>  	unsigned int mode;
>  	kuid_t uid;
> @@ -1596,13 +1597,15 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
>  	if (!(mode & (S_ISUID|S_ISGID)))
>  		return;
>  
> +	mnt_userns = file_mnt_user_ns(file);
> +
>  	/* Be careful if suid/sgid is set */
>  	inode_lock(inode);
>  
>  	/* reload atomically mode/uid/gid now that lock held */
>  	mode = inode->i_mode;
> -	uid = inode->i_uid;
> -	gid = inode->i_gid;
> +	uid = i_uid_into_mnt(mnt_userns, inode);
> +	gid = i_gid_into_mnt(mnt_userns, inode);
>  	inode_unlock(inode);
>  
>  	/* We ignore suid/sgid if there are no mappings for them in the ns */
