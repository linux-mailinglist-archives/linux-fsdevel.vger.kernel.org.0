Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635965BD8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 02:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiITAZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 20:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITAZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:25:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379727DC4;
        Mon, 19 Sep 2022 17:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0027DB80A4A;
        Tue, 20 Sep 2022 00:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785D0C433D6;
        Tue, 20 Sep 2022 00:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663633540;
        bh=QwuQMl9wFShqaF+4Yx7SmnjCoadogeCd3Hp2DV/PX8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmtcFfz7FU4DWKwV8H+VVNkfxgZmm+zd8qcJAJhwDX0puF9OHeOYtm2NuG1ds0X0P
         51ZdFb916cPeL7dPnleTPiHLpX9LY9gN42b8x1pMc4VJvUkjao9aBgBhPMMX2UDfYJ
         HZDhSH6NnLruhOlOIOkkExVyvtse5gFKc7V5u/jp8jcLVteXgg7WhxfJbLtYcQvAqQ
         bzB8WqMlU83xQC7ypVYNYyhtziH71LMMe+8maEbzqv78VQKFP15qafOSVQEIczoZef
         sTckwQ1rch5GBi+T5r9R6vN5AjPTWxI9jwmaAbHSw+yfVqAKKBgszRC9RqS8kBY4mf
         GiWS0L4RLU4Dg==
Date:   Mon, 19 Sep 2022 19:25:39 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH (urgent)] vfs: fix uninitialized uid/gid in chown_common()
Message-ID: <YykIg4PRC3XZoJ9A@do-x1extreme>
References: <00000000000008058305e9033f85@google.com>
 <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
 <20220919151220.htzmyesqt24xr26o@wittgenstein>
 <20220919151414.excah6gywyposvfj@wittgenstein>
 <20220919234102.GA21118@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919234102.GA21118@mail.hallyn.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 06:41:02PM -0500, Serge E. Hallyn wrote:
> On Mon, Sep 19, 2022 at 05:14:14PM +0200, Christian Brauner wrote:
> > On Mon, Sep 19, 2022 at 05:12:25PM +0200, Christian Brauner wrote:
> > > On Mon, Sep 19, 2022 at 08:05:12PM +0900, Tetsuo Handa wrote:
> > > > syzbot is reporting uninit-value in tomoyo_path_chown() [1], for
> > > > chown_common() is by error passing uninitialized newattrs.ia_vfsuid to
> > > > security_path_chown() via from_vfsuid() when user == -1 is passed.
> > > > We must initialize newattrs.ia_vfs{u,g}id fields in order to make
> > > > from_vfs{u,g}id() work.
> > > > 
> > > > Link: https://syzkaller.appspot.com/bug?extid=541e21dcc32c4046cba9 [1]
> > > > Reported-by: syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>
> > > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > ---
> > > 
> > > Odd that we didn't get any of the reports. Thanks for relying this.
> > > I'll massage this a tiny bit, apply and will test with syzbot.
> > 
> > Fyi, Seth.
> 
> Because the modules are ignoring ia_valid & ATTR_XID?

security_path_chown() takes ids as arguments, not struct iattr.

  int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)

The ones being passed are now taken from iattr and thus potentially not
initialized. Even if we change it to only call security_path_chown()
when one of ATTR_{U,G}ID is set the other might not be set, so
initializing iattr.ia_vfs{u,g}id makes sense to me and should match the
old behavior of passing invalid ids in this situation.

What I don't understand is why security_path_chown() is even necessary
when we also have security_inode_setattr(), which also gets called
during chown and gets the full iattr struct. Maybe there's a good
reason, but at first glance it seems like it could do any checks that
security_path_chown() is doing.

Seth
