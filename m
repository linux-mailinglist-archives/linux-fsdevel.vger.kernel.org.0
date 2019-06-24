Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F02518C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfFXQiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:38:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50640 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfFXQiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:38:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OGYBIm140014;
        Mon, 24 Jun 2019 16:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HA99AMTfTSc28plQQ/cp41x7Nn4dwb3FKNRresvoez8=;
 b=Val/xFIcmXfnvXdGrQBd2uUMZYObEi3W8WIlY6oMUJIKvjldL9xYJIbr4X8m/8PfUkNP
 RhH7NFaRejnXOwK4OrHcHI49LEDw30Z0srM0V+BtgIV6OV/ooJ8YuV1XwJC9gXt//xWz
 Q0bSRiqdmELhNdVSkCIZr87TrKLwiGMPLZJNCBd7weSod/LyeYSIITLeuy/oyb0/36Pk
 joZS32wTTBm4Xftsq9fhk9nHXmjGPPxMMMzommCPqRpU1cRv8ZoyAI6/8dXnLZ2krssP
 nfR6QpxDK+AWnV/OvlFkpdglsTrJTTQAP82qwXJGdU82OAjIBZeAn2VIxNce6Btsj8Q4 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyq7dxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:36:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OGZS5o040090;
        Mon, 24 Jun 2019 16:36:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2t9acbktrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 16:36:51 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5OGaodY042889;
        Mon, 24 Jun 2019 16:36:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acbktr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:36:50 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OGaiFC016783;
        Mon, 24 Jun 2019 16:36:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 09:36:44 -0700
Date:   Mon, 24 Jun 2019 09:36:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] vfs: flush and wait for io when setting the
 immutable flag via SETFLAGS
Message-ID: <20190624163642.GT5387@magnolia>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
 <20190624153358.GH32376@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624153358.GH32376@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=682 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:33:58PM +0200, Jan Kara wrote:
> On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
> > +/*
> > + * Flush file data before changing attributes.  Caller must hold any locks
> > + * required to prevent further writes to this file until we're done setting
> > + * flags.
> > + */
> > +static inline int inode_flush_data(struct inode *inode)
> > +{
> > +	inode_dio_wait(inode);
> > +	return filemap_write_and_wait(inode->i_mapping);
> > +}
> 
> BTW, how about calling this function inode_drain_writes() instead? The
> 'flush_data' part is more a detail of implementation of write draining than
> what we need to do to set immutable flag.

Ok, that's a much better description of what the function does.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
