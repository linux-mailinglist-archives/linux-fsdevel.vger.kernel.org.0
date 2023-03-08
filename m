Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF086B0C4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCHPPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjCHPPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:15:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0700B7883;
        Wed,  8 Mar 2023 07:15:17 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328DqI1V017279;
        Wed, 8 Mar 2023 15:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wsSNtYNth8vWVB0WyhnfA9Yf92sFqjOF34GLKBIYDtY=;
 b=L5gTvcQu9D1aNW3M3WNJy2YCSXzdKhAmoBWdLMec8qR002EkuU/Xx9XQseETv61ieNpQ
 7d4jR4A3U01kEGKtK6da/PnVXIjkZrNyoipC+22sGpaPaLnDVFTN5EYZEPCb0FAMp6/L
 FRfWu4hR+XdiRJz0OYcId29IpmKNhRwU1c1nRPg5necu2ThO7nKwit2rFQUZFVnEKXMA
 4mD/0cCel+G5RjvzELK2l0qYiT1ips3KtaDkAINihQG0xeK+Q0p23MEBcl3iPmlJwxgU
 61fgRPEiTfihZMhidUjRW/Ng8NCmUBY7tKOL+OV3PbW5WKT8GqgCLinWF8QGck0ANMJ5 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a5uc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:14:49 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328DpfI0032917;
        Wed, 8 Mar 2023 15:14:49 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6s9a5ubk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:14:48 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328EB1Qi022786;
        Wed, 8 Mar 2023 15:14:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p6fkxmryy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:14:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328FEkac10158630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:14:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E7258065;
        Wed,  8 Mar 2023 15:14:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A91A58043;
        Wed,  8 Mar 2023 15:14:43 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:14:43 +0000 (GMT)
Message-ID: <59eb6d6d2ffd5522b2116000ab48b1711d57f5e5.camel@linux.ibm.com>
Subject: Re: [PATCH 00/28] security: Move IMA and EVM to the LSM
 infrastructure
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 10:14:43 -0500
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zdCOlqUF6T3fV5T9q5Vlng-KzKLsjuRP
X-Proofpoint-GUID: _d4khsLow4UcGpqeUVXzZJSGP8iQWKTJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> This patch set depends on:
> - https://lore.kernel.org/linux-integrity/20221201104125.919483-1-roberto.sassu@huaweicloud.com/ (there will be a v8 shortly)
> - https://lore.kernel.org/linux-security-module/20230217032625.678457-1-paul@paul-moore.com/
> 
> IMA and EVM are not effectively LSMs, especially due the fact that in the
> past they could not provide a security blob while there is another LSM
> active.
> 
> That changed in the recent years, the LSM stacking feature now makes it
> possible to stack together multiple LSMs, and allows them to provide a
> security blob for most kernel objects. While the LSM stacking feature has
> some limitations being worked out, it is already suitable to make IMA and
> EVM as LSMs.
> 
> In short, while this patch set is big, it does not make any functional
> change to IMA and EVM. IMA and EVM functions are called by the LSM
> infrastructure in the same places as before (except ima_post_path_mknod()),
> rather being hardcoded calls, and the inode metadata pointer is directly
> stored in the inode security blob rather than in a separate rbtree.
> 
> More specifically, patches 1-13 make IMA and EVM functions suitable to
> be registered to the LSM infrastructure, by aligning function parameters.
> 
> Patches 14-22 add new LSM hooks in the same places where IMA and EVM
> functions are called, if there is no LSM hook already.
> 
> Patch 23 adds the 'last' ordering strategy for LSMs, so that IMA and EVM
> functions are called in the same order as of today. Also, like with the
> 'first' strategy, LSMs using it are always enabled, so IMA and EVM
> functions will be always called (if IMA and EVM are compiled built-in).
> 
> Patches 24-27 do the bulk of the work, remove hardcoded calls to IMA and
> EVM functions, register those functions in the LSM infrastructure, and let
> the latter call them. In addition, they also reserve one slot for EVM to 
> supply an xattr to the inode_init_security hook.
> 
> Finally, patch 28 removes the rbtree used to bind metadata to the inodes,
> and instead reserve a space in the inode security blob to store the pointer
> to metadata. This also brings performance improvements due to retrieving
> metadata in constant time, as opposed to logarithmic.

Prior to IMA being upstreamed, it went through a number of iterations,
first on the security hooks, then as a separate parallel set of
integrity hooks, and, finally, co-located with the security hooks,
where they exist.  With this patch set we've come full circle.

With the LSM stacking support, multiple LSMs can now use the
'i_security' field removing the need for the rbtree indirection for
accessing integrity state info.

Roberto, thank you for making this change.  Mostly it looks good.  
Reviewing the patch set will be easier once the prereq's and this patch
set can be properly applied.

-- 
thanks,

Mimi

