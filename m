Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E278F000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbjHaPNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjHaPNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:13:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126CE59;
        Thu, 31 Aug 2023 08:13:27 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VFApXQ025576;
        Thu, 31 Aug 2023 15:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9RvTIMXhjg+qCqq55rO5Im9gWOH18IqnefVeYQcqlpw=;
 b=sUKzuSaLWqVaK7xzlZZKc/neNRUMtC96rpENhfE9ftLEChfAO8G1/jGU5Xlo/HAb+Eb1
 S1pIInrtkMOt9rm2u5G4quxpgoMbf2H8G4RIv9joUHgvXnaIIMzfY2nJf03PURlf3NkW
 mehkbsI4WLaD2Q2CrJAC1c3FYxD/2iQUdg/oHlt4YNqdTVBe+ZTAESt5NcNrC3oUJsOv
 GQyHluIPNgvePTlXbG9b6tMRU3O+7dkYCTq+IRzj60conEFv6u5JUohaIsASNSk1cpKj
 rqUByt7uGkdz3/mfKHEiSteQNaT/uo2SeBwlPURrmCpNPkoXWaHeo0l7PyUD/LnMF4aa wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stvcu9prc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 15:13:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VFCre6004922;
        Thu, 31 Aug 2023 15:13:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stvcu9pr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 15:13:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDeZm0020344;
        Thu, 31 Aug 2023 15:13:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3ywm34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 15:13:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37VFDHU665863978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 15:13:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 388E0582B8;
        Thu, 31 Aug 2023 15:13:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E4FA582B7;
        Thu, 31 Aug 2023 15:13:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.247])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 31 Aug 2023 15:13:16 +0000 (GMT)
Message-ID: <cd76e05c82d294a9d0965a2d98b8e51782489b5f.camel@linux.ibm.com>
Subject: Re: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-mm@kvack.org, linux-integrity@vger.kernel.org
Date:   Thu, 31 Aug 2023 11:13:15 -0400
In-Reply-To: <20230831-nachverfolgen-meditation-dcde56b10df7@brauner>
References: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
         <f75539a8-adf0-159b-15b9-4cc4a674e623@google.com>
         <20230831-nachverfolgen-meditation-dcde56b10df7@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: usbwRtpZUpkBHG1yUJFauP0_n1EYK3rs
X-Proofpoint-GUID: X0Ta0lRbupOh8WdDS0J7wA2c2Tdi1No1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-08-31 at 14:36 +0200, Christian Brauner wrote:
> On Thu, Aug 31, 2023 at 02:19:20AM -0700, Hugh Dickins wrote:
> > On Wed, 30 Aug 2023, Paul Moore wrote:
> > 
> > > Hello all,
> > > 
> > > While looking at some recent changes in mm/shmem.c I noticed that the
> > > ordering between simple_acl_create() and
> > > security_inode_init_security() is different between shmem_mknod() and
> > > shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LSM
> > > hook, and in shmem_tmpfile() the LSM call comes before the ACL call.
> > > 
> > > Perhaps this is correct, but it seemed a little odd to me so I wanted
> > > to check with all of you to make sure there is a good reason for the
> > > difference between the two functions.  Looking back to when
> > > shmem_tmpfile() was created ~2013 I don't see any explicit mention as
> > > to why the ordering is different so I'm looking for a bit of a sanity
> > > check to see if I'm missing something obvious.
> > > 
> > > My initial thinking this morning is that the
> > > security_inode_init_security() call should come before
> > > simple_acl_create() in both cases, but I'm open to different opinions
> > > on this.
> > 
> > Good eye.  The crucial commit here appears to be Mimi's 3.11 commit
> > 37ec43cdc4c7 "evm: calculate HMAC after initializing posix acl on tmpfs"
> > which intentionally moved shmem_mknod()'s generic_acl_init() up before
> > the security_inode_init_security(), around the same time as Al was
> > copying shmem_mknod() to introduce shmem_tmpfile().
> > 
> > I'd have agreed with you, Paul, until reading Mimi's commit:
> > now it looks more like shmem_tmpfile() is the one to be changed,
> > except (I'm out of my depth) maybe it's irrelevant on tmpfiles.
> 
> POSIX ACLs generally need to be set first as they are may change inode
> properties that security_inode_init_security() may rely on to be stable.
> That specifically incudes inode->i_mode:
> 
> * If the filesystem doesn't support POSIX ACLs then the umask is
>   stripped in the VFS before it ever gets to the filesystems. For such
>   cases the order of *_init_security() and setting POSIX ACLs doesn't
>   matter.
> * If the filesystem does support POSIX ACLs and the directory of the
>   resulting file does have default POSIX ACLs with mode settings then
>   the inode->i_mode will be updated.
> * If the filesystem does support POSIX ACLs but the directory doesn't
>   have default POSIX ACLs the umask will be stripped.
> 
> (roughly from memory)
> 
> If tmpfs is compiled with POSIX ACL support the mode might change and if
> anything in *_init_security() relies on inode->i_mode being stable it
> needs to be called after they have been set.
> 
> EVM hashes do use the mode and the hash gets updated when POSIX ACLs are
> changed - which caused me immense pain when I redid these codepaths last
> year.
> 
> IMHO, the easiest fix really is to lump all this together for all
> creation paths. This is what most filesystems do. For examples, see
> 
> xfs_generic_create()
> -> posix_acl_create(&mode)
> -> xfs_create{_tmpfile}(mode)
> -> xfs_inode_init_security()
> 
> or
> 
> __ext4_new_inode()
> -> ext4_init_acl()
> -> ext4_init_security()

Agreed.  Thanks, Hugh, Christian for the clear explanation.

