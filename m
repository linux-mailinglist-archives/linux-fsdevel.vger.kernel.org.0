Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31FE5BD858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 01:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiISXlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiISXlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:41:06 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BFB480;
        Mon, 19 Sep 2022 16:41:03 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1EB661012; Mon, 19 Sep 2022 18:41:02 -0500 (CDT)
Date:   Mon, 19 Sep 2022 18:41:02 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH (urgent)] vfs: fix uninitialized uid/gid in chown_common()
Message-ID: <20220919234102.GA21118@mail.hallyn.com>
References: <00000000000008058305e9033f85@google.com>
 <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
 <20220919151220.htzmyesqt24xr26o@wittgenstein>
 <20220919151414.excah6gywyposvfj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919151414.excah6gywyposvfj@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:14:14PM +0200, Christian Brauner wrote:
> On Mon, Sep 19, 2022 at 05:12:25PM +0200, Christian Brauner wrote:
> > On Mon, Sep 19, 2022 at 08:05:12PM +0900, Tetsuo Handa wrote:
> > > syzbot is reporting uninit-value in tomoyo_path_chown() [1], for
> > > chown_common() is by error passing uninitialized newattrs.ia_vfsuid to
> > > security_path_chown() via from_vfsuid() when user == -1 is passed.
> > > We must initialize newattrs.ia_vfs{u,g}id fields in order to make
> > > from_vfs{u,g}id() work.
> > > 
> > > Link: https://syzkaller.appspot.com/bug?extid=541e21dcc32c4046cba9 [1]
> > > Reported-by: syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > ---
> > 
> > Odd that we didn't get any of the reports. Thanks for relying this.
> > I'll massage this a tiny bit, apply and will test with syzbot.
> 
> Fyi, Seth.

Because the modules are ignoring ia_valid & ATTR_XID?
