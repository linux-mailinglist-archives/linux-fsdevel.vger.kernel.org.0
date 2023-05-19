Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE970A006
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 21:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjESTm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjESTmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 15:42:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40EC186;
        Fri, 19 May 2023 12:42:53 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJb0aX023123;
        Fri, 19 May 2023 19:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XsOHwqSus0ATATt2cux6Mgrp0/sHwsa6ufvz+q0MK8g=;
 b=c9ELQp+Re9BiKXDXTxlE0rFLbKbhdTmPV7aKJsnIAVCyEYJ5wdS1pyzDF/1q127Se3eJ
 acLqWr8DruMmg7pbMDK9/9HWMxGmr753ygh0j6NIopweYQ80CKmihTT18tTdjH2GxLDC
 d0LT7c4Gys94/z7+Q7le/6wwf5Jv/opLotpAnOMtY/BfuXBJcPgChzk1nEWpudQyOVwC
 iFPgh+IXGMuqNkfEs+hLIRGprjbrc1idmvR+Wy7J9mY6hb9oUw/r/syVUka5IQtRyE+K
 kUoaXa204wkk+VKa6RnXHnic/5Hp0x++2ctSqUJD6ptgJZTNGT3QX3OXV+5DGuR51U54 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qpem8198y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:42:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JJb6ED023940;
        Fri, 19 May 2023 19:42:42 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qpem8198h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:42:42 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34JJBZ5F005254;
        Fri, 19 May 2023 19:42:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qj266rjv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:42:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JJgeAi57082344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 19:42:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E25495805E;
        Fri, 19 May 2023 19:42:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 247025805A;
        Fri, 19 May 2023 19:42:39 +0000 (GMT)
Received: from wecm-9-67-22-188.wecm.ibm.com (unknown [9.67.22.188])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 19:42:39 +0000 (GMT)
Message-ID: <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
Date:   Fri, 19 May 2023 15:42:38 -0400
In-Reply-To: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zr_Pq2V2khX2xqvpCsnZD1Mjxeh_EExZ
X-Proofpoint-ORIG-GUID: ks43xaZjg_1cB0zk9Sgi9XaOBDVpYPRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190168
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> So, I think we want both; we want the ovl_copyattr() and the
> vfs_getattr_nosec() change:
> 
> (1) overlayfs should copy up the inode version in ovl_copyattr(). That
>     is in line what we do with all other inode attributes. IOW, the
>     overlayfs inode's i_version counter should aim to mirror the
>     relevant layer's i_version counter. I wouldn't know why that
>     shouldn't be the case. Asking the other way around there doesn't
>     seem to be any use for overlayfs inodes to have an i_version that
>     isn't just mirroring the relevant layer's i_version.
> (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
>     Currently, ima assumes that it will get the correct i_version from
>     an inode but that just doesn't hold for stacking filesystem.
> 
> While (1) would likely just fix the immediate bug (2) is correct and
> _robust_. If we change how attributes are handled vfs_*() helpers will
> get updated and ima with it. Poking at raw inodes without using
> appropriate helpers is much more likely to get ima into trouble.

In addition to properly setting the i_version for IMA, EVM has a
similar issue with i_generation and s_uuid. Adding them to
ovl_copyattr() seems to resolve it.   Does that make sense?

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..cd0aeb828868 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_atime = realinode->i_atime;
 	inode->i_mtime = realinode->i_mtime;
 	inode->i_ctime = realinode->i_ctime;
+	inode->i_generation = realinode->i_generation;
+	if (inode->i_sb)
+		uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
>s_uuid);
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
thanks,

Mimib

