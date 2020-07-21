Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF76228319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgGUPFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 11:05:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47962 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:05:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LF1HDL009115;
        Tue, 21 Jul 2020 15:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JBvyVnS9yNS9WGW4ZkUnv+XIT9x73e1vnw654HyBDF8=;
 b=G71SURUOV+c37MjYx55xoyJQZi5k7zjD4FiNSNvmYqimvwtZ5y8ntwXhceXUIl4+/ZHt
 lwgofgiPvc1zVA8t8pnCE2F45tuyGk7+4L4363PfjzZzPdcpw7yEe7GgxsdIPLtNByeb
 U8Eohc6Mn99aZ2TvaqEsaLyo+dPFfv/LmyOjNN5Sgrbsmhx2JFiERu5TZjnO/jw436OK
 LpAt8M8cW9cYWU/Jc2zrkk1dZimr5SYP4g0Od2XxuJGnjDZ/8wKAFpdYT3adn8k0sW6X
 wcb+hossGKdfkVe8zmEW0QdLbTAnrPelw9MIv/2JVL19Lt5unrUCvDVfV4uWZo60yiZx ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32d6ksj1dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:04:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LEvxTQ041630;
        Tue, 21 Jul 2020 15:04:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32dw48yjn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:04:52 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06LExkt6031795;
        Tue, 21 Jul 2020 14:59:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 07:59:46 -0700
Date:   Tue, 21 Jul 2020 07:59:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721145939.GZ3151642@magnolia>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721145313.GA9217@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210110
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:53:13PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 04:51:25PM -0500, Goldwyn Rodrigues wrote:
> > Hi Christoph,
> > 
> > On  9:46 13/07, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series has two parts:  the first one picks up Dave's patch to avoid
> > > invalidation entierly for reads, picked up deep down from the btrfs iomap
> > > thread.  The second one falls back to buffered writes if invalidation fails
> > > instead of leaving a stale cache around.  Let me know what you think about
> > > this approch.
> > 
> > Which kernel version are these changes expected?
> > btrfs dio switch to iomap depends on this.
> 
> No idea.  Darrick, are you ok with picking this up soon so that
> Goldwyn can pull it in?

Yes; I was nearly about to ping you to see if you were going to have
time to push out a corrected patch 2 in time for ... 5.9?  5.10?

--D
