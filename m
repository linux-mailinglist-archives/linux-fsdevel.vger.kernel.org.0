Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246195BD014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiISPMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiISPM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:12:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25903057E;
        Mon, 19 Sep 2022 08:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9707DB81243;
        Mon, 19 Sep 2022 15:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED27C433D6;
        Mon, 19 Sep 2022 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663600345;
        bh=pv6zmGM6KDP6JaKJ7gu2d7pq+PXptBOnndUuReydMRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbFrFYW9LG1FLosIhDQocAkdG3Gw1WA6kXLD+DFHkdehsRVqO22OVjHb+EUSCrbvt
         s720krQQij3maO+WJk5kJK1967sZifDXSeqS9RgBjDsK5yK9TEjOGkMCaJjUewQ1gB
         zQFr3rj2GLKnx5mNh8keblv7Lk9eKALkRTwZmboPZWzFzN2tWJABdDOFEtHDOGaSXO
         1VsUflGcD9zV9FzddRraW+K72zvobMfjYTepDoL2+UzrxoOkfyYyob0NKmsrE6yJDF
         rOBvGzhGq6FclJreJKcJYfRfmT09+M6opgJlOrHMQtPNZtEY8uspfpNBQL3CdpDGLB
         IOdgZ+FlOyVhA==
Date:   Mon, 19 Sep 2022 17:12:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH (urgent)] vfs: fix uninitialized uid/gid in chown_common()
Message-ID: <20220919151220.htzmyesqt24xr26o@wittgenstein>
References: <00000000000008058305e9033f85@google.com>
 <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3411f396-a41e-76cb-7836-941fbade81dc@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 08:05:12PM +0900, Tetsuo Handa wrote:
> syzbot is reporting uninit-value in tomoyo_path_chown() [1], for
> chown_common() is by error passing uninitialized newattrs.ia_vfsuid to
> security_path_chown() via from_vfsuid() when user == -1 is passed.
> We must initialize newattrs.ia_vfs{u,g}id fields in order to make
> from_vfs{u,g}id() work.
> 
> Link: https://syzkaller.appspot.com/bug?extid=541e21dcc32c4046cba9 [1]
> Reported-by: syzbot <syzbot+541e21dcc32c4046cba9@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---

Odd that we didn't get any of the reports. Thanks for relying this.
I'll massage this a tiny bit, apply and will test with syzbot.
