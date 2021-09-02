Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64D3FE83C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 06:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhIBEH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 00:07:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhIBEH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 00:07:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0075C1FF59;
        Thu,  2 Sep 2021 04:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630555620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1RSALV8ApOsm1VHTw7KqnnrgJfw7xIPxpqw2LXq714=;
        b=ipd7HaDrjsAFqEPTt8UU3uW66e+1+FRewur3IXDnUnc9jm0LuifHDKcMlY9FinxViYlc22
        yx4kLnfUaPIHFR3M7Z4IfVGc7QHTx+mUTodY+NC4fKr1itncGOEuwqyT/mAyzhZAahXyUE
        f/V8mvpEjt3yi7gqX3ps2qUxlEBLLhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630555620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1RSALV8ApOsm1VHTw7KqnnrgJfw7xIPxpqw2LXq714=;
        b=lU1We/H9nFR8uLtEfARHTPne2mX+fjb9T87nb1//xllCkd2ViP4AgStcga3JI8D/jYO2Am
        6xVoQtdbYUwtQnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C9A313AE9;
        Thu,  2 Sep 2021 04:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ISgwMuFNMGGPewAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 02 Sep 2021 04:06:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <YS8ppl6SYsCC0cql@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>
Date:   Thu, 02 Sep 2021 14:06:54 +1000
Message-id: <163055561473.24419.12486186372497472066@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 01 Sep 2021, Christoph Hellwig wrote:
> On Tue, Aug 31, 2021 at 02:59:05PM +1000, NeilBrown wrote:
> > Making the change purely in btrfs is simply not possible.  There is no
> > way for btrfs to provide nfsd with a different inode number.  To move
> > the bulk of the change into btrfs code we would need - at the very least
> > - some way for nfsd to provide the filehandle when requesting stat
> > information.  We would also need to provide a reference filehandle when
> > requesting a dentry->filehandle conversion.  Cluttering the
> > export_operations like that just for btrfs doesn't seem like the right
> > balance.  I agree that cluttering kstat is not ideal, but it was a case
> > of choosing the minimum change for the maximum effect.
>=20
> So you're papering over a btrfs bug by piling up cludges in the nsdd
> code that has not business even knowing about this btrfs bug, while
> leaving other users of inodes numbers and file handles broken?
>=20
> If you only care about file handles:  this is what the export operations
> are for.  If you care about inode numbers:  well, it is up to btrfs
> to generate uniqueue inode numbers.  It currently doesn't do that, and
> no amount of papering over that in nfsd is going to fix the issue.
>=20
> If XORing a little more entropy into the inode number is a good enough
> band aid (and I strongly disagree with that), do it inside btrfs for
> every place they report the inode number.  There is nothing NFS-specific
> about that.
>=20

Hi Christoph,
 I have to say that I struggle with some of these conversations with
 you.
 I don't know if it is deliberate on your part, or inadvertent, or
 purely in my imagination, but your attitude often seems combative.  I
 find that to be a disincentive to continuing to engage, which I need to
 work hard to overcome.  If I'm misunderstanding you, I apologise and
 simply ask that you do what you can to compensate for my apparent
 sensitivity.

 Your attitude seems to be that this is a btrfs problem and must be
 fixed in btrfs.  I agree about the source of the problem - specifically:
  Commit 3394e1607eaf ("Btrfs: Give each subvol and snapshot their own anonym=
ous devid")
 took a wrong turn.  But I don't think we can completely isolate any
 part of the kernel, and we need to work together to solve problems that
 affect us, no matter the cause.  Similarly our code needs to work
 together.

 Highlighting the various problems with the proposed solution doesn't
 help a lot - they are fairly obvious.  Proposing solutions would be
 much more helpful, and I have no doubt that your different experience
 and perspective could help me see things that I have missed.   Any help
 that you can provide would certainly be appreciated.

Thanks,
NeilBrown
