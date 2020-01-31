Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6613214E68F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 01:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAaAYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 19:24:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgAaAYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:24:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V0DS5n013696;
        Fri, 31 Jan 2020 00:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=PHHFJnHdUF//GSXlXFHlwA3WfQxHtImAPZuJXTssNqY=;
 b=hLxxiWGJC3dwuAiuoTgjziWsoLp4SKpihiHt838a3pqqhkX+rMJAlgdnjYfE08qXMUYx
 iYq9iUQ6JKHwpOOMtuC2omMkOgClGEoitfn4KYnftVN5EHJtwYTcuBKvP8Hz/DgQFHAG
 opeNs/Q7Wt6SJtuczal1KqIeKCI/jacPURHpvSqQ0DWw37PWiy/MuSNGz0cDZrO3p9w5
 GUXNu5p0xTH1iJWG9DMh6UwUIn3i1UsV3ZkO17iUkfczGdwzbQTZCxDJ5wsuVGvVv2ue
 b4zTZqyD4Cn3XWY+z8IuAQj0GCEFVlxcLQVOM5b3Vjl+hVkh9UZj7iwtqp2zly8WKNiN Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3uqg27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 00:24:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V0DvoF091397;
        Fri, 31 Jan 2020 00:24:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xv8npk8r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 00:24:36 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00V0OZLD009238;
        Fri, 31 Jan 2020 00:24:35 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 16:24:34 -0800
Date:   Thu, 30 Jan 2020 16:24:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] shrinker changes for non-blocking inode reclaim
Message-ID: <20200131002432.GA6874@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Dave Chinner sent a big long patchset[1] that changes the behavior of mm
shrinker which will make it easier for us to make reclaim of xfs inodes
not block on IO.  I don't want to lead this discussion and nominate Dave
to do so, but if he cannot make it to LSF then I will take over.

---

In a nutshell, we actually can make XFS inode reclaim mostly nonblocking
right now by shifting responsibility for doing one last flush of the
ondisk metadata to the XFS log.  After that, memory reclaim "merely" has
to poke the log ... but doing this naïvely causes IO storms issued from
log pokes started during direct reclaim.  Shifting that to kswapd
results in unnecessary OOMs in direct reclaim because we failed to free
enough resources even though we're on our way to being able to free
resources.

What we need are some fairly minor changes to how the shrinkers work --
first, XFS needs to be able to communicate to a caller of its shrinker
that we freed X items, but we can free another Y items from another
context (e.g. kswapd).  Second, we need a way to actually do that work
from a less-restrictive context (kswapd) and to have direct reclaim
throttle itself if kswapd is busy actually doing the work that it can't
do.  Third, we need to teach kswapd how to discover that we're running
IO as fast as we can and that it needs to wait a little while to let us
catch up.

So the question(s) are: What do people think of these changes to
shrinker behavior?  Are they acceptable to the mm and fs communities?
If so, how do we stage these changes in tandem with the XFS changes so
that we can commit these new features and a user of them in the same
kernel cycle?

--D

[1] https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/
