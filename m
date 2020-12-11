Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF06D2D8235
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 23:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436775AbgLKWgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 17:36:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436721AbgLKWgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:36:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBMUxbp136018;
        Fri, 11 Dec 2020 22:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tit4hGGp99VsMRkEIE45lsaL/RqvoY94HPSKp63Y9bY=;
 b=A9VZoVYr6hlC+2O//48xcyqmXCsclPrsyqzqbHauXzrDHZxc5md0aPFdoHlN7VqBoWWd
 oiZ9Z9p3r73+sTj03pTti0hp7Lp9GG9GvJYDbpes+lCctU4WDGO4QVfBp7lxpCE78v2Y
 OL56sJNb1Z5N3xl+grqgEvdN09YpUE7dY9ACSvcSVz9R+3K9Xc+jsC/Fdf60VbFPFK+h
 AZ2elUb1Hq9vqsAbdL9QBX3VaHZw9fMndzpr0dyJ5qHWUEuc3OM/WVIVzeoW6ZALoiIu
 E4Y0qE4+HzIOIQjKv/ypOk5FZJBSJyayuL1K730eCXColgqKpLvIDeT5s8TQOA5VygW3 rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825mmybd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 22:35:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BBMUq10061166;
        Fri, 11 Dec 2020 22:35:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 358kyysrbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 22:35:40 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BBMZcCv028211;
        Fri, 11 Dec 2020 22:35:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Dec 2020 14:35:37 -0800
Date:   Fri, 11 Dec 2020 14:35:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Message-ID: <20201211223536.GE106255@magnolia>
References: <20201208003117.342047-6-krisman@collabora.com>
 <20201208003117.342047-1-krisman@collabora.com>
 <952750.1607431868@warthog.procyon.org.uk>
 <87r1o05ua6.fsf@collabora.com>
 <20201208184123.GC106255@magnolia>
 <87lfe85c6b.fsf@collabora.com>
 <20201209032425.GD106255@magnolia>
 <87h7ov5dts.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7ov5dts.fsf@collabora.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9832 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110148
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:06:07AM -0300, Gabriel Krisman Bertazi wrote:
> "Darrick J. Wong" <darrick.wong@oracle.com> writes:
> 
> > On Tue, Dec 08, 2020 at 04:29:32PM -0300, Gabriel Krisman Bertazi wrote:
> >> "Darrick J. Wong" <darrick.wong@oracle.com> writes:
> >> 
> >> > On Tue, Dec 08, 2020 at 09:58:25AM -0300, Gabriel Krisman Bertazi wrote:
> >> >> David Howells <dhowells@redhat.com> writes:
> >> >> 
> >> >> > Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> >> >> >
> >> >> >> @@ -130,6 +131,8 @@ struct superblock_error_notification {
> >> >
> >> > FWIW I wonder if this really should be inode_error_notification?
> >> >
> >> > If (for example) ext4 discovered an error in the blockgroup descriptor
> >> > and wanted to report it, the inode and block numbers would be
> >> > irrelevant, but the blockgroup number would be nice to have.
> >> 
> >> A previous RFC had superblock_error_notification and
> >> superblock_inode_error_notification split, I think we can recover that.
> >> 
> >> >
> >> >> >>  	__u32	error_cookie;
> >> >> >>  	__u64	inode;
> >> >> >>  	__u64	block;
> >> >> >> +	char	function[SB_NOTIFICATION_FNAME_LEN];
> >> >> >> +	__u16	line;
> >> >> >>  	char	desc[0];
> >> >> >>  };
> >> >> >
> >> >> > As Darrick said, this is a UAPI breaker, so you shouldn't do this (you can,
> >> >> > however, merge this ahead a patch).  Also, I would put the __u16 before the
> >> >> > char[].
> >> >> >
> >> >> > That said, I'm not sure whether it's useful to include the function name and
> >> >> > line.  Both fields are liable to change over kernel commits, so it's not
> >> >> > something userspace can actually interpret.  I think you're better off dumping
> >> >> > those into dmesg.
> >> >> >
> >> >> > Further, this reduces the capacity of desc[] significantly - I don't know if
> >> >> > that's a problem.
> >> >> 
> >> >> Yes, that is a big problem as desc is already quite limited.  I don't
> >> >
> >> > How limited?
> >> 
> >> The largest notification is 128 bytes, the one with the biggest header
> >> is superblock_error_notification which leaves 56 bytes for description.
> >> 
> >> >
> >> >> think it is a problem for them to change between kernel versions, as the
> >> >> monitoring userspace can easily associate it with the running kernel.
> >> >
> >> > How do you make that association?  $majordistro's 4.18 kernel is not the
> >> > same as the upstream 4.18.  Wouldn't you rather the notification message
> >> > be entirely self-describing rather than depending on some external
> >> > information about the sender?
> >> 
> >> True.  I was thinking on my use case where the customer controls their
> >> infrastructure and would specialize their userspace tools, but that is
> >> poor design on my part.  A self describing mechanism would be better.
> >> 
> >> >
> >> >> The alternative would be generating something like unique IDs for each
> >> >> error notification in the filesystem, no?
> >> >> 
> >> >> > And yet further, there's no room for addition of new fields with the desc[]
> >> >> > buffer on the end.  Now maybe you're planning on making use of desc[] for
> >> >> > text-encoding?
> >> >> 
> >> >> Yes.  I would like to be able to provide more details on the error,
> >> >> without having a unique id.  For instance, desc would have the formatted
> >> >> string below, describing the warning:
> >> >> 
> >> >> ext4_warning(inode->i_sb, "couldn't mark inode dirty (err %d)", err);
> >> >
> >> > Depending on the upper limit on the length of messages, I wonder if you
> >> > could split the superblock notification and the description string into
> >> > separate messages (with maybe the error cookie to tie them together) so
> >> > that the struct isn't limited by having a VLA on the end, and the
> >> > description can be more or less an arbitrary string?
> >> >
> >> > (That said I'm not familiar with the watch queue system so I have no
> >> > idea if chained messages even make sense here, or are already
> >> > implemented in some other way, or...)
> >> 
> >> I don't see any support for chaining messages in the current watch_queue
> >> implementation, I'd need to extend the interface to support it.  I
> >> considered this idea before, given the small description size, but I
> >> thought it would be over-complicated, even though much more future
> >> proof.  I will look into that.
> >> 
> >> What about the kernel exporting a per-filesystem table, as a build
> >> target or in /sys/fs/<fs>/errors, that has descriptions strings for each
> >> error?  Then the notification can have only the FS type, index to the
> >> table and params.  This won't exactly be self-describing as you wanted
> >> but, differently from function:line, it removes the need for the source
> >> code, and allows localization.  The per-filesystem table would be
> >> stable ABI, of course.
> >
> > Yikes.  I don't think people are going to be ok with a message table
> > where we can never remove the strings.  I bet GregKH won't like that
> > either (one value per sysfs file).
> 
> Indeed, sysfs seems out of question.  In fact the string format doesn't
> even need to be in the kernel, and we don't need the strings to be sent
> as part of the notifications.  What if we can have a bunch of
> notification types, specific for each error message, and a library in
> userspace that parses the notifications and understands the parameters
> passed?  The library then displays the data as they wish.

Er... I don't think we (XFS) really are going to maintain a userspace
library to decode kernel messages.

> > (Maybe I misread that and all you meant by stable ABI is the fact that
> > the table exists at a given path and the notification message gives you
> > a index into ... wherever we put it.)
> 
> The kernel could even export the table as a build-time target, that
> get's installed into X. But even that is not necessary if a library can
> make sense of a notification that uniquely identifies each error and
> only includes the useful debug parameters without any string formatting?

/me shrugs and thinks that chaining fs notifications via cookie might be
a better way to do this, since then you could push out a stream of
notices about a filesystem event:

(0) generic vfs error telling you something happened at a inode/offset

(1) fs-specific notice giving more details about what that fs thinks is
wrong

(2) formatted message string so that you can send it to the sysadmin or
feed it to google translate or whatever :)

--D

> -- 
> Gabriel Krisman Bertazi
