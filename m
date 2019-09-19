Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E64B8781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404637AbfISWjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 18:39:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389100AbfISWjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:39:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JMdHlA067687;
        Thu, 19 Sep 2019 22:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=99zjAnXqySXwxr0uYe+uqDwcIA/v1Abq/AHqzl4pTOU=;
 b=aH2dN4O6DZeftOBMhuBwyP6LW5GPLV4H0pnhOFLWZWHhj7/EZtZQ+T4eDGvm6nJ4yPc5
 ZwT86U3I3336JpCx+jpQB/v4uwH0KVbjUGjNNhH4SLwKGUkBN8MlRik0GXaeQ7ZPFZK0
 3W3WlSv+YJgsfUBw8zAaQ1ZKR8zTCxRiXgLEFkDTg/W2X3+58tSf9jhEdw6NmPZAaAem
 nOqu5Je191RDVWnPRkch1CZeBwyf6BO+w7igcKLjlFCMeH6dV0ZZdziD3O0R1YY/DmOa
 hTscxlz8rA/87JiR28d0EZNdaZgRaF5S06pTAewWTBSajxL6G8wLpOhJDQuG4YNouDll bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v3vb4pvge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 22:39:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JMdCKJ147967;
        Thu, 19 Sep 2019 22:39:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2v4g2u8445-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 22:39:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8JMdgK7013986;
        Thu, 19 Sep 2019 22:39:42 GMT
Received: from localhost (/10.145.179.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 15:39:42 -0700
Date:   Thu, 19 Sep 2019 15:39:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20190919223941.GO5340@magnolia>
References: <20190829161155.GA5360@magnolia>
 <20190830210603.GB5340@magnolia>
 <20190905034244.GL5340@magnolia>
 <CAHpGcM+iYfqniKugC-enWnx+S3KT=8-YtY9RRcr4bVhG8GtkOA@mail.gmail.com>
 <20190917164605.GM5340@magnolia>
 <CAHpGcMKfiygNKD0s2MMyQnkKu+0GVANCejVpNESspTszeUy4Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKfiygNKD0s2MMyQnkKu+0GVANCejVpNESspTszeUy4Tw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190190
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 07:00:15PM +0200, Andreas Grünbacher wrote:
> Am Di., 17. Sept. 2019 um 18:46 Uhr schrieb Darrick J. Wong
> <darrick.wong@oracle.com>:
> > > Is this going to go in via the xfs tree?
> >
> > I'll let it soak in -next for a few days and send a single-patch pull
> > request for it.
> >
> > (I'm sending out pull requests today for the things that have been
> > ready to go for the last couple of weeks.)
> 
> Okay, works for me.

Heh, syzbot found a bug[1] in this patch, so I'm withdrawing it for now.

--D

[1] https://lore.kernel.org/linux-fsdevel/20190919211013.GN5340@magnolia/T/

> Thanks,
> Andreas
