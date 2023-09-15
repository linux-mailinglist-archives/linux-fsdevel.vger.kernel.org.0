Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964137A1D87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjIOLgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjIOLga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:36:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601281AB;
        Fri, 15 Sep 2023 04:36:25 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FB91Ac007837;
        Fri, 15 Sep 2023 11:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=l+LP/lnnjZjSwTZ05zHuArbufqGuJUQZccOlgIKwXv4=;
 b=LtCyjxchD7PtJQEeoYLMxKcc4wxBeDgRfi3VKU+ZxDJBoIWejlxp2MxvfXA43PFK7z6T
 B/Qnt/oYLJ1Qnv5+4K/eaychBvDdI9a7MN7EtawCDbKLU4IxWBeo77Aw7jGzn1SrZceY
 yVJi1oWh1ycbJehKx4JukjoFH3YiCO8OyO7RGg3EcXmGES3JL/XWnAZ1kP0pTAJpFZXb
 FEy7H8WD8bnF11oCxF5Y68BZ5vE8jjBMigingC5pLKY4Sl39EAebKzi4mA6/sLTJ60ap
 86GAnwLji556jolQDZd9MJW1eZ9F8wAxIn6w+54L9ydaqwVohARFAKwiyM+BGF3pi7co 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4nwp9956-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:36:04 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FBA0pW012980;
        Fri, 15 Sep 2023 11:34:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4nwp94e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:34:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FAPpIx011971;
        Fri, 15 Sep 2023 11:33:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2jhyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 11:33:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FBXp9m65405324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 11:33:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C39E58043;
        Fri, 15 Sep 2023 11:33:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A403158059;
        Fri, 15 Sep 2023 11:33:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.152.72])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 15 Sep 2023 11:33:50 +0000 (GMT)
Message-ID: <f350092536a5e7305fd4740ee754087e61fd2f9a.camel@linux.ibm.com>
Subject: Re: Fwd: [PATCH] ima: fix wrong dereferences of file->f_path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Fri, 15 Sep 2023 07:33:50 -0400
In-Reply-To: <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com>
References: <20230913073755.3489676-1-amir73il@gmail.com>
         <CAOQ4uxg2_d2eFfSy45JCCLE41qCPZtLFytnZ5x5C1uXdCMUA=Q@mail.gmail.com>
         <4919dcc1066d6952190dc224004e1f6bcba5e9df.camel@linux.ibm.com>
         <CAOQ4uxiKgYO5Z25DFG=GQj3GeGZ8unSPExM-jn1HL_U8qncrtA@mail.gmail.com>
         <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
         <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iYyVn7GRh3ERtjhqzAyUqDnOXhiW5mnj
X-Proofpoint-ORIG-GUID: 4oPxUaxIQw80Uw6y-ANVAywiChuUODjo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-09-15 at 12:57 +0300, Amir Goldstein wrote:
> [adding back fsdevel]
> 
> On Fri, Sep 15, 2023 at 7:04 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Fri, 2023-09-15 at 06:21 +0300, Amir Goldstein wrote:
> > > On Thu, Sep 14, 2023 at 11:01 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > Hi Amir,  Goldwyn,
> > > >
> > > > FYI,
> > > > 1. ima_file_free() is called to check whether the file is in policy.
> > > > 2. ima_check_last_writer() is called to determine whether or not the
> > > > file hash stored as an xattr needs to be updated.
> > > >
> > > > 3. As ima_update_xattr() is not being called, I assume there is no
> > > > appraise rule. I asked on the thread which policy rules are being used
> > > > and for the boot command line, but assume that they're specifying
> > > > 'ima_policy=tcb" on the boot command line.
> > >
> > > Yes, here is the kconfig from syzbot report dashboard
> > > https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
> > >
> > > >
> > > > 4. Is commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > i_version") the problem?
> > >
> > > IIUC, this commit is responsible for the ovl_getattr() call in the stack
> > > trace. syzbot did not bisect the bug yet, but now that it has found
> > > a reproducer, it is just a matter of time.
> > > However, all the bug reports in the  dashboard are only from upstream,
> > > so I think that means that this bug was not found on any stable kernels.
> > >
> > > >
> > > > 5. ima_file_free() is being called twice.  We should not be seeing
> > > > ima_get_current_hash_algo() in the trace.
> > > >
> > > > [   66.991195][ T5030]  ovl_getattr+0x1b1/0xf70
> > > > [   66.995635][ T5030]  ? ovl_setattr+0x4e0/0x4e0
> > > > [   67.000229][ T5030]  ? trace_raw_output_contention_end+0xd0/0xd0
> > > > [   67.006387][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > > [   67.011154][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > > [   67.015920][ T5030]  ? trace_contention_end+0x3c/0xf0
> > > > [   67.021122][ T5030]  ? __mutex_lock_common+0x42d/0x2530
> > > > [   67.026506][ T5030]  ? lock_release+0xbf/0x9d0
> > > > [   67.031126][ T5030]  ? read_lock_is_recursive+0x20/0x20
> > > > [   67.036719][ T5030]  ? ima_file_free+0x17c/0x4b0
> > > > [   67.041578][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > > [   67.046615][ T5030]  ? locks_remove_file+0x429/0x1040
> > > > [   67.051820][ T5030]  ? mutex_lock_io_nested+0x60/0x60
> > > > [   67.057030][ T5030]  ? _raw_spin_unlock+0x40/0x40
> > > > [   67.061894][ T5030]  ? __asan_memset+0x23/0x40
> > > > [   67.066577][ T5030]  ima_file_free+0x26e/0x4b0
> > > > [   67.071279][ T5030]  ? ima_get_current_hash_algo+0x10/0x10
> > > > [   67.076929][ T5030]  ? __rwlock_init+0x150/0x150
> > > > [   67.081694][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > > [   67.086727][ T5030]  __fput+0x36a/0x910
> > > > [   67.090728][ T5030]  task_work_run+0x24a/0x300
> > > >
> > > >
> > > > Were you able to duplicate this locally?
> > > >
> > >
> > > I did not try. Honestly, I don't know how to enable IMA.
> > > Is the only thing that I need to do is set the IMA policy
> > > in the kernel command line?
> > >
> > > Does IMA need to be enabled per fs? per sb?
> > >
> > > If so, I can run the overlay test suite with IMA enabled and
> > > see what happens.
> >
> > Yes, you'll definitely will be able to see the measurement list.
> >
> > [Setting up the system to verify file signatures is a bit more
> > difficult:  files need to be signed, keys need to be loaded.  Finally
> > CentOS and RHEL 9.3 will have file signatures and will publish the IMA
> > code signing key.]
> >
> > Assuming IMA is configured, just add "ima_policy=tcb" to the command
> > line.   This will measure all files executed, mmap'ed, kernel modules,
> > firmware, and all files opened by root.  Normally the builtin policy is
> > replaced with a finer grained one.
> >
> > Below are a few commands, but Ken Goldman is writing documentation -
> > https://ima-doc.readthedocs.io/en/latest/
> >
> > 1. Display the IMA measurement list:
> > # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > # cat /sys/kernel/security/ima/binary_runtime_measurements
> >
> > 2. Display the IMA policy  (or append to the policy)
> > # cat /sys/kernel/security/ima/policy
> >
> > 3. Display number of measurements
> > # cat /sys/kernel/security/ima/runtime_measurements_count
> >
> 
> Nice.
> This seems to work fine and nothing pops up when running
> fstests unionmount tests of overlayfs over xfs.
> 
> What strikes me as strange is that there are measurements
> of files in xfs and in overlayfs, but no measurements of files in tmpfs.

tmpfs is excluded from policy, since there is no way of storing the
file signature in the initramfs (CPIO).  There have been a number of
attempts of extending the initramfs CPIO format.  As you know Al's
reasons for not using some other format persist today.

"cat /sys/kernel/security/ima/policy" will list the current policy.  
The rules is based on the fsmagic labels.  The builtin policy can be
replaced with a custom policy.

From include/uapi/linux/magic.h:
#define TMPFS_MAGIC             0x01021994

> I suppose that is because no one can tamper with the storage
> of tmpfs, but following the same logic, nobody can tamper with
> the storage of overlayfs files without tampering with storage of
> underlying fs (e.g. xfs), so measuring overlayfs files should not
> bring any extra security to the system.

Sorry, files, especially random name files, can be stored on tmpfs and
do need to be measured and appraised.

> Especially, since if files are signed they are signed in the real
> storage (e.g. xfs) and not in overlayfs.

IMA-appraisal needs to prevent executing files that aren't properly
signed no matter the filesystem.  We can't just ignore the upper
filesystem.   What happens if file metadata - ower, group, modes -
changes.  Is the file data and metadata copied up to the overlay?  If
the file data remains the same, then the file signature should still
verify.   So it isn't as simple as saying the upper layer shouldn't
ever be verified.


> So in theory, we should never ever measure files in the
> "virtual" overlayfs and only measure them in the real fs.
> The only problem is the the IMA hooks when executing,
> mmaping, reading files from overlayfs, don't work on the real fs.

Right, if the file data changed, then signature verification would fail
with the existing signature.   And in most situations that is exactly
what is desired.

It's possible someone would want to sign files on upper layer with
their own key, but let's ignore that use case scenario for now.

> fsnotify also was not working correctly in that respect, because
> fs operations on overlayfs did not always trigger fsnotify events
> on the underlying real fs.

Yes, that will probably address detecting file change on the real inode
when accessing the lower overlay.   Not sure that it will address the
upper overlay issues.

> This was fixed in 6.5 by commit bc2473c90fca ("ovl: enable fsnotify
> events on underlying real files") and the file_real_path() infrastructure
> was added to enable this.

Ok, will take a closer look later. 

> This is why I say, that in most likelihood, IMA hook should always use
> file_real_path() and file_dentry() to perform the measurements
> and record the path of the real fs when overlayfs is performing the
> actual read/mmap on the real fs and IMA hooks should ideally
> do nothing at all (as in tmpfs) when the operation is performed
> on the "virtual" overlayfs object.

An IMA policy rule could be defined to ignore the upper layer, but it
can't be the default.  If the policy is always measure and appraise
executables and mmap'ed libraries regardless of the filesystem, then we
can't just ignore the upper layer.

Shannah tova!

Mimi

