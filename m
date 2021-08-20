Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804283F2508
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhHTCzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 22:55:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhHTCzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:55:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA2F61FDC4;
        Fri, 20 Aug 2021 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629428063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2zXkDjop7FqBMhamhO77clbpIHPjjrwzFjux/7s1ko=;
        b=z+IPtxhwiCQj54wnCS9E5A5YF6gzhj5OsnYDX7vxvzFu5g0zYPiEt8yStLdHNjubFiXE51
        +Y9zgpIgHQcImMYiiGCU1mpBg7iopNb8gLiIklur05Q8qr3s+cLhvREVLjvLMKKs2Dy/fw
        SsR77vKyLkXXzii/fmtg/g62CYIfTWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629428063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2zXkDjop7FqBMhamhO77clbpIHPjjrwzFjux/7s1ko=;
        b=LNo5jCN08kHhgnFlBs5FjaEIjsNN3buPVTXqLgQxZEvYiVzdIPZPmylYGIg/bfFFP5qGGK
        HyFZM2eoVTDbPFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77F5B13ABC;
        Fri, 20 Aug 2021 02:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NhGdDVwZH2H8QwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 20 Aug 2021 02:54:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210819021910.GB29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <20210818225454.9558.409509F4@e16-tech.com>,
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>,
 <20210819021910.GB29026@hungrycats.org>
Date:   Fri, 20 Aug 2021 12:54:17 +1000
Message-id: <162942805745.9892.7512463857897170009@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Aug 2021, Zygo Blaxell wrote:
> On Thu, Aug 19, 2021 at 07:46:22AM +1000, NeilBrown wrote:
> > 
> > Remember what the goal is.  Most apps don't care at all about duplicate
> > inode numbers - only a few do, and they only care about a few inodes.
> > The only bug I actually have a report of is caused by a directory having
> > the same inode as an ancestor.  i.e.  in lots of cases, duplicate inode
> > numbers won't be noticed.
> 
> rsync -H and cpio's hardlink detection can be badly confused.  They will
> think distinct files with the same inode number are hardlinks.  This could
> be bad if you were making backups (though if you're making backups over
> NFS, you are probably doing something that could be done better in a
> different way).

Yes, they could get confused.  inode numbers remain unique within a
"subvolume" so you would need to do at backup of multiple subtrees to
hit a problem.  Certainly possible, but probably less common.

> 
> 40 bit inodes would take about 20 years to collide with 24-bit subvols--if
> you are creating an average of 1742 inodes every second.  Also at the
> same time you have to be creating a subvol every 37 seconds to occupy
> the colliding 25th bit of the subvol ID.  Only the highest inode number
> in any subvol counts--if your inode creation is spread out over several
> different subvols, you'll need to make inodes even faster.
> 
> For reference, my high scores are 17 inodes per second and a subvol
> every 595 seconds (averaged over 1 year).  Burst numbers are much higher,
> but one has to spend some time _reading_ the files now and then.
> 
> I've encountered other btrfs users with two orders of magnitude higher
> inode creation rates than mine.  They are barely squeaking under the
> 20-year line--or they would be, if they were creating snapshots 50 times
> faster than they do today.

I do like seeing concrete numbers, thanks.  How many of these inodes and
subvols remain undeleted?  Supposing inode numbers were reused, how many
bits might you need?


> > My preference would be for btrfs to start re-using old object-ids and
> > root-ids, and to enforce a limit (set at mkfs or tunefs) so that the
> > total number of bits does not exceed 64.  Unfortunately the maintainers
> > seem reluctant to even consider this.
> 
> It was considered, implemented in 2011, and removed in 2020.  Rationale
> is in commit b547a88ea5776a8092f7f122ddc20d6720528782 "btrfs: start
> deprecation of mount option inode_cache".  It made file creation slower,
> and consumed disk space, iops, and memory to run.  Nobody used it.
> Newer on-disk data structure versions (free space tree, 2015) didn't
> bother implementing inode_cache's storage requirement.

Yes, I saw that.  Providing reliable functional certainly can impact
performance and consume disk-space.  That isn't an excuse for not doing
it. 
I suspect that carefully tuned code could result in typical creation
times being unchanged, and mean creation times suffering only a tiny
cost.  Using "max+1" when the creation rate is particularly high might
be a reasonable part of managing costs.
Storage cost need not be worse than the cost of tracking free blocks
on the device.

"Nobody used it" is odd.  It implies it would have to be explicitly
enabled, and all it would provide anyone is sane behaviour.  Who would
imagine that to be an optional extra.

NeilBrown

