Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6010904
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEAOYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:24:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726779AbfEAOYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:24:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EMCUM006550
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:24:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7cemhvgc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:24:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:24:36 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:24:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EOVGx38076636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:24:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D4652054;
        Wed,  1 May 2019 14:24:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C3E805204E;
        Wed,  1 May 2019 14:24:28 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        yuchao0@huawei.com, hch@infradead.org
Subject: Re: [PATCH V2 03/13] fsverity: Add call back to decide if verity check has to be performed
Date:   Wed, 01 May 2019 18:03:56 +0530
Organization: IBM
In-Reply-To: <20190430211037.GA30337@azazel.net>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-4-chandan@linux.ibm.com> <20190430211037.GA30337@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050114-0012-0000-0000-000003173D63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-0013-0000-0000-0000214FA97D
Message-Id: <1679959.ODoryAfBfi@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, May 1, 2019 2:40:38 AM IST Jeremy Sowden wrote:
> On 2019-04-28, at 10:01:11 +0530, Chandan Rajendra wrote:
> > Ext4 and F2FS store verity metadata in data extents (beyond
> > inode->i_size) associated with a file. But other filesystems might
> > choose alternative means to store verity metadata. Hence this commit
> > adds a callback function pointer to 'struct fsverity_operations' to
> > help in deciding if verity operation needs to performed against a
> > page-cache page holding file data.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/ext4/super.c          | 6 ++++++
> >  fs/f2fs/super.c          | 6 ++++++
> >  fs/read_callbacks.c      | 4 +++-
> >  include/linux/fsverity.h | 1 +
> >  4 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index aba724f82cc3..63d73b360f1d 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1428,10 +1428,16 @@ static struct page *ext4_read_verity_metadata_page(struct inode *inode,
> >  	return read_mapping_page(inode->i_mapping, index, NULL);
> >  }
> >  
> > +static bool ext4_verity_required(struct inode *inode, pgoff_t index)
> > +{
> > +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +}
> > +
> >  static const struct fsverity_operations ext4_verityops = {
> >  	.set_verity		= ext4_set_verity,
> >  	.get_metadata_end	= ext4_get_verity_metadata_end,
> >  	.read_metadata_page	= ext4_read_verity_metadata_page,
> > +	.verity_required	= ext4_verity_required,
> >  };
> >  #endif /* CONFIG_FS_VERITY */
> >  
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 2f75f06c784a..cd1299e1f92d 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2257,10 +2257,16 @@ static struct page *f2fs_read_verity_metadata_page(struct inode *inode,
> >  	return read_mapping_page(inode->i_mapping, index, NULL);
> >  }
> >  
> > +static bool f2fs_verity_required(struct inode *inode, pgoff_t index)
> > +{
> > +	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +}
> > +
> >  static const struct fsverity_operations f2fs_verityops = {
> >  	.set_verity		= f2fs_set_verity,
> >  	.get_metadata_end	= f2fs_get_verity_metadata_end,
> >  	.read_metadata_page	= f2fs_read_verity_metadata_page,
> > +	.verity_required	= f2fs_verity_required,
> >  };
> >  #endif /* CONFIG_FS_VERITY */
> >  
> > diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> > index b6d5b95e67d7..6dea54b0baa9 100644
> > --- a/fs/read_callbacks.c
> > +++ b/fs/read_callbacks.c
> > @@ -86,7 +86,9 @@ struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> >  		read_callbacks_steps |= 1 << STEP_DECRYPT;
> >  #ifdef CONFIG_FS_VERITY
> >  	if (inode->i_verity_info != NULL &&
> > -		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> > +		((inode->i_sb->s_vop->verity_required
> > +			&& inode->i_sb->s_vop->verity_required(inode, index))
> > +			|| (inode->i_sb->s_vop->verity_required == NULL)))
> 
> I think this is a bit easier to follow:
> 
> 		(inode->i_sb->s_vop->verity_required == NULL || 
> 			inode->i_sb->s_vop->verity_required(inode, index)))

Yes, you are right. I will implement the changes suggested by you.

-- 
chandan



