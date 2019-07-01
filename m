Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69B65C196
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfGARCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfGARCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnUCw089727;
        Mon, 1 Jul 2019 17:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=3LYFHyCpICUHxeSxhEs+F2NKe4AZz9fjPXhjw5GzcjY=;
 b=P2Z2QZQp6fsdWgGX3mG/dQe+qt30fH03zLnoRmR5fPU/IvX8FdXtJx8XAXtlkRQSNPCb
 eq8DpNYdIfAyDFMfdq1Fk9xGqti9IbJv0oFctAvcXZalKoXUk/oi/nnojvc4q8UzXHHv
 P8ar+bCci3IbvBwW/TihLqn8GmQrvGyjD61rPeT6ocgdU3wb4DHCNstG6fm1AFgJL1gl
 9nvyTJOxIBu/w60bgaSYQjPCHOIeVcahFG2ZaMmIZCYHxSWkWwKsGOZA1EQxJ7oxHNyS
 7/hkJM5yLlFA1oXf7mmibQQ3hh7E+9nlu8dBAb8VhYL9KfUCMEgQaWXlH8yO33h65FEW uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbevef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmLUk080110;
        Mon, 1 Jul 2019 17:02:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tebak9p89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61H20gs001410;
        Mon, 1 Jul 2019 17:02:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:00 -0700
Subject: [PATCH RFC 00/11] iomap: regroup code by functional area
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:01:59 -0700
Message-ID: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=707
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series breaks up fs/iomap.c by grouping the functions by major
functional area (swapfiles, fiemap, seek hole/data, directio, buffered
writes, buffered reads, page management, and page migration) in separate
source code files under fs/iomap/.  No functional changes have been
made.

Note that this is not the final format of the patches, because I intend
to pick a point towards the end of the merge window (after everyone
else's merges have landed), rebase this series atop that, and push it
back to Linus.  The RFC is posted so that everyone can provide feedback
on the grouping strategy, not line-specific code movements.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D
