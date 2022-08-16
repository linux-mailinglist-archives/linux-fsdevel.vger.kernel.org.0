Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933EC595DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiHPNrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiHPNrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446892F65;
        Tue, 16 Aug 2022 06:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E9960C43;
        Tue, 16 Aug 2022 13:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5A7C433D7;
        Tue, 16 Aug 2022 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660657608;
        bh=7mBGw86hBM02Re2npdyK3gkwA4s0sdGUvdvSWxUV1iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkigbmFA+q4QsvasGDagQ+ZOdeyUSXn9uy6PBAOiEZYuqtbGqh2m+/hNIqKc0Cj8X
         tETSOACtlIqQ0NErpMr81FhR6KGs/jgyRayvemg7b+D0aLL7Cm1M1mCmdNGnzGKMOo
         SLTrKavFwD7NfXFwdk5GcOme2p8mUVUoebqdEwMtK/JZbV1jtRkhfcsXGFifVamdbj
         eNT5X5VvSHnhWkc726OutRXGboBSgEeXroSpk31j2rfZHaatM4mHoLwrOdIdW82ulo
         upUgJDSavQsgB1OphD4LUTxh0/y8kRziO78HVbA/k5D3e4qXpNQXGPc1HT1WgJ7ZXk
         +Tg91eteA2U0g==
Date:   Tue, 16 Aug 2022 15:46:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
Message-ID: <20220816134643.gpdj4pmih3txzhto@wittgenstein>
References: <20220816131522.42467-1-jlayton@kernel.org>
 <20220816133340.mtaa7mxmgvhzffoh@wittgenstein>
 <46ecd0f938ecdc508505456f76e767e0ffcc7137.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46ecd0f938ecdc508505456f76e767e0ffcc7137.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:43:16AM -0400, Jeff Layton wrote:
> On Tue, 2022-08-16 at 15:33 +0200, Christian Brauner wrote:
> > On Tue, Aug 16, 2022 at 09:15:22AM -0400, Jeff Layton wrote:
> > > ext4 currently updates the i_version counter when the atime is updated
> > > during a read. This is less than ideal as it can cause unnecessary cache
> > > invalidations with NFSv4. The increment in ext4_mark_iloc_dirty is also
> > > problematic since it can also corrupt the i_version counter for
> > > ea_inodes.
> > > 
> > > We aren't bumping the file times in ext4_mark_iloc_dirty, so changing
> > > the i_version there seems wrong, and is the cause of both problems.
> > > Remove that callsite and add increments to the setattr and setxattr
> > > codepaths (at the same time that we update the ctime). The i_version
> > > bump that already happens during timestamp updates should take care of
> > > the rest.
> > > 
> > > Cc: Lukas Czerner <lczerner@redhat.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > Seems good to me. But it seems that the xfs patch you sent does have
> > inode_inc_version() right after setattr_copy() as well. So I wonder if
> > we couldn't just try and move inode_inc_version() into setattr_copy()
> > itself.
> > 
> 
> We probably could, but setattr_copy has a lot of callers and most
> filesystems don't need this.  Also, there are some cases where we don't
> want to update the i_version after a setattr.
> 
> In particular, if you do a truncate and the size doesn't change, then
> you really don't want to update the timestamps (and therefore the
> i_version shouldn't change either).

We could probably all handle that with some massaging but I'm also fine
with doing it just for ext4 and xfs if these are the only ones where
this is relevant:

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
