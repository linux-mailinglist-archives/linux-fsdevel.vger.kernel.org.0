Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8998376F90D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 06:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjHDEmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 00:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHDEmD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89BF180;
        Thu,  3 Aug 2023 21:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7D461F29;
        Fri,  4 Aug 2023 04:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2CAC433C7;
        Fri,  4 Aug 2023 04:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691124118;
        bh=483xcLasT3cOTrxUXGXtibomqh1U7dTQNKUfCSr0aBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5REp5QCvmmZ5NkRVkpLVzwl0MiA0bI+SR/XdKPOcj8jqYI9WZirVeVplh/2b8i1Q
         roMrmCG242fT9QQP/B2bahS2aNCanlpWUGftxZuIbblqajP7uYnt3CooErFske5t4g
         R+QR6PwE4Ep8t+ytmnWsxvrLeLG1icA6PKo9AjEUwZ7LH1oZ3oFAY/4nXil3iX4+vA
         L4LoulTP72IR06STRpxXRzAZLIvnHt4E6Bo1COwKnQtJCZ5EDh/GyiRXsvVHnXfgbH
         5DVV3KdP4hb0TvqM8L/+Dl1U8wbW3hbkY0Df0x54CEFX47+EdJC3edb41g3+Up+alm
         3viLGtON5P+0Q==
Date:   Thu, 3 Aug 2023 21:41:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230804044156.GB1954@sol.localdomain>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-4-krisman@suse.de>
 <20230729042048.GB4171@sol.localdomain>
 <875y5w10ye.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y5w10ye.fsf@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 01:37:45PM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > On Thu, Jul 27, 2023 at 01:28:39PM -0400, Gabriel Krisman Bertazi wrote:
> >>   - In __lookup_slow, either the parent inode is read locked by the
> >>     caller (lookup_slow), or it is called with no flags (lookup_one*).
> >>     The read lock suffices to prevent ->d_name modifications, with the
> >>     exception of one case: __d_unalias, will call __d_move to fix a
> >>     directory accessible from multiple dentries, which effectively swaps
> >>     ->d_name while holding only the shared read lock.  This happens
> >>     through this flow:
> >> 
> >>     lookup_slow()  //LOOKUP_CREATE
> >>       d_lookup()
> >>         ->d_lookup()
> >>           d_splice_alias()
> >>             __d_unalias()
> >>               __d_move()
> >> 
> >>     Nevertheless, this case is not a problem because negative dentries
> >>     are not allowed to be moved with __d_move.
> >
> > Isn't it possible for a negative dentry to become a positive one concurrently?
> 
> Do you mean d_splice_alias racing with a dentry instantiation and
> __d_move being called on a negative dentry that is turning positive?
> 
> It is not possible for __d_move to be called with a negative dentry for
> d_splice_alias, since the inode->i_lock is locked during __d_find_alias,
> so it can't race with __d_instantiate or d_add. Then, __d_find_alias
> can't find negative dentries in the first place, so we either have a
> positive dentry, in which case __d_move is fine with regard to
> d_revalidate_name, or we don't have any aliases and don't call
> __d_move.
> 
> Can you clarify what problem you see here?
> 

I agree that negative dentries can't be moved --- I pointed this out earlier
(https://lore.kernel.org/linux-fsdevel/20230720060657.GB2607@sol.localdomain).
The question is whether if ->d_revalidate sees a negative dentry, when can it
assume that it remains a negative dentry for the remainder of ->d_revalidate.
I'm not sure there is a problem, I just don't understand your explanation.

- Eric
