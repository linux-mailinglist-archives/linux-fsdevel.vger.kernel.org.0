Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DE3D9B20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhG2Bj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 21:39:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42656 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhG2Bj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:39:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21506201C8;
        Thu, 29 Jul 2021 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627522795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9lhWH4GhyGPwuu3uTrq8hMzFnYZKNcbMGRacy9YazM=;
        b=0ytyMmCLDf/ZaVROechth7bCUBSBbZipxf4pqsmsch9k8NXBlkUFJPRlzBWk1CIa0+1jIi
        cvBnxQ5aiQ28+IMb5GOek947DpGQqUvsCtZ6KuiTKGX8n0KsmfN8tIVrzrD6io8ddGmqMd
        E/R/B1tSUL3eoz7v2E3hrMf7y3hewmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627522795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9lhWH4GhyGPwuu3uTrq8hMzFnYZKNcbMGRacy9YazM=;
        b=BpYNSwJ4uTNNArHxJowYOg12sdNTFEYOOCirW++IqY34NhrqEWydMGHgYChpiNjGvQD9tP
        ToTcAvdJ0L2risDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B147113481;
        Thu, 29 Jul 2021 01:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d6fFG+cGAmF6DAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 01:39:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     g.btrfs@cobb.uk.net
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <2cb6455c-7b9f-9ac3-fd9d-9121eb1aa109@cobb.uk.net>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <2cb6455c-7b9f-9ac3-fd9d-9121eb1aa109@cobb.uk.net>
Date:   Thu, 29 Jul 2021 11:39:48 +1000
Message-id: <162752278855.21659.8220794370174720381@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Jul 2021, g.btrfs@cobb.uk.net wrote:
> On 28/07/2021 08:01, NeilBrown wrote:
> > On Wed, 28 Jul 2021, Wang Yugui wrote:
> >> Hi,
> >>
> >> This patchset works well in 5.14-rc3.
> > 
> > Thanks for testing.
> > 
> >>
> >> 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
> >> dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)
> > 
> > The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
> > be permanent.
> > The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
> > think).
> > This is a bit less of a hack.  It is an easily available number that is
> > fairly unique.
> > 
> >>
> >> 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
> >> not used.
> >> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
> >> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
> >> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
> >>
> >> This is a visiual feature change for btrfs user.
> > 
> > Hopefully it is an improvement.  But it is certainly a change that needs
> > to be carefully considered.
> 
> Would this change the behaviour of findmnt? I have several scripts that
> depend on findmnt to select btrfs filesystems. Just to take a couple of
> examples (using the example shown above): my scripts would depend on
> 'findmnt --target /mnt/test/sub1 -o target' providing /mnt/test, not the
> subvolume; and another script would depend on 'findmnt -t btrfs
> --mountpoint /mnt/test/sub1' providing no output as the directory is not
> an /etc/fstab mount point for a btrfs filesystem.

Yes, I think it does change the behaviour of findmnt.
If the sub1 automount has not been triggered,
  findmnt --target /mnt/test/sub1 -o target
will report "/mnt/test".
After it has been triggered, it will report "/mnt/test/sub1"

Similarly "findmnt -t btrfs --mountpoint /mnt/test/sub1" will report
nothing if the automount hasn't been triggered, and will report full
details of /mnt/test/sub1 if it has.

> 
> Maybe findmnt isn't affected? Or maybe the change is worth making
> anyway? But it needs to be carefully considered if it breaks existing
> user interfaces.
> 
I hope the change is worth making anyway, but breaking findmnt would not
be a popular move.
This is unfortunate....  btrfs is "broken" and people/code have adjusted
to that breakage so that "fixing" it will be traumatic.

The only way I can find to get findmnt to ignore the new entries in
/proc/self/mountinfo is to trigger a parse error such as by replacing the 
" - " with " -- "
but that causes a parse error message to be generated, and will likely
break other tools.
(...  or I could check if current->comm is "findmnt", and suppress the
extra entries, but that is even more horrible!!)

A possible option is to change findmnt to explicitly ignore the new
"internal" mounts (unless some option is given) and then delay the
kernel update until that can be rolled out.

Or we could make the new internal mounts invisible in /proc without some
kernel setting enabled.  Then distros can enable it once all important
tools can cope, and they can easily test correctness without rebooting.

I wonder if correcting the device-number reported for explicit subvol
mounts will break anything....  findmnt seems happy with it in my
limited testing.  There seems to be a testsuite with util-linux.  Maybe
I should try that.

Thanks,
NeilBrown

