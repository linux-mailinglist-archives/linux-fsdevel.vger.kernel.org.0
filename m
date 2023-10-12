Return-Path: <linux-fsdevel+bounces-133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B707C6161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568081C20E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EA37A;
	Thu, 12 Oct 2023 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OVy+Cmvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3119B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 00:08:04 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BD94;
	Wed, 11 Oct 2023 17:08:03 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BNolws012543;
	Thu, 12 Oct 2023 00:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uiaSbBpM/Pa4uCwRgwG3S7EBa1GDOotgmEOLvNJZmGw=;
 b=OVy+CmvyaWOQo9XaYjZUd8HyxhhPY0CUmed/WgVIGq7HkqHnGn03l5Eg1p+8CWjuZA0p
 pqeXF7paoU30W/vD0RFUHgkCBQK4Nh/tisz5FlCu9SIQ11JY7AXWGNgyWqU2doVX7UQQ
 eP+1BhBp9x+D0T8jjyr80EeHAbO4WpOs7ULwtkLPzHEBhDR1ikNb48lRsg+U9Vz1hlDa
 U1hvyghoHaKzvB0CeixJC2yuU1MmY7UFCRMAB1125dAt+/da+l29UcmLyS5zFqJzWtNj
 regAOZJNmK03a84djtRiLqbHEE+yseMRpie35GYFWgyueIlaZ96hjggPzllrWLM7pjTy Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp5r08ade-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 00:07:31 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39C0680L022307;
	Thu, 12 Oct 2023 00:07:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp5r08acy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 00:07:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BNAA2B023021;
	Thu, 12 Oct 2023 00:07:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1uc85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 00:07:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39C07Tqm20644476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 00:07:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67DCF58055;
	Thu, 12 Oct 2023 00:07:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0A658059;
	Thu, 12 Oct 2023 00:07:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.14.38])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 00:07:26 +0000 (GMT)
Message-ID: <f38831743d8ad127031171016eb2d962d0fe3210.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/25] ima: Align ima_post_read_file() definition
 with LSM infrastructure
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>
Date: Wed, 11 Oct 2023 20:07:26 -0400
In-Reply-To: <20230904133415.1799503-8-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-8-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: SJldbvHMDQU6DaxPyQXHOSQ2m3C9GIPB
X-Proofpoint-ORIG-GUID: bdXpaMZzUWfwWN2NTKW83feLuOtpR7qc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310110212
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change ima_post_read_file() definition, so that it can be registered as
> implementation of the post_read_file hook.

The only change here is making "void *buf" a "char *buf".

thanks,

Mimi

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h               | 6 +++---
>  security/integrity/ima/ima_main.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 93e3c6cdf1f8..6e4d060ff378 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -31,8 +31,8 @@ extern int ima_post_load_data(char *buf, loff_t size,
>  			      enum kernel_load_data_id id, char *description);
>  extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
>  			 bool contents);
> -extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> -			      enum kernel_read_file_id id);
> +int ima_post_read_file(struct file *file, char *buf, loff_t size,
> +		       enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
>  				const struct path *dir, struct dentry *dentry,
>  				umode_t mode, unsigned int dev);
> @@ -112,7 +112,7 @@ static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
>  	return 0;
>  }
>  
> -static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
> +static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
>  				     enum kernel_read_file_id id)
>  {
>  	return 0;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e9e2a3ad25a1..f8581032e62c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -801,7 +801,7 @@ const int read_idmap[READING_MAX_ID] = {
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_read_file(struct file *file, void *buf, loff_t size,
> +int ima_post_read_file(struct file *file, char *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;



