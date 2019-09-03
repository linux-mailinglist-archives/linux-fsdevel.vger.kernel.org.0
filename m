Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552D5A67EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfICL6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:58:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfICL6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:58:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83Bvouq133276
        for <linux-fsdevel@vger.kernel.org>; Tue, 3 Sep 2019 07:58:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usntnc3nr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 07:58:37 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 3 Sep 2019 12:58:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 12:58:32 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83BwS3A61014132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 11:58:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4F2AA4060;
        Tue,  3 Sep 2019 11:58:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8A0A405B;
        Tue,  3 Sep 2019 11:58:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 11:58:26 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC] - vfs: Null pointer dereference issue with symlink create and
 read of symlink
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     aneesh.kumar@linux.ibm.com, Jeff Layton <jlayton@kernel.org>,
        wugyuan@cn.ibm.com
Date:   Tue, 3 Sep 2019 17:28:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090311-0012-0000-0000-000003461720
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090311-0013-0000-0000-00002180650C
Message-Id: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030127
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Viro/All,

Could you please review below issue and it's proposed solutions.
If you could let me know which of the two you think will be a better 
approach to solve this or in case if you have any other better approach, 
I can prepare and submit a official patch with that.



Issue signature:-
  [NIP  : trailing_symlink+80]
  [LR   : trailing_symlink+1092]
  #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
  #5 [c00000198069bc00] path_openat at c0000000004bdd14
  #6 [c00000198069bc90] do_filp_open at c0000000004c0274
  #7 [c00000198069bdb0] do_sys_open at c00000000049b248
  #8 [c00000198069be30] system_call at c00000000000b388



Test case:-
shell-1 - "while [ 1 ]; do cat /gpfs/g1/testdir/file3; sleep 1; done"
shell-2 - "while [ 1 ]; do ln -s /gpfs/g1/testdir/file1 
/gpfs/g1/testdir/file3; sleep 1; rm /gpfs/g1/testdir/file3 sleep 1; done



Problem description:-
In some filesystems like GPFS below described scenario may happen on 
some platforms (Reported-By:- wugyuan)

Here, two threads are being run in 2 different shells. Thread-1(cat) 
does cat of the symlink and Thread-2(ln) is creating the symlink.

Now on any platform with GPFS like filesystem, if CPU does out-of-order 
execution (or any kind of re-ordering due compiler optimization?) in 
function __d_set_and_inode_type(), then we see a NULL pointer 
dereference due to inode->i_uid.

This happens because in lookup_fast in nonRCU path or say REF-walk (i.e. 
in else condition), we check d_is_negative() without any lock protection.
And since in __d_set_and_inode_type() re-ordering may happen in setting 
of dentry->type & dentry->inode => this means that there is this tiny 
window where things are going wrong.


(GPFS like):- Any FS with -inode_operations ->permission callback 
returning -ECHILD in case of (mask & MAY_NOT_BLOCK) may cause this 
problem to happen. (few e.g. found were - ocfs2, ceph, coda, afs)

int xxx_permission(struct inode *inode, int mask)
{
          if (mask & MAY_NOT_BLOCK)
                  return -ECHILD;
	<...>
}

Wugyuan(cc), could reproduce this problem with GPFS filesystem.
Since, I didn't have the GPFS setup, so I tried replicating on a native 
FS by forcing out-of-order execution in function 
__d_set_inode_and_type() and making sure we return -ECHILD in 
MAY_NOT_BLOCK case in ->permission operation for all inodes.

With above changes in kernel, I could as well hit this issue on a native 
FS too.

(basically what we observed is link_path_walk will do nonRCU(REF-walk) 
lookup due to may_lookup -> inode_permission return -ECHILD and then 
unlazy_walk drops the LOOKUP_RCU flag (nd->flag). After that below race 
is possible).



Sequence of events:-

Thread-2(Comm: ln)		Thread-1(Comm: cat)

				dentry = __d_lookup() //nonRCU

__d_set_and_inode_type() (Out-of-order execution)
	flags = READ_ONCE(dentry->d_flags);
	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
	flags |= type_flags;
	WRITE_ONCE(dentry->d_flags, flags);

					
				if (unlikely(d_is_negative()) // fails
   					{}
				// since type is already updated in
				// Thread-2 in parallel but inode
				// not yet set.
				// d_is_negative returns false

				*inode = d_backing_inode(path->dentry);
				// means inode is still NULL

	dentry->d_inode = inode;
	
				trailing_symlink()
					may_follow_link()
						inode = nd->link_inode;
						// nd->link_inode = NULL
						//Then it crashes while
						//doing inode->i_uid
					
	



Approach-1:- using wmb()

diff --git a/fs/dcache.c b/fs/dcache.c
index e88cf0554e65..966172df77ee 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -316,6 +316,7 @@ static inline void __d_set_inode_and_type(struct 
dentry *dentry,
         unsigned flags;

         dentry->d_inode = inode;
+       smp_wmb();
         flags = READ_ONCE(dentry->d_flags);
         flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
         flags |= type_flags;



Approach-2:- using spin_lock(&dentry->d_lock);

Do you think lock should be a better approach, given that we are already
in REF-walk mode. As per the Documentation, we should be able to take
spin_lock(&dentry->d_lock) in Ref-walk mode whenever required?


With smp_wmb(), if added, should add a small latency in both
RCU/REF-walk. But should be able to cover all the cases in general 
related to dentry->type & dentry->inode ordering. Though, we don't have 
any other race conditions reported or tested, other than the one, 
mentioned in this email.

Confused :(



diff --git a/fs/namei.c b/fs/namei.c
index 209c51a5226c..a3145594da1c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1557,6 +1557,7 @@ static int lookup_fast(struct nameidata *nd,
         struct dentry *dentry, *parent = nd->path.dentry;
         int status = 1;
         int err;
+       bool negative;

         /*
          * Rename seqlock is not required here because in the off chance
@@ -1565,7 +1566,6 @@ static int lookup_fast(struct nameidata *nd,
          */
         if (nd->flags & LOOKUP_RCU) {
                 unsigned seq;
-               bool negative;
                 dentry = __d_lookup_rcu(parent, &nd->last, &seq);
                 if (unlikely(!dentry)) {
                         if (unlazy_walk(nd))
@@ -1623,7 +1623,11 @@ static int lookup_fast(struct nameidata *nd,
                 dput(dentry);
                 return status;
         }
-       if (unlikely(d_is_negative(dentry))) {
+
+       spin_lock(&dentry->d_lock);
+       negative = d_is_negative(dentry);
+       spin_unlock(&dentry->d_lock);
+       if (unlikely(negative)) {
                 dput(dentry);
                 return -ENOENT;
         }


Regards
Ritesh

