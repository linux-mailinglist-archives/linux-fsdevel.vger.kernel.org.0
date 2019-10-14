Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4584ED6B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfJNWQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 18:16:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfJNWQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 18:16:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EMEOwM091697;
        Mon, 14 Oct 2019 22:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9D93uPwYO7/QwkYu0na59Bh8hudZIr/smbJMrOwimDg=;
 b=Hqt5KSGmGpsmFt4YDHWBdJa5zkUwgACGVhnyEBtQPXFC6c+Vbkm6N9N0uFxP2YoQxDxx
 dab3cJ40yT3XcA26wL0hCCySOXPTY1UELEO3BbgNyZQBBaBk6jZLf7cy+0rq4I62s2AQ
 skZiyWbdbKQtU4+8b7TOS0eqbo6t+X5ZFDpdNDc6Kb7ciMTIua5qA3SEutnFBUpB7Kbq
 kphMRzW8Uq5TiHfpJ+JB2TKfdqbfp3WELk9VV+YHG2AxeoAn7NCq4k/eOj3Q7qjPJ+ig
 6bt+1GpfXpw4xBlkRMNyp+9szg7NEIk32OsrWXxWL7ItpDSpKxk3svn4hQEiLvDafi4q /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fr3qag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 22:16:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EMCtFC120257;
        Mon, 14 Oct 2019 22:16:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vkry79u7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 22:16:17 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9EMGGkj026000;
        Mon, 14 Oct 2019 22:16:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 15:16:15 -0700
Date:   Mon, 14 Oct 2019 15:16:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: INFO: task hung in pipe_write (2)
Message-ID: <20191014221612.GG13098@magnolia>
References: <000000000000ac6a360592eb26c1@google.com>
 <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
 <20190919211013.GN5340@magnolia>
 <CAHc6FU7drv7r7yu4BzTGKycnKi_wUDGsvND6XyhDLq7B=HCM8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7drv7r7yu4BzTGKycnKi_wUDGsvND6XyhDLq7B=HCM8g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140185
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:40:44PM +0200, Andreas Gruenbacher wrote:
> Hi Darrick,
> 
> On Thu, Sep 19, 2019 at 11:10 PM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> > On Thu, Sep 19, 2019 at 10:55:44PM +0200, Rasmus Villemoes wrote:
> > > On 19/09/2019 19.19, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    288b9117 Add linux-next specific files for 20190918
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000
> > > >
> > > > The bug was bisected to:
> > > >
> > > > commit cfb864757d8690631aadf1c4b80022c18ae865b3
> > > > Author: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Date:   Tue Sep 17 16:05:22 2019 +0000
> > > >
> > > >     splice: only read in as much information as there is pipe buffer space
> > >
> > > The middle hunk (the one before splice_pipe_to_pipe()) accesses
> > > opipe->{buffers, nrbufs}, but opipe is not locked at that point. So
> > > maybe we end up passing len==0, which seems (once there's room in opipe)
> > > it would put a zero-length pipe_buffer in opipe - and that probably
> > > violates an invariant somewhere.
> > >
> > > But does the splice_pipe_to_pipe() case even need that extra logic?
> > > Doesn't it handle short writes correctly already?
> >
> > Yep.  I missed the part where splice_pipe_to_pipe is already perfectly
> > capable of detecting insufficient space in opipe and kicking opipe's
> > readers to clear out the buffer.  So that hunk isn't needed, and now I'm
> > wondering how in the other clause we return 0 from wait_for_space yet
> > still don't have buffer space...
> >
> > Oh well, back to the drawing board.  Good catch, though now it's become
> > painfully clear that xfstests lacks rigorous testing of splice()...
> 
> have you had any luck figuring out how to fix this? We're still
> suffering from the regression I've reported a while ago (*).

Nope, that's slipped along with everything else because I'm burning out
on all the buggy sh*t that has gone in the kernel for 5.4 that has made
it difficult to get regression tests to run reliably to find out if
there's anything wrong with XFS.

Oh, sure, if I turn off kmemleak and whatever the hell "haltpoll" is
then it tidies up enough to run fstests but now "sleep 0.5" runs in
anywhere between a jiffie and 10s.  WTH.

> If not, I wonder if reverting commit 8f67b5adc030 would make sense for now.

Ugh, no, splice shouldn't be asking the filesystem for a 75k buffered
read and then *oopsie* running out of pages after ~64k or so.  Even more
frighteningly the syzbot reproducer asks for a 20GB read into a pipe
which gets sent right into the fs without any size clamping.

Ok I'll at least cough up a v3 patch which maybe will work.

--D

> 
> * https://lore.kernel.org/linux-fsdevel/CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com/T/#u
> 
> Thanks,
> Andreas
