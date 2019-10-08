Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BECCFD47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfJHPNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:13:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJHPNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:13:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FBmOO083559;
        Tue, 8 Oct 2019 15:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=68SBRTzfcPv/q/TZxoO50lTVRZcj/rpk3BTPijLLZXA=;
 b=mQ75tPNTTBITRe5gTTmblil96ATwPitGDAhoHo1i2K2cyAB8DVpmXrVxKfSNg+ro+YCA
 9IJIqCncjNiQegI3sbFnPXBVW4dfAIiZD7hqifpGSl+9YCcpP05HDtVfUBJFCJPhNC8V
 aDSPT5Qdnk4YPD/eMweHLNAMhDbcAqCgQR17O4U0315qYjuhNnzvlGKX+QrXwCaY41qo
 SD0Nv2BiQBC7Q0hEwEN618D8fI8UfYJkWP7qoF9bsCVCbG2+VRgw1taoBUELMino6kYz
 66uKiMMdDUxdzU0IJh4daSvtuqTf+XRlxxNVdrR2le/AJ/TL0viLpmnZ4MluySeihXrn DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qdxm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:12:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98F97o8001699;
        Tue, 8 Oct 2019 15:12:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vgefasedj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:12:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98FCrgn020460;
        Tue, 8 Oct 2019 15:12:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 15:12:52 +0000
Date:   Tue, 8 Oct 2019 08:12:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/19] iomap: use write_begin to read pages to unshare
Message-ID: <20191008151251.GA13098@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-7-hch@lst.de>
 <20190916183428.GK2229799@magnolia>
 <20190930110731.GA6987@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930110731.GA6987@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 30, 2019 at 01:07:31PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 11:34:28AM -0700, Darrick J. Wong wrote:
> > > -		if ((from <= poff || from >= poff + plen) &&
> > > +		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
> > 
> > Mmm, archeology of code that I wrote originally and have forgotten
> > already... :)
> > 
> > I think the purpose of F_UNSHARE is to mimic the behavior of the code
> > that's being removed, and the old behavior is that if a user asks to
> > unshare a page backed by shared extents we'll read in all the blocks
> > backing the page, even if that means reading in blocks that weren't part
> > of the original unshare request, right?
> 
> No.  The flag causes the code to always read the page, even if the iomap
> range covers the whole block.  For normal writes that means we don't to
> read the block in at all, but for unshare we absolutely must do so.

Ahhh, right.  Missed that.  I'll go RVB the v2 patch now.

--D
