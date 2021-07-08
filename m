Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F53BF913
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGHLe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:34:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhGHLe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:34:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D290D21C81;
        Thu,  8 Jul 2021 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625743935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPB+6FQxlPwCeAAWlGe3TItBTa/pn51TQ4crTIBkyYM=;
        b=YWQM+0knvHTA+GNYm/qmxKwPCR2nOqifyKXqJsaRDLi389RWk0iksCI0SFq6BqoBROVREm
        hy2m0y9A+LK75VhOm3Ts1a7dIuedSXdmz0p3ZBvdcs8NdIIueiO5NNN0XNn3vDWe5urgNQ
        rjn49Qy9wr7xbqy97pzE8cOowRct6dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625743935;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPB+6FQxlPwCeAAWlGe3TItBTa/pn51TQ4crTIBkyYM=;
        b=cxvt0vtWO3kll1jrG3eJ7cWlopT6mZgcl4DI5gIvbfKkur8uLIZYGwJOwhNlkEgYNXPVzl
        X6qv/Xf/pmv+IBBQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B8F2CA3B84;
        Thu,  8 Jul 2021 11:32:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A7B751E62E4; Thu,  8 Jul 2021 13:32:15 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:32:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] File system wide monitoring
Message-ID: <20210708113215.GE1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <CAOQ4uxgigXTtGgEC3yzt3f4HDHUiYqL7vk73v6E5LGx0OoFWHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgigXTtGgEC3yzt3f4HDHUiYqL7vk73v6E5LGx0OoFWHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-06-21 08:10:39, Amir Goldstein wrote:
> > This change raises the question of how we report non-inode errors.  On
> > one hand, we could omit the FID report, but then fsid would also be
> > ommited.  I chose to report these kind of errors against the root
> > inode.
> 
> There are other option to consider.

Yeah, so reporting against root inode has the disadvantage that in
principle you don't know whether the error really happened on the root
inode or whether the event is in fact without an inode. So some information
is lost here. Maybe the set of errors that can happen without an inode and
the set of errors that can happen with an inode are disjoint, so no
information is actually lost but then does reporting root inode actually
bring any benefit? So I agree reporting root inode is not ideal.

> To avoid special casing error events in fanotify event read code,
> it would is convenient to use a non-zero length FID, but you can
> use a 8 bytes zero buffer as NULL-FID
> 
> If I am not mistaken, that amounts to 64 bytes of event_len
> including the event_metadata and both records which is pretty
> nicely aligned.
> 
> All 3 handle_type options below are valid options:
> 1. handle_type FILEID_ROOT
> 2. handle_type FILEID_INVALID
> 3. handle_type FILEID_INO32_GEN (i.e. ino=0;gen=0)
> 
> The advantage of option #3 is that the monitoring program
> does not need to special case the NULL_FID case when
> parsing the FID to informative user message.

I actually like #2 more. #1 has similar problems as I outlined above for
reporting root dir. The advantage that userspace won't have to special case
FILEID_INO32_GEN FID in #3 is IMHO a dream - if you want a good message,
you should report the problem was on a superblock, not some just some
zeroes instead of proper inode info. Even more if it was on a real inode, 
good reporter will e.g. try to resolve it to a path.

Also because we will presumably have more filesystems supporting this in
the future, normal inodes can be reported with other handle types anyway.
So IMO #2 is the most sensible option.

> w.r.t LTP test, I don't think that using a corrupt image will be a good way
> for an LTP test. LTP tests can prepare and mount an ext4 loop image.
> Does ext4 have some debugging method to inject an error?
> Because that would be the best way IMO.
> If it doesn't, you can implement this in ext4 and use it in the test if that
> debug file exists - skip the test otherwise - it's common practice.

Ext4 does not have an error injection facility. Not sure if we want to
force Gabriel into creating one just for these LTP tests. Actually creating
ext4 images with known problems (through mke2fs and debugfs) should be
rather easy and we could then test we get expected error notifications
back...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
