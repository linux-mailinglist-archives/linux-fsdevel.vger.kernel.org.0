Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986F9242721
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHLI7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 04:59:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgHLI7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:59:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07C8pwEP159483;
        Wed, 12 Aug 2020 08:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fX5Hq12QB3O54zKi56LfEX/5PhMYcRNizebtS1uhJZQ=;
 b=z95BENQnuCk+9ZFmipY4ugqKKVuN5wdZa3NCOnxx8GsoNTFsTNUGlUUwRGwlJl6oq0h0
 6DZY0KCiVtzVp/Q/gGx07HLD5UDiVXf6ffX80cbrR9My/cF85N9pfEpF4cbut05WaQy8
 5ISY+hiv86gIwjC0VbQaLZ2GKwrbQsvMxGCH2ETye018Y7Ln6V+GTtYi1XqwiZ3dFx25
 +uQzAO8NTZZxtcWvKzwvPN98rxrnnRyYhyADWJHtS8MfKQAWHZjDPE8AERycH92HoDZH
 z0RKErQKqsotkdHJk8ta3suUVlezia62jBO0WSSNFNnWp/RaH/qd/JYpIdgEtSH6gk2G iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32t2ydqunn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Aug 2020 08:59:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07C8rLm8092500;
        Wed, 12 Aug 2020 08:59:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32t5y6cah2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Aug 2020 08:59:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07C8xAgB015682;
        Wed, 12 Aug 2020 08:59:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Aug 2020 08:59:10 +0000
Date:   Wed, 12 Aug 2020 11:59:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812085904.GA16441@kadam>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812071306.GA869606@PWN>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008120064
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yeah, the patch doesn't work at all.  I looked at one call tree and it
is:

hfs_mdb_get() tries to allocate HFS_SB(sb)->ext_tree.

	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
                    ^^^^^^^^

hfs_btree_open() calls page = read_mapping_page(mapping, 0, NULL);
read_mapping_page() calls mapping->a_ops->readpage() which leads to
hfs_readpage() which leads to hfs_ext_read_extent() which calls
res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
                                         ^^^^^^^^

So we need ->ext_tree to be non-NULL before we can set ->ext_tree to be
non-NULL...  :/

I wonder how long this has been broken and if we should just delete the
AFS file system.

regards,
dan carpenter

