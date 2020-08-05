Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190B723D1E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgHEUHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:07:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHEQeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GM4BD038971;
        Wed, 5 Aug 2020 16:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IQLdx5abes21j8K7iHnVnBLrSGwXYmzNR4vIr2rCepI=;
 b=q25j3yFCZq1ZH0dHoKbPHv8VCIDBkrVg3ESlEMQDIO313ZVAJL3bbCVbkb87xqQrRUCm
 DfEqdeLSynhXTeQqUjffQd7tCybsxI5V6XItsOVGvoV1y/+WTHJtLq0knW7tro0lSVOv
 ERcCwS+/uwfmQsffNQvLBPBN5QgyUMIKp368IpUQlFtCrTqLx15i/WuTy6OY49J/UwbY
 w5CSyW0Sz14pqW8luVJCotpnL5HKonN2RZYUSgpi98TmDG6IeXp7/LlW6BLkbOZjVKxf
 84uZpBM8DSraJiNmdLk98yq/t5ykat3kqPuv/ENLvgYkV7yy2uqmZTxy6lNN7rCVXC3C WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32n11nb3fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 16:33:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GJBpZ061181;
        Wed, 5 Aug 2020 16:31:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32p5gu12aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 16:31:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 075GVTHY020512;
        Wed, 5 Aug 2020 16:31:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 09:31:29 -0700
Date:   Wed, 5 Aug 2020 09:31:26 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
Message-ID: <20200805163126.GC6107@magnolia>
References: <20200805153214.GA6090@magnolia>
 <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
 <20200805162349.GB6107@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805162349.GB6107@magnolia>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:23:49AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 05, 2020 at 05:54:31PM +0200, Andreas Gruenbacher wrote:
> > Hi Darrick,
> > 
> > On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > ----------------------------------------------------------------
> > > Andreas Gruenbacher (1):
> > >       iomap: Make sure iomap_end is called after iomap_begin
> > 
> > that commit (d1b4f507d71de) contains the following garbage in the
> > commit message:
> > 
> >     The message from this sender included one or more files
> >     which could not be scanned for virus detection; do not
> >     open these files unless you are certain of the sender's intent.
> > 
> >     ----------------------------------------------------------------------
> > 
> > How did it come to that?
> 
> I have no idea.  It's not in the email that I turned into a patch, but
> golly roundtripping git patches through email and back to git sucks.

Aha-- the effing Oracle email virus scanner doesn't run on mails coming
in via mailing lists (which is the copy that I keep in my archive) but
the copy that you sent direct to me /did/ get a virus scan, which failed
because it's too stupid to recognize plain text, so the virus scanner
injected its stupid warning *into the message body*, and then I git-am'd
that without noticing.

S'ok, they're moving us to Exchange soon, so I expect never to hear from
any of you ever again.

--D

> 
> Oh well, I guess I have to rebase the whole branch now.
> 
> Linus: please ignore this pull request.
> 
> --D
> 
> > 
> > Thanks,
> > Andreas
> > 
> 
