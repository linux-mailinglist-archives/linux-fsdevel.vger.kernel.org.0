Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1D370018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhD3SBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:01:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3315 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229750AbhD3SBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:01:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UHXfBu041442;
        Fri, 30 Apr 2021 14:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dlQ6N9A7X8KUPbXEssDvs9Lv+9ATvqt04iELCkYH8uc=;
 b=KN7/95UYqqoS9dp+Luw03BokChEsBMsd4RG29gUTm4fNrdYgNdf5LeIZafmwj73AkJz8
 EID8KnL2k/Vwe6LGrJ9OL9piNIPd4CcI0lZrGEZub550mQSoYVuLuUFyJdNK9QUd3jsl
 VhXaiVshKkp1yTEC/c5J16WVl9pdLKGS/2z3H8ZqmXaua7PcqWEXvHQfrSF6djRb/fbI
 CoeIgWyP01+CtsBRvQFc5xt212g0IbgqE9Mj6oT/wxAaDqRy7SoFULPMtH/dHtfGn15i
 ftImtF+zRgK4luEVDM9ncKSL7leWS28RQRG7xieD+UeMoW9JWrxNXHHZqnIy1XhwoX37 PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 388nwhsk4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 14:00:13 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13UHYNAI045483;
        Fri, 30 Apr 2021 14:00:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 388nwhsk3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 14:00:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UHwBoc002154;
        Fri, 30 Apr 2021 18:00:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 384ay8kbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 18:00:11 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UI08MR28901756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 18:00:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54A8E42067;
        Fri, 30 Apr 2021 18:00:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5217642047;
        Fri, 30 Apr 2021 18:00:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.32.5])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Apr 2021 18:00:06 +0000 (GMT)
Message-ID: <960b27ad2fa7e85a999f0ad600ba07546dc39f2b.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Fri, 30 Apr 2021 14:00:05 -0400
In-Reply-To: <8e62ae3f8cf94c798fc1b7ffd69cbdc4@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <8e62ae3f8cf94c798fc1b7ffd69cbdc4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P1JWKCvGzsQV13jvwyTbBn3un9MDAyeV
X-Proofpoint-GUID: HsFk_RrLgO1TlILkQnTairWOaITcN-LN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_11:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300116
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-04-28 at 15:35 +0000, Roberto Sassu wrote:
> > From: Roberto Sassu
> > Sent: Friday, March 5, 2021 4:19 PM
> > ima_inode_setxattr() and ima_inode_removexattr() hooks are called before
> > an
> > operation is performed. Thus, ima_reset_appraise_flags() should not be
> > called there, as flags might be unnecessarily reset if the operation is
> > denied.
> > 
> > This patch introduces the post hooks ima_inode_post_setxattr() and
> > ima_inode_post_removexattr(), and adds the call to
> > ima_reset_appraise_flags() in the new functions.
> > 
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  fs/xattr.c                            |  2 ++
> >  include/linux/ima.h                   | 18 ++++++++++++++++++
> >  security/integrity/ima/ima_appraise.c | 25 ++++++++++++++++++++++---
> >  security/security.c                   |  1 +
> >  4 files changed, 43 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index b3444e06cded..81847f132d26 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/security.h>
> >  #include <linux/evm.h>
> > +#include <linux/ima.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/export.h>
> >  #include <linux/fsnotify.h>
> > @@ -502,6 +503,7 @@ __vfs_removexattr_locked(struct user_namespace
> > *mnt_userns,
> > 
> >  	if (!error) {
> >  		fsnotify_xattr(dentry);
> > +		ima_inode_post_removexattr(dentry, name);
> >  		evm_inode_post_removexattr(dentry, name);
> >  	}
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 61d5723ec303..5e059da43857 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -171,7 +171,13 @@ extern void ima_inode_post_setattr(struct
> > user_namespace *mnt_userns,
> >  				   struct dentry *dentry);
> >  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> >  		       const void *xattr_value, size_t xattr_value_len);
> > +extern void ima_inode_post_setxattr(struct dentry *dentry,
> > +				    const char *xattr_name,
> > +				    const void *xattr_value,
> > +				    size_t xattr_value_len);
> >  extern int ima_inode_removexattr(struct dentry *dentry, const char
> > *xattr_name);
> > +extern void ima_inode_post_removexattr(struct dentry *dentry,
> > +				       const char *xattr_name);
> >  #else
> >  static inline bool is_ima_appraise_enabled(void)
> >  {
> > @@ -192,11 +198,23 @@ static inline int ima_inode_setxattr(struct dentry
> > *dentry,
> >  	return 0;
> >  }
> > 
> > +static inline void ima_inode_post_setxattr(struct dentry *dentry,
> > +					   const char *xattr_name,
> > +					   const void *xattr_value,
> > +					   size_t xattr_value_len)
> > +{
> > +}
> > +
> >  static inline int ima_inode_removexattr(struct dentry *dentry,
> >  					const char *xattr_name)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline void ima_inode_post_removexattr(struct dentry *dentry,
> > +					      const char *xattr_name)
> > +{
> > +}
> >  #endif /* CONFIG_IMA_APPRAISE */
> > 
> >  #if defined(CONFIG_IMA_APPRAISE) &&
> > defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> > diff --git a/security/integrity/ima/ima_appraise.c
> > b/security/integrity/ima/ima_appraise.c
> > index 565e33ff19d0..1f029e4c8d7f 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -577,21 +577,40 @@ int ima_inode_setxattr(struct dentry *dentry, const
> > char *xattr_name,
> >  	if (result == 1) {
> >  		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
> >  			return -EINVAL;
> > -		ima_reset_appraise_flags(d_backing_inode(dentry),
> > -			xvalue->type == EVM_IMA_XATTR_DIGSIG);
> >  		result = 0;
> >  	}
> >  	return result;
> >  }
> > 
> > +void ima_inode_post_setxattr(struct dentry *dentry, const char
> > *xattr_name,
> > +			     const void *xattr_value, size_t xattr_value_len)
> > +{
> > +	const struct evm_ima_xattr_data *xvalue = xattr_value;
> > +	int result;
> > +
> > +	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
> > +				   xattr_value_len);
> > +	if (result == 1)
> > +		ima_reset_appraise_flags(d_backing_inode(dentry),
> 
> I found an issue in this patch.
> 
> Moving ima_reset_appraise_flags() to the post hook causes this
> function to be executed also when __vfs_setxattr_noperm() is
> called.
> 
> The problem is that at the end of a write IMA calls
> ima_collect_measurement() to recalculate the file digest and
> update security.ima. ima_collect_measurement() sets
> IMA_COLLECTED.
> 
> However, after that __vfs_setxattr_noperm() causes
> IMA_COLLECTED to be reset, and to unnecessarily recalculate
> the file digest. This wouldn't happen if ima_reset_appraise_flags()
> is in the pre hook.
> 
> I solved by replacing:
> 	iint->flags &= ~IMA_DONE_MASK;
> with:
> 	iint->flags &= ~(IMA_DONE_MASK & ~IMA_COLLECTED);
> 
> just when the IMA_CHANGE_XATTR bit is set. It should
> not be a problem since setting an xattr does not influence
> the file content.
> 
> Mimi, what do you think?

Thank yor for noticing this.

Without seeing the actual change it is hard to tell.   The only place
that "iint->flags &= ~IMA_DONE_MASK;" occurs is in neither of the above
functions, but in process_measurement().  There it is a part of a
compound "if" statement.  Perhaps it would be ok to change it for just
the IMA_CHANGE_XATTR test, but definitely not for the other conditions,
like untrusted mounts.

Moving ima_reset_appraise_flags() to the post hooks is to minimize
resetting the flags unnecessarily.  That is really a performance fix,
not something necessary for making the EVM portable & immutable
signatures more usable.  As much as possible, please minimize the
changes to facilitate review and testing.

thanks,

Mimi

