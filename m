Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C983C194
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfFKD3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 23:29:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39764 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbfFKD3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:29:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B3Saoi128547;
        Tue, 11 Jun 2019 03:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1ZrnmwAZMwf7yVrJ6H2vQT5nz7XKRKDkWftJBAoXNTk=;
 b=YEzplyH+yeq8DAFFJDKCkNGxoA2VlqCsjYLGCEIkXVhfq7GJziiuBftrXS5spbHf4+op
 TNcwZuW1DR6YjLuc6u7MDM/7KOPcpwngpoedrdikT2s7WUF5YokX5OG9NOcmTs7n6G2C
 Ky//2CBYA9A4oUyDPYmNioHrWy7qgJ+2J398HoODybvfzRC75V2CKlJPpZXfU0UOu8uz
 C+7dfJwoS8cxO5vpOBf63gZin9cxS2MSUKAj3YuPmjSCzdASz76x0wcgTaKofvYuh5YA
 XnnixYmzoNp110iPX9bKioEVePmtHD3pgA49HO0uJ3Wsl93l9PCU2xmOER7W1RnApIQg 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02hejhu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 03:29:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B3Spvr099895;
        Tue, 11 Jun 2019 03:29:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jph74n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 03:29:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B3TSjp010593;
        Tue, 11 Jun 2019 03:29:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 20:29:28 -0700
Date:   Mon, 10 Jun 2019 20:29:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH] vfs: allow copy_file_range from a swapfile
Message-ID: <20190611032926.GA1872778@magnolia>
References: <20190610172606.4119-1-amir73il@gmail.com>
 <20190611011612.GQ1871505@magnolia>
 <20190611025108.GB2774@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611025108.GB2774@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110022
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:51:08PM -0400, Theodore Ts'o wrote:
> On Mon, Jun 10, 2019 at 06:16:12PM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 10, 2019 at 08:26:06PM +0300, Amir Goldstein wrote:
> > > read(2) is allowed from a swapfile, so copy_file_range(2) should
> > > be allowed as well.
> > > 
> > > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > > Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > > 
> > > Darrick,
> > > 
> > > This fixes the generic/554 issue reported by Ted.
> > 
> > Frankly I think we should go the other way -- non-root doesn't get to
> > copy from or read from swap files.
> 
> The issue is that without this patch, *root* doesn't get to copy from
> swap files.  Non-root shouldn't have access via Unix permissions.  We

I'm not sure even root should have that privilege - it's a swap file,
and until you swapoff, it's owned by the kernel and we shouldn't let
backup programs copy your swapped out credit card numbers onto tape.

> could add a special case if we don't trust system administrators to be
> able to set the Unix permissions correctly, I suppose, but we don't do
> that for block devices when they are mounted....

...and administrators often mkfs over mounted filesystems because we let
them read and write block devices.  Granted I tried to fix that once and
LVM totally stopped working...

--D

> 
> 					- Ted
