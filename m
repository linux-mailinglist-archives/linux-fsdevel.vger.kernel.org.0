Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89847556F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbfFYSSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 14:18:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfFYSSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:18:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PI4epq154535;
        Tue, 25 Jun 2019 18:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lmgK8Cm3Fl3Y68PjHL3I/TBSUBy/0hTgnkbGgtqK7rI=;
 b=sq8wRGFMDp2keeCzfEbQvRF23m4FZdHqzF6KTStnvsnqKgYJRFIybtKXIRJ/BkjACsOp
 VHjdfFdvkzl4/Qyds9SgcqVsToxzG/t5q2X6QJw92ykC0hsb2bCu0+1HnE8/vR1cKWgj
 9LAuCEvVM/6Q8BB9oO+b2Er0NdC/PFqDczBk7D1I2Io7k9QsIy4cloHAf7QWxHhbVscL
 fa9qlI7JJ3E8N38P1RnUBSFFAK1Ox9ur0vfVe7sOoxdIUQu71AdGqU2biDBGiUMsl2PB
 KOtGcPBYzfwUGEHU5Q7xPZKcvd0Ct/iT3yoSupbQ+ljJ3hcRKX4C0zF8TH1T/hnyBICA pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brt63t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 18:17:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PIHUke113170;
        Tue, 25 Jun 2019 18:17:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2t9acc8wvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jun 2019 18:17:38 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5PIHcHG113583;
        Tue, 25 Jun 2019 18:17:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acc8wve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 18:17:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PIHai8000391;
        Tue, 25 Jun 2019 18:17:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 11:17:36 -0700
Date:   Tue, 25 Jun 2019 11:17:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     dsterba@suse.cz, matthew.garrett@nebula.com, yuchao0@huawei.com,
        tytso@mit.edu, shaggy@kernel.org, ard.biesheuvel@linaro.org,
        josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
        jk@ozlabs.org, jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org,
        viro@zeniv.linux.org.uk, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, linux-efi@vger.kernel.org,
        Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] vfs: create a generic checking function for
 FS_IOC_SETFLAGS
Message-ID: <20190625181733.GG5375@magnolia>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
 <156116138140.1664814.9610454726122206157.stgit@magnolia>
 <20190625171254.GT8917@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625171254.GT8917@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:12:54PM +0200, David Sterba wrote:
> On Fri, Jun 21, 2019 at 04:56:21PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Create a generic checking function for the incoming FS_IOC_SETFLAGS flag
> > values so that we can standardize the implementations that follow ext4's
> > flag values.
> 
> I checked a few samples what's the type of the flags, there are unsigned
> types while the proposed VFS functions take signed type.
> 
> > +int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags);
> 
> Specifically ext4 uses unsigned type and his was the original API that
> got copied so I'd think that it should unsigned everywhere.

Yeah, I'll change it.

> >  fs/btrfs/ioctl.c    |   13 +++++--------
> 
> For the btrfs bits
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> and besides the signedness, the rest of the changes look good to me.

Thanks for the look around!  I'll have a new revision with all changes
out by the end of the day. :)

--D
