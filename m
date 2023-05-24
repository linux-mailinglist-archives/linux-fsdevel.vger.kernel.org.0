Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BA870EC9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 06:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEXEo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbjEXEoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 00:44:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6987184;
        Tue, 23 May 2023 21:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pw5jtrWc5mlEb+z3kqKdHdl+8xysLiTevuDCKnVl3+g=; b=TX5p/dGzVmaAST7FpCFc/xKhA0
        1gKps74vCkoJpNAXl8ge7RzmHhnqWMAON3aHn+yEv2ERxR0rpv4CrrdJReyS/HHYyX/Fu75Pr7lmj
        nDiBOEygAGuXj1rrotxkqMs4gfKhjm5E5CxqRv7dfJVRjRS6CMYP4fo1nSxqZA16DFW77Q0rbgh7/
        hgfE6nW6HHvYTu+B5TmJp+jkACbZYJwFyMazhuNpvOP4QsH47X9i3lpKvKuzP5fQxKcoixTriNvvi
        OSYF1IorfZnH1mWTOcx29w/wkEuyNT97ca5pnkFfXkj+MrgypNK1ypiwyLeLMeYMuq6EUDxQ+WMRJ
        /8wBzI0g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1gMh-00CL05-09;
        Wed, 24 May 2023 04:44:47 +0000
Date:   Tue, 23 May 2023 21:44:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 0/8] sysctl: Completely remove register_sysctl_table
 from sources
Message-ID: <ZG2WP5BeGHDIJj3d@bombadil.infradead.org>
References: <CGME20230523122224eucas1p1834662efdd6d8e6f03db5c52b6e0a7ea@eucas1p1.samsung.com>
 <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:22:12PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. It contains 2 patchsets that were originally sent
> separately. I have put them together because the second followed the first.
> 
> Parport driver uses the "CHILD" pointer in the ctl_table structure to create
> its directory structure. We move to the newer register_sysctl call and remove
> the pointer madness. I have separated the parport into 5 patches to clarify the
> different changes needed for the 3 calls to register_sysctl_paths.
> 
> We no longer export the register_sysctl_table call as parport was the
> last user from outside proc_sysctl.c. Also modified documentation slightly
> so register_sysctl_table is no longer mentioned.
> 
> Replace register_sysctl_table with register_sysctl effectively effectively
> transitioning 5 base paths ("kernel", "vm", "fs", "dev" and "debug") to the new
> call. Besides removing the actual function, I also removed it from the checks
> done in check-sysctl-docs. @mcgrof went a bit further and removed 2 more
> functions.
> 
> Testing for this change was done in the same way as with previous sysctl
> replacement patches: I made sure that the result of `find /proc/sys/ | sha1sum`
> was the same before and after the patchset.

Thanks! Queued up onto sysctl-next!

  Luis
