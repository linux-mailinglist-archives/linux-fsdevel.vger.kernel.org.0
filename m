Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD4A1143CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLEPjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:39:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45406 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:39:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5FbfXD095911;
        Thu, 5 Dec 2019 15:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=I9kmCuQ1AnhnmmiS+Ch9NTbdcya3JWLVHzv7+tUWclM=;
 b=RBJKuIcv+TVtWTBxx0SSXH+qVQCQ/gDyk5/iJlvih9brEScCIeBEqTP/9N+OMp/cFHfJ
 nlPvx03jQTizqkxab3lFPAcY8nqR6mB63Gzacwdm0e158aV8gbrzJHxaZoj9FgbMr1sf
 H82tm2K0fzXZBBhCbEF3ahkjPl+TOLraQfNWDwR4JSY4kmwmWS6dhK7k++LjDyiw6xrN
 NZsLMBoUnt/b9EdsRmB3z7acvEIN1NPFD8GJTDkX4dyOjg2doHckKi/v5PtcWGHfklJT
 RdCWof6II0UlNUE0+7YC+wNzCBJPohD+5NexTVF5hNV5MuKZDBr23As32k7prv02+IYZ Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wkgcqnx8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 15:39:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5Faq1d147819;
        Thu, 5 Dec 2019 15:39:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wptpvcvhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 15:39:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5FdjH9028372;
        Thu, 5 Dec 2019 15:39:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 07:39:45 -0800
Date:   Thu, 5 Dec 2019 07:39:44 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: stop using ioend after it's been freed in
 iomap_finish_ioend()
Message-ID: <20191205153944.GB13260@magnolia>
References: <20191205065132.21604-1-zlang@redhat.com>
 <20191205075235.GA21619@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205075235.GA21619@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=837
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=920 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:52:35PM -0800, Christoph Hellwig wrote:
> The code changes looks good, although we usually don't do that
> style of comment.  Otherwise looksgood:

I specifically requested it to avoid future maintainer fail. :)

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the reviews!

--D
