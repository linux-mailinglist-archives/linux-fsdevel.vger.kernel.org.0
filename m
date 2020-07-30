Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E992330CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 13:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgG3LNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 07:13:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44214 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG3LNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:13:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UB6tcI130925;
        Thu, 30 Jul 2020 11:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YsQkXRLkmGYEVr03Tuj+SbGjYBA/aaol6l5jtVzpjMA=;
 b=U2wKHsGbgQSUFrVA4GPbBcZOnpTXbQTG073NAprRQR2kKP1ZKSRgv3E0QLrUcjVJJALQ
 cFDZm0tg8hIOGmpQhl244RZvHKEKYr4Aun4udrSCvBi18iCnxEbP0XbHXXBKG3Excdu6
 8YAAl4adWoj1RNxzLQiOPJokZlDS32OGAgp84TuFI47TMun1wdx1MNmqFWnDmiZmqX8M
 5GxU9PoPc4WjwXE2rLEcVL37qp35T8m3587DG4c3UuD2FG169X9vQmQj6Hw+rGb8J0qS
 7nvk8O0d0q22hqfUSO9+RvihLX3OEJZOYvlThdNWXDTQaXcGrosEFVNdcrDGPlQ6Gdre zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1jk2st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 11:13:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UBDR26149977;
        Thu, 30 Jul 2020 11:13:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu5wh0dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 11:13:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UBDi0v027256;
        Thu, 30 Jul 2020 11:13:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 04:13:44 -0700
Date:   Thu, 30 Jul 2020 14:13:39 +0300
From:   <dan.carpenter@oracle.com>
To:     <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fsnotify: pass dir and inode arguments to fsnotify()
Message-ID: <20200730111339.GA54272@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=676 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=688 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300082
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir Goldstein,

This is a semi-automatic email about new static checker warnings.

The patch 40a100d3adc1: "fsnotify: pass dir and inode arguments to
fsnotify()" from Jul 22, 2020, leads to the following Smatch
complaint:

    fs/notify/fsnotify.c:460 fsnotify()
    warn: variable dereferenced before check 'inode' (see line 449)

fs/notify/fsnotify.c
   448		}
   449		sb = inode->i_sb;
                     ^^^^^^^^^^^
New dreference.

   450	
   451		/*
   452		 * Optimization: srcu_read_lock() has a memory barrier which can
   453		 * be expensive.  It protects walking the *_fsnotify_marks lists.
   454		 * However, if we do not walk the lists, we do not have to do
   455		 * SRCU because we have no references to any objects and do not
   456		 * need SRCU to keep them "alive".
   457		 */
   458		if (!sb->s_fsnotify_marks &&
   459		    (!mnt || !mnt->mnt_fsnotify_marks) &&
   460		    (!inode || !inode->i_fsnotify_marks) &&
                     ^^^^^^
Check too late.  Presumably this check can be removed?

   461		    (!child || !child->i_fsnotify_marks))
   462			return 0;

regards,
dan carpenter
