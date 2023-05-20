Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DBE70A6A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjETJRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETJRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E61A1;
        Sat, 20 May 2023 02:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 079AF60FAF;
        Sat, 20 May 2023 09:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B076C433D2;
        Sat, 20 May 2023 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684574261;
        bh=mowLDJSazBRR389uypvAnkZ6SteMSeKtNBJ9Du8HS5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4zhr8OReoYGWjCxyrnnJPmEBBPax2FUJlVJ6fON3YjXnloiSN8wGWlZgfC7Z9y0X
         aYoR8THbEudStlUXj+9y10YshY3tcQRxcWsaV4fT9H+hKDsG717IEI6JqlvctuvyKt
         OwsCbPBAzwNGUUmoS4pANmD//mFetFtlKIWKCKqFbNatHTd5/EUzNoWWgQJNGba7d1
         jPFD0da4bqaDI0MrBApqwJaNUMqENuhEcHIKJoXuN1PdgI/A0HIB/Wsib+HutoTS7u
         7Yl3qYyLOIJaqcoUKvQ1dXFsHTOD+PsKsS0NDTt9NEuslShts07XAaKrVR5B5ALwVL
         u+6l3bPVS9UYA==
Date:   Sat, 20 May 2023 11:17:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after
 writes
Message-ID: <20230520-angenehm-orangen-80fdce6f9012@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 03:42:38PM -0400, Mimi Zohar wrote:
> On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > So, I think we want both; we want the ovl_copyattr() and the
> > vfs_getattr_nosec() change:
> > 
> > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> >     is in line what we do with all other inode attributes. IOW, the
> >     overlayfs inode's i_version counter should aim to mirror the
> >     relevant layer's i_version counter. I wouldn't know why that
> >     shouldn't be the case. Asking the other way around there doesn't
> >     seem to be any use for overlayfs inodes to have an i_version that
> >     isn't just mirroring the relevant layer's i_version.
> > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> >     Currently, ima assumes that it will get the correct i_version from
> >     an inode but that just doesn't hold for stacking filesystem.
> > 
> > While (1) would likely just fix the immediate bug (2) is correct and
> > _robust_. If we change how attributes are handled vfs_*() helpers will
> > get updated and ima with it. Poking at raw inodes without using
> > appropriate helpers is much more likely to get ima into trouble.
> 
> In addition to properly setting the i_version for IMA, EVM has a
> similar issue with i_generation and s_uuid. Adding them to
> ovl_copyattr() seems to resolve it.   Does that make sense?
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 923d66d131c1..cd0aeb828868 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
>  	inode->i_atime = realinode->i_atime;
>  	inode->i_mtime = realinode->i_mtime;
>  	inode->i_ctime = realinode->i_ctime;
> +	inode->i_generation = realinode->i_generation;
> +	if (inode->i_sb)
> +		uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-

Overlayfs can consist of multiple lower layers and each of those lower
layers may have a different uuid. So everytime you trigger a
ovl_copyattr() on a different layer this patch would alter the uuid of
the overlayfs superblock.

In addition the uuid should be set when the filesystem is mounted.
Unless the filesystem implements a dedicated ioctl() - like ext4 - to
change the uuid.
