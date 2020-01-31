Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8954B14E862
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaFZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:25:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaFZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:25:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V5Nhg1016118;
        Fri, 31 Jan 2020 05:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Q8K46XY2SN8n0jr4TVed23P9qDKr7ITh1g9zSWQV5Nk=;
 b=UWuN5mffDwa+mn/g1u3Bp18Zd8IjyvUJb4X3V/uYbFbanNeYjPWNz7hmQuUzArd0W6dw
 B26ZEDJkLmSzb+GAxy7k/ooH2GJCep6RtV8/jZI8xwBsVCzVTSW9i29xRYSz5rC40f9g
 HF7PQkE/1mglNJdV8rR9d4sU9RSizrY9LcB0bZAMySwRenzRjwGN8Gped8XCJt6MRTFc
 P7/3dGoYIqPS4y9kf4U6lrHZYh6afjHvo0WivPCFpX06TMBMNnVEF1mDBEVj6cE/n8g9
 RewHdyUZ05g4B/N++rKaxfcYR6oAOvm1N1mX6dRCbkMkUYH835dVYw7KfIx/n5BKHW4Z JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xrd3ur60t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:25:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V5NJ8Z127896;
        Fri, 31 Jan 2020 05:25:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xva6pqak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 05:25:22 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00V5PLjv028148;
        Fri, 31 Jan 2020 05:25:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 21:25:21 -0800
Date:   Thu, 30 Jan 2020 21:25:20 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
Message-ID: <20200131052520.GC6869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

I would like to discuss how to improve the process of shepherding code
into the kernel to make it more enjoyable for maintainers, reviewers,
and code authors.  Here is a brief summary of how we got here:

Years ago, XFS had one maintainer tending to all four key git repos
(kernel, userspace, documentation, testing).  Like most subsystems, the
maintainer did a lot of review and porting code between the kernel and
userspace, though with help from others.

It turns out that this didn't scale very well, so we split the
responsibilities into three maintainers.  Like most subsystems, the
maintainers still did a lot of review and porting work, though with help
from others.

It turns out that this system doesn't scale very well either.  Even with
three maintainers sharing access to the git trees and working together
to get reviews done, mailing list traffic has been trending upwards for
years, and we still can't keep up.  I fear that many maintainers are
burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
testing of the git trees, but keeping up with the mail and the reviews.

So what do we do about this?  I think we (the XFS project, anyway)
should increase the amount of organizing in our review process.  For
large patchsets, I would like to improve informal communication about
who the author might like to have conduct a review, who might be
interested in conducting a review, estimates of how much time a reviewer
has to spend on a patchset, and of course, feedback about how it went.
This of course is to lay the groundwork for making a case to our bosses
for growing our community, allocating time for reviews and for growing
our skills as reviewers.

---

I want to spend the time between right now and whenever this discussion
happens to make a list of everything that works and that could be made
better about our development process.

I want to spend five minutes at the start of the discussion to
acknowledge everyone's feelings around that list that we will have
compiled.

Then I want to spend the rest of the session breaking up the problems
into small enough pieces to solve, discussing solutions to those
problems, and (ideally) pushing towards a consensus on what series of
small adjustments we can make to arrive at something that works better
for everyone.

--D
