Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB004BF661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfIZQEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 12:04:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfIZQEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:04:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QFsFND171931;
        Thu, 26 Sep 2019 16:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=gdTkC2ATMKRJXLTLxlLJahE5tTU+YeW8OmIosbjjRqc=;
 b=Ih2qtoZqg8UjnDER3bCzXyBjATU7HP4ZrwqbVC9QUGyrPAjoEbQsQSBqqS0XBnd8MRoo
 oZLeWnuR/lvUHxHLGMZXc2UcOfBT0qT170KCwJ3076urmVcL1QV2uRqVhbSNUFNc//3Q
 SVwZ7/GGAZQBo3UkaHp/MY/7ayNg2eg73FAG6LsTa7LnXuNFruXuV5HFfrTkhIZAfwL9
 IdSdYy0mbxMifIV2yWloa+BwyicP8gl5ehlYIUfA6AeLmuHBYZK0akJ83VbY3i+FUkU6
 XT63GDr4eVPnLYjuZ5WvqH1fw1lxK92tTJwxlL/PkfR3vOh71NAo1omFVDkhJ9yWDSMl rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v5b9u4us1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 16:04:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QFsVc7028002;
        Thu, 26 Sep 2019 16:04:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v82tneajr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 16:04:37 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8QG4X2J026163;
        Thu, 26 Sep 2019 16:04:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 09:04:33 -0700
Date:   Thu, 26 Sep 2019 09:04:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
Message-ID: <20190926160432.GC9916@magnolia>
References: <20190926155608.GC23296@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926155608.GC23296@dell5510>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> Hi Amir,
> 
> I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?
> 
> * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
> * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

I'm not Amir, but by my recollection, yes, those are intentional. :)

--D

> Thanks for info.
> 
> Kind regards,
> Petr
