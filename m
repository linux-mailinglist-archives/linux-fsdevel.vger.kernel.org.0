Return-Path: <linux-fsdevel+bounces-173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACFF7C6F33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118A4282AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6F29416;
	Thu, 12 Oct 2023 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WNPuzFyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FCBA3C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:30:30 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD39BB;
	Thu, 12 Oct 2023 06:30:28 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDRmsJ001634;
	Thu, 12 Oct 2023 13:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bpdH/n3r6+yycJzKF5SsiELzintg9p4tdVCawcD9mM0=;
 b=WNPuzFyqVUo9ErvL9bORrPi+XkUKVPlUszUi/bOG0qfn3LlogMDu/2H/hLTyOpayArIz
 69d+UE/uFu7sQkFYQjPYmQCUS2cQJl403k7SCyqcSle6QHRiBFvCBvKxwDBg3BX5MbMX
 HTv+GF/y3nMPt4017TMcua7H87GqOtVWyKZYSQ00nQZ4gIiuPN1sVfYjEtSs8fxyUwnh
 xeEaTfQwKCr1+KuRX8Q4aU43KZQiRUTcjisXSLYINhHX3HuKRLDNJ+R60Lngyt+xU9vz
 J80eI4M2bAETGZkn+PMJWlyyyF3vpx8T6UnSe6xaLK9KWUw4Yd0TngNO6JiMeDQ57oIP nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphpvr256-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:29:51 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CDToZN009080;
	Thu, 12 Oct 2023 13:29:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphpvr219-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:29:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBpObj024465;
	Thu, 12 Oct 2023 13:25:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnt01ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:25:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CDP4AH57672082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:25:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D2358059;
	Thu, 12 Oct 2023 13:25:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D905805D;
	Thu, 12 Oct 2023 13:25:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.11.225])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 13:25:01 +0000 (GMT)
Message-ID: <84cfe4d93cb5b02591f4bd921b828eb6f3e95faa.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/25] ima: Align ima_post_path_mknod() definition
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 12 Oct 2023 09:25:00 -0400
In-Reply-To: <2336abd6ae195eda221d54e3c2349a4760afaff2.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
	 <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
	 <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
	 <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
	 <16c8c95f2e63ab9a2fba8cba919bf129d0541b61.camel@huaweicloud.com>
	 <c16551704db68c6e0ba89c729c892e9401f05dfc.camel@linux.ibm.com>
	 <2336abd6ae195eda221d54e3c2349a4760afaff2.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: 3O5zaE-jKMy0v3K8bSHmEwYSbhvfpYCS
X-Proofpoint-GUID: m8ZqZUL2g5V8V5rT8_Mbj_JZVELiLoiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 14:19 +0200, Roberto Sassu wrote:
> On Thu, 2023-10-12 at 07:42 -0400, Mimi Zohar wrote:
> > On Thu, 2023-10-12 at 09:29 +0200, Roberto Sassu wrote:
> > > On Wed, 2023-10-11 at 15:01 -0400, Mimi Zohar wrote:
> > > > On Wed, 2023-10-11 at 18:02 +0200, Roberto Sassu wrote:
> > > > > On Wed, 2023-10-11 at 10:38 -0400, Mimi Zohar wrote:
> > > > > > On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > 
> > > > > > > Change ima_post_path_mknod() definition, so that it can be registered as
> > > > > > > implementation of the path_post_mknod hook. Since LSMs see a umask-stripped
> > > > > > > mode from security_path_mknod(), pass the same to ima_post_path_mknod() as
> > > > > > > well.
> > > > > > > Also, make sure that ima_post_path_mknod() is executed only if
> > > > > > > (mode & S_IFMT) is equal to zero or S_IFREG.
> > > > > > > 
> > > > > > > Add this check to take into account the different placement of the
> > > > > > > path_post_mknod hook (to be introduced) in do_mknodat().
> > > > > > 
> > > > > > Move "(to be introduced)" to when it is first mentioned.
> > > > > > 
> > > > > > > Since the new hook
> > > > > > > will be placed after the switch(), the check ensures that
> > > > > > > ima_post_path_mknod() is invoked as originally intended when it is
> > > > > > > registered as implementation of path_post_mknod.
> > > > > > > 
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > ---
> > > > > > >  fs/namei.c                        |  9 ++++++---
> > > > > > >  include/linux/ima.h               |  7 +++++--
> > > > > > >  security/integrity/ima/ima_main.c | 10 +++++++++-
> > > > > > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > > index e56ff39a79bc..c5e96f716f98 100644
> > > > > > > --- a/fs/namei.c
> > > > > > > +++ b/fs/namei.c
> > > > > > > @@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > > >  	struct path path;
> > > > > > >  	int error;
> > > > > > >  	unsigned int lookup_flags = 0;
> > > > > > > +	umode_t mode_stripped;
> > > > > > >  
> > > > > > >  	error = may_mknod(mode);
> > > > > > >  	if (error)
> > > > > > > @@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > > >  	if (IS_ERR(dentry))
> > > > > > >  		goto out1;
> > > > > > >  
> > > > > > > -	error = security_path_mknod(&path, dentry,
> > > > > > > -			mode_strip_umask(path.dentry->d_inode, mode), dev);
> > > > > > > +	mode_stripped = mode_strip_umask(path.dentry->d_inode, mode);
> > > > > > > +
> > > > > > > +	error = security_path_mknod(&path, dentry, mode_stripped, dev);
> > > > > > >  	if (error)
> > > > > > >  		goto out2;
> > > > > > >  
> > > > > > > @@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > > > > >  			error = vfs_create(idmap, path.dentry->d_inode,
> > > > > > >  					   dentry, mode, true);
> > > > > > >  			if (!error)
> > > > > > > -				ima_post_path_mknod(idmap, dentry);
> > > > > > > +				ima_post_path_mknod(idmap, &path, dentry,
> > > > > > > +						    mode_stripped, dev);
> > > > > > >  			break;
> > > > > > >  		case S_IFCHR: case S_IFBLK:
> > > > > > >  			error = vfs_mknod(idmap, path.dentry->d_inode,
> > > > > > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > > > > > index 910a2f11a906..179ce52013b2 100644
> > > > > > > --- a/include/linux/ima.h
> > > > > > > +++ b/include/linux/ima.h
> > > > > > > @@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> > > > > > >  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
> > > > > > >  			      enum kernel_read_file_id id);
> > > > > > >  extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > > -				struct dentry *dentry);
> > > > > > > +				const struct path *dir, struct dentry *dentry,
> > > > > > > +				umode_t mode, unsigned int dev);
> > > > > > >  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
> > > > > > >  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
> > > > > > >  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> > > > > > > @@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
> > > > > > >  }
> > > > > > >  
> > > > > > >  static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > > -				       struct dentry *dentry)
> > > > > > > +				       const struct path *dir,
> > > > > > > +				       struct dentry *dentry,
> > > > > > > +				       umode_t mode, unsigned int dev)
> > > > > > >  {
> > > > > > >  	return;
> > > > > > >  }
> > > > > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > > > > index 365db0e43d7c..76eba92d7f10 100644
> > > > > > > --- a/security/integrity/ima/ima_main.c
> > > > > > > +++ b/security/integrity/ima/ima_main.c
> > > > > > > @@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > > > > > >  /**
> > > > > > >   * ima_post_path_mknod - mark as a new inode
> > > > > > >   * @idmap: idmap of the mount the inode was found from
> > > > > > > + * @dir: path structure of parent of the new file
> > > > > > >   * @dentry: newly created dentry
> > > > > > > + * @mode: mode of the new file
> > > > > > > + * @dev: undecoded device number
> > > > > > >   *
> > > > > > >   * Mark files created via the mknodat syscall as new, so that the
> > > > > > >   * file data can be written later.
> > > > > > >   */
> > > > > > >  void ima_post_path_mknod(struct mnt_idmap *idmap,
> > > > > > > -			 struct dentry *dentry)
> > > > > > > +			 const struct path *dir, struct dentry *dentry,
> > > > > > > +			 umode_t mode, unsigned int dev)
> > > > > > >  {
> > > > > > >  	struct integrity_iint_cache *iint;
> > > > > > >  	struct inode *inode = dentry->d_inode;
> > > > > > >  	int must_appraise;
> > > > > > >  
> > > > > > > +	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG: */
> > > > > > > +	if ((mode & S_IFMT) != 0 && (mode & S_IFMT) != S_IFREG)
> > > > > > > +		return;
> > > > > > > +
> > > > > > 
> > > > > > There's already a check below to make sure that this is a regular file.
> > > > > > Are both needed?
> > > > > 
> > > > > You are right, I can remove the first check.
> > > > 
> > > > The question then becomes why modify hook the arguments?   
> > > 
> > > We need to make sure that ima_post_path_mknod() has the same parameters
> > > as the LSM hook at the time we register it to the LSM infrastructure.
> > 
> > I'm trying to understand why the pre hook parameters and the missing
> > IMA parameter are used, as opposed to just defining the new
> > post_path_mknod hook like IMA.
> 
> As an empyrical rule, I pass the same parameters as the corresponding
> pre hook (plus idmap, in this case). This is similar to the
> inode_setxattr hook. But I can be wrong, if desired I can reduce.

The inode_setxattr hook change example is legitimate, as EVM includes
idmap, while IMA doesn't. 

Unless there is a good reason for the additional parameters, I'm not
sure that adding them makes sense.  Not modifying the parameter list
will reduce the size of this patch set.

-- 
thanks,

Mimi


