Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00844A9781
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 11:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358183AbiBDKL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 05:11:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229626AbiBDKL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:11:57 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2149jJ5t021994;
        Fri, 4 Feb 2022 10:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vhyi4FQa7M/IzVHtdVSl2k9Hm+sa4T48Jp4pvuXqwbY=;
 b=H3HgsawuhfWbxCbVrISDgs9EbTLl8aeWZ00BOC3bOQz4523VK+m2+8op/YqR+GVOiydN
 7ifTEADRoaWqQKmQqzT7xUzOZasqxAonrpiYjf+m/JQXYkyRPAszfIULZg2N068uJgxK
 37FTstXE203XY681N8MCgdDiSGSCzWmy88vYVwPJ5XLEnW7raHjx3ez+JY8TeOX/gsub
 wXWJlDVZuzOcfnjDx1SI6FtXzqAnMSdfR9BHbmJcT17MM0Gq1sMUu8LQdC7oFewyH2kO
 pWLMFJIM2vsVTqHTCMv77iypD5xq0grC/8cjGQ/clukKqgt0bEv/FxY6ZE/l/wzydCf8 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrnvkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:11:53 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214A5xcn006942;
        Fri, 4 Feb 2022 10:11:53 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrnvk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:11:53 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214A5SH1006513;
        Fri, 4 Feb 2022 10:11:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3e0r0ybb0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 10:11:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214ABnQ234013568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 10:11:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD344C052;
        Fri,  4 Feb 2022 10:11:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7916E4C04E;
        Fri,  4 Feb 2022 10:11:48 +0000 (GMT)
Received: from localhost (unknown [9.43.61.133])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 10:11:48 +0000 (GMT)
Date:   Fri, 4 Feb 2022 15:41:47 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 6/6] ext4: Add extra check in ext4_mb_mark_bb() to prevent
 against possible corruption
Message-ID: <20220204101147.5ph7o4hnxyd6iz35@riteshh-domain>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <fa6d3adad7e1a4691c4c38b6b670d9330757ce82.1643642105.git.riteshh@linux.ibm.com>
 <20220201114719.dzyeitz26kpde5zf@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201114719.dzyeitz26kpde5zf@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lFtRUCkT465FLWKBrShzXFFiVVZWSr5B
X-Proofpoint-ORIG-GUID: 5uOaLjHYHoM11imOrtZsBfyGDaq4P1XE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=613 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/02/01 12:47PM, Jan Kara wrote:
> On Mon 31-01-22 20:46:55, Ritesh Harjani wrote:
> > This patch adds an extra checks in ext4_mb_mark_bb() function
> > to make sure we mark & report error if we were to mark/clear any
> > of the critical FS metadata specific bitmaps (&bail out) to prevent
> > from any accidental corruption.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Again please rather use ext4_inode_block_valid() here. All the callers of
> ext4_mb_mark_bb() have the information available.
>

Same reason here too, since we are already aware of the block group these blocks
belong too, does it make any sense to check against the system-zone in that
case?

-ritesh


> 								Honza
>
> > ---
> >  fs/ext4/mballoc.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 5f20e355d08c..c94888534caa 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -3920,6 +3920,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> >  		len -= overflow;
> >  	}
> >
> > +	if (!ext4_group_block_valid(sb, group, block, len)) {
> > +		ext4_error(sb, "Marking blocks in system zone - "
> > +			   "Block = %llu, len = %d", block, len);
> > +		bitmap_bh = NULL;
> > +		goto out_err;
> > +	}
> > +
> >  	clen = EXT4_NUM_B2C(sbi, len);
> >
> >  	bitmap_bh = ext4_read_block_bitmap(sb, group);
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
