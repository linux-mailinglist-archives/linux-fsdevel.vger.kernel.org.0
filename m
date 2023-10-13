Return-Path: <linux-fsdevel+bounces-337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56F7C8BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F54428301F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07C21A0B;
	Fri, 13 Oct 2023 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aRyGFJSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE872219F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:56:38 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB8A9;
	Fri, 13 Oct 2023 09:56:36 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DGqKOC024192;
	Fri, 13 Oct 2023 16:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KvcxPRXQT8z860vA5hg/tsLyh50B3/HpjRrU1QQJ8xI=;
 b=aRyGFJSh+SLsZmP2gF94tKa+RhNvw2DTpxNxbMGzS0lqn4KBjf7ffTdilYFucYAho2GY
 y2MfrPXmrUgUw0H2fyveW8E/KbTUhz/YXPMZ2nukxK2KSemKk0DnEltEAXVgzzD2c1sR
 4d1KjYgcwqEvkRT9AGVCgOm5Jkore8dupnBAfgxzS+kIvgR7SNksDajKAvs6zbq3n0Zk
 a/qNrZ5gL1EQi11bRSrNQkLrASX6svl2HNHIaeq4ix7xMlelG4M57KFdYEJBulpy+LyW
 Mm5bIqZM8i/2SGuRdZVxv2dirghpgbJn6DVpXgdnCY5R+xA3jFcAENW2/DWQ0R4WQCAP jA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq9sx05et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 16:55:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DGqTfr024518;
	Fri, 13 Oct 2023 16:55:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq9sx05du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 16:55:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39DGmj3S008868;
	Fri, 13 Oct 2023 16:55:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt57nb08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Oct 2023 16:55:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39DGtnoB27656848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 16:55:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 397F158060;
	Fri, 13 Oct 2023 16:55:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E158B5805E;
	Fri, 13 Oct 2023 16:55:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.129.99])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Oct 2023 16:55:47 +0000 (GMT)
Message-ID: <d24bfa5752f751cbd36070838508fde26a4e0625.camel@linux.ibm.com>
Subject: Re: [PATCH v3 21/25] ima: Move to LSM infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 13 Oct 2023 12:55:47 -0400
In-Reply-To: <20230904134049.1802006-2-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904134049.1802006-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Yl2JA_HcM8CzbBM_Hj9g2VYlGlJP-Cj
X-Proofpoint-ORIG-GUID: BrWDdS3j3a8JQM-mkSYfvS6gTLhas4ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_08,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:40 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Remove hardcoded IMA function calls (not for appraisal) from the LSM
> infrastructure, the VFS, NFS and the key subsystem.
> 
> Make those functions as static (except for ima_file_check() which is
> exported, and ima_post_key_create_or_update(), which is not in ima_main.c),
> and register them as implementation of the respective hooks in the new
> function init_ima_lsm().

ima_post_path_mknod() is currently enabled whether or not
CONFIG_SECURITY_PATH is enabled.  Now it will only be enabled when
CONFIG_SECURITY_PATH is confiured.  Changes like this need to be
mentioned.

> Call init_ima_lsm() from integrity_lsm_init() (renamed from
> integrity_iintcache_init()), to make sure that the integrity subsystem is
> ready at the time IMA hooks are registered. The same will be done for EVM,
> by calling init_evm_lsm() just after init_ima_lsm().

Instead of creating separate IMA and EVM LSMs, the hooks are being
added to "integrity".  Some sort of (brief) explanation should be
provided.

    security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

-- 
thanks,

Mimi


