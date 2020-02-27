Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9055172A34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgB0Vdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:33:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0Vdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:33:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLMmiZ030019;
        Thu, 27 Feb 2020 21:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=26vP5yqSHUgG0Uo9ubIi3AuFzWFw+pcCN2GIKW+ya98=;
 b=vJ5jiJr4gw5mgi8EBHIfXBIvvScf2HTA7sucQRgyk30vUw5mHKrxrqcSO0iPwU8nVCIx
 UaRzwnaTeTR64PZBsSUMKOi8PIQ3tPIvZQy/x805fp+NRW0U15Lj/7kEmRJAm7M77KuX
 YmOH3oAIS5eisCl/aTxDeHgL5lrKvqZvC4lU+6vEU8TXr2U8tfbCJz+d32ZY3h226N5K
 t1kZ4m9UEMgKw4SrejQvDoqM0I8r4IK6twEwjR1BJTytjLu3KZh6fM6AdjW/81TMCWCt
 95U7fcLZbAYI1CqohTdP9XKRUTeKA43sWgSA9w5PbzXLxM2DExNYDueWR15walx6+zNy bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct3ds4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RLIEDZ167823;
        Thu, 27 Feb 2020 21:33:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ydj4nnqvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 21:33:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RLXaGL010885;
        Thu, 27 Feb 2020 21:33:36 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 13:33:36 -0800
Subject: [PATCH RFC 0/3] fs: online filesystem uuid operations
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 27 Feb 2020 13:33:35 -0800
Message-ID: <158283921562.904118.13877489081184026686.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=1
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patch series creates a couple of new ioctls to query and set the
filesystem uuid of mounted filesystems.  This is apparently desirous for
some cloud providers who wish to be able to deploy pre-baked rootfs
images to a machine, boot it, and have the client machine be able to
change the label and uuid to reflect that it's now derivative of the
original image.

For ext4 this is pretty easy to do as all the pieces are already in
place.  For XFS this is a little more difficult because we need to get
our house in order w.r.t. dependencies between the log uuid and
filesystem superblock uuid, which means that this is really new ext4
functionality that I'd like to share with the other filesystems.

I'm particularly curious to hear what people think about the
FORCE_INCOMPAT flag.  There are some circumstances (namely when the
entire fs metadata is keyed to a certain uuid) where we can only change
the uuid by turning on an incompat feature flag.  The currently running
kernel should be able to handle that just fine, but older kernels won't
be able to mount the fs after that.  We (XFS) normally don't do things
like that, which is why I require positive affirmation from userspace
that doing so is ok.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D
