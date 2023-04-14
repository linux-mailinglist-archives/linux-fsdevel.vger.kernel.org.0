Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFEF6E201F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDNKCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNKCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3E76B4;
        Fri, 14 Apr 2023 03:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B0B645FF;
        Fri, 14 Apr 2023 10:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FEFC433D2;
        Fri, 14 Apr 2023 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681466521;
        bh=Po//8bQ/Ud+UwSwJ0EqALVbU8j/ZFbLNuOKXcDcPfdw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AXmN+IFfWPL1qt4B913nrLJyterbuNFqpe023OtZ3Au63xFm+i5zAwDbwTjTSJ0wW
         Nb5sac80ET/87acJrH5oqXSdMIF55R94YjKWL8S5K2xPbV7vu7e39mP7O8WvSnJYub
         QjD8+LASf1zaLPZ/mPiTNZff7kxVkGdC1UyH3MWzv612a4rO/+Od6kzjdwnt74otdO
         7W1s++0zueHmnxMocVw05RKgifW+Jkn3tGR7EHW4RDnewqPwhzVfGIWcbx+iWjzuLv
         8vOjOI8RNyTW+RNMk3Vq0H3WQtJ9NNLmth6zQ1EWg3rJPfOpsKhfukd1AU1WpY+XWM
         c3ep4mxBPzzDQ==
Message-ID: <8d2c619d2a91f3ac925fbc8e4fc467c6b137ab14.camel@kernel.org>
Subject: Re: allowing for a completely cached umount(2) pathwalk
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>
Date:   Fri, 14 Apr 2023 06:01:59 -0400
In-Reply-To: <20230414023211.GE3390869@ZenIV>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <20230414023211.GE3390869@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-14 at 03:32 +0100, Al Viro wrote:
> On Thu, Apr 13, 2023 at 06:00:42PM -0400, Jeff Layton wrote:
>=20
> > It describes a situation where there are nested NFS mounts on a client,
> > and one of the intermediate mounts ends up being unexported from the
> > server. In a situation like this, we end up being unable to pathwalk
> > down to the child mount of these unreachable dentries and can't unmount
> > anything, even as root.
>=20
> So umount -l the stuck sucker.  What's the problem with that?
>=20

You mean lazy umount the parent that is stuck? What happens to the child
mount in that case? Is it also eventually cleaned up?

> > 2/ disallow ->lookup operations: a umount is about removing an existing
> > mount, so the dentries had better already be there.
>=20
> That changes the semantics; as it is, you need exec permissions on the
> entire path...
>=20

Yep. But, I think it makes some sense to do so in the context of a
umount. Mostly, umount is done by a privileged user anyway so avoiding
permission checks isn't too great a stretch, IMO.

> > Is this a terrible idea? Are there potentially problems with
> > containerized setups if we were to do something like this? Are there
> > better ways to solve this problem (and others like it)? Maybe this woul=
d
> > be best done with a new UMOUNT_CACHED flag for umount2()?
>=20
> We already have lazy umount.  And what will you do to symlinks you run
> into along the way?  They *are* traversed; requiring the caller to
> canonicalize them will only shift the problem to userland...

Yeah, I hadn't considered symlinks here. Still, if we have a cached
symlink dentry, wouldn't we also already have the symlink target in
cache too? Or is that not guaranteed?

--=20
Jeff Layton <jlayton@kernel.org>
