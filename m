Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979523ECB8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhHOVyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 17:54:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHOVyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:54:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01A8F1FE49;
        Sun, 15 Aug 2021 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629064445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56y/Def2nMkNp3coJSSqIPb+5JvFWXIr2Sjjvt/Soug=;
        b=b7BNsdnYAibTL13hBupU22Jz8E+9hFXD6OKZ62SAstQ2NLSe/9wf3WRT1tCZMPgb6LZjjj
        iEfYGgQJvtUvG8Y3l7y5sChekJNUZBJCWUL0veYdV9VsGNL1L1eyVLcEmHpDQJ/gfBrxzc
        k5C2K72jhV2T5ysiYI598FARvXHeonw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629064445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56y/Def2nMkNp3coJSSqIPb+5JvFWXIr2Sjjvt/Soug=;
        b=a0fj8xB25GCYDqR5DEM5VQwPIcNGQQYE+hfqum36UfX3RV+KnpLQxtGbaGEHaIOsubvKpm
        D6Ov5v2CKti8vfCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90AEB147F9;
        Sun, 15 Aug 2021 21:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GcjcE/mMGWFuZwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 15 Aug 2021 21:54:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     kreijack@inwind.it
Cc:     "Roman Mamedov" <rm@romanrm.net>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>,
 <20210816003505.7b3e9861@natsu>,
 <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>
Date:   Mon, 16 Aug 2021 07:53:58 +1000
Message-id: <162906443866.1695.6446438554332029261@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Aug 2021, kreijack@inwind.it wrote:
> On 8/15/21 9:35 PM, Roman Mamedov wrote:
> > On Sun, 15 Aug 2021 09:39:08 +0200
> > Goffredo Baroncelli <kreijack@libero.it> wrote:
> >=20
> >> I am sure that it was discussed already but I was unable to find any tra=
ck
> >> of this discussion. But if the problem is the collision between the inode
> >> number of different subvolume in the nfd export, is it simpler if the ex=
port
> >> is truncated to the subvolume boundary ? It would be more coherent with =
the
> >> current behavior of vfs+nfsd.
> >=20
> > See this bugreport thread which started it all:
> > https://www.spinics.net/lists/linux-btrfs/msg111172.html
> >=20
> > In there the reporting user replied that it is strongly not feasible for =
them
> > to export each individual snapshot.
>=20
> Thanks for pointing that.
>=20
> However looking at the 'exports' man page, it seems that NFS has already an
> option to cover these cases: 'crossmnt'.
>=20
> If NFSd detects a "child" filesystem (i.e. a filesystem mounted inside an a=
lready
> exported one) and the "parent" filesystem is marked as 'crossmnt',  the cli=
ent mount
> the parent AND the child filesystem with two separate mounts, so there is n=
ot problem of inode collision.

As you acknowledged, you haven't read the whole back-story.  Maybe you
should.

https://lore.kernel.org/linux-nfs/20210613115313.BC59.409509F4@e16-tech.com/
https://lore.kernel.org/linux-nfs/162848123483.25823.15844774651164477866.stg=
it@noble.brown/
https://lore.kernel.org/linux-btrfs/162742539595.32498.13687924366155737575.s=
tgit@noble.brown/

The flow of conversation does sometimes jump between threads.

I'm very happy to respond you questions after you've absorbed all that.

NeilBrown
