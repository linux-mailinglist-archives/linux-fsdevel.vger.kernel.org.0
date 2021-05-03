Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279F3715E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhECNXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 09:23:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10168 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233592AbhECNXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 09:23:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143D2rZS037410;
        Mon, 3 May 2021 09:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VZsz2X+39PaNXGepVYPsE32mXrMrJrd6fuqGVli/oZg=;
 b=j4/uwNi+81R9bfV0E77qu7qxSa6EDqE0CawIBgRjcgjcVLqifro1A5wvckYqVo2r4X8X
 ze+6qmfMW0zrf4xRVxH3BtyXDaPjYzqUCurJIn3CkoBAQL/5rNgNXdhbNHVsIqJbOHKo
 BIb8FpjgK4BMQEItOSv5XgBc0NFnBpywcugteuA0TnagQN/f9bQeTwi21dTy1nMYDOhm
 2y6OU1LKE3hlbSMDb3uDrSVT4m497rMN51gaNMjKWUn6GhfbcI/VAVVxub/klAfL3XQD
 KtUNOgH2EvYd+xitUIFYXYeNYZxOpyAUMlZf38KPJlOn9pH2qk/NzoajrczaNJFcKFir 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah0y1upr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 09:21:50 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143D2tkB037601;
        Mon, 3 May 2021 09:21:50 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38ah0y1unu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 09:21:50 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143D9EQL006287;
        Mon, 3 May 2021 13:21:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 388xm88da8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 May 2021 13:21:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143DLjSH30081332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 May 2021 13:21:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDE7111C04A;
        Mon,  3 May 2021 13:21:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1FD111C050;
        Mon,  3 May 2021 13:21:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.45.89])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 May 2021 13:21:43 +0000 (GMT)
Message-ID: <bfc5e86e8bc0c04f028bd26e087828fc1a48e742.camel@linux.ibm.com>
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
Date:   Mon, 03 May 2021 09:21:42 -0400
In-Reply-To: <8c851eec3ae44d209c5b8e45dd67266e@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
         <20210305151923.29039-5-roberto.sassu@huawei.com>
         <8e62ae3f8cf94c798fc1b7ffd69cbdc4@huawei.com>
         <960b27ad2fa7e85a999f0ad600ba07546dc39f2b.camel@linux.ibm.com>
         <8c851eec3ae44d209c5b8e45dd67266e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IN_gLspEvmKnJwqxQrOZeUF8eJ3I3snc
X-Proofpoint-GUID: cBo7EJtqh5NwhtZS8h1-Vne6Cn9hwc5t
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_07:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-05-03 at 07:41 +0000, Roberto Sassu wrote:
> 
> > > > diff --git a/security/integrity/ima/ima_appraise.c
> > > > b/security/integrity/ima/ima_appraise.c
> > > > index 565e33ff19d0..1f029e4c8d7f 100644
> > > > --- a/security/integrity/ima/ima_appraise.c
> > > > +++ b/security/integrity/ima/ima_appraise.c
> > > > @@ -577,21 +577,40 @@ int ima_inode_setxattr(struct dentry *dentry,
> > const
> > > > char *xattr_name,
> > > >  	if (result == 1) {
> > > >  		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
> > > >  			return -EINVAL;
> > > > -		ima_reset_appraise_flags(d_backing_inode(dentry),
> > > > -			xvalue->type == EVM_IMA_XATTR_DIGSIG);
> > > >  		result = 0;
> > > >  	}
> > > >  	return result;
> > > >  }
> > > >
> > > > +void ima_inode_post_setxattr(struct dentry *dentry, const char
> > > > *xattr_name,
> > > > +			     const void *xattr_value, size_t xattr_value_len)
> > > > +{
> > > > +	const struct evm_ima_xattr_data *xvalue = xattr_value;
> > > > +	int result;
> > > > +
> > > > +	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
> > > > +				   xattr_value_len);
> > > > +	if (result == 1)
> > > > +		ima_reset_appraise_flags(d_backing_inode(dentry),
> > >
> > > I found an issue in this patch.
> > >
> > > Moving ima_reset_appraise_flags() to the post hook causes this
> > > function to be executed also when __vfs_setxattr_noperm() is
> > > called.
> > >
> > > The problem is that at the end of a write IMA calls
> > > ima_collect_measurement() to recalculate the file digest and
> > > update security.ima. ima_collect_measurement() sets
> > > IMA_COLLECTED.
> > >
> > > However, after that __vfs_setxattr_noperm() causes
> > > IMA_COLLECTED to be reset, and to unnecessarily recalculate
> > > the file digest. This wouldn't happen if ima_reset_appraise_flags()
> > > is in the pre hook.
> > >
> > > I solved by replacing:
> > > 	iint->flags &= ~IMA_DONE_MASK;
> > > with:
> > > 	iint->flags &= ~(IMA_DONE_MASK & ~IMA_COLLECTED);
> > >
> > > just when the IMA_CHANGE_XATTR bit is set. It should
> > > not be a problem since setting an xattr does not influence
> > > the file content.
> > >
> > > Mimi, what do you think?
> > 
> > Thank yor for noticing this.
> > 
> > Without seeing the actual change it is hard to tell.   The only place
> > that "iint->flags &= ~IMA_DONE_MASK;" occurs is in neither of the above
> > functions, but in process_measurement().  There it is a part of a
> > compound "if" statement.  Perhaps it would be ok to change it for just
> > the IMA_CHANGE_XATTR test, but definitely not for the other conditions,
> > like untrusted mounts.
> 
> Ok. Should I include this change in this patch or in a separate patch?
> 	
> > Moving ima_reset_appraise_flags() to the post hooks is to minimize
> > resetting the flags unnecessarily.  That is really a performance fix,
> > not something necessary for making the EVM portable & immutable
> > signatures more usable.  As much as possible, please minimize the
> > changes to facilitate review and testing.
> 
> Ok.

I'm really sorry, but the more I'm looking at the patch set, the more
I'm realizing that a number of the changes are a result of this
"performance improvement".   Without this change, reviewing the code
would be simplified.  So yes, the patch set needs to be updated to
reflect only what is needed to support making EVM portable & immutable
signatures more usable.

thanks,

Mimi

