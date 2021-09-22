Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893EE41413B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 07:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhIVFa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 01:30:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231896AbhIVFa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:30:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M4xd5T032721;
        Wed, 22 Sep 2021 01:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=47nIbvR+LFyg6zGGaJMRcbkXTukftCGHc5HemEoOdkw=;
 b=qWBSaiqES+nHVYbcQqkLt6utuvDfWRhD6JM9O0GKlSZVbYi/xiBLs97pvI6jUukJMtqA
 Ij5avpxVNEae4qu3Apbxk/b809acpTReFZeok/5ISrfhGvdkXBarVxro1ZP49NTfwO6n
 xi4F3q08cukjtsrBujA6VW47JbX5AvsTk9yx2EstCVVzF7kh1d5QHWzeYIiV9H+zfIpX
 KGeb9t9tWMC62OzOLdOQBT+dzkyZsXsRKX1Qd2veH2sTsawUzjBYpszv4XuLKAvqTyEe
 ZTy4K+H8RgXuTh7PcrbZSz7xd5UII+zuTuuc3f4PIShILl+lsDjacF3fGYROzcerfJVS bg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b7wxw0jaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 01:28:25 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18M5N6dp012809;
        Wed, 22 Sep 2021 05:28:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3b7q69t6ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:28:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18M5SK1Y42992012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 05:28:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A6BA405D;
        Wed, 22 Sep 2021 05:28:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D813A4040;
        Wed, 22 Sep 2021 05:28:19 +0000 (GMT)
Received: from localhost (unknown [9.43.105.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Sep 2021 05:28:19 +0000 (GMT)
Date:   Wed, 22 Sep 2021 10:58:18 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, jane.chu@oracle.com,
        linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <20210922052818.rszl76zkmx2tbgu2@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
 <20210921004431.GO1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921004431.GO1756565@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vkVkkma6gF4He-fsjlrIMC2Ekg4QstdM
X-Proofpoint-ORIG-GUID: vkVkkma6gF4He-fsjlrIMC2Ekg4QstdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220033
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/21 10:44AM, Dave Chinner wrote:
> On Fri, Sep 17, 2021 at 06:31:01PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add a new mode to fallocate to zero-initialize all the storage backing a
> > file.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/open.c                   |    5 +++++
> >  include/linux/falloc.h      |    1 +
> >  include/uapi/linux/falloc.h |    9 +++++++++
> >  3 files changed, 15 insertions(+)
> >
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index daa324606a41..230220b8f67a 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >  	    (mode & ~FALLOC_FL_INSERT_RANGE))
> >  		return -EINVAL;
> >
> > +	/* Zeroinit should only be used by itself and keep size must be set. */
> > +	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
> > +	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
> > +		return -EINVAL;
> > +
> >  	/* Unshare range should only be used with allocate mode. */
> >  	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
> >  	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > index f3f0b97b1675..4597b416667b 100644
> > --- a/include/linux/falloc.h
> > +++ b/include/linux/falloc.h
> > @@ -29,6 +29,7 @@ struct space_resv {
> >  					 FALLOC_FL_PUNCH_HOLE |		\
> >  					 FALLOC_FL_COLLAPSE_RANGE |	\
> >  					 FALLOC_FL_ZERO_RANGE |		\
> > +					 FALLOC_FL_ZEROINIT_RANGE |	\
> >  					 FALLOC_FL_INSERT_RANGE |	\
> >  					 FALLOC_FL_UNSHARE_RANGE)
> >
> > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > index 51398fa57f6c..8144403b6102 100644
> > --- a/include/uapi/linux/falloc.h
> > +++ b/include/uapi/linux/falloc.h
> > @@ -77,4 +77,13 @@
> >   */
> >  #define FALLOC_FL_UNSHARE_RANGE		0x40
> >
> > +/*
> > + * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
> > + * writing zeros to it.  Subsequent read and writes should not fail due to any
> > + * previous media errors.  Blocks must be not be shared or require copy on
> > + * write.  Holes and unwritten extents are left untouched.  This mode must be
> > + * used with FALLOC_FL_KEEP_SIZE.
> > + */
> > +#define FALLOC_FL_ZEROINIT_RANGE	0x80
>
> Hmmmm.
>
> I think this wants to be a behavioural modifier for existing
> operations rather than an operation unto itself. i.e. similar to how
> KEEP_SIZE modifies ALLOC behaviour but doesn't fundamentally alter
> the guarantees ALLOC provides userspace.
>
> In this case, the change of behaviour over ZERO_RANGE is that we
> want physical zeros to be written instead of the filesystem
> optimising away the physical zeros by manipulating the layout
> of the file.
>
> There's been requests in the past for a way to make ALLOC also
> behave like this - in the case that users want fully allocated space
> to be preallocated so their applications don't take unwritten extent
> conversion penalties on first writes. Databases are an example here,
> where setup of a new WAL file isn't performance critical, but writes
> to the WAL are and the WAL files are write-once. Hence they always
> take unwritten conversion penalties and the only way around that is
> to physically zero the files before use...
>
> So it seems to me what we actually need here is a "write zeroes"
> modifier to fallocate() operations to tell the filesystem that the
> application really wants it to write zeroes over that range, not
> just guarantee space has been physically allocated....
>
> Then we have and API that looks like:
>
> 	ALLOC		- allocate space efficiently
> 	ALLOC | INIT	- allocate space by writing zeros to it
> 	ZERO		- zero data and preallocate space efficiently
> 	ZERO | INIT	- zero range by writing zeros to it
>
> Which seems to cater for all the cases I know of where physically
> writing zeros instead of allocating unwritten extents is the
> preferred behaviour of fallocate()....
>

If that's the case we can just have FALLOC_FL_ZEROWRITE_RANGE?
Where FALLOC_FL_ZERO_RANGE & FALLOC_FL_ZEROWRITE_RANGE are mutually exclusive.

AFAIU,
/* FALLOC_FL_ZERO_RANGE may optimize the underlying blocks with unwritten
 * extents if the filesystem allows so, but with FALLOC_FL_ZEROWRITE_RANGE,
 * the underlying blocks are guranteed to be written with zeros.
 * In case of hole it will be preallocated with written extents and will be
 * initialized with zeroes. If FALLOC_FL_KEEP_SIZE is specified then the
 * inode size will remain the same.
 *
 * Essentially similar to FALLOC_FL_ZERO_RANGE but with gurantees that
 * underlying storage has written extents initialized with zeroes.
 */
#define FALLOC_FL_ZEROWRITE_RANGE		0x80

Does that make sense?

-ritesh
