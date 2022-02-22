Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609D4BF555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBVKEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVKEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:04:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71886A1BDC;
        Tue, 22 Feb 2022 02:04:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3133421114;
        Tue, 22 Feb 2022 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645524249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGfyKWdEZJhA5+6FN5DHdSypDyy+shnNAH3syJfBIhw=;
        b=fZBn/89ZZ6v6UmwwwdiXYAKlVaPaicKVlFrMRrjRsuIg+qha1jJe52hIbeUj/Ou8+FoxGn
        1cxY8IvRDu6adoTND6bnEMzHGaPT4m1SN3y9b+dJp4u9TiTNfNJfB3iGiVi2GZwJSxIJQK
        sxMy0MBE0iA1ofp773/AvwesyjMgtb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645524249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGfyKWdEZJhA5+6FN5DHdSypDyy+shnNAH3syJfBIhw=;
        b=gUyIalokRoQw6vM3QJW4ZE4IYfyI+MvEfaOOT6h4z5naBLtUqhtzXIpz2AQEHPGX/uP8ME
        Qr0jYJVeXr+qZYAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21483A3B81;
        Tue, 22 Feb 2022 10:04:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9607A0606; Tue, 22 Feb 2022 11:04:08 +0100 (CET)
Date:   Tue, 22 Feb 2022 11:04:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhIwUEpymVzmytdp@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Sun 20-02-22 12:13:04, Matthew Wilcox wrote:
> Keeping reiserfs in the tree has certain costs.  For example, I would
> very much like to remove the 'flags' argument to ->write_begin.  We have
> the infrastructure in place to handle AOP_FLAG_NOFS differently, but
> AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.
> 
> Looking over the patches to reiserfs over the past couple of years, there
> are fixes for a few syzbot reports and treewide changes.  There don't
> seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
> still have a large install base that is just very happy with an old
> stable filesystem?  Or have all its users migrated to new and exciting
> filesystems with active feature development?
> 
> We've removed support for senescent filesystems before (ext, xiafs), so
> it's not unprecedented.  But while I have a clear idea of the benefits to
> other developers of removing reiserfs, I don't have enough information to
> weigh the costs to users.  Maybe they're happy with having 5.15 support
> for their reiserfs filesystems and can migrate to another filesystem
> before they upgrade their kernel after 5.15.
> 
> Another possibility beyond outright removal would be to trim the kernel
> code down to read-only support for reiserfs.  Most of the quirks of
> reiserfs have to do with write support, so this could be a useful way
> forward.  Again, I don't have a clear picture of how people actually
> use reiserfs, so I don't know whether it is useful or not.
> 
> NB: Please don't discuss the personalities involved.  This is purely a
> "we have old code using old APIs" discussion.

So from my distro experience installed userbase of reiserfs is pretty small
and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
for enterprise offerings it is unsupported (for like 3-4 years) and the module
is not in the default kernel rpm anymore.

So clearly the filesystem is on the deprecation path, the question is
whether it is far enough to remove it from the kernel completely. Maybe
time to start deprecation by printing warnings when reiserfs gets mounted
and then if nobody yells for year or two, we'll go ahead and remove it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
