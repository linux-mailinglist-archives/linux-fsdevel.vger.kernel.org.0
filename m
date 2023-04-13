Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64016E17A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDMWlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDMWln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:41:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA1B45A;
        Thu, 13 Apr 2023 15:41:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DBFB21985;
        Thu, 13 Apr 2023 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681425670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE4Gz8QNDOpac6ho7oHefnQ9ZPFmOV/nlPQa16N1JsE=;
        b=wSxS05PEvufJpjIRzRFTkxpKPT4WT0hF1ponIlqRku/3R9oEbdg8U76le1XI3250w99eAX
        PUOIRkI3yxWH9J3AcR/YmYIn+xkdoOBzuQDd0xgr+F6GPZbc452TRJkT2pvHdgropAXIih
        yHVAJCUVV3erfh0eI0WkbrnAwJG3QS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681425670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE4Gz8QNDOpac6ho7oHefnQ9ZPFmOV/nlPQa16N1JsE=;
        b=72dHRHdgoLb1D7KsFn/KVkCB9DlEXLuczuX47I7dk1dtl4MlKYIn54yolFMQEOBNvpGkkH
        43NE1Axf7/mwNcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83FB013421;
        Thu, 13 Apr 2023 22:41:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A6byDQOFOGQCEAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 13 Apr 2023 22:41:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Dave Wysochanski" <dwysocha@redhat.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
In-reply-to: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
Date:   Fri, 14 Apr 2023 08:41:03 +1000
Message-id: <168142566371.24821.15867603327393356000@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Apr 2023, Jeff Layton wrote:
> David Wysochanski posted this a week ago:
>=20
>     https://lore.kernel.org/linux-nfs/CALF+zOnizN1KSE=3DV095LV6Mug8dJirqk7e=
N1joX8L1-EroohPA@mail.gmail.com/
>=20
> It describes a situation where there are nested NFS mounts on a client,
> and one of the intermediate mounts ends up being unexported from the
> server. In a situation like this, we end up being unable to pathwalk
> down to the child mount of these unreachable dentries and can't unmount
> anything, even as root.
>=20
> A decade ago, we did some work to make the kernel not revalidate the
> leaf dentry on a umount [1]. This helped some similar sorts of problems
> but it doesn't help if the problem is an intermediate dentry.
>=20
> The idea at the time was that umount(2) is a special case: We are
> specifically looking to stop using the mount, so there's nothing to be
> gained by revalidating its root dentry and inode.
>=20
> Based on the problem Dave describes, I'd submit that umount(2) is
> special in another way too: It's intended to manipulate the mount table
> of the local host, so contacting the backing store (the NFS server in
> this case) during a pathwalk doesn't really help anything. All we care
> about is getting to the right spot in the mount tree.
>=20
> A "modest" proposal:

I hope you didn't mean to reference
https://en.wikipedia.org/wiki/A_Modest_Proposal ...

> --------------------
> This is still somewhat handwavy, but what if we were to make umount(2)
> an even more special case for the pathwalk? For the umount(2) pathwalk,
> we could:
>=20
> 1/ walk down the dentry tree without calling ->d_revalidate: We don't
> care about changes that might have happened remotely. All we care about
> is walking down the cached dentries as they are at that moment.
>=20
> 2/ disallow ->lookup operations: a umount is about removing an existing
> mount, so the dentries had better already be there.
>=20
> 3/ skip inode ->permission checks. We don't want to check with the
> server about our permission to walk the path when we're looking to
> unmount. We're walking down the path on the _local_ machine so we can
> unuse it. The server should have no say-so in the matter. (We probably
> would want to require CAP_SYS_ADMIN or CAP_DAC_READ_SEARCH for this of
> course).
>=20
> We might need other safety checks too that I haven't considered yet.
>=20
> Is this a terrible idea? Are there potentially problems with
> containerized setups if we were to do something like this? Are there
> better ways to solve this problem (and others like it)? Maybe this would
> be best done with a new UMOUNT_CACHED flag for umount2()?

It might be a terrible idea, but it is essentially the same idea that I
had, but hadn't got around to posting.

The path name that appears in /proc/mounts is the key that must be used
to find and unmount a filesystem.  When you do that "find"ing you are
not looking up a name in a filesystem, you are looking up a key in the
mount table.

We could, instead, create an api that is given a mount-id (first number
in /proc/self/mountinfo) and unmounts that.  Then /sbin/umount could
read /proc/self/mountinfo, find the mount-id, and unmount it - all
without ever doing path name lookup in the traditional sense.

But I prefer your suggestion.  LOOKUP_MOUNTPOINT could be renamed
LOOKUP_CACHED, and it only finds paths that are in the dcache, never
revalidates, at most performs simple permission checks based on cached
content.

NeilBrown
