Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2D5BC3FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiISIHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISIHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C65DF98
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 01:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F162B61771
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 08:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2639C433C1;
        Mon, 19 Sep 2022 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663574842;
        bh=dCMQMZlbfFFynzqkotN2SZpZNnD3GMUHjU2mt7gOXIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJBxDVH8xJMkjkErM48AZ+pB0zM2yWRqrejqn1z5onvZdi8zF/ajMWJ2R5Gm1JB/+
         a3d3/qxDc1Pc0MV3JkEvLIKir3KYe0JcEiMZQR1GwvnIVVlmiz1zEpBwME84yihMCt
         p+nJLwtEZAedp7UuAst7JmbqUkfhcVD3XjuT/+iNB2EseMZbyEaaNCF5UF8vo68z16
         zYV2Yx92iE5Fb4t8+wNdv+aQ3Bk/JNncHDPyjAIPApkT9pA5vpaSPVMiVZuhKdOH63
         1UfM+HmRFnEqETbseUyckE2prFa5NqwoNnW3hKo6x/XbWLzFs4N+0kpZxd1R3NQqNv
         GIX/jSFcaeV2g==
Date:   Mon, 19 Sep 2022 10:07:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: port to vfs{g,u}id_t and associated helpers
Message-ID: <20220919080717.mgn2noszguledsfn@wittgenstein>
References: <20220909093019.936863-1-brauner@kernel.org>
 <87czc4rhng.fsf@mail.parknet.co.jp>
 <20220909102656.pqlipjit2zlp4vdx@wittgenstein>
 <878rmsralz.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878rmsralz.fsf@mail.parknet.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 09:33:12PM +0900, OGAWA Hirofumi wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Fri, Sep 09, 2022 at 07:01:07PM +0900, OGAWA Hirofumi wrote:
> >> Christian Brauner <brauner@kernel.org> writes:
> >> 
> >> > A while ago we introduced a dedicated vfs{g,u}id_t type in commit
> >> > 1e5267cd0895 ("mnt_idmapping: add vfs{g,u}id_t"). We already switched
> >> > over a good part of the VFS. Ultimately we will remove all legacy
> >> > idmapped mount helpers that operate only on k{g,u}id_t in favor of the
> >> > new type safe helpers that operate on vfs{g,u}id_t.
> >> 
> >> If consistent with other parts in kernel, looks good.
> >> 
> >> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >
> > Just to make sure: will you be taking this patch yourself or should I?
> 
> Ah, I was expecting almost all convert patches goes at once via you or
> vfs git.  However, if you want this goes via me, please let me know.

The patch is standalone which is why it would be great if you could just
take it. :)

Thanks!
Christian
