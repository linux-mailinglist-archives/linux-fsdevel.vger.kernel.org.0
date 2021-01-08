Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0802EF7EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 20:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbhAHTKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 14:10:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33240 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAHTKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:10:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108J52fv008954;
        Fri, 8 Jan 2021 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mM6AT4VIgyY77kqNzTjiuApzWT+pAy7YDdIiGpktXDY=;
 b=NUGl9vvCjI+srkXa647I47YdrcKV2Ohfi8KN8TwzR3PkJyYM8+ogxpVnJ2Vb3puq6ggm
 IZuQSXVkttwfPd+9bwh0Ip5NzH4c3cVtIEGb39a3Djzt9bSTJOt3iIJnUKq8+oFPC6NA
 0rIlcKB4tUTvuZhsNhdRiEQqW3LksF1gGN8M7ZW8Iu5gvQn9bHJZCNPvYSzcfJKGntqH
 9Vxu01RchOtrRygQDQFoyBP30dNwcqJKCHjPr8JfbiAaYDT9jlkKf8PYAEYPn9ZIlNZL
 6IEHavuS77KAZU4aMx20TZu/QV9eP4l7wl+DAMCD44jJr5H/85TCcjCu+nm7cT1fGmZ1 Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35wcuy2ve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 19:09:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108J4Xsu055993;
        Fri, 8 Jan 2021 19:09:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 35w3qvtm49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 19:09:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 108J9C96013451;
        Fri, 8 Jan 2021 19:09:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 19:09:12 +0000
Date:   Fri, 8 Jan 2021 11:09:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, song@kernel.org,
        rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH 02/10] blk: Introduce ->corrupted_range() for block device
Message-ID: <20210108190910.GR6918@magnolia>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-3-ruansy.fnst@cn.fujitsu.com>
 <20210108095500.GA5647@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108095500.GA5647@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080102
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:55:00AM +0100, Christoph Hellwig wrote:
> It happens on a dax_device.  We should not interwind dax and block_device
> even more after a lot of good work has happened to detangle them.

I agree that the dax device should not be implied from the block device,
but what happens if regular block device drivers grow the ability to
(say) perform a background integrity scan and want to ->corrupted_range?

--D
