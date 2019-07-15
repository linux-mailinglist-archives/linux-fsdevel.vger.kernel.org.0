Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B110C69A51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfGOR7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 13:59:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41834 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfGOR7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:59:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHxMLO143446;
        Mon, 15 Jul 2019 17:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=LqM6x+JiqNEld0a0hrOy16yec3T6/nrylzk/ojFP3eE=;
 b=HL1rZUCt/7CQK6p6gfIcYEEPs63ZWVG5mZ3Gv+5ZJBJoSv+UbxYo7mo0DiQHfuhwPjAV
 e4XEjq061D/b4sdvviskqby7ZdsRhJjtrEbEPlujUBNTdMTf4A1CCUTyTk7zsF5Z1dFA
 kRRB9sy/XEeodi8YQJEGrAjjG3BSyOnyFFp+/bwj01RC1RvFNUCZgPKfu1qwDKS/QtFo
 X4rdoH40kmeGNrgFpjtNoyjUT1AeLVEt0ic/qqigs9P3UxjO8kwxT0x6uPrGJmFqig3S
 0ifUUoCRKE2afmrxhM3wSnbftuDtCMacdN6Lb8OJuS0V8yISeCCOOwkDGsx4e+VFm5Eu ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtg4tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:59:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHwTko186905;
        Mon, 15 Jul 2019 17:59:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4dtf0ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:59:22 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FHxLtM009992;
        Mon, 15 Jul 2019 17:59:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 10:59:21 -0700
Subject: [PATCH v2 0/9] iomap: regroup code by functional area
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Mon, 15 Jul 2019 10:59:20 -0700
Message-ID: <156321356040.148361.7463881761568794395.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=407
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=460 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150209
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This series breaks up fs/iomap.c by grouping the functions by major
functional area (swapfiles, fiemap, seek hole/data, directio, buffered
io, and page migration) in separate source code files under fs/iomap/.
No functional changes have been made.  Please check the copyrights to
make sure the attribution is correct.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D
