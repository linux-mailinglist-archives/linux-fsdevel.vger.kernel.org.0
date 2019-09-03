Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB6A6C04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfICO4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:56:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICO4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:56:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83ErpU0139258;
        Tue, 3 Sep 2019 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=J1/XR8SIYBwnS7qUVqN/+gnZ5pU/aly9Tp9KElNL18w=;
 b=Mx6msCtHFfoUOOGoKlGXGLohgPLtb4ZK4CjhKxFiEv21aYyvEOZC1qBY0PGo0F9guLtt
 0VM6LuSK2oycz7w6vKlwh1jDJ/VxgFaUpNjH9Pf1TY1TxOue5/y3rDDf2haBPo0iMtGs
 pT8r+IXITq06LUxYUd2hVfuTWckjNz+dvhtf4TWVlODYG5yXpRENcCd5rmC1p5Q6SkkJ
 eisutsMvgEfWVq25uf/76ePEvD2sc9DUR8l4I3/qg6cCo7edKsJ2RtclM62zNpOtkTHB
 KZy7y6/4qu49XKqbCda4CXfB9jqwgXx2gRQOiKW4LBR6VY7Qk+eyKEx6ky5WnllhmTIg PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ussxpr6ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:56:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83ErWH6088076;
        Tue, 3 Sep 2019 14:56:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2us4we0507-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:56:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Euf4V023738;
        Tue, 3 Sep 2019 14:56:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 07:56:41 -0700
Date:   Tue, 3 Sep 2019 07:56:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com,
        riteshh@linux.ibm.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190903145644.GE5340@magnolia>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
 <20190901200836.14959-3-rgoldwyn@suse.de>
 <20190902163104.GB6263@lst.de>
 <20190903140536.5ak7phk5oydkqmx2@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903140536.5ak7phk5oydkqmx2@fiona>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:05:36AM -0500, Goldwyn Rodrigues wrote:
> On 18:31 02/09, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 03:08:23PM -0500, Goldwyn Rodrigues wrote:
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -37,6 +37,7 @@ struct vm_fault;
> > >  #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
> > >  #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
> > >  #define IOMAP_INLINE	0x05	/* data inline in the inode */
> > > +#define IOMAP_COW	0x06	/* copy data from srcmap before writing */
> > 
> > I don't think IOMAP_COW can be a type - it is a flag given that we
> > can do COW operations that allocate normal written extents (e.g. for
> > direct I/O or DAX) and for delayed allocations.
> > 
> 
> Ah.. we have come a full circle on this one. From going to a flag, to a type,
> and now back to flag. Personally, I like COW to be a flag, because we are
> doing a write, just doining extra steps which should be a flag.
> From previous objections, using two iomaps should help the cause and we
> can not worry about bloating.

Heh, ok, let's do a cow flag.  Thank you for driving the consensus. :)

(Sorry it took so long while we went around in circles.)

Also, I'm going on vacation starting Friday at noon PDT, so please have
the three patches that touch fs/iomap/ in before 7am Friday.  (Assuming
you're not making drastic changes to your iomap changes, they've tested
ok so far.)

--D

> 
> -- 
> Goldwyn
