Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DA9A8DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfIDRqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 13:46:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42952 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDRqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:46:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84HjXS0167122;
        Wed, 4 Sep 2019 17:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=m1xb93kdFsK6mm3L3edDblCpTmvsIqxTLcRfkK3xq/8=;
 b=sZTJnGzfeX9NqJJNVnouW2ubwAIgGt2MapsgJ4Y1B1OGatmZZrmjjGsP8amBYCNp/4VG
 tC5/cMZQ0sI+S9K9zJJokNxeLflv7y7VraAYzQ6HUN9IIaIb617eGwRRa1WAQLEgW10P
 5Q68yubVTxC075kx7W45LeHKPVl+CvPx0svwK2l2WuqPA62Y4LZF+uBou4b303sFmN1s
 B4rJfwyYpbtBUyY82y9GpI1h5c19BNaBLq4M7BReBEh8ygk2Joop2/dpZxELk5yLTaZL
 L5VXnWDkHeSWF43ljTQ4kveJRAKHm2JyFFbaXiSuEJv3rVUQK51+eq/3rF27ZQFpVaV3 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uthxm003a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 17:45:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84Hhctw154778;
        Wed, 4 Sep 2019 17:45:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uthq0rggs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 17:45:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84HjlOx012901;
        Wed, 4 Sep 2019 17:45:49 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 10:45:47 -0700
Date:   Wed, 4 Sep 2019 10:45:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: iomap_dio_rw ->end_io improvements
Message-ID: <20190904174545.GJ5340@magnolia>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903221621.GH568270@magnolia>
 <20190904051229.GA9970@lst.de>
 <CAHc6FU42hsk9Ld7+mezh6Ba++5yvzJk30AyJzHOq3Ob7YASDgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU42hsk9Ld7+mezh6Ba++5yvzJk30AyJzHOq3Ob7YASDgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040177
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:46:23PM +0200, Andreas Gruenbacher wrote:
> On Wed, Sep 4, 2019 at 7:12 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Tue, Sep 03, 2019 at 03:16:21PM -0700, Darrick J. Wong wrote:
> > > The biggest problem with merging these patches (and while we're at it,
> > > Goldwyn's patch adding a srcmap parameter to ->iomap_begin) for 5.4 is
> > > that they'll break whatever Andreas and Damien have been preparing for
> > > gfs2 and zonefs (respectively) based off the iomap-writeback work branch
> > > that I created off of 5.3-rc2 a month ago.
> >
> > Does Andreas have changes pending that actually pass an end_io call
> > back to gfs2?  So far it just passed NULL so nothing should change.
> 
> Right, we don't currently use that and there's nothing in queue in
> that direction.

Ok, sounds good.  I'll pull these two changes into the iomap tree for
5.4 then.

--D

> Andreas
