Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC14C14E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 14:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbiBWN7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 08:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiBWN7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:59:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3842A99ED9;
        Wed, 23 Feb 2022 05:59:06 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NDK5vr018298;
        Wed, 23 Feb 2022 13:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=lvXdCKE8OJefMNbv2v6d9q7AEN2/nPUxBlLZedxcxhE=;
 b=ak532BpWMF8YC0pPlfAOb7vsSdcpGIs3Q28JTJ9iLER1T9cySjoZ+eDkRsnntmIc0AYS
 fRJAFEFdjZfX1w9FqJWiRrteh/fzllITcXZ/mv+rn1OB/+NOXRBRTYb+aMND6eg5d2cM
 jhEBJWpVGjDpA6bDyTY8flrt/cJ3lPzfVLIVv0/ABDsAOs1JgaZ9Lclf2ELQ6vSjNGpg
 3F1bhi4js2aI0UQm+3Yn3yBKrk2WLHYzDZqQUhgTOiAKZJlSx42+cbgMbUJ0QKuQWpwe
 9vYZ46gD4Kb/vjYVWLdo56ei+FsFqyPYgpKWSy6G7KkyCRNwtk/WCRGI+H4akS8TfL40 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edk21ca0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:59:02 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NDkcN1005141;
        Wed, 23 Feb 2022 13:59:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edk21ca09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:59:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NDwYX4014003;
        Wed, 23 Feb 2022 13:59:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear69aewp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:58:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NDwvu338535454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 13:58:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C50552063;
        Wed, 23 Feb 2022 13:58:57 +0000 (GMT)
Received: from localhost (unknown [9.43.7.150])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D20155205F;
        Wed, 23 Feb 2022 13:58:52 +0000 (GMT)
Date:   Wed, 23 Feb 2022 19:28:27 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] [RFC 9/9] ext4: fast_commit missing tracking updates
 to a file
Message-ID: <20220223135755.plbr2fvt66k3xyn5@riteshh-domain>
References: <cover.1645558375.git.riteshh@linux.ibm.com>
 <e91b6872860df3ec520799a5d0b65e54ccf32407.1645558375.git.riteshh@linux.ibm.com>
 <CAK896s7V7wj0Yiu0NQEFvmS9-oivJUosgMYW5UBJ4cX2YCSh6g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK896s7V7wj0Yiu0NQEFvmS9-oivJUosgMYW5UBJ4cX2YCSh6g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IaBRPVVALUrrclXBs8jOIGEe8lfLcMEm
X-Proofpoint-GUID: vzA8xlSg4GA4SH6nfGhyDpu0QGlNdBhY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_05,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/23 11:50AM, Xin Yin wrote:
> On Wed, Feb 23, 2022 at 4:36 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >
> > <DO NOT MERGE THIS YET>
> >
> > Testcase
> > ==========
> > 1. i=0; while [ $i -lt 1000 ]; do xfs_io -f -c "pwrite -S 0xaa -b 32k 0 32k" -c "fsync" /mnt/$i; i=$(($i+1)); done && sudo ./src/godown -v /mnt && sudo umount /mnt && sudo mount /dev/loop2 /mnt'
> > 2. ls -alih /mnt/ -> In this you will observe one such file with 0 bytes (which ideally should not happen)
> >
> > ^^^ say if you don't see the issue because your underlying storage
> > device is very fast, then maybe try with commit=1 mount option.
> >
> > Analysis
> > ==========
> > It seems a file's updates can be a part of two transaction tid.
> > Below are the sequence of events which could cause this issue.
> >
> > jbd2_handle_start -> (t_tid = 38)
> > __ext4_new_inode
> > ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid = 38)
> > <track more updates>
> > jbd2_start_commit -> (t_tid = 38)
> >
> > jbd2_handle_start (tid = 39)
> > ext4_fc_track_template -> __track_inode -> (i_sync_tid = 38, t_tid 39)
> >     -> ext4_fc_reset_inode & ei->i_sync_tid = t_tid
> >
> > ext4_fc_commit_start -> (will wait since jbd2 full commit is in progress)
> > jbd2_end_commit (t_tid = 38)
> >     -> jbd2_fc_cleanup() -> this will cleanup entries in sbi->s_fc_q[FC_Q_MAIN]
> >         -> And the above could result inode size as 0 as  after effect.
> > ext4_fc_commit_stop
> >
> > You could find the logs for the above behavior for inode 979 at [1].
> >
> > -> So what is happening here is since the ei->i_fc_list is not empty
> > (because it is already part of sb's MAIN queue), we don't add this inode
> > again into neither sb's MAIN or STAGING queue.
> > And after jbd2_fc_cleanup() is called from jbd2 full commit, we
> > just remove this inode from the main queue.
> >
> > So as a simple fix, what I did below was to check if it is a jbd2 full commit
> > in ext4_fc_cleanup(), and if the ei->i_sync_tid > tid, that means we
> > need not remove that from MAIN queue. This is since neither jbd2 nor FC
> > has committed updates of those inodes for this new txn tid yet.
> >
> > But below are some quick queries on this
> > =========================================
> >
> > 1. why do we call ext4_fc_reset_inode() when inode tid and
> >    running txn tid does not match?
> This is part of a change in commit:bdc8a53a6f2f,  it fixes the issue
> for fc tracking logic while jbd2 commit is ongoing.

Thanks Xin for pointing the other issue too.
But I think what I was mostly referring to was - calling ext4_fc_reset_inode()
in ext4_fc_track_template().

<..>
 391         tid = handle->h_transaction->t_tid;
 392         mutex_lock(&ei->i_fc_lock);
 393         if (tid == ei->i_sync_tid) {
 394                 update = true;
 395         } else {
 396                 ext4_fc_reset_inode(inode);
 397                 ei->i_sync_tid = tid;
 398         }
 399         ret = __fc_track_fn(inode, args, update);
 400         mutex_unlock(&ei->i_fc_lock);
 <..>

So, yes these are few corner cases which I want to take a deeper look at.
I vaugely understand that this reset inode is done since we anyway might have
done the full commit for previous tid, so we can reset the inode track range.

So, yes, we should carefully review this as well that if jbd2 commit happens for
an inode which is still part of MAIN_Q, then does it make sense to still
call ext4_fc_reset_inode() for that inode in ext4_fc_track_template()?

> If the inode tid is bigger than txn tid, that means this inode may be
> in the STAGING queue, if we reset it then it will lose the tack range.
> I think it's a similar issue, the difference is this inode is already

Do you have a test case which was failing for your issue?
I would like to test that one too.


> in the MAIN queue before the jbd2 commit starts.
> And yes , I think in this case we can not remove it from the MAIN

Yes. I too have a similar thought. But I still wanted to get few queries sorted
(like point 1 & 2).

> queue, but still need to clear EXT4_STATE_FC_COMMITTING right? it may
> block some task still waiting for it.

Sorry I didn't get you here. So I think we will end up in such situation
(where ext4_fc_cleanup() is getting called for an inode with i_sync_tid > tid)
only from full commit path right ?
And that won't set EXT4_FC_COMMITTING for this inode right anyways no?

Do you mean anything else, or am I missing something here?

-ritesh


>
> Thanks,
> Xin Yin
> >
> > 2. Also is this an expected behavior from the design perspective of
> >    fast_commit. i.e.
> >    a. the inode can be part of two tids?
> >    b. And that while a full commit is in progress, the inode can still
> >    receive updates but using a new transaction tid.
> >
> > Frankly speaking, since I was also working on other things, so I haven't
> > yet got the chance to completely analyze the situation yet.
> > Once I have those things sorted, I will spend more time on this, to
> > understand it more. Meanwhile if you already have some answers to above
> > queries/observations, please do share those here.
> >
> > Links
> > =========
> > [1] https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fast_commit/fc_inode_missing_updates_ino_979.txt
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  fs/ext4/fast_commit.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 8803ba087b07..769b584c2552 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1252,6 +1252,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> >         spin_lock(&sbi->s_fc_lock);
> >         list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
> >                                  i_fc_list) {
> > +               if (full && iter->i_sync_tid > tid)
> > +                       continue;
> >                 list_del_init(&iter->i_fc_list);
> >                 ext4_clear_inode_state(&iter->vfs_inode,
> >                                        EXT4_STATE_FC_COMMITTING);
> > --
> > 2.31.1
> >
