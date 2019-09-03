Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8904A5FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 05:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfICDhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 23:37:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfICDhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:37:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x833ZY17129753;
        Tue, 3 Sep 2019 03:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=50XNFIb8h061K6T8DCq0QS3N4O01GqXcj1NG5px4GVs=;
 b=GUTJYJUMoXH4BodIu3KX9fib8fpg3gxsyf9V2USXVqY3SVW/2wlzZNZrX4b5RycCiOve
 45X1cQsj4YeB+NWl/98FZgjCe2cK4obGBuwQ0te1uX3wLpywVcxML2nA18JnaCRr/QAY
 BiF8job8ePXLmK3l0IJfLJRm6XjDLiloenNPfHi6ty/FWNmtvdGxp2TkmxzacRo/Wls/
 N8qHZixz/AyDdkMsXOFioHFbn7p+WvH37WwDJ7MLR+XSSHiE6NeLVW1fzvMkeiLtPHfp
 LfV1+b8en1uQSLlxh5Q7USh49OvEGkOx+x2oHedzztRcAkJL3h9BSmss+ekpHFeLhB1w dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2usgdg0086-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 03:37:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8338FIS044496;
        Tue, 3 Sep 2019 03:18:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uryv60nce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 03:18:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x833IhfI026999;
        Tue, 3 Sep 2019 03:18:43 GMT
Received: from localhost (/10.159.255.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 20:18:42 -0700
Date:   Mon, 2 Sep 2019 20:18:43 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190903031843.GC5340@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-3-rgoldwyn@suse.de>
 <20190902163104.GB6263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902163104.GB6263@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030037
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 06:31:04PM +0200, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 03:08:23PM -0500, Goldwyn Rodrigues wrote:
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -37,6 +37,7 @@ struct vm_fault;
> >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
> 
> I don't think IOMAP_COW can be a type - it is a flag given that we
> can do COW operations that allocate normal written extents (e.g. for
> direct I/O or DAX) and for delayed allocations.

If iomap_apply always zeros out @srcmap before calling ->iomap_begin, do
we even need a flag/type code?  Or does it suffice to check that
srcmap.length > 0 and use it appropriately?

--D
