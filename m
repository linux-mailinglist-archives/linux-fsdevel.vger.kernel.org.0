Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970FC4BDD9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiBURFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 12:05:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiBURFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:05:24 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB7CD2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 09:05:01 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:52886)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMC7Q-009jh6-3I; Mon, 21 Feb 2022 10:05:00 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52582 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMC7O-002fv0-Ny; Mon, 21 Feb 2022 10:04:59 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
Date:   Mon, 21 Feb 2022 11:04:32 -0600
In-Reply-To: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 21 Feb 2022 03:02:35 +0000")
Message-ID: <87v8x8b17j.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nMC7O-002fv0-Ny;;;mid=<87v8x8b17j.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+r0TF891M5Ij36ary+2FiCC6M741uvs54=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 742 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.4 (0.5%), b_tie_ro: 2.3 (0.3%), parse: 1.00
        (0.1%), extract_message_metadata: 13 (1.7%), get_uri_detail_list: 2.5
        (0.3%), tests_pri_-1000: 9 (1.2%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 428 (57.7%), check_bayes:
        425 (57.3%), b_tokenize: 10 (1.3%), b_tok_get_all: 8 (1.0%),
        b_comp_prob: 2.4 (0.3%), b_tok_touch_all: 402 (54.2%), b_finish: 0.72
        (0.1%), tests_pri_0: 275 (37.0%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.1 (0.3%), poll_dns_idle: 0.82 (0.1%), tests_pri_10:
        1.60 (0.2%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] umount/__detach_mounts() race
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	umount_tree() is very definitely not supposed to be called
> on MNT_UMOUNT subtrees (== stuck-together fragments that got
> unmounted, but not split into individual mount nodes).  Refcounting
> rules are different there and umount_tree() assumes that we start with
> the normal ones.
>
> 	do_umount() appears to be checking for that:
>
> 	if (flags & MNT_DETACH) {
> 		if (!list_empty(&mnt->mnt_list))
> 			umount_tree(mnt, UMOUNT_PROPAGATE);
> 		retval = 0;
> 	} else {
> 		shrink_submounts(mnt);
> 		retval = -EBUSY;
> 		if (!propagate_mount_busy(mnt, 2)) {
> 			if (!list_empty(&mnt->mnt_list))
> 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> 			retval = 0;
> 		}
> 	}
>
> which would prevent umount_tree() on those - mnt_list eviction happens
> for the same nodes that get MNT_UMOUNT.  However, shrink_submounts()
> will call umount_tree() for e.g. nfs automounts it finds on victim
> mount, and if ours happens to be already unmounted, with automounts
> stuck to it, we have trouble.
>
> It looks like something that should be impossible to hit, but...
>
> A: umount(2) looks the sucker up
> B: rmdir(2) in another namespace (where nothing is mounted on that mountpoint)
> does __detach_mounts(), which grabs namespace_sem, sees the mount A is about
> to try and kill and calls umount_tree(mnt, UMOUNT_CONNECTED).  Which detaches
> our mount (and its children, automounts included) from the namespace it's in,
> modifies their refcounts accordingly and keeps the entire thing in one
> piece.
> A: in do_umount() blocks on namespace_sem
> B: drops namespace_sem
> A: gets to the quoted code.  mnt is already MNT_UMOUNT (and has empty
> ->mnt_list), but it does have (equally MNT_UMOUNT) automounts under it,
> etc.  So shrink_submounts() finds something to umount and calls umount_tree().
> Buggered refcounts happen.
>
> Does anybody see a problem with the following patch?

I think it looks like 2 patches.
One patch to remove some list_empty checks.
> -		if (!list_empty(&mnt->mnt_list))
> -			umount_tree(mnt, UMOUNT_PROPAGATE);
> +		umount_tree(mnt, UMOUNT_PROPAGATE);

Another patch to add a MNT_UMOUNT condition.


The MNT_UMOUNT condition should probably be checked optimistically along
with MNT_FORCE in can_umount as well to be explicit.  I think it is
redundant with check_mnt but it would add clarity to what we are looking
for, and keep people thinking about the MNT_UMOUNT races.

Testing MNT_UMOUNT after the locks have been grabbed seem very
reasonable.  Alternately the code could call check_mnt again and lean on
that test.  But testing MNT_UMOUNT seems sufficient.


> diff --git a/fs/namespace.c b/fs/namespace.c
> index 42d4fc21263b2..1604b9d7a69d9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1654,21 +1654,20 @@ static int do_umount(struct mount *mnt, int flags)
>  	lock_mount_hash();
>  
>  	/* Recheck MNT_LOCKED with the locks held */
> +	/* ... and don't go there if we'd raced and it's already unmounted */
>  	retval = -EINVAL;
> -	if (mnt->mnt.mnt_flags & MNT_LOCKED)
> +	if (mnt->mnt.mnt_flags & (MNT_LOCKED|MNT_UMOUNT))
>  		goto out;
>  
>  	event++;
>  	if (flags & MNT_DETACH) {
> -		if (!list_empty(&mnt->mnt_list))
> -			umount_tree(mnt, UMOUNT_PROPAGATE);
> +		umount_tree(mnt, UMOUNT_PROPAGATE);
>  		retval = 0;
>  	} else {
>  		shrink_submounts(mnt);
>  		retval = -EBUSY;
>  		if (!propagate_mount_busy(mnt, 2)) {
> -			if (!list_empty(&mnt->mnt_list))
> -				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
> +			umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
>  			retval = 0;
>  		}
>  	}

Eric
