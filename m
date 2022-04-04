Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123364F1173
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiDDI5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiDDI5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:57:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DC3BA4D;
        Mon,  4 Apr 2022 01:55:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9B8E1F37E;
        Mon,  4 Apr 2022 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649062538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kY/sFAjkRuSr9SzS2qZmCVG0Hlopzp38fTG/CHvJ2jc=;
        b=TasKbmu/n1IUYJFmDMQsEy+BBf3khn33iVJQT4VKf1BUvZ6y9RYPl3jrQtydsBTyZ6Vrej
        9FpJoEEEK6OT9t5N42XWn7mRDNA5SfT8q6AuIgLePIxjgbZZdyG6tfrTClIg6tv/9D2DbT
        wuKm0s58O8sp9fJ31BgOw7dyo1NjC94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649062538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kY/sFAjkRuSr9SzS2qZmCVG0Hlopzp38fTG/CHvJ2jc=;
        b=eiURE+SEuasfHCDv84WkUWVOz4SY7GwrBlnkFdDdLy1TWbcahItaOBrtdGeWX17VdDI6VF
        QQBX9OE4Lmc6GgDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC6B4A3B83;
        Mon,  4 Apr 2022 08:55:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C4E9A0615; Mon,  4 Apr 2022 10:55:35 +0200 (CEST)
Date:   Mon, 4 Apr 2022 10:55:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220404085535.g2qr4s7itfunlrqb@quack3.lan>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220402105454.GA16346@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402105454.GA16346@amd>
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

On Sat 02-04-22 12:54:55, Pavel Machek wrote:
> > > Keeping reiserfs in the tree has certain costs.  For example, I would
> > > very much like to remove the 'flags' argument to ->write_begin.  We have
> > > the infrastructure in place to handle AOP_FLAG_NOFS differently, but
> > > AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.
> > > 
> > > Looking over the patches to reiserfs over the past couple of years, there
> > > are fixes for a few syzbot reports and treewide changes.  There don't
> > > seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
> > > still have a large install base that is just very happy with an old
> > > stable filesystem?  Or have all its users migrated to new and exciting
> > > filesystems with active feature development?
> > > 
> > > We've removed support for senescent filesystems before (ext, xiafs), so
> > > it's not unprecedented.  But while I have a clear idea of the benefits to
> > > other developers of removing reiserfs, I don't have enough information to
> > > weigh the costs to users.  Maybe they're happy with having 5.15 support
> > > for their reiserfs filesystems and can migrate to another filesystem
> > > before they upgrade their kernel after 5.15.
> > > 
> > > Another possibility beyond outright removal would be to trim the kernel
> > > code down to read-only support for reiserfs.  Most of the quirks of
> > > reiserfs have to do with write support, so this could be a useful way
> > > forward.  Again, I don't have a clear picture of how people actually
> > > use reiserfs, so I don't know whether it is useful or not.
> > > 
> > > NB: Please don't discuss the personalities involved.  This is purely a
> > > "we have old code using old APIs" discussion.
> > 
> > So from my distro experience installed userbase of reiserfs is pretty small
> > and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
> > for enterprise offerings it is unsupported (for like 3-4 years) and the module
> > is not in the default kernel rpm anymore.
> 
> I believe I've seen reiserfs in recent Arch Linux ARM installation on
> PinePhone. I don't really think you can remove a feature people are
> using.

Well, if someone uses Reiserfs they better either migrate to some other
filesystem or start maintaining it. It is as simple as that because
currently there's nobody willing to invest resources in it for quite a few
years and so it is just a question of time before it starts eating people's
data (probably it already does in some cornercases, as an example there are
quite some syzbot reports for it)...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
