Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22184BDF75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381190AbiBUQrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 11:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381208AbiBUQrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:47:01 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499DE6E
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 08:46:35 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:36758)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMBpa-009hYd-6z; Mon, 21 Feb 2022 09:46:34 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:51802 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMBpZ-002bvF-65; Mon, 21 Feb 2022 09:46:33 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
        <YhMdVcrtXGLTrbWR@zeniv-ca.linux.org.uk>
Date:   Mon, 21 Feb 2022 10:46:26 -0600
In-Reply-To: <YhMdVcrtXGLTrbWR@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 21 Feb 2022 05:04:21 +0000")
Message-ID: <87tucscgm5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nMBpZ-002bvF-65;;;mid=<87tucscgm5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QOqccXFM17n72cA1akYyrUF6VVN2W+es=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 338 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (1.4%), b_tie_ro: 3.3 (1.0%), parse: 1.06
        (0.3%), extract_message_metadata: 11 (3.2%), get_uri_detail_list: 2.3
        (0.7%), tests_pri_-1000: 7 (2.2%), tests_pri_-950: 1.05 (0.3%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 54 (16.0%), check_bayes:
        53 (15.6%), b_tokenize: 5 (1.5%), b_tok_get_all: 7 (2.0%),
        b_comp_prob: 1.71 (0.5%), b_tok_touch_all: 36 (10.8%), b_finish: 0.75
        (0.2%), tests_pri_0: 245 (72.4%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.0 (0.6%), poll_dns_idle: 0.26 (0.1%), tests_pri_10:
        2.8 (0.8%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] umount/__detach_mounts() race
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	BTW, while looking through the vicinity - I think this 
>         if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
> 			return mnt;
> in __do_loopback() is too permissive.  I'd prefer to replace it with
>         if (!check_mnt(old)) {
> 		// allow binding objects from internal instance of nsfs
> 		if (old->mnt_ns != MNT_NS_INTERAL ||
> 		    old_path->dentry->d_op != &ns_dentry_operations)
> 			return mnt;
> 	}
>
> Suppose we'd bound an nsfs object e.g. on /tmp/foo.  Consider a race
> between mount --bind /tmp/foo /tmp/bar and umount -l /tmp/foo.
>
> do_loopback() resolves /tmp/foo.  We have dentry from nsfs and mount
> that sits on /tmp/foo.  We'd resolved /tmp/bar.
>
> In the meanwhile, umount has resolved /tmp/foo and unmounted it.
> struct mount is still alive due to the reference held by do_loopback().
>
> do_loopback() finally grabs namespace_sem.  It verifies that mountpoint
> to be (/tmp/bar) is still OK (it is) and calls __do_loopback().  The
> check in __do_loopback() passes - old is unmounted, but dentry is
> nsfs one, so we proceed to clone old.
>
> And that's where the things go wrong - we copy the flags, including
> MNT_UMOUNT, to the new instance.  And proceed to attach it on /tmp/bar.
>
> It's really not a good thing.  E.g. __detach_mnt() will assume that
> reference to the parent mount of /tmp/bar is *not* held.  As the
> matter of fact, it is, so we'll get a leak if the mountpoint (/tmp/bar,
> that is) gets unlinked in another namespace.  That's not the only way
> to get trouble - we are really not supposed to have MNT_UMOUNT mounts
> attached to !MNT_UMOUNT ones.
>
> Eric, do you see any problems with the change above?

Such as breaking userspace code? Maybe.

Currently we exempt nsfs dentries from the same namespace restriction
when cloning them.

If I read your proposal correctly you are proposing only exempting nsfs
dentries that are internally mounted from the same namespace
restriction.

We need to keep the ordinary case of bind mounts from one nsfs dentry to
another dentry working even after it is mounted.

If my foggy brain is reasoning correctly you are proposing not allowing
bind mounts before the mount has been attached or after the mount has
been detached by umount_tree.  Not allowing already umounted mounts to
be bind mounted seems semantically fine.  Userspace should not care.

I wonder if perhaps we should have an explicit test for MNT_UMOUNT in
__do_loopback.

Eric

