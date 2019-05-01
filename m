Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA21090F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEAOZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:25:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfEAOZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:25:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EMBgU067191
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:25:22 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7ayan1fa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:25:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:25:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:25:16 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EPFKk55181526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:25:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09E815204E;
        Wed,  1 May 2019 14:25:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07DC652057;
        Wed,  1 May 2019 14:25:12 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 11/13] ext4: Compute logical block and the page range to be encrypted
Date:   Wed, 01 May 2019 19:41:49 +0530
Organization: IBM
In-Reply-To: <20190430170151.GB48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-12-chandan@linux.ibm.com> <20190430170151.GB48973@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050114-0008-0000-0000-000002E23AB1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-0009-0000-0000-0000224EA5BD
Message-Id: <12288535.bgPuNnGEdQ@localhost.localdomain>
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

On Tuesday, April 30, 2019 10:31:51 PM IST Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 10:01:19AM +0530, Chandan Rajendra wrote:
> > For subpage-sized blocks, the initial logical block number mapped by a
> > page can be different from page->index. Hence this commit adds code to
> > compute the first logical block mapped by the page and also the page
> > range to be encrypted.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/ext4/page-io.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > index 3e9298e6a705..75485ee9e800 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -418,6 +418,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
> >  {
> >  	struct page *data_page = NULL;
> >  	struct inode *inode = page->mapping->host;
> > +	u64 page_blk;
> >  	unsigned block_start;
> >  	struct buffer_head *bh, *head;
> >  	int ret = 0;
> > @@ -478,10 +479,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
> >  
> >  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
> >  		gfp_t gfp_flags = GFP_NOFS;
> > +		unsigned int page_bytes;
> > +
> 
> page_blk should be declared here, just after page_bytes.
> 
> > +		page_bytes = round_up(len, i_blocksize(inode));
> > +		page_blk = page->index << (PAGE_SHIFT - inode->i_blkbits);
> 
> Although block numbers are 32-bit in ext4, if you're going to make 'page_blk' a
> u64 anyway, then for consistency page->index should be cast to u64 here.
> 
> >  
> >  	retry_encrypt:
> > -		data_page = fscrypt_encrypt_page(inode, page, PAGE_SIZE, 0,
> > -						page->index, gfp_flags);
> > +		data_page = fscrypt_encrypt_page(inode, page, page_bytes, 0,
> > +						page_blk, gfp_flags);
> >  		if (IS_ERR(data_page)) {
> >  			ret = PTR_ERR(data_page);
> >  			if (ret == -ENOMEM && wbc->sync_mode == WB_SYNC_ALL) {
> 
> 

I will implement the changes that have been suggested here.

-- 
chandan



