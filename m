Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D9123D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBVFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 17:05:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 17:05:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42L4PkD036372;
        Thu, 2 May 2019 21:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7pY7M/ejd/CdjQKheUzHbPlIC1MLHfFvlMQLp7rQ08A=;
 b=hEExdEEYWCzQo45uHLUsPPWADf01Yitwa6cIS9Mw2lEEFstvikk2t/uoqOKzTsG5H9FD
 SF8kdIynvNCDB7JCJvcRAZlDCnVfLYYAjtHyoQn8kb1UCBsT4VS3e2HCaRfZbXcTrayM
 4iwWOf0rlL2TD5HRoeNGRebxm1DGfDRrtEP6M2oz4YIYS5D2MCxhS8sB3J5U8dVOYecb
 qi3zRjWr/lHpb6zTmP6d58IkakzdpQuP2qGofvWBeaypOkNOpOcT1pUaFiwebmC8GGUJ
 /gedr75WWe95ZRRqOdr/23yreEdy2/ukHs+mYcTF0pCRzBXbYGzidREG53vI7SUySYgE Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s6xhykcj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 21:05:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42L4qC6039220;
        Thu, 2 May 2019 21:05:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2s7rtby03q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 21:05:29 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x42L5QqY005488;
        Thu, 2 May 2019 21:05:26 GMT
Received: from localhost (/10.145.179.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 May 2019 14:05:26 -0700
Date:   Thu, 2 May 2019 14:05:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190502210524.GI5200@magnolia>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020132
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 12:12:22PM -0400, Amir Goldstein wrote:
> On Sat, Apr 27, 2019 at 5:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Suggestion for another filesystems track topic.
> >
> > Some of you may remember the emotional(?) discussions that ensued
> > when the crashmonkey developers embarked on a mission to document
> > and verify filesystem crash recovery guaranties:
> >
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxj8YpYPPdEvAvKPKXO7wdBg6T1O3osd6fSPFKH9j=i2Yg@mail.gmail.com/
> >
> > There are two camps among filesystem developers and every camp
> > has good arguments for wanting to document existing behavior and for
> > not wanting to document anything beyond "use fsync if you want any guaranty".
> >
> > I would like to take a suggestion proposed by Jan on a related discussion:
> > https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQx+TO3Dt7TA3ocXnNxbr3+oVyJLYUSpv4QCt_Texdvw@mail.gmail.com/
> >
> > and make a proposal that may be able to meet the concerns of
> > both camps.
> >
> > The proposal is to add new APIs which communicate
> > crash consistency requirements of the application to the filesystem.
> >
> > Example API could look like this:
> > renameat2(..., RENAME_METADATA_BARRIER | RENAME_DATA_BARRIER)
> > It's just an example. The API could take another form and may need
> > more barrier types (I proposed to use new file_sync_range() flags).
> >
> > The idea is simple though.
> > METADATA_BARRIER means all the inode metadata will be observed
> > after crash if rename is observed after crash.
> > DATA_BARRIER same for file data.
> > We may also want a "ALL_METADATA_BARRIER" and/or
> > "METADATA_DEPENDENCY_BARRIER" to more accurately
> > describe what SOMC guaranties actually provide today.
> >
> > The implementation is also simple. filesystem that currently
> > have SOMC behavior don't need to do anything to respect
> > METADATA_BARRIER and only need to call
> > filemap_write_and_wait_range() to respect DATA_BARRIER.
> > filesystem developers are thus not tying their hands w.r.t future
> > performance optimizations for operations that are not explicitly
> > requesting a barrier.
> >
> 
> An update: Following the LSF session on $SUBJECT I had a discussion
> with Ted, Jan and Chris.
> 
> We were all in agreement that linking an O_TMPFILE into the namespace
> is probably already perceived by users as the barrier/atomic operation that
> I am trying to describe.
> 
> So at least maintainers of btrfs/ext4/ext2 are sympathetic to the idea of
> providing the required semantics when linking O_TMPFILE *as long* as
> the semantics are properly documented.
> 
> This is what open(2) man page has to say right now:
> 
>  *  Creating a file that is initially invisible, which is then
> populated with data
>     and adjusted to have  appropriate  filesystem  attributes  (fchown(2),
>     fchmod(2), fsetxattr(2), etc.)  before being atomically linked into the
>     filesystem in a fully formed state (using linkat(2) as described above).
> 
> The phrase that I would like to add (probably in link(2) man page) is:
> "The filesystem provided the guaranty that after a crash, if the linked
>  O_TMPFILE is observed in the target directory, than all the data and

"if the linked O_TMPFILE is observed" ... meaning that if we can't
recover all the data+metadata information then it's ok to obliterate the
file?  Is the filesystem allowed to drop the tmpfile data if userspace
links the tmpfile into a directory but doesn't fsync the directory?

TBH I would've thought the basis of the RENAME_ATOMIC (and LINK_ATOMIC?)
user requirement would be "Until I say otherwise I want always to be
able to read <data> from this given string <pathname>."

(vs. regular Unix rename/link where we make you specify how much you
care about that by hitting us on the head with a file fsync and then a
directory fsync.)

>  metadata modifications made to the file before being linked are also
>  observed."
> 
> For some filesystems, btrfs in farticular, that would mean an implicit
> fsync on the linked inode. On other filesystems, ext4/xfs in particular
> that would only require at least committing delayed allocations, but
> will NOT require inode fsync nor journal commit/flushing disk caches.

I don't think it does much good to commit delalloc blocks but not flush
dirty overwrites, and I don't think it makes a lot of sense to flush out
overwrite data without also pushing out the inode metadata too.

FWIW I'm ok with the "Here's a 'I'm really serious' flag that carries
with it a full fsync, though how to sell developers on using it?

> I would like to hear the opinion of XFS developers and filesystem
> maintainers who did not attend the LSF session.

I miss you all too.  Sorry I couldn't make it this year. :(

> I have no objection to adding an opt-in LINK_ATOMIC flag
> and pass it down to filesystems instead of changing behavior and
> patching stable kernels, but I prefer the latter.
> 
> I believe this should have been the semantics to begin with
> if for no other reason, because users would expect it regardless
> of whatever we write in manual page and no matter how many
> !!!!!!!! we use for disclaimers.
> 
> And if we can all agree on that, then O_TMPFILE is quite young
> in historic perspective, so not too late to call the expectation gap
> a bug and fix it.(?)

Why would linking an O_TMPFILE be a special case as opposed to making
hard links in general?  If you hardlink a dirty file then surely you'd
also want to be able to read the data from the new location?

> Taking this another step forward, if we agree on the language
> I used above to describe the expected behavior, then we can
> add an opt-in RENAME_ATOMIC flag to provide the same
> semantics and document it in the same manner (this functionality
> is needed for directories and non regular files) and all there is left
> is the fun part of choosing the flag name ;-)

Will have to think about /that/ some more.

--D

> 
> Thanks,
> Amir.
