Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55843792D34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 20:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjIESOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbjIESNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:13:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9B4EEC;
        Tue,  5 Sep 2023 09:51:02 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385GNCfo008770;
        Tue, 5 Sep 2023 16:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sXbdMgLZIhSiK3fzcXK/UJ4zDBMkRUqUfRPvekWz8lk=;
 b=W32CF3tZbRODnibb39KNLzvGfuWJnLkedHKokJ6efcufGUqeFmILVcJOCTiyWPl4WY0H
 WN9TNdb7Qk4FxmaGPFO78Z8ubuy1Uynf/IRRnTJi4f6bFgfhunDT4dqec6RHEnMb/czZ
 MPcDW2888R2M9KJ0gX15WAbuTm3JpWnMi+vkMuveiXniBhMXqC0rLCT2fUePQib9UruM
 +ioJ+dBJGjkaoa5N+3WSq0bBWoyYlQyYj8P3Aa9e418z+lCA803X4kZI59kTp3pYoM7b
 08VcEeWS1Iq8uTD01zslAtH+JZLythABxMxPOanqjonCgtpN+49WZJOpwbtWFy2RTApL iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx7tbgymm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 16:49:16 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385GQnTK018987;
        Tue, 5 Sep 2023 16:49:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx7tbgym1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 16:49:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385EtNPT006710;
        Tue, 5 Sep 2023 16:49:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkc1g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 16:49:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385GnDv017105500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 16:49:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612A85805E;
        Tue,  5 Sep 2023 16:49:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD6F58052;
        Tue,  5 Sep 2023 16:49:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.131.237])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 16:49:10 +0000 (GMT)
Message-ID: <ff07bf7410dd212985edda83e3cd51906889cbf2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 13/25] security: Introduce inode_post_removexattr hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 05 Sep 2023 12:49:10 -0400
In-Reply-To: <b4bc9dbb2417dc8afe0bf0a50233d4c2968bfb7a.camel@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
         <20230831104136.903180-14-roberto.sassu@huaweicloud.com>
         <CVAFXF2BQ14B.19BO7F9P62WGT@suppilovahvero>
         <b4bc9dbb2417dc8afe0bf0a50233d4c2968bfb7a.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EWR6RCXHULnph_bFOuDNlcAdxMADmypc
X-Proofpoint-ORIG-GUID: hcdF1FGxFYOb_xwwjhvoUo2ttDjX17PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-05 at 08:51 +0200, Roberto Sassu wrote:
> On Tue, 2023-09-05 at 00:11 +0300, Jarkko Sakkinen wrote:
> > On Thu Aug 31, 2023 at 1:41 PM EEST, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > > the inode_post_removexattr hook.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >  fs/xattr.c                    |  9 +++++----
> > >  include/linux/lsm_hook_defs.h |  2 ++
> > >  include/linux/security.h      |  5 +++++
> > >  security/security.c           | 14 ++++++++++++++
> > >  4 files changed, 26 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index e7bbb7f57557..4a0280295686 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
> > >  		goto out;
> > >  
> > >  	error = __vfs_removexattr(idmap, dentry, name);
> > > +	if (error)
> > > +		goto out;
> > >  
> > > -	if (!error) {
> > > -		fsnotify_xattr(dentry);
> > > -		evm_inode_post_removexattr(dentry, name);
> > > -	}
> > > +	fsnotify_xattr(dentry);
> > > +	security_inode_post_removexattr(dentry, name);
> > > +	evm_inode_post_removexattr(dentry, name);
> > >  
> > >  out:
> > >  	return error;
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 995d30336cfa..1153e7163b8b 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
> > >  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
> > >  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
> > >  	 struct dentry *dentry, const char *name)
> > > +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> > > +	 const char *name)
> > >  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
> > >  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> > >  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 820899db5276..665bba3e0081 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
> > >  int security_inode_listxattr(struct dentry *dentry);
> > >  int security_inode_removexattr(struct mnt_idmap *idmap,
> > >  			       struct dentry *dentry, const char *name);
> > > +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> > >  int security_inode_need_killpriv(struct dentry *dentry);
> > >  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
> > >  int security_inode_getsecurity(struct mnt_idmap *idmap,
> > > @@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
> > >  	return cap_inode_removexattr(idmap, dentry, name);
> > >  }
> > >  
> > > +static inline void security_inode_post_removexattr(struct dentry *dentry,
> > > +						   const char *name)
> > > +{ }
> > 
> > static inline void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> > {
> > }
> > 
> > > +
> > >  static inline int security_inode_need_killpriv(struct dentry *dentry)
> > >  {
> > >  	return cap_inode_need_killpriv(dentry);
> > > diff --git a/security/security.c b/security/security.c
> > > index 764a6f28b3b9..3947159ba5e9 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
> > >  	return evm_inode_removexattr(idmap, dentry, name);
> > >  }
> > >  
> > > +/**
> > > + * security_inode_post_removexattr() - Update the inode after a removexattr op
> > > + * @dentry: file
> > > + * @name: xattr name
> > > + *
> > > + * Update the inode after a successful removexattr operation.
> > > + */
> > > +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> > > +{
> > > +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > > +		return;
> > > +	call_void_hook(inode_post_removexattr, dentry, name);
> > > +}
> > > +
> > >  /**
> > >   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
> > >   * @dentry: associated dentry
> > > -- 
> > > 2.34.1
> > 
> > 
> > These odd splits are everywhere in the patch set. Just (nit)picking some.
> > 
> > It is huge patch set so I don't really get for addign extra lines for no
> > good reason.
> 
> Thanks for the review, Jarkko.
> 
> I don't know... to be honest I still prefer to stay within 80
> characters.

I agree.

-- 
thanks,

Mimi


