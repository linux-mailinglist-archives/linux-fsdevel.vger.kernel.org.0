Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA594BECDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiBUWAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 17:00:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiBUWAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:00:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDEB22BE2;
        Mon, 21 Feb 2022 13:59:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12A701F394;
        Mon, 21 Feb 2022 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645480786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amkKzkJIzKNate+BxqSEOR/ytWm/qtbc3ZtFRsmXvBM=;
        b=ewbLWa07/OWM66IgZRicpm+p2kQSmHWSjBx7karBkmzsU+Am9Luj52I81aK1VcCcKpG32U
        7Kte65o7tKx3lwtmEtBhfLp/I754vnHVTpUidbU+VehJwQiiR7ivpHn3oYqKSKyQt4M56r
        lnDj7pdx6RLhot+T27GJQqjzneXL59s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645480786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amkKzkJIzKNate+BxqSEOR/ytWm/qtbc3ZtFRsmXvBM=;
        b=usMGoFll1fN7Jr8ihiuzN2Oyjbu3A2BOIGQk9PcT0THkbOsGhKeeSZDikNFJsuzviRbtq4
        Aa0N9GleGZknZUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2812613BA5;
        Mon, 21 Feb 2022 21:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v/pjNU8LFGISZwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 21 Feb 2022 21:59:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     "Josef Bacik" <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
In-reply-to: <20220217145422.C7EC.409509F4@e16-tech.com>
References: <20220217125253.0F07.409509F4@e16-tech.com>,
 <164507395131.10228.17031212675231968127@noble.neil.brown.name>,
 <20220217145422.C7EC.409509F4@e16-tech.com>
Date:   Tue, 22 Feb 2022 08:59:41 +1100
Message-id: <164548078112.17923.854375583220948734@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Feb 2022, Wang Yugui wrote:
> Hi,
>=20
> > On Thu, 17 Feb 2022, Wang Yugui wrote:
> > > Hi,
> > > Cc: NeilBrown
> > >=20
> > > btrfs cross-vfsmount reflink works well now with these 2 patches.
> > >=20
> > > [PATCH] fs: allow cross-vfsmount reflink/dedupe
> > > [PATCH] btrfs: remove the cross file system checks from remap
> > >=20
> > > But nfs over btrfs still fail to do cross-vfsmount reflink.
> > > need some patch for nfs too?
> >=20
> > NFS doesn't support reflinks at all, does it?
>=20
> NFS support reflinks now.
>=20
> # df -h /ssd
> Filesystem              Type  Size  Used Avail Use% Mounted on
> T640:/ssd               nfs4   17T  5.5T   12T  34% /ssd
> # /bin/cp --reflink=3Dalways /ssd/1.txt /ssd/2.txt
> # uname -a
> Linux T7610 5.15.24-3.el7.x86_64 #1 SMP Thu Feb 17 12:13:25 CST 2022 x86_64=
 x86_64 x86_64 GNU/Linux
>=20

So it does ..... ahhh, the CLONE command in NFSv4.2.....
This is used by the .remap_file_range file operation.  That operation
only gets called when the "from" and "to" files have the same
superblock.
btrfs has an ....  interesting concept of filesystem identity.  While
different "subvols" have the same superblock locally, when they are
exported over NFS they appear to be different filesystems and so have
different superblocks.  This is in part because btrfs cannot create
properly unique inode numbers across the whole filesystem.
Until btrfs sorts itself out, it will not be able to work with NFS
properly.

NeilBrown
