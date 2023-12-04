Return-Path: <linux-fsdevel+bounces-4780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFE803A77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E62280576
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E122E627
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mRF4r2OC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDAC4;
	Mon,  4 Dec 2023 07:03:51 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Exrmi003821;
	Mon, 4 Dec 2023 15:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1M+Lb7RENQgWWhXI/S8gGx7CVn38cCrH9gi8fM6ANxk=;
 b=mRF4r2OCNy2A3Q36eSmIFv+fGgfC9k6w0Z53J0FiB9WvOJvflQA/5EGTKe8kqv16IyN7
 9SsQL8wx670mRgkFNiNW3bFss2Zy0ZRV5QVvk7XkcE5K7zOCcfeOcUpD/VsDvWjP1lk1
 u48AIIdoUJbJ56R9xW+Y87T9IFnMHdCii/WvWwPugqFpqW9SjgG+fPzn/WDboDhea2TR
 bE87HNx6QaFADbj1UD8YgNnOjcJCUPMn3+Sk9HeChQAWkooBJXsv52i/82IHm6KVIRq5
 UINrSGEXdlxYeUZVSjA0MXaEfHX8t1hvyZAASEI4ScB+sZqcxofgtFXoxrRcfglCqSoE OA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ush1602tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 15:02:03 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4F0Nt2005079;
	Mon, 4 Dec 2023 15:02:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ush1602sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 15:02:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EJf6O017843;
	Mon, 4 Dec 2023 15:02:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8awk6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 15:02:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4F20MM31392126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 15:02:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D247D58055;
	Mon,  4 Dec 2023 15:02:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59CD85803F;
	Mon,  4 Dec 2023 15:01:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.81.193])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 15:01:58 +0000 (GMT)
Message-ID: <99c92965c2b2c49253967d56f2a4e5f1d2c881f2.camel@linux.ibm.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore
	 <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Mon, 04 Dec 2023 10:01:57 -0500
In-Reply-To: <5f441267b6468b98e51a08d247a7ae066a60ff0c.camel@huaweicloud.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
	 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
	 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
	 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
	 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
	 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
	 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
	 <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
	 <5f441267b6468b98e51a08d247a7ae066a60ff0c.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WLTcmefykaHbDOEIiLJwsS3WymVSyxpp
X-Proofpoint-GUID: xRtCrWQrHAe-uEV4KEeAH2kUbps7vgkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040112

On Mon, 2023-12-04 at 14:26 +0100, Roberto Sassu wrote:
> On Thu, 2023-11-30 at 11:34 -0500, Paul Moore wrote:
> > On Wed, Nov 29, 2023 at 1:47 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On 11/29/2023 6:22 PM, Paul Moore wrote:
> > > > On Wed, Nov 29, 2023 at 7:28 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > 
> > > > > On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> > > > > > On Mon, Nov 20, 2023 at 3:16 AM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> > > > > > > > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > > 
> > > > > > > > > Before the security field of kernel objects could be shared among LSMs with
> > > > > > > > > the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> > > > > > > > > of inode metadata. The association between inode metadata and inode is
> > > > > > > > > maintained through an rbtree.
> > > > > > > > > 
> > > > > > > > > Because of this alternative storage mechanism, there was no need to use
> > > > > > > > > disjoint inode metadata, so IMA and EVM today still share them.
> > > > > > > > > 
> > > > > > > > > With the reservation mechanism offered by the LSM infrastructure, the
> > > > > > > > > rbtree is no longer necessary, as each LSM could reserve a space in the
> > > > > > > > > security blob for each inode. However, since IMA and EVM share the
> > > > > > > > > inode metadata, they cannot directly reserve the space for them.
> > > > > > > > > 
> > > > > > > > > Instead, request from the 'integrity' LSM a space in the security blob for
> > > > > > > > > the pointer of inode metadata (integrity_iint_cache structure). The other
> > > > > > > > > reason for keeping the 'integrity' LSM is to preserve the original ordering
> > > > > > > > > of IMA and EVM functions as when they were hardcoded.
> > > > > > > > > 
> > > > > > > > > Prefer reserving space for a pointer to allocating the integrity_iint_cache
> > > > > > > > > structure directly, as IMA would require it only for a subset of inodes.
> > > > > > > > > Always allocating it would cause a waste of memory.
> > > > > > > > > 
> > > > > > > > > Introduce two primitives for getting and setting the pointer of
> > > > > > > > > integrity_iint_cache in the security blob, respectively
> > > > > > > > > integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> > > > > > > > > the code more understandable, as they directly replace rbtree operations.
> > > > > > > > > 
> > > > > > > > > Locking is not needed, as access to inode metadata is not shared, it is per
> > > > > > > > > inode.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > > > > ---
> > > > > > > > >   security/integrity/iint.c      | 71 +++++-----------------------------
> > > > > > > > >   security/integrity/integrity.h | 20 +++++++++-
> > > > > > > > >   2 files changed, 29 insertions(+), 62 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > > > > > > > > index 882fde2a2607..a5edd3c70784 100644
> > > > > > > > > --- a/security/integrity/iint.c
> > > > > > > > > +++ b/security/integrity/iint.c
> > > > > > > > > @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> > > > > > > > >      return 0;
> > > > > > > > >   }
> > > > > > > > > 
> > > > > > > > > +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> > > > > > > > > +   .lbs_inode = sizeof(struct integrity_iint_cache *),
> > > > > > > > > +};
> > > > > > > > 
> > > > > > > > I'll admit that I'm likely missing an important detail, but is there
> > > > > > > > a reason why you couldn't stash the integrity_iint_cache struct
> > > > > > > > directly in the inode's security blob instead of the pointer?  For
> > > > > > > > example:
> > > > > > > > 
> > > > > > > >    struct lsm_blob_sizes ... = {
> > > > > > > >      .lbs_inode = sizeof(struct integrity_iint_cache),
> > > > > > > >    };
> > > > > > > > 
> > > > > > > >    struct integrity_iint_cache *integrity_inode_get(inode)
> > > > > > > >    {
> > > > > > > >      if (unlikely(!inode->isecurity))
> > > > > > > >        return NULL;
> > > > > > > >      return inode->i_security + integrity_blob_sizes.lbs_inode;
> > > > > > > >    }
> > > > > > > 
> > > > > > > It would increase memory occupation. Sometimes the IMA policy
> > > > > > > encompasses a small subset of the inodes. Allocating the full
> > > > > > > integrity_iint_cache would be a waste of memory, I guess?
> > > > > > 
> > > > > > Perhaps, but if it allows us to remove another layer of dynamic memory
> > > > > > I would argue that it may be worth the cost.  It's also worth
> > > > > > considering the size of integrity_iint_cache, while it isn't small, it
> > > > > > isn't exactly huge either.
> > > > > > 
> > > > > > > On the other hand... (did not think fully about that) if we embed the
> > > > > > > full structure in the security blob, we already have a mutex available
> > > > > > > to use, and we don't need to take the inode lock (?).
> > > > > > 
> > > > > > That would be excellent, getting rid of a layer of locking would be significant.
> > > > > > 
> > > > > > > I'm fully convinced that we can improve the implementation
> > > > > > > significantly. I just was really hoping to go step by step and not
> > > > > > > accumulating improvements as dependency for moving IMA and EVM to the
> > > > > > > LSM infrastructure.
> > > > > > 
> > > > > > I understand, and I agree that an iterative approach is a good idea, I
> > > > > > just want to make sure we keep things tidy from a user perspective,
> > > > > > i.e. not exposing the "integrity" LSM when it isn't required.
> > > > > 
> > > > > Ok, I went back to it again.
> > > > > 
> > > > > I think trying to separate integrity metadata is premature now, too
> > > > > many things at the same time.
> > > > 
> > > > I'm not bothered by the size of the patchset, it is more important
> > > > that we do The Right Thing.  I would like to hear in more detail why
> > > > you don't think this will work, I'm not interested in hearing about
> > > > difficult it may be, I'm interested in hearing about what challenges
> > > > we need to solve to do this properly.
> > > 
> > > The right thing in my opinion is to achieve the goal with the minimal
> > > set of changes, in the most intuitive way.
> > 
> > Once again, I want to stress that I don't care about the size of the
> > change, the number of patches in a patchset, etc.  While it's always
> > nice to be able to minimize the number of changes in a patch/patchset,
> > that is secondary to making sure we are doing the right thing over the
> > long term.  This is especially important when we are talking about
> > things that are user visible.
> > 
> > > Until now, there was no solution that could achieve the primary goal of
> > > this patch set (moving IMA and EVM to the LSM infrastructure) and, at
> > > the same time, achieve the additional goal you set of removing the
> > > 'integrity' LSM.
> > 
> > We need to stop thinking about the "integrity" code as a LSM, it isn't
> > a LSM.  It's a vestigial implementation detail that was necessary back
> > when there could only be one LSM active at a time and there was a
> > desire to have IMA/EVM active in conjunction with one of the LSMs,
> > i.e. Smack, SELinux, etc.
> > 
> > IMA and EVM are (or will be) LSMs, "integrity" is not.  I recognize
> > that eliminating the need for the "integrity" code is a relatively new
> > addition to this effort, but that is only because I didn't properly
> > understand the relationship between IMA, EVM, and the "integrity" code
> > until recently.  The elimination of the shared "integrity" code is
> > consistent with promoting IMA and EVM as full LSMs, if there is core
> > functionality that cannot be split up into the IMA and/or EVM LSMs
> > then we need to look at how to support that without exposing that
> > implementation detail/hack to userspace.  Maybe that means direct
> > calls between IMA and EVM, maybe that means preserving some of the
> > common integrity code hidden from userspace, maybe that means adding
> > functionality to the LSM layer, maybe that means something else?
> > Let's think on this to come up with something that we can all accept
> > as a long term solution instead of just doing the quick and easy
> > option.
> 
> If the result of this patch set should be that IMA and EVM become
> proper LSMs without the shared integrity layer, instead of collapsing
> all changes in this patch set, I think we should first verify if IMA
> and EVM can be really independent. Once we guarantee that, we can
> proceed making the proper LSMs.
> 
> These are the changes I have in mind:
> 
> 1) Fix evm_verifyxattr(), and make it work without integrity_iint_cache
> 2) Remove the integrity_iint_cache parameter from evm_verifyxattr(),
>    since the other callers are not going to use it
> 3) Create an internal function with the original parameters to be used
>    by IMA
> 4) Introduce evm_post_path_mknod(), which similarly to
>    ima_post_path_mknod(), sets IMA_NEW_FILE for new files
> 5) Add hardcoded call to evm_post_path_mknod() after
>    ima_post_path_mknod() in security.c
> 
> If we think that this is good enough, we proceed with the move of IMA
> and EVM functions to the LSM infrastructure (patches v7 19-21).
> 
> The next patches are going to be similar to patches v6 22-23, but
> unlike those, their goal would be simply to split metadata, not to make
> IMA and EVM independent, which at this point has been addressed
> separately in the prerequisite patches.
> 
> The final patch is to remove the 'integrity' LSM and the integrity
> metadata management code, which now is not used anymore.
> 
> Would that work?

Sounds good to me.

Mimi


