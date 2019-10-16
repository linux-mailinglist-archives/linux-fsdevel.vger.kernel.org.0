Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82329D9997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436630AbfJPSxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 14:53:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38134 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfJPSxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:53:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GIiNf4158572;
        Wed, 16 Oct 2019 18:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=Ww+MEhgd1n8SK/eJ/tLOJgaby8Gm0ozgCCBhIm1/XXo=;
 b=HygNcgc6e+O9RysYQNx5eE8iiSkhEg5gK8Hd/fIeo9s0ETjOxqyDNDflPxLFCeruSuhj
 EqMpqoOhS5cT900Vyc7IOVwU6h+vdDKV+egLDfStbDQjVoZ5cEqsmF47gRaZ7m+1IVut
 c3rPIdXQgVqpJYAbU4Hiklpf9mOSoHEzgCJ+yMRjq4Z4WnqITBg3N41Y5BTCL9bbD/BX
 f2qwBdtokPMvGKLa4qMCs64j+OTxFc8MJijQ4xi+ZM9Qx+xiFX/IaJ2cWeVyhaizbf0S
 hQyJymqLcvMGydEO5qt7dcyHsR8T5Vx2dPt3BOE27fa5wZnxtG7DgEW3329DVmqoGM0M 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frgyke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 18:52:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GImC7C135674;
        Wed, 16 Oct 2019 18:52:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vnf7twh7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 18:52:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GIqtHI023586;
        Wed, 16 Oct 2019 18:52:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 18:52:55 +0000
Date:   Wed, 16 Oct 2019 11:52:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v3] splice: only read in as much information as there is
 pipe buffer space
Message-ID: <20191016185254.GH13098@magnolia>
References: <20191014220940.GF13098@magnolia>
 <20191016184549.GB720@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016184549.GB720@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:45:49AM -0700, Eric Biggers wrote:
> On Mon, Oct 14, 2019 at 03:09:40PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Andreas Grünbacher reports that on the two filesystems that support
> > iomap directio, it's possible for splice() to return -EAGAIN (instead of
> > a short splice) if the pipe being written to has less space available in
> > its pipe buffers than the length supplied by the calling process.
> > 
> > Months ago we fixed splice_direct_to_actor to clamp the length of the
> > read request to the size of the splice pipe.  Do the same to do_splice.
> > 
> > Fixes: 17614445576b6 ("splice: don't read more than available pipe space")
> > Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com
> 
> I already invalidated this syzbot report when the previous version of this patch
> was dropped, as that was what the report appeared to be for.  So you don't need
> this Reported-by line.  It's not a big deal, but including it could mislead
> people into thinking that syzbot found a problem with the commit in the Fixes:
> line, rather than a prior version of this patch.

Ok, will drop for v4.  Thanks for taking care of the report.

--D

> - Eric
