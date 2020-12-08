Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324312D34F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 22:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgLHVJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 16:09:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgLHVJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:09:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IXuFR154732;
        Tue, 8 Dec 2020 18:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=c5mQ1V5VgH7MMoI7Q0YWAh6hSiZJ62pi8stI/s0zQ+c=;
 b=Bbhqw1TzD5G84Dic7kDHDSQ/0mFmO09+UX17YDfCFvunlLVev/DJRI6wyJ2xxRhqABsJ
 UurBrzzI9Y5DYSOhua0gxwPmE67Db90J932lQ6t28OcNL2R5UKMFtlHRTP7sUSfWK3Au
 5cTFlijM8EM4BUzH1mFAKjIGp695IGwgNE6+WAMQgbbo9W5avPYRIl7JF0vLFUHEyFmU
 du0mzITrP8BmVnSSQl6muIU1RXLJg6vaYhtRft48+ienq9SohjBm8NoOBplaf4idcwtD
 vwcQ8FRCZXEXdEoJAa9GkRJzL+YHmhUP+HD/FPb49CbQfF82SmgmoDrJ8bBsZdWrUvxa gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mqvc81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 18:43:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IZiRp061932;
        Tue, 8 Dec 2020 18:41:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 358m4y9cgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 18:41:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8IfPta027504;
        Tue, 8 Dec 2020 18:41:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 10:41:24 -0800
Date:   Tue, 8 Dec 2020 10:41:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        tytso@mit.edu, khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Message-ID: <20201208184123.GC106255@magnolia>
References: <20201208003117.342047-6-krisman@collabora.com>
 <20201208003117.342047-1-krisman@collabora.com>
 <952750.1607431868@warthog.procyon.org.uk>
 <87r1o05ua6.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1o05ua6.fsf@collabora.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:58:25AM -0300, Gabriel Krisman Bertazi wrote:
> David Howells <dhowells@redhat.com> writes:
> 
> > Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> >
> >> @@ -130,6 +131,8 @@ struct superblock_error_notification {

FWIW I wonder if this really should be inode_error_notification?

If (for example) ext4 discovered an error in the blockgroup descriptor
and wanted to report it, the inode and block numbers would be
irrelevant, but the blockgroup number would be nice to have.

> >>  	__u32	error_cookie;
> >>  	__u64	inode;
> >>  	__u64	block;
> >> +	char	function[SB_NOTIFICATION_FNAME_LEN];
> >> +	__u16	line;
> >>  	char	desc[0];
> >>  };
> >
> > As Darrick said, this is a UAPI breaker, so you shouldn't do this (you can,
> > however, merge this ahead a patch).  Also, I would put the __u16 before the
> > char[].
> >
> > That said, I'm not sure whether it's useful to include the function name and
> > line.  Both fields are liable to change over kernel commits, so it's not
> > something userspace can actually interpret.  I think you're better off dumping
> > those into dmesg.
> >
> > Further, this reduces the capacity of desc[] significantly - I don't know if
> > that's a problem.
> 
> Yes, that is a big problem as desc is already quite limited.  I don't

How limited?

> think it is a problem for them to change between kernel versions, as the
> monitoring userspace can easily associate it with the running kernel.

How do you make that association?  $majordistro's 4.18 kernel is not the
same as the upstream 4.18.  Wouldn't you rather the notification message
be entirely self-describing rather than depending on some external
information about the sender?

> The alternative would be generating something like unique IDs for each
> error notification in the filesystem, no?
> 
> > And yet further, there's no room for addition of new fields with the desc[]
> > buffer on the end.  Now maybe you're planning on making use of desc[] for
> > text-encoding?
> 
> Yes.  I would like to be able to provide more details on the error,
> without having a unique id.  For instance, desc would have the formatted
> string below, describing the warning:
> 
> ext4_warning(inode->i_sb, "couldn't mark inode dirty (err %d)", err);

Depending on the upper limit on the length of messages, I wonder if you
could split the superblock notification and the description string into
separate messages (with maybe the error cookie to tie them together) so
that the struct isn't limited by having a VLA on the end, and the
description can be more or less an arbitrary string?

(That said I'm not familiar with the watch queue system so I have no
idea if chained messages even make sense here, or are already
implemented in some other way, or...)

Even better if you could find a way to send the string and the arguments
separately so that whatever's on the receiving end could run it through
a localization catalogue.  Though I remember my roommates trying to
localize 2.0.35 into Latin 25 years ago and never getting very far. :)

--D

> 
> 
> >
> > David
> >
> 
> -- 
> Gabriel Krisman Bertazi
