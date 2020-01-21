Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4362B143710
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 07:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgAUGWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 01:22:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58894 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUGWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:22:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L6MZk2169427;
        Tue, 21 Jan 2020 06:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=1cdQIGHfAh492cGv7CI32nA7YsPURlgoMllb9U8eMSA=;
 b=aVRX4e44M8DuSg/z8t4Dl3MlvyCGLubBkffX5bvjenU8iJMBNCCBxuKxEypp1ZA6AkBC
 9X8YakN6sE8DaG6jFy3fK9nx/GJEMrmSo0OZtYgmm7YGBPYPSVzANees3dlCeMrATp4j
 mVjOPlunkdnzH7mDeAFk04Jh9x5ZG3Nzio7NaJD9tL83PGyhl+CbIXs2okh+129SYGdW
 6U/OnibN1c2d24sIK/w/HvR9f8URhEZVZiCDeKzEGgAPLTNsuqj1ZbWIcgeJM56wTJGL
 S7zZt6nisZ1Cx32BexKun3XpVOTIlq3KbUcXI5+VNFgfvqjDUSYtkS0SExCaU/Dpgzbq oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseuaxpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:22:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L6962o101674;
        Tue, 21 Jan 2020 06:20:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xnpebpsjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:20:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00L6KWMl024939;
        Tue, 21 Jan 2020 06:20:33 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 22:20:32 -0800
Date:   Tue, 21 Jan 2020 09:20:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     damien.lemoal@wdc.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fs: New zonefs file system
Message-ID: <20200121062025.gqkfye2wbk6la7wr@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=510
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=571 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Damien Le Moal,

The patch 5bba4a0d475a: "fs: New zonefs file system" from Dec 25,
2019, leads to the following static checker warning:

	fs/zonefs/super.c:218 zonefs_inode_setattr()
	error: should you be using S_ISDIR()

fs/zonefs/super.c
   208  static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
   209  {
   210          struct inode *inode = d_inode(dentry);
   211          int ret;
   212  
   213          ret = setattr_prepare(dentry, iattr);
   214          if (ret)
   215                  return ret;
   216  
   217          /* Files and sub-directories cannot be created or deleted */
   218          if ((iattr->ia_valid & ATTR_MODE) && (inode->i_mode & S_IFDIR) &&
                                                      ^^^^^^^^^^^^^^^^^^^^^^^
TBH, I don't know what the rules are with these.

   219              (iattr->ia_mode & 0222))
   220                  return -EPERM;
   221  
   222          if (((iattr->ia_valid & ATTR_UID) &&
   223               !uid_eq(iattr->ia_uid, inode->i_uid)) ||
   224              ((iattr->ia_valid & ATTR_GID) &&
   225               !gid_eq(iattr->ia_gid, inode->i_gid))) {
   226                  ret = dquot_transfer(inode, iattr);

regards,
dan carpenter
