Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF2426B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfFLMw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 08:52:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbfFLMw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:52:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CCqkAs059930
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 08:52:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t313ft3mm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 08:52:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 13:51:55 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 13:51:52 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CCppLb34603156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 12:51:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C7254C04A;
        Wed, 12 Jun 2019 12:51:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EB904C040;
        Wed, 12 Jun 2019 12:51:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.218])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jun 2019 12:51:50 +0000 (GMT)
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date:   Wed, 12 Jun 2019 08:51:39 -0400
In-Reply-To: <20190608135717.8472-2-amir73il@gmail.com>
References: <20190608135717.8472-1-amir73il@gmail.com>
         <20190608135717.8472-2-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061212-0008-0000-0000-000002F31C46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061212-0009-0000-0000-000022601DF8
Message-Id: <1560343899.4578.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=707 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2019-06-08 at 16:57 +0300, Amir Goldstein wrote:
> Count struct files open RO together with inode reference count instead
> of using a dedicated i_readcount field.  This will allow us to use the
> RO count also when CONFIG_IMA is not defined and will reduce the size of
> struct inode for 32bit archs when CONFIG_IMA is defined.
> 
> We need this RO count for posix leases code, which currently naively
> checks i_count and d_count in an inaccurate manner.
> 
> Should regular i_count overflow into RO count bias by struct files
> opened for write, it's not a big deal, as we mostly need the RO count
> to be reliable when the first writer comes along.

"i_count" has been defined forever.  Has its meaning changed?  This
patch implies that "i_readcount" was never really needed.

Mimi

> 
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fs.h                | 33 +++++++++++++++++++------------
>  security/integrity/ima/ima_main.c |  2 +-
>  2 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f7fdfe93e25d..504bf17967dd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -694,9 +694,6 @@ struct inode {
>  	atomic_t		i_count;
>  	atomic_t		i_dio_count;
>  	atomic_t		i_writecount;
> -#ifdef CONFIG_IMA
> -	atomic_t		i_readcount; /* struct files open RO */
> -#endif
>  	union {
>  		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
>  		void (*free_inode)(struct inode *);
> @@ -2890,26 +2887,36 @@ static inline bool inode_is_open_for_write(const struct inode *inode)
>  	return atomic_read(&inode->i_writecount) > 0;
>  }
>  
> -#ifdef CONFIG_IMA
> +/*
> + * Count struct files open RO together with inode rerefernce count.
> + * We need this count for IMA and for posix leases. The RO count should not
> + * include files opened RDWR nor files opened O_PATH and internal kernel
> + * inode references, like the ones taken by overlayfs and inotify.
> + * Should regular i_count overflow into I_RO_COUNT_BIAS by struct files
> + * opened for write, it's not a big deal, as we mostly need
> + * inode_is_open_rdonly() to be reliable when the first writer comes along.
> + */
> +#define I_RO_COUNT_SHIFT 10
> +#define I_RO_COUNT_BIAS	(1UL << I_RO_COUNT_SHIFT)
> +
>  static inline void i_readcount_dec(struct inode *inode)
>  {
> -	BUG_ON(!atomic_read(&inode->i_readcount));
> -	atomic_dec(&inode->i_readcount);
> +	WARN_ON(atomic_read(&inode->i_count) < I_RO_COUNT_BIAS);
> +	atomic_sub(I_RO_COUNT_BIAS, &inode->i_count);
>  }
>  static inline void i_readcount_inc(struct inode *inode)
>  {
> -	atomic_inc(&inode->i_readcount);
> +	atomic_add(I_RO_COUNT_BIAS, &inode->i_count);
>  }
> -#else
> -static inline void i_readcount_dec(struct inode *inode)
> +static inline int i_readcount_read(const struct inode *inode)
>  {
> -	return;
> +	return atomic_read(&inode->i_count) >> I_RO_COUNT_SHIFT;
>  }
> -static inline void i_readcount_inc(struct inode *inode)
> +static inline bool inode_is_open_rdonly(const struct inode *inode)
>  {
> -	return;
> +	return atomic_read(&inode->i_count) > I_RO_COUNT_BIAS;
>  }
> -#endif
> +
>  extern int do_pipe_flags(int *, int);
>  
>  #define __kernel_read_file_id(id) \
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..766bac778d11 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -94,7 +94,7 @@ static void ima_rdwr_violation_check(struct file *file,
>  	bool send_tomtou = false, send_writers = false;
>  
>  	if (mode & FMODE_WRITE) {
> -		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
> +		if (inode_is_open_rdonly(inode) && IS_IMA(inode)) {
>  			if (!iint)
>  				iint = integrity_iint_find(inode);
>  			/* IMA_MEASURE is set from reader side */

