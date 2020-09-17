Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5326E824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIQWTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:19:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:19:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HMJ2VC131566;
        Thu, 17 Sep 2020 22:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RUEE1gdARxSd8TLKFRIs3ndOmPAr4ZKel97nw+RPwJM=;
 b=K3zvi+KuVfbFuBqN+Gfl8KU0HDG27V5ZTPOFdbX2O2b8q+JKQIj/tukic9oNphrt1hAb
 GAO8IgAh1dDpnKNKmf6qMzK12U8EnBzrvvyhKLVW4uCLDopCU/KXTI+UJb+UxiHvvOva
 0M6RQrhk3HzsGCfi52OoQ3nKcB/EdhTMgfX31uTcjecFWCNCn5QNhoDlB/i3hFTxX0QQ
 vQX5nfPOblo+bpHgSEue0x2ZhhQZ0aIjtD95kbgR/06U/3p2RdLCC4xxFy+df3VagSQx
 71Qx9lkLQS9aqd4xmu0CCNyJ/7vnTPDkFgKO1dzywKAFztPYDeS5fP8DdPoO85vD+OBe BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33gp9mm15q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 22:19:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM05kk102004;
        Thu, 17 Sep 2020 22:19:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33khpnr2mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 22:19:01 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08HMJ0kd019685;
        Thu, 17 Sep 2020 22:19:00 GMT
Received: from localhost (/10.159.155.161)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 22:18:59 +0000
Date:   Thu, 17 Sep 2020 15:18:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200917221858.GH7964@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-10-willy@infradead.org>
 <20200917220500.GR7955@magnolia>
 <20200917221115.GY5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917221115.GY5449@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170163
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:11:15PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 17, 2020 at 03:05:00PM -0700, Darrick J. Wong wrote:
> > > -static loff_t
> > > -iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
> > > -		void *data, struct iomap *iomap, struct iomap *srcmap)
> > > +static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
> > > +		loff_t length, void *data, struct iomap *iomap,
> > 
> > Any reason not to change @length and the return value to s64?
> 
> Because it's an actor, passed to iomap_apply, so its types have to match.
> I can change that, but it'll be a separate patch series.

Ah, right.  I seemingly forgot that. :(

Carry on.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D
