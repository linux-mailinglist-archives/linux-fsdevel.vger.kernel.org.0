Return-Path: <linux-fsdevel+bounces-73-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37457C577B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78026281F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F921D69D;
	Wed, 11 Oct 2023 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RbYpBDT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3B10A2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 14:52:52 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85290;
	Wed, 11 Oct 2023 07:52:51 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEjU1S026452;
	Wed, 11 Oct 2023 14:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=blZIXf/q+c58Li9oxSoCW7D5FlG32Z/tjOwLZgshI+w=;
 b=RbYpBDT3kScP27fNIuz3Ym84LZVaHqoGgV55DgT3iGCO7lsULcV3E2VhgQSxCMgr7cY2
 GU5lJE7bFZ78Zxytc5L65WDwXHHQrtISjXgcQgclIuurhuAAv7sQlI6G4aE+0RfZcWvV
 q6+Efthta+L9tq4N2XH0nHGubGAP55Wyttg6Cn44z2kgr5wo0+VC+xyiZIEqEjdS3Dy0
 fqna5w/qhaXqqLHjNzuvI+4UTFqzoqv4OwUeVWCNSlFQPiJR4up3dYIEkIlm9EJraUgR
 etfLJTGtvkDPl5Az2iEvQa0a0xudzDMJJ0sLU7rEoJd9uGL5kLkVgZ3sdwqi78nDJbxn Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwrhgb03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:52:10 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BElp7a001343;
	Wed, 11 Oct 2023 14:52:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwrhg9ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:52:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BDCZS8023094;
	Wed, 11 Oct 2023 14:51:38 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1r96p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:51:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BEpbhV9110044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 14:51:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E539B5805C;
	Wed, 11 Oct 2023 14:51:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBDA58054;
	Wed, 11 Oct 2023 14:51:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.67.198])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Oct 2023 14:51:35 +0000 (GMT)
Message-ID: <443fb4da33eb0ac51a580e8fd51fa271a59172ef.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/25] ima: Align ima_file_mprotect() definition with
 LSM infrastructure
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
Date: Wed, 11 Oct 2023 10:51:34 -0400
In-Reply-To: <20230904133415.1799503-5-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-5-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: l4C-9nHSHM0F3YkPBpc_8Yl32DzZISE1
X-Proofpoint-GUID: x9r6_64VsuLv9CyGeWjhzhatKx7jdmXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=720 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change ima_file_mprotect() definition, so that it can be registered
> as implementation of the file_mprotect hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/ima.h               | 5 +++--
>  security/integrity/ima/ima_main.c | 6 ++++--
>  security/security.c               | 2 +-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 893c3b98b4d0..56e72c0beb96 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -24,7 +24,8 @@ extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
>  			 unsigned long prot, unsigned long flags);
> -extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
> +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +		      unsigned long prot);

"extern" is needed here and similarly in 5/25.

Mimi

>  extern int ima_load_data(enum kernel_load_data_id id, bool contents);
>  extern int ima_post_load_data(char *buf, loff_t size,
>  			      enum kernel_load_data_id id, char *description);
> @@ -88,7 +89,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
>  }
>  
>  static inline int ima_file_mprotect(struct vm_area_struct *vma,
> -				    unsigned long prot)
> +				    unsigned long reqprot, unsigned long prot)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 52e742d32f4b..e9e2a3ad25a1 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -441,7 +441,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>  /**
>   * ima_file_mprotect - based on policy, limit mprotect change
>   * @vma: vm_area_struct protection is set to
> - * @prot: contains the protection that will be applied by the kernel.
> + * @reqprot: protection requested by the application
> + * @prot: protection that will be applied by the kernel
>   *
>   * Files can be mmap'ed read/write and later changed to execute to circumvent
>   * IMA's mmap appraisal policy rules.  Due to locking issues (mmap semaphore
> @@ -451,7 +452,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>   *
>   * On mprotect change success, return 0.  On failure, return -EACESS.
>   */
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
> +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +		      unsigned long prot)
>  {
>  	struct ima_template_desc *template = NULL;
>  	struct file *file;
> diff --git a/security/security.c b/security/security.c
> index 96f2c68a1571..dffb67e6e119 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2721,7 +2721,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
>  	if (ret)
>  		return ret;
> -	return ima_file_mprotect(vma, prot);
> +	return ima_file_mprotect(vma, reqprot, prot);
>  }
>  
>  /**



