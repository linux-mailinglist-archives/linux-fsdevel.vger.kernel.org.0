Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8935F3AD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 02:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJDAwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDAwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:52:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8369C31ED1;
        Mon,  3 Oct 2022 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1t754NP8N0osI363iMCUeHbmoECWkhK/Mpr/5fY8eag=; b=W7K8LC8vPfeZ8Mak+cqgqN9XzF
        /3hEh2qMwDYd9QzwOIuEnCA8G7d+gtLTn/6KD32q9GnUEn26g+/znRAofzIJYKtmFrp7xhbceqqCD
        TvDe42X9VVXNX9jdHzoGrkfxBZ28+0eXGttkntyPGb5su7TsT+MDo+k7+D0vNPrSljCDw4zIHfKh1
        Qn10/jq4K33NN5oOwH1LSQZc/EPJwfayKZulJ358zihM+BwShTL5LMyI3qOFA3GPTVxbSOnxONlaS
        wCu00FDQGmGK+MvAtYY/l0TcgWdr6THcPEcYlL6xGhkNuo3Jj3Dne9No7/IJkhQ/PIdpK2Q/twxEa
        N6XbnpCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofWAZ-006fwJ-1f;
        Tue, 04 Oct 2022 00:52:23 +0000
Date:   Tue, 4 Oct 2022 01:52:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YzuDx8eTUVK74DIQ@ZenIV>
References: <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
 <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV>
 <4011.1664837894@jrobl>
 <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
 <Yzt+xvE88/OENka+@ZenIV>
 <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 03, 2022 at 05:37:24PM -0700, Linus Torvalds wrote:
> On Mon, Oct 3, 2022 at 5:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > OK, incremental is in #fixes, pushed out.
> 
> I'm assuming I'll still get a proper pull request. No?

Pull request follows; after all, whatever else is there, this is an obvious
fix for the breakage Okajima caught...

Al, very much hoping there's no other embarrassing fuckups lurking in that
thing ;-/

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 4f526fef91b24197d489ff86789744c67f475bb4:

  [brown paperbag] fix coredump breakage (2022-10-03 20:28:38 -0400)

----------------------------------------------------------------
fs/coredump fix

----------------------------------------------------------------
Al Viro (1):
      [brown paperbag] fix coredump breakage

 fs/coredump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
