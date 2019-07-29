Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5C782AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 02:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfG2AIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 20:08:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfG2AIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:08:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6T07EFJ051956;
        Mon, 29 Jul 2019 00:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1Xbfu53Ww+9Z+XNOFW2PofuFqfEK+HKRB6513qm7i5Y=;
 b=tYyC/bS8yk5A4Rgyi3odQeC+rThpG7kZYc9fOlzrTmkjCxQl9ts582umcexy7zj7Ts8J
 knNzh9ry4/9OWmxqKoHxJlFYlkwL7REjLLG71x6W9ZX0cOBenLPYAHKGyNsZ9gfX0fT2
 PpqvkECfJCP6lrByktB9s/LY5z4pgPghB4ZWdw5Fy2TTCOcCM05pvScdtTBsZEBrfBLG
 Sj215QeUv90xHqGsR7frNhT4zgy1Bg/fcJ/JqcZQp0LieLZMKj6cUX7nNtUmu2niI332
 kZvUL3auUknYIxUjRY2RN463dr2jCbyH09bIiWEK8fZRD1bhH1oNm9bAJ8SsSUIa7WFk EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejp47uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 00:08:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6T02Y0B035038;
        Mon, 29 Jul 2019 00:06:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u0ee3mfyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 00:06:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6T0625R028613;
        Mon, 29 Jul 2019 00:06:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 00:06:02 +0000
Date:   Sun, 28 Jul 2019 17:06:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: lift the xfs writepage code into iomap v3
Message-ID: <20190729000603.GL1561054@magnolia>
References: <20190722095024.19075-1-hch@lst.de>
 <20190726233753.GD2166993@magnolia>
 <CAHc6FU7L52soLiRafnOiTsaMYp4X_NmjjimpMMzdaoSH_afT+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7L52soLiRafnOiTsaMYp4X_NmjjimpMMzdaoSH_afT+A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9332 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907280302
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9332 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907280302
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 27, 2019 at 03:33:14PM +0200, Andreas Gruenbacher wrote:
> On Sat, 27 Jul 2019 at 01:38, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Mon, Jul 23, 2019 at 11:50:12AM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > >
> > > this series cleans up the xfs writepage code and then lifts it to
> > > fs/iomap.c so that it could be use by other file system.  I've been
> > > wanting to this for a while so that I could eventually convert gfs2
> > > over to it, but I never got to it.  Now Damien has a new zonefs
> > > file system for semi-raw access to zoned block devices that would
> > > like to use the iomap code instead of reinventing it, so I finally
> > > had to do the work.
> >
> > Hmm... I don't like how there are xfs changes mixed in with the iomap
> > changes, because were I to take this series as-is then I'd have to
> > commit both to adding iomap writeback code /and/ converting xfs at the
> > same time.
> >
> > I think I'd be more comfortable creating a branch to merge the changes
> > to list.h and fs/iomap/, and then gfs2/zonefs/xfs can sprout their own
> > branches from there to do whatever conversions are necessary.
> >
> > To me what that means is splitting patch 7 into 7a which does the iomap
> > changes and 7b which does the xfs changes.  To get there, I'd create a
> > iomap-writeback branch containing:
> >
> > 1 7a 8 9 10 11 12
> >
> > and then a new xfs-iomap-writeback branch containing:
> >
> > 2 4 7b
> >
> > This eliminates the need for patches 3, 5, and 6, though the cost is
> > that it's less clear from the history that we did some reorganizing of
> > the xfs writeback code and then moved it over to iomap.  OTOH, I also
> > see this as a way to lower risk because if some patch in the
> > xfs-iomap-writeback branch shakes loose a bug that doesn't affect gfs2
> > or zonedfs we don't have to hold them up.
> >
> > I'll try to restructure this series along those lines and report back
> > how it went.
> 
> Keeping the infrastructure changes in separate commits would certainly
> make the patches easier to work with for me. Keeping the commits
> interleaved should be fine though: patch "iomap: zero newly allocated
> mapped blocks" depends on "xfs: set IOMAP_F_NEW more carefully", so a
> pure infrastructure branch without "xfs: set IOMAP_F_NEW more
> carefully" probably wouldn't be correct.

<nod> In the end I went with:

iomap: 1 7a 8 9 10 11 12

and then atop that:

xfs: 2 4 3 5 6 7b

Because xfs can merge the refactoring in patches 2 & 4 without needing
to take patches 3-7b.  Will retest overnight with -rc2 (now that scsi
works again <cough>).

--D

> Thanks,
> Andreas
