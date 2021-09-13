Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720A40A123
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbhIMXBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 19:01:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44158 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbhIMXBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:01:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 457A2200A9;
        Mon, 13 Sep 2021 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631573992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcWfA5d+lR5YNPO7UjfSk/r4MnR7nuV2MelnKFymfFI=;
        b=bFMb9r2E6Z1dQTvgeOsdXcvYuLV0jED1J2X8Rzpf8Ndy6dMhGEodOJ6BrFFDZmTFBLPkYt
        vxaPKF3sPHjnKiPILhSOiBbgYnHsP0oN9w+LbIVbsnCU8afBQSfaZRaGo5DEWYbeVv0Jp/
        pzxmWVAw1FCcDlpHSsdNz0aw42VLNuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631573992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcWfA5d+lR5YNPO7UjfSk/r4MnR7nuV2MelnKFymfFI=;
        b=x+LS/pYZq8OvczBtDA5aXDJMh656Qb42uLSsmq8qeH15lCy3n80dFbMAzHdCvjTTbL4ozr
        H3e2zD8dJCc4caBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4CEE13BA9;
        Mon, 13 Sep 2021 22:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JnnfGOXXP2G7TAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Sep 2021 22:59:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Theodore Tso" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <CAOQ4uxgFf5c0to7f4cT9c9JwWisYRf-kxiZS4BuyXaQV=bLbJg@mail.gmail.com>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>, <20210901152251.GA6533@fieldses.org>,
 <163055605714.24419.381470460827658370@noble.neil.brown.name>,
 <20210905160719.GA20887@fieldses.org>,
 <163089177281.15583.1479086104083425773@noble.neil.brown.name>,
 <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>,
 <163149382437.8417.3479990258042844514@noble.neil.brown.name>,
 <CAOQ4uxgFf5c0to7f4cT9c9JwWisYRf-kxiZS4BuyXaQV=bLbJg@mail.gmail.com>
Date:   Tue, 14 Sep 2021 08:59:46 +1000
Message-id: <163157398661.3992.2107487416802405356@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Sep 2021, Amir Goldstein wrote:
> 
> Right, so the right fix IMO would be to provide similar semantics
> to the NFS client, like your first patch set tried to do.
> 

Like every other approach, this sounds good and sensible ...  until
you examine the details.

For NFSv3 (RFC1813) this would be a protocol violation.
Section 3.3.3 (LOOKUP) says:
  A server will not allow a LOOKUP operation to cross a mountpoint to
  the root of a different filesystem, even if the filesystem is
  exported.

The filesystem is represented by the fsid, so this implies that the fsid
of an object reported by LOOKUP must be the same as the fsid of the
directory used in the LOOKUP.

Linux NFS does allow this restriction to be bypassed with the "crossmnt"
export option.  Maybe if crossmnt were given it would be defensible to
change the fsid - if crossmnt is not given, we leave the current
behaviour.  Note that this is a hack and while it is extremely useful,
it does not produce a seemly experience.  You can get exactly the same
problems with "find" - just not as uniformly (mounting with "-o noac"
makes them uniform).

For NFSv4, we need to provide a "mounted-on" fileid for any mountpoint. 
btrfs doesn't have a mounted-on fileid that can be used.  We can fake
something that might work reasonably well - but it would be fake.  (but
then ... btrfs already provided bogus information in getdents when there
is a subvol root in the directory).

But these are relatively minor.  The bigger problem is /proc/mounts.  If
btrfs maintainers were willing to have every active subvolume appear in
/proc/mounts, then I would be happy to fiddle the NFS fsid and allow
every active NFS/btrfs subvolume to appear in /proc/mounts on the NFS
client.  But they aren't.  So I am not.

> > And I really don't see how an nfs export option would help...  Different
> > people within and organisation and using the same export might have
> > different expectations.
> 
> That's true.
> But if admin decides to export a specific btrfs mount as a non-unified
> filesystem, then NFS clients can decide whether ot not to auto-mount the
> exported subvolumes and different users on the client machine can decide
> if they want to rsync or rsync --one-file-system, just as they would with
> local btrfs.
> 
> And maybe I am wrong, but I don't see how the decision on whether to
> export a non-unified btrfs can be made a btrfs option or a nfsd global
> option, that's why I ended up with export option.

Just because a btrfs option and global nfsd option are bad, that doesn't
mean an export option must be good.  It needs to be presented and
defended on its own merits.

My current opinion (and I must admit I am feeling rather jaded about the
whole thing), is that while btrfs is a very interesting and valuable
experiment in fs design, it contains core mistakes that cannot be
incrementally fixed.  It should be marked as legacy with all current
behaviour declared as intentional and not subject to change.  This would
make way for a new "betrfs" which was designed based on all that we have
learned.  It would use the same code base, but present a more coherent
interface.  Exactly what that interface would be has yet to be decided,
but we would not be bound to maintain anything just because btrfs
supports it.

NeilBrown
