Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4740826A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 02:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhIMApJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 20:45:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhIMApG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 20:45:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 994A91FF92;
        Mon, 13 Sep 2021 00:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631493830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OhiqEI5WRN41+hz7K8GD6ziTq8KYbUtfgpW9+YKBL8=;
        b=EU6s5UX+XAJ3Q9YJb81KwZ9AsL23Ta8RjRFJJLmfXxULyzooIPB5A13bg2gCtetDYD9jW3
        jzH8rKoq9VcJCuyPPA6mQb2aZCj3WsAb/U99vf7kjgQcXYk7n0/aibK56Da3B2I+eFsibx
        GOqpfkSd9O6PHXsdFAkGXnepONqxbcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631493830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OhiqEI5WRN41+hz7K8GD6ziTq8KYbUtfgpW9+YKBL8=;
        b=wty3BBQ9b3bvKAqRC3L12Nut29ILRMJSpTzZspOR52sx11qdsEQlHRCbrpEsbkv2KovQcq
        ZC0waAmr11DrU8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F6A413A61;
        Mon, 13 Sep 2021 00:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9HVvB8OePmHvWQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Sep 2021 00:43:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>
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
 <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>
Date:   Mon, 13 Sep 2021 10:43:44 +1000
Message-id: <163149382437.8417.3479990258042844514@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 12 Sep 2021, Amir Goldstein wrote:
> > Maybe what we really need is for a bunch of diverse filesystem
> > developers to get together and agree on some new common interface for
> > subvolume management, including coming up with some sort of definition
> > of what a subvolume "is".
>=20
> Neil,
>=20
> Seeing that LSF/MM is not expected to gather in the foreseen future, would
> you like to submit this as a topic for discussion in LPC Filesystem MC [1]?
> I know this is last minute, but we've just extended the CFP deadline
> until Sep 15 (MC is on Sep 21), so if you post a proposal, I think we will
> be able to fit this session in the final schedule.

Thanks for the suggestion.  Maybe that is a good idea...  But I don't
personally find face-to-face interactions particularly useful - though
other people obviously do.  I need thinking time after receiving new
ideas, so I can be sure that I understand them properly.  Face-to-face
doesn't allow me that thinking time.

So: no, I won't be proposing anything for LPC.

>=20
> Granted, I don't know how many of the stakeholders plan to attend
> the LPC Filesystem MC, but at least Josef should be there ;)
>=20
> I do have one general question about the expected behavior -
> In his comment to the LWN article [2], Josef writes:
>=20
> "The st_dev thing is unfortunate, but again is the result of a lack of
> interfaces.
>  Very early on we had problems with rsync wandering into snapshots and
>  copying loads of stuff. Find as well would get tripped up.
>  The way these tools figure out if they've wandered into another file system
>  is if the st_dev is different..."
>=20
> If your plan goes through to export the main btrfs filesystem and
> subvolumes as a uniform st_dev namespace to the NFS client,
> what's to stop those old issues from remerging on NFS exported btrfs?

That comment from Josef was interesting.... It doesn't align with
Commit 3394e1607eaf ("Btrfs: Give each subvol and snapshot their own anonymou=
s devid")
when Chris Mason introduced the per-subvol device number with the
justification that:
    Each subvolume has its own private inode number space, and so we need
    to fill in different device numbers for each subvolume to avoid confusing
    applications.

But I understand that history can be messy and maybe there were several
justifications of which Josef remembers one and Chris reported
another.

If rsync did, in fact, wander into subvols and didn't get put off by the
duplicate inode numbers (like 'find' does), then it would still do that
when accessing btrfs over NFS.  This has always been the case.  Chris'
"fix" only affected local access, it didn't change NFS access at all.

>=20
> IOW, the user experience you are trying to solve is inability of 'find'
> to traverse the unified btrfs namespace, but Josef's comment indicates
> that some users were explicitly unhappy from 'find' trying to traverse
> into subvolumes to begin with.

I believe that even 12 years ago, find would have complained if it saw a
directory with the same inode as an ancestor.  Chris's fix wouldn't
prevent find from entering in that case, because it wouldn't enter
anyway.

>=20
> So is there really a globally expected user experience?

No.  Everybody wants what they want.  There is some overlap, not no
guarantees.  That is the unavoidable consequence of ignoring standards
when implementing functionality.

> If not, then I really don't see how an nfs export option can be avoided.

And I really don't see how an nfs export option would help...  Different
people within and organisation and using the same export might have
different expectations.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20
> [1] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconfe=
rences#cont-filesys
> [2] https://lwn.net/Articles/867509/
>=20
>=20
