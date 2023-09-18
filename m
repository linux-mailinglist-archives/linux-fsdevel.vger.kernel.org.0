Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7227A49A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjIRMaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjIRLA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:00:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F18F;
        Mon, 18 Sep 2023 04:00:52 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IAcO3i013238;
        Mon, 18 Sep 2023 11:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HNg/xS85emMbXvwSQ46Qcmgfwh4RbcBmp/oNBBS386g=;
 b=H4BgGJTzcWFie8ZSRV2FsgpA42ffM65FISUocAmKD61IDpkC1Gj0ijzkXPisO7x0eJxE
 +Vgg3sc4iNhalq+KWNy1iGbntxbBeK7IaCb2LvgPWPCrle1T6law3V40x39d4Vtn7/4D
 o4QOpyZwj7BkQiRLeRBP6a8tKQ/IOoMdyMqbXr17lZFsvGRUc7Yq9PTr7KGBYhHQm1QJ
 6BQ3R/LCnfFU5td1E2NSCZlIOnnZ8PUa9yBe83UIoUtC/DXf5u0ITRS9+IcNLaocW7yK
 EjBoWXZ/P86AZLuLhPp2y2v1JWKt8SxkVMitRpa1eZF3XHWirTlJ5mJtRqPEzdMRbSG1 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6mtb0k3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:00:38 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IAcgAi014733;
        Mon, 18 Sep 2023 11:00:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6mtb0k2r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:00:37 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I8mbe1018211;
        Mon, 18 Sep 2023 10:36:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppsa9gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:36:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IAakYq7340650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 10:36:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667945803F;
        Mon, 18 Sep 2023 10:36:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB1845805A;
        Mon, 18 Sep 2023 10:36:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.80.66])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 10:36:45 +0000 (GMT)
Message-ID: <ddd831c35bdcd46c5912b0f34486a36785f17622.camel@linux.ibm.com>
Subject: Re: Fwd: [PATCH] ima: fix wrong dereferences of file->f_path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Mon, 18 Sep 2023 06:36:45 -0400
In-Reply-To: <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com>
References: <20230913073755.3489676-1-amir73il@gmail.com>
         <CAOQ4uxg2_d2eFfSy45JCCLE41qCPZtLFytnZ5x5C1uXdCMUA=Q@mail.gmail.com>
         <4919dcc1066d6952190dc224004e1f6bcba5e9df.camel@linux.ibm.com>
         <CAOQ4uxiKgYO5Z25DFG=GQj3GeGZ8unSPExM-jn1HL_U8qncrtA@mail.gmail.com>
         <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
         <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X0GBblCh38VnqzD4X2sA1B0arRayVU-c
X-Proofpoint-GUID: SI8HbGQRNoBaa5FxXVUAqRWEs8FA_ftn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=812 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-09-15 at 12:57 +0300, Amir Goldstein wrote:

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
> I suppose that is because no one can tamper with the storage
> of tmpfs, but following the same logic, nobody can tamper with
> the storage of overlayfs files without tampering with storage of
> underlying fs (e.g. xfs), so measuring overlayfs files should not
> bring any extra security to the system.
> 
> Especially, since if files are signed they are signed in the real
> storage (e.g. xfs) and not in overlayfs.
> 
> So in theory, we should never ever measure files in the
> "virtual" overlayfs and only measure them in the real fs.
> The only problem is the the IMA hooks when executing,
> mmaping, reading files from overlayfs, don't work on the real fs.
> 
> fsnotify also was not working correctly in that respect, because
> fs operations on overlayfs did not always trigger fsnotify events
> on the underlying real fs.
> 
> This was fixed in 6.5 by commit bc2473c90fca ("ovl: enable fsnotify
> events on underlying real files") and the file_real_path() infrastructure
> was added to enable this.
> 
> This is why I say, that in most likelihood, IMA hook should always use
> file_real_path() and file_dentry() to perform the measurements
> and record the path of the real fs when overlayfs is performing the
> actual read/mmap on the real fs and IMA hooks should ideally
> do nothing at all (as in tmpfs) when the operation is performed
> on the "virtual" overlayfs object.

tmpfs is excluded from the builtin policy, since there is no way of
storing the file signature in the initramfs (CPIO).  There have been a
number of attempts at extending the initramfs CPIO format, but none
have been upstreamed.

Agreed, IMA should always use the real file for both the lower and the
upper overlayfs.

-- 
thanks,

Mimi

