Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB547F50BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 17:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfKHQLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 11:11:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHQLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:11:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8G9FRo111108;
        Fri, 8 Nov 2019 16:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1EwJvm5NkxfeRU6BPf21P6axBzeFqCLtrq5RsUar2/0=;
 b=iXwrFQBwPZE47FeKyoC8yNcWJYFi/r72uoLc6wfXwkkqGHRlqJp0I4gF78cksoHt93JT
 m+Rob1hAXw8kADsEKebqeGm8aVqsCXxeXg5JxDldTDacW1WINE8pRsIhZnwp1x2njN5W
 pqCMKQPDQ0K5DXjhBb9I/hWsaxNBSONZyWTZThSiPV47MX8grN6n35sGoOwDKYCnsSXL
 xePdb3p/M/7eupCyfmW4tWOUppcWUy8oDIZno5NfopO4yRfDIg/i0UN67QaZ7G+8sMCM
 BwcfQhdP7eGGvRp5Qznndl6U8WGNKmP0F8Diqr8xylj1in9lPggCKqcsYkxuBOkhXTzm tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w41w168jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 16:11:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8G4PYa001761;
        Fri, 8 Nov 2019 16:11:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w50m5k2vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 16:11:29 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA8GBPoY010043;
        Fri, 8 Nov 2019 16:11:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 08:11:24 -0800
Date:   Fri, 8 Nov 2019 08:11:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap_bmap should check iomap_apply return value
Message-ID: <20191108161123.GC6211@magnolia>
References: <20191107025927.GA6219@magnolia>
 <20191107083050.GB9802@lst.de>
 <20191107153617.GB6219@magnolia>
 <20191108055151.GA30144@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108055151.GA30144@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080161
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 08, 2019 at 06:51:51AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 07, 2019 at 07:36:17AM -0800, Darrick J. Wong wrote:
> > On Thu, Nov 07, 2019 at 09:30:50AM +0100, Christoph Hellwig wrote:
> > > On Wed, Nov 06, 2019 at 06:59:27PM -0800, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > > 
> > > > Check the return value of iomap_apply and return 0 (i.e. error) if it
> > > > didn't succeed.
> > > 
> > > And how could we set the bno value if we didn't succeed?
> > 
> > The iomap_bmap caller supplies an ->iomap_end that returns an error.
> > 
> > Granted there's only one caller and it doesn't, so we could dump this
> > patch and just tell Coverity to shut up, but it's odd that this is the
> > one place where we ignore the return value.
> > 
> > OTOH it's bmap which has been broken for ages; the more insane behavior
> > seen in the wild, the better to scare away users. :P
> 
> Oh well.  I guess the patch is fine, it just isn't really needed as-is.

Thanks for the review. :)

--D

> Reviewed-by: Christoph Hellwig <hch@lst.de>
