Return-Path: <linux-fsdevel+bounces-4364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3E7FEF43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D397D281D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855047A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTP7bEU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BFD7F;
	Thu, 30 Nov 2023 03:13:30 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUB7Gb3032264;
	Thu, 30 Nov 2023 11:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ef6HC5NvzFqBlHTAWd4J/zuJBCADIu2dLz+sXG5InPg=;
 b=PTP7bEU733/WjUffCuUFmyUAg4KFGDESPP7T5aW5wjx6Rfox7sA8IgJZzF6hhaDzKiTp
 GPZAu+Ef3Jt/2CYVMRRBBncVsmSHr7garPnh3QajGybqYxtw573dJPohY/PJWMB1PKJx
 T7Qp4xVQH1vMw7sVxZO3p0MR1nRC0neV4Bol9DAseeNdBlZtwGLo48nP9D5tV++F6dbx
 um8A8qVmysnHGgqp0Gt39vNcvt8gfUEP8kgktXH4/d5xso24bvej3BPsfab15xNE7EoF
 wSz/XgswOb4Yt6BV7ItczXSIclKxXflWbilNUQcFYspPCwqpY7p60BWQr43yV4r/84Yp 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ups85895u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 11:12:54 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUB7Ch2032122;
	Thu, 30 Nov 2023 11:12:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ups85894r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 11:12:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUB435i002068;
	Thu, 30 Nov 2023 11:12:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nwnkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 11:12:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUBCpiD10814034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 11:12:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B71A58043;
	Thu, 30 Nov 2023 11:12:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AD1A5805E;
	Thu, 30 Nov 2023 11:12:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.17.185])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Nov 2023 11:12:49 +0000 (GMT)
Message-ID: <7cb732ea42a221b4b8bbfad941d9dec41a3a35fa.camel@linux.ibm.com>
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
Date: Thu, 30 Nov 2023 06:12:49 -0500
In-Reply-To: <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
	 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
	 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
	 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
	 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
	 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
	 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
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
X-Proofpoint-GUID: sGlpADXpdEzfRPTTb11QNq5AVfyA7kb_
X-Proofpoint-ORIG-GUID: vXheKywDcBelVZCXMm0lWvPo-OP3VVP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300083

On Wed, 2023-11-29 at 19:46 +0100, Roberto Sassu wrote:
> On 11/29/2023 6:22 PM, Paul Moore wrote:
> > On Wed, Nov 29, 2023 at 7:28 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >>
> >> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> >>> On Mon, Nov 20, 2023 at 3:16 AM Roberto Sassu
> >>> <roberto.sassu@huaweicloud.com> wrote:
> >>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> >>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >>>>>>
> >>>>>> Before the security field of kernel objects could be shared among LSMs with
> >>>>>> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> >>>>>> of inode metadata. The association between inode metadata and inode is
> >>>>>> maintained through an rbtree.
> >>>>>>
> >>>>>> Because of this alternative storage mechanism, there was no need to use
> >>>>>> disjoint inode metadata, so IMA and EVM today still share them.
> >>>>>>
> >>>>>> With the reservation mechanism offered by the LSM infrastructure, the
> >>>>>> rbtree is no longer necessary, as each LSM could reserve a space in the
> >>>>>> security blob for each inode. However, since IMA and EVM share the
> >>>>>> inode metadata, they cannot directly reserve the space for them.
> >>>>>>
> >>>>>> Instead, request from the 'integrity' LSM a space in the security blob for
> >>>>>> the pointer of inode metadata (integrity_iint_cache structure). The other
> >>>>>> reason for keeping the 'integrity' LSM is to preserve the original ordering
> >>>>>> of IMA and EVM functions as when they were hardcoded.
> >>>>>>
> >>>>>> Prefer reserving space for a pointer to allocating the integrity_iint_cache
> >>>>>> structure directly, as IMA would require it only for a subset of inodes.
> >>>>>> Always allocating it would cause a waste of memory.
> >>>>>>
> >>>>>> Introduce two primitives for getting and setting the pointer of
> >>>>>> integrity_iint_cache in the security blob, respectively
> >>>>>> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> >>>>>> the code more understandable, as they directly replace rbtree operations.
> >>>>>>
> >>>>>> Locking is not needed, as access to inode metadata is not shared, it is per
> >>>>>> inode.
> >>>>>>
> >>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>>>> ---
> >>>>>>   security/integrity/iint.c      | 71 +++++-----------------------------
> >>>>>>   security/integrity/integrity.h | 20 +++++++++-
> >>>>>>   2 files changed, 29 insertions(+), 62 deletions(-)
> >>>>>>
> >>>>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> >>>>>> index 882fde2a2607..a5edd3c70784 100644
> >>>>>> --- a/security/integrity/iint.c
> >>>>>> +++ b/security/integrity/iint.c
> >>>>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> >>>>>>      return 0;
> >>>>>>   }
> >>>>>>
> >>>>>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> >>>>>> +   .lbs_inode = sizeof(struct integrity_iint_cache *),
> >>>>>> +};
> >>>>>
> >>>>> I'll admit that I'm likely missing an important detail, but is there
> >>>>> a reason why you couldn't stash the integrity_iint_cache struct
> >>>>> directly in the inode's security blob instead of the pointer?  For
> >>>>> example:
> >>>>>
> >>>>>    struct lsm_blob_sizes ... = {
> >>>>>      .lbs_inode = sizeof(struct integrity_iint_cache),
> >>>>>    };
> >>>>>
> >>>>>    struct integrity_iint_cache *integrity_inode_get(inode)
> >>>>>    {
> >>>>>      if (unlikely(!inode->isecurity))
> >>>>>        return NULL;
> >>>>>      return inode->i_security + integrity_blob_sizes.lbs_inode;
> >>>>>    }
> >>>>
> >>>> It would increase memory occupation. Sometimes the IMA policy
> >>>> encompasses a small subset of the inodes. Allocating the full
> >>>> integrity_iint_cache would be a waste of memory, I guess?
> >>>
> >>> Perhaps, but if it allows us to remove another layer of dynamic memory
> >>> I would argue that it may be worth the cost.  It's also worth
> >>> considering the size of integrity_iint_cache, while it isn't small, it
> >>> isn't exactly huge either.
> >>>
> >>>> On the other hand... (did not think fully about that) if we embed the
> >>>> full structure in the security blob, we already have a mutex available
> >>>> to use, and we don't need to take the inode lock (?).
> >>>
> >>> That would be excellent, getting rid of a layer of locking would be significant.
> >>>
> >>>> I'm fully convinced that we can improve the implementation
> >>>> significantly. I just was really hoping to go step by step and not
> >>>> accumulating improvements as dependency for moving IMA and EVM to the
> >>>> LSM infrastructure.
> >>>
> >>> I understand, and I agree that an iterative approach is a good idea, I
> >>> just want to make sure we keep things tidy from a user perspective,
> >>> i.e. not exposing the "integrity" LSM when it isn't required.
> >>
> >> Ok, I went back to it again.
> >>
> >> I think trying to separate integrity metadata is premature now, too
> >> many things at the same time.
> > 
> > I'm not bothered by the size of the patchset, it is more important
> > that we do The Right Thing.  I would like to hear in more detail why
> > you don't think this will work, I'm not interested in hearing about
> > difficult it may be, I'm interested in hearing about what challenges
> > we need to solve to do this properly.
> 
> The right thing in my opinion is to achieve the goal with the minimal 
> set of changes, in the most intuitive way.
> 
> Until now, there was no solution that could achieve the primary goal of 
> this patch set (moving IMA and EVM to the LSM infrastructure) and, at 
> the same time, achieve the additional goal you set of removing the 
> 'integrity' LSM.
> 
> If you see the diff, the changes compared to v5 that was already 
> accepted by Mimi are very straightforward. If the assumption I made that 
> in the end the 'ima' LSM could take over the role of the 'integrity' 
> LSM, that for me is the preferable option.
> 
> Given that the patch set is not doing any design change, but merely 
> moving calls and storing pointers elsewhere, that leaves us with the 
> option of thinking better what to do next, including like you suggested 
> to make IMA and EVM use disjoint metadata.
> 
> >> I started to think, does EVM really need integrity metadata or it can
> >> work without?
> >>
> >> The fact is that CONFIG_IMA=n and CONFIG_EVM=y is allowed, so we have
> >> the same problem now. What if we make IMA the one that manages
> >> integrity metadata, so that we can remove the 'integrity' LSM?
> > 
> > I guess we should probably revisit the basic idea of if it even makes
> > sense to enable EVM without IMA?  Should we update the Kconfig to
> > require IMA when EVM is enabled?
> 
> That would be up to Mimi. Also this does not seem the main focus of the 
> patch set.

First you suggested lumping IMA and EVM together, dropping EVM
entirely.  Now you're suggesting making EVM dependent on IMA.  Please
stop.  EVM and IMA should remain independent of each other.   The first
user of EVM is IMA.

> >> Regarding the LSM order, I would take Casey's suggestion of introducing
> >> LSM_ORDER_REALLY_LAST, for EVM.
> > 
> > Please understand that I really dislike that we have imposed ordering
> > constraints at the LSM layer, but I do understand the necessity (the
> > BPF LSM ordering upsets me the most).  I really don't want to see us
> > make things worse by adding yet another ordering bucket, I would
> > rather that we document it well and leave it alone ... basically treat
> > it like the BPF LSM (grrrrrr).
> 
> Uhm, that would not be possible right away (the BPF LSM is mutable), 
> remember that we defined LSM_ORDER_LAST so that an LSM can be always 
> enable and placed as last (requested by Mimi)?

Making EVM a full fledged LSM was contingent on two things - EVM always
being enabled if configured and being the last LSM.  Using capability
as a precedent for ordering requirement, Mickaël suggested defining
LSM_ORDER_LAST, which you agreed to.   It sounds like you're
backtracking on an agreement.

Mimi


