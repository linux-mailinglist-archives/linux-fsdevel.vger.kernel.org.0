Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664FC6731C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 07:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjASG1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 01:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASG1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:27:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0D9E8;
        Wed, 18 Jan 2023 22:27:41 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J3cxV6008888;
        Thu, 19 Jan 2023 06:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XOcfcEiqBrqZeiwANJPH8VKdRNEdk3HtQCP4Av08pZc=;
 b=MfyTdejagG6puSFEdS5eubqMYtwbDVHg/fPGHFKiLePoM6rd6PeL9Pj1eHa0GLLdn3td
 UHZc6NEQpZ8r88hLvzu+7O1uBglPOs8XkGJBytJox8b8OMkmLWBMLfa80xv4eIfqZ75M
 XmDwDN2GXZ87PRdx1+9AKPoDvQ52rntU1MC6t9sEE2j7IZ6rTdms/Bn/2qSfD8MZcvhF
 S5hQOvIVt3HWaVsg5EXySdTLtB1kmjwA6Ch4YZ7wUelbndMhrebu2gMl8Q6V0SVbBnJi
 bWDa0O1c5sObAMLhqrWQDs7GNV8yX3GZONvHVub72hzHs7x/htjdZld1KxtYfRuUojJk /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6jbyuf57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:27:36 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30J6KMxe028605;
        Thu, 19 Jan 2023 06:27:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6jbyuf4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:27:35 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30J3GnRY007521;
        Thu, 19 Jan 2023 06:27:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16mj7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 06:27:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30J6RVIV46530926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 06:27:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ECBF20040;
        Thu, 19 Jan 2023 06:27:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FB820043;
        Thu, 19 Jan 2023 06:27:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Jan 2023 06:27:28 +0000 (GMT)
Date:   Thu, 19 Jan 2023 11:57:25 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hQqPZtiUAs0mPh8W"
Content-Disposition: inline
In-Reply-To: <20230117110335.7dtlq4catefgjrm3@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GDTNezIeKmww7mgAkX1rLYWunN7BDkZa
X-Proofpoint-GUID: NMAhWoR9vVNqthvDntZ_EFp6nEdpCZN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hQqPZtiUAs0mPh8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 17, 2023 at 12:03:35PM +0100, Jan Kara wrote:
> On Tue 17-01-23 16:00:47, Ojaswin Mujoo wrote:
> > On Mon, Jan 16, 2023 at 01:23:34PM +0100, Jan Kara wrote:
> > > > Since this covers the special case we discussed above, we will always
> > > > un-delete the PA when we encounter the special case and we can then
> > > > adjust for overlap and traverse the PA rbtree without any issues.
> > > > 
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > Hi Jan,
> > Thanks for the review, sharing some of my thoughts below.
> > 
> > > 
> > > So I find this putting back of already deleted inode PA very fragile. For
> > > example in current code I suspect you've missed a case in ext4_mb_put_pa()
> > > which can mark inode PA (so it can then be spotted by
> > > ext4_mb_pa_adjust_overlap() and marked as in use again) but
> > > ext4_mb_put_pa() still goes on and destroys the PA.
> > 
> > The 2 code paths that clash here are:
> > 
> > ext4_mb_new_blocks() -> ext4_mb_release_context() -> ext4_mb_put_pa()
> > ext4_mb_new_blocks() -> ext4_mb_normalize_request() -> ext4_mb_pa_adjust_overlap()
> > 
> > Since these are the only code paths from which these 2 functions are
> > called, for a given inode, access will always be serialized by the upper
> > level ei->i_data_sem, which is always taken when writing data blocks
> > using ext4_mb_new_block(). 
> 
> Indeed, inode->i_data_sem prevents the race I was afraid of.
>  
> > From my understanding of the code, I feel only
> > ext4_mb_discard_group_preallocations() can race against other functions
> > that are modifying the PA rbtree since it does not take any inode locks.
> > 
> > That being said, I do understand your concerns regarding the solution,
> > however I'm willing to work with the community to ensure our
> > implementation of this undelete feature is as robust as possible. Along
> > with fixing the bug reported here [1], I believe that it is also a good
> > optimization to have especially when the disk is near full and we are
> > seeing a lot of group discards going on. 
> > 
> > Also, in case the deleted PA completely lies inside our new range, it is
> > much better to just undelete and use it rather than deleting the
> > existing PA and reallocating the range again. I think the advantage
> > would be even bigger in ext4_mb_use_preallocated() function where we can
> > just undelete and use the PA and skip the entire allocation, incase original
> > range lies in a deleted PA.
> 
> Thanks for explantion. However I think you're optimizing the wrong thing.
> We are running out of space (to run ext4_mb_discard_group_preallocations()
> at all) and we allocate from an area covered by PA that we've just decided
> to discard - if anything relies on performance of the filesystem in ENOSPC
> conditions it has serious problems no matter what. Sure, we should deliver
> the result (either ENOSPC or some block allocation) in a reasonable time
> but the performance does not really matter much because all the scanning
> and flushing is going to slow down everything a lot anyway. One additional
> scan of the rbtree is really negligible in this case. So what we should
> rather optimize for in this case is the code simplicity and maintainability
> of this rare corner-case that will also likely get only a small amount of
> testing. And in terms of code simplicity the delete & restart solution
> seems to be much better (at least as far as I'm imagining it - maybe the
> code will prove me wrong ;)).
Hi Jan,

So I did try out the 'rb_erase from ext4_mb_adjust_overlap() and retry' method,
with ane extra pa_removed flag, but the locking is getting pretty messy. I'm
not sure if such a design is possible is the lock we currently have. 

Basically, the issue I'm facing is that we are having to drop the
locks read locks and accquire the write locks in
ext4_mb_adjust_overlap(), which looks something like this:

				spin_unlock(&tmp_pa->pa_lock);
				read_unlock(&ei->i_prealloc_lock);

				write_lock(&ei->i_prealloc_lock);
				spin_lock(&tmp_pa->pa_lock);

We have to preserve the order and drop both tree and PA locks to avoid
deadlocks.  With this approach, the issue is that in between dropping and
accquiring this lock, the group discard path can actually go ahead and free the
PA memory after calling rb erase on it, which can result in use after free in
the adjust overlap path.  This is because the PA is freed without any locks in
discard path, as it assumes no other thread will have a reference to it. This
assumption was true earlier since our allocation path never gave up the rbtree
lock however it is not possible with this approach now.  Essentially, the
concept of having two different areas where a PA can be deleted is bringing in
additional challenges and complexity, which might make things worse from a
maintainers/reviewers point of view.

After brainstorming a bit, I think there might be a few alternatives here:

1. Instead of deleting PA in the adjust overlap thread, make it sleep till group
discard path goes ahead and deletes/frees it. At this point we can wake it up and retry
allocation. 

* Pros: We can be sure that PA would have been removed at the time of retry so
we don't waste extra retries. C
* Cons: Extra complexity in code. 

2. Just go for a retry in adjust overlap without doing anything. In ideal case,
by the time we start retrying the PA might be already removed. Worse case: We
keep looping again and again since discard path has not deleted it yet.

* Pros: Simplest approach, code remains straightforward.
* Cons: We can end up uselessly retrying if the discard path doesn't delete the PA fast enough.

3. The approach of undeleting the PA (proposed in this patchset) that we've already discussed.

Now, to be honest, I still prefer the undelete PA approach as it makes more
sense to me and I think the code is simple enough as there are not many paths
that might race. Mostly just adjust_overlap and group discard or
use_preallocated and group discard.

However, I'm still open to improve the approach you suggested to overcome the
issues discussed in the mailing thread. For reference I'm also attaching the
diff of changes I did to implement the rb_erase and retry solution in this
mail. (The diff is on top of this patch series)

Regards,
Ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--hQqPZtiUAs0mPh8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rberase.patch"

commit 9c69b141d8815d6ecba409c2ac119dd4d6f1ef76
Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date:   Wed Jan 18 17:14:49 2023 +0530

    ext4: Retry rbtree walk after deleteing PA
    
    This commit has use after free issue and possibly other issues.
    Just an initial draft
    
    Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 273a98bcaa0d..66a9ef416d00 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4073,6 +4073,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	new_end = *end;
 
 	/* check we don't cross already preallocated blocks */
+retry:
 	read_lock(&ei->i_prealloc_lock);
 	for (iter = ei->i_prealloc_node.rb_node; iter;
 	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter)) {
@@ -4089,12 +4090,34 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 			if (is_overlap) {
 				/*
 				 * Normalized range overlaps with range of this
-				 * deleted PA, that means we might need it in
-				 * near future. Since the PA is yet to be
-				 * removed from inode PA tree and freed, lets
-				 * just undelete it.
+				 * deleted PA. It can be tricky to decide how to
+				 * descend in the tree so it's easier to just
+				 * delete the PA from rbtree and retry the
+				 * operation. Since such a case is rare and
+				 * usually only happens when FS is under high
+				 * utilization, the performance hit due to retry
+				 * should be minimal.
 				 */
-				ext4_mb_mark_pa_inuse(ac->ac_sb, tmp_pa);
+				spin_unlock(&tmp_pa->pa_lock);
+				read_unlock(&ei->i_prealloc_lock);
+				/*
+				 * !!BUG!! As we giveup the tree and PA locks,
+				 * it might be possible that the group discard
+				 * path has already removed this PA from the
+				 * tree or the pa has already been freed. This
+				 * results in use after free when acquiring
+				 * pa_lock below.
+				 */
+				write_lock(&ei->i_prealloc_lock);
+				spin_lock(&tmp_pa->pa_lock);
+				if (tmp_pa->pa_removed == 0) {
+					rb_erase(&tmp_pa->pa_node.inode_node,
+						 &ei->i_prealloc_node);
+					tmp_pa->pa_removed = 1;
+				}
+				spin_unlock(&tmp_pa->pa_lock);
+				write_unlock(&ei->i_prealloc_lock);
+				goto retry;
 			} else {
 				spin_unlock(&tmp_pa->pa_lock);
 				continue;
@@ -4493,15 +4516,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 		/* found preallocated blocks, use them */
 		spin_lock(&tmp_pa->pa_lock);
-		if (tmp_pa->pa_free) {
-			if (tmp_pa->pa_deleted == 1) {
-				/*
-				 * Since PA is yet to be deleted from inode PA
-				 * rbtree, just undelete it and use it.
-				 */
-				ext4_mb_mark_pa_inuse(ac->ac_sb, tmp_pa);
-			}
-
+		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
@@ -5061,33 +5076,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 			list_del_rcu(&pa->pa_node.lg_list);
 			spin_unlock(pa->pa_node_lock.lg_lock);
 		} else {
-			/*
-			 * The allocation path might undelete a PA
-			 * incase it expects it to be used again in near
-			 * future. In that case, rollback the ongoing delete
-			 * operation and don't remove the PA from inode PA
-			 * tree.
-			 *
-			 * TODO: See if we need pa_lock since there might no
-			 * path that contends with it once the rbtree writelock
-			 * is taken.
-			 */
 			write_lock(pa->pa_node_lock.inode_lock);
 			spin_lock(&pa->pa_lock);
-			if (pa->pa_deleted == 0) {
-				free -= pa->pa_free;
-				list_add(&pa->pa_group_list,
-					 &grp->bb_prealloc_list);
-				list_del(&pa->u.pa_tmp_list);
-
-				spin_unlock(&pa->pa_lock);
-				write_unlock(pa->pa_node_lock.inode_lock);
-				continue;
+			if (pa->pa_removed == 0) {
+				ei = EXT4_I(pa->pa_inode);
+				rb_erase(&pa->pa_node.inode_node,
+					 &ei->i_prealloc_node);
+				pa->pa_removed = 1;
 			}
 			spin_unlock(&pa->pa_lock);
-
-			ei = EXT4_I(pa->pa_inode);
-			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
 			write_unlock(pa->pa_node_lock.inode_lock);
 		}
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6d85ee8674a6..3ea5701215fc 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -120,7 +120,9 @@ struct ext4_prealloc_space {
 	} u;
 	spinlock_t		pa_lock;
 	atomic_t		pa_count;
-	unsigned		pa_deleted;
+	unsigned		pa_deleted;	/* Has PA been marked deleted */
+	unsigned		pa_removed;	/* Has PA been removed from its
+						   respecitve data structure */
 	ext4_fsblk_t		pa_pstart;	/* phys. block */
 	ext4_lblk_t		pa_lstart;	/* log. block */
 	ext4_grpblk_t		pa_len;		/* len of preallocated chunk */

--hQqPZtiUAs0mPh8W--

