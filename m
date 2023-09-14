Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F887A0926
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjINP07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbjINP0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:26:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D775E1FF6;
        Thu, 14 Sep 2023 08:26:36 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFCRT7013948;
        Thu, 14 Sep 2023 15:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZJXJKIlpr0jS8J18KXtuBATK5zZy3b2SUTm0yKdYhAs=;
 b=C91KgEOoItLiuPAFu2oQIhO+jn5oK7nWYfT/p3rMsHFOxsdmqzAdcTaNtDaDpupgbwhl
 1IH8Ht8pRQ7QfFnSBdxsh8aya5oDaJRQa7tCq8gHVfLeI9GHw99v1BjuRHtptRLNffmt
 gHv3g+LfrpNnKCIAOeRfI/E1yLIjfAMOJkpW8YBO5fB63biXnZiq6IwnUBiSNpBwPKaS
 H4P8p5UTAfEmzmPdhJ4QCn/CD8mfI0w9Y18aqyylylLpetGBzPZjSXa/gl1i4V3du+gw
 qB95F/DfO38TW+dieJq+R+qdTeKS3MewEdwd72nKyRWV7gINMQVybFabz6vKtp+OS4xU Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t44m5gf8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:26:28 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EFLnth019871;
        Thu, 14 Sep 2023 15:26:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t44m5gf8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:26:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EDwRIf002755;
        Thu, 14 Sep 2023 15:26:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hmbrnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 15:26:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EFQQNK4850324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:26:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A7645805C;
        Thu, 14 Sep 2023 15:26:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B92758051;
        Thu, 14 Sep 2023 15:26:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.110.230])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Sep 2023 15:26:25 +0000 (GMT)
Message-ID: <296dae962a2a488bde682d3def074db91686e1c3.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix wrong dereferences of file->f_path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu, 14 Sep 2023 11:26:25 -0400
In-Reply-To: <CAOQ4uxiPREeTmkaxohaqbg_XvngNXdRAssupoo+EdBoDD-FBeg@mail.gmail.com>
References: <20230913073755.3489676-1-amir73il@gmail.com>
         <CAOQ4uxiPREeTmkaxohaqbg_XvngNXdRAssupoo+EdBoDD-FBeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _F273nGUIVhoAa0fxuazTm_dhJ_iWbNc
X-Proofpoint-GUID: u8EVJ6uHBzjAYr7kAIIGSpUH9WHP7j5J
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-09-13 at 15:09 +0300, Amir Goldstein wrote:
> On Wed, Sep 13, 2023 at 10:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > When storing IMA xattr on an overlayfs inode, the xattr is actually
> > stored in the inode of the underlying (a.k.a real) filesystem, so there
> > is an ambiguity whether this IMA xattr describes the integrity of the
> > overlayfs inode or the real inode.
> >
> > For this reason and other reasons, IMA is not supported on overlayfs,
> > in the sense that integrity checking on the overlayfs inode/file/path
> > do not work correctly and have undefined behavior and the IMA xattr
> > always describes the integrity of the real inode.
> >
> > When a user operates on an overlayfs file, whose underlying real file
> > has IMA enabled, IMA should always operate on the real path and not
> > on the overlayfs path.
> >
> > IMA code already uses the helper file_dentry() to get the dentry
> > of the real file. Dereferencing file->f_path directly means that IMA
> > will operate on the overlayfs inode, which is wrong.
> >
> > Therefore, all dereferences to f_path were converted to use the
> > file_real_path() helper.

Thanks, Amir.  This sounds right.

> >
> > Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-unionfs/0000000000005bd097060530b758@google.com/
> > Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Mimi,
> >
> > Some of the wrong f_path dereferences are much older than the Fixes
> > commit, but they did not have as big an impact as the wrong f_path
> > dereference that the Fixes commit introduced.
> >
> > For example, commit a408e4a86b36 ("ima: open a new file instance if no
> > read permissions") worked because reading the content of the overlayfs
> > file has the same result as reading the content of the real file, but it
> > is actually the real file integrity that we want to verify.
> >
> > Anyway, the real path information, that is now available via the
> > file_real_path() helper, was not available in IMA integrity check context
> > at the time that commit a408e4a86b36 was merged.
> 
> Only problem is that fix did not resolve the syzbot bug, which
> seems to do the IMA integrity check on overlayfs file (not sure).
> 
> I am pretty sure that this patch fixes "a bug" when IMA is on the filesystem
> under overlayfs and this is a pretty important use case.

Agreed.

> But I guess there are still issues with IMA over overlayfs and this is not
> the only one.

Sigh

> Is this really a use case that needs to be supported?
> Isn't the newly added SB_I_IMA_UNVERIFIABLE_SIGNATUREh flag
> a hint that IMA on overlayfs is not a good idea at all?

With  SB_I_IMA_UNVERIFIABLE_SIGNATURE enabled for overlayfs, signature
verification will then fail immediately for all overlayfs files in
policy.  I don't think that's the right solution.  Verification should
be limited to when the overlayfs file is the same as the underlying
backing store, the real inode, not the overlay upper files.

-- 
Thanks,

Mimi

