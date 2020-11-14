Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7D22B2A25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKNAuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 19:50:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:50:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AE0XQrc080903;
        Sat, 14 Nov 2020 00:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mHBeexTDuhQKt/eKiIryiY6f75xw9tq2bK3L1Hi9/Gc=;
 b=XEP0g9p9zUf+/7t0EE9rvQcT8NxSht4NsuZ9OBup6c3sogFLAu9oK+i8zHxbVgVYb7rx
 kjHAQ1DkGkernEAP3HkWDQxgMHQjDhyln3ru0sOBW870BTL+7CR5jwDAwmCg4aOiPAlO
 4gzsxfCmjy5E4v1TjlQXdiJ0Lk12b9VWFz9QfPqlLJCSgkqvOoL+6UJHW/CWCn7H4w3E
 YxxtcFwa6GpscED3BT0h0H8qZ1sIyDj84SW5oHbb2saekk7Y2PCjAqlbuYTXjsAR+Hyr
 QmlTdpwznKVMniTy4BZqyj52RPc5eH2RdoW2BrdtziAuSL/fQ3KCOk7kfKbMiTx/Y/FV kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72f2ykw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 14 Nov 2020 00:49:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AE0ZO30107334;
        Sat, 14 Nov 2020 00:49:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34p55u0efs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Nov 2020 00:49:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AE0ngWm030587;
        Sat, 14 Nov 2020 00:49:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 16:49:42 -0800
Date:   Fri, 13 Nov 2020 16:49:41 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [GIT PULL] vfs: fs freeze fix for 5.10-rc4
Message-ID: <20201114004941.GF9699@magnolia>
References: <20201113233847.GG9685@magnolia>
 <CAHk-=whvWbFBr-W8FvAT1_ekuzWk=q_g+6+_h2ChycsW8dMhmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvWbFBr-W8FvAT1_ekuzWk=q_g+6+_h2ChycsW8dMhmw@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011140001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011140001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:13:37PM -0800, Linus Torvalds wrote:
> On Fri, Nov 13, 2020 at 3:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Since the hack is unnecessary and causes thread race errors, just get
> > rid of it completely.  Pushing this kind of vfs change midway through a
> > cycle makes me nervous, but a large enough number of the usual
> > VFS/ext4/XFS/btrfs suspects have said this looks good and solves a real
> > problem vector, so I'm sending this for your consideration instead of
> > holding off until 5.11.
> 
> Not a fan of the timing, but you make a good argument, and I love
> seeing code removal. So I took it.

Thanks!  Admittedly this is super late because it didn't occur to me
until after -rc1 that the periodic hangs I saw in for-next were related
to lockdep being broken and weren't some other weird vfs/xfs breakage;
and then I wanted to spin this patch through my internal testing systems
for a week to convince myself that changing the freeze locking code
wasn't totally nuts. :)

--D

> And once I took the real code change, the two cleanups looked like the
> least of the problem, so I took them too.
> 
> I ended up doing it all just as a single pull, since it seemed
> pointless to make history more complicated just to separate out the
> cleanups in a separate pull.
> 
> Now I really hope this won't cause any problems, but it certainly
> _looks_ harmless.
> 
>           Linus
> 
