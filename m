Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2365BF3372
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 16:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfKGPg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 10:36:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKGPg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:36:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FYl5S101764;
        Thu, 7 Nov 2019 15:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YoXv0UfpzhTOjQMaQ++wZBs8wusJqaVStP5vlwP518k=;
 b=hKRjRz5sTKHQzwSDg0ED1qO9LYL6cbaohdF4rQYODu4+U5I7vfM0r3qsa+ropcmMNPb3
 AMRYDwoMGScNHtQrYnt9NThVv+nji7nNx24hvs71VyDafrMREUIQ18kixxqI9ODqRzO3
 YLzd6D1zSbZFL/PA4XoHs5DFyKtmFQBAoB67SHIKkJUxt4ZAbZLUNIWfpwbAsBOXS1h/
 CU5DA8UzJ/B6uqeXUSDQs91PtGJNboB4vmRxiLbA4KSPjye7rkZWmn/+RNZ55aj5ZyUB
 R/crCJ8fc9QB8uYQjEDlsYgb8kHbaHJYXi11at1kjVAJwr2yrZhMVre3LssW5QswiMrR CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2w41w17184-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 15:36:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7FZ0NZ195327;
        Thu, 7 Nov 2019 15:36:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w41whexmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 15:36:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7FaJfl012074;
        Thu, 7 Nov 2019 15:36:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 07:36:18 -0800
Date:   Thu, 7 Nov 2019 07:36:17 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_bmap should check iomap_apply return value
Message-ID: <20191107153617.GB6219@magnolia>
References: <20191107025927.GA6219@magnolia>
 <20191107083050.GB9802@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107083050.GB9802@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=900
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:30:50AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 06, 2019 at 06:59:27PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Check the return value of iomap_apply and return 0 (i.e. error) if it
> > didn't succeed.
> 
> And how could we set the bno value if we didn't succeed?

The iomap_bmap caller supplies an ->iomap_end that returns an error.

Granted there's only one caller and it doesn't, so we could dump this
patch and just tell Coverity to shut up, but it's odd that this is the
one place where we ignore the return value.

OTOH it's bmap which has been broken for ages; the more insane behavior
seen in the wild, the better to scare away users. :P

--D
