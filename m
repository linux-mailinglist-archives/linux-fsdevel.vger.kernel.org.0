Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286A9AAF17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 01:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbfIEXYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 19:24:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfIEXYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:24:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85NOdLd126107;
        Thu, 5 Sep 2019 23:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=buSpWDUaplHizgDq0mCXybaUt8lWPA8Hkv8MkXf08zM=;
 b=OBm/NEGMan/kO3vxVIu4nsIJ37DeTPgevElrsVjpPlGnhXGZmHKZy1nEpSh8J52AvouD
 Qh+PJRWSvX7tSdvY+kfstNJMfg5B76lszWhqcrAzN72PX3+CKHUvFH7LM/ZA+n9fvf7R
 Uo2z/okFkkGKNu251o1js8LkgOETu5DGyVWedrSAYKzM6R7TQ7NWryNxwSjbLRTYOvvb
 STdvPi8hoz9+uBJUcZfbr341kbfQbPOA+IcYtnUELfij7VhyWfIshjycKhljUaebrK7j
 +uIOryt2mIh8PFxeQ1Q6IdkZirfNEmL5SJpRP7yAokpRZnkqnTD92Omwff0h2fpkqF5J jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uuc0k0015-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 23:24:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85NObl6063202;
        Thu, 5 Sep 2019 23:24:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uthq296cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Sep 2019 23:24:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x85NOSNL030398;
        Thu, 5 Sep 2019 23:24:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 16:24:27 -0700
Date:   Thu, 5 Sep 2019 16:24:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 11/15] iomap: use a function pointer for dio submits
Message-ID: <20190905232424.GK2229799@magnolia>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
 <20190905150650.21089-12-rgoldwyn@suse.de>
 <20190905162721.GC22450@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905162721.GC22450@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050217
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=862 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050217
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 06:27:21PM +0200, Christoph Hellwig wrote:
> > +	if (dio->dops && dio->dops->submit_io) {
> > +		dio->dops->submit_io(bio, file_inode(dio->iocb->ki_filp),
> > +				pos);
> 
> pos would still fit on the previously line as-is.
> 
> > +		dio->submit.cookie = BLK_QC_T_NONE;
> 
> But I think you should return the cookie from the submit function for
> completeness, even if btrfs would currently always return BLK_QC_T_NONE.

Yeah, that looked funny to me too.

--D
