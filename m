Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4E752100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGMMPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMMPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9E2D70;
        Thu, 13 Jul 2023 05:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEBC61087;
        Thu, 13 Jul 2023 12:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9076C433C7;
        Thu, 13 Jul 2023 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689250468;
        bh=2VVSIy1YZ66u0URdAb9GESE3Ic5mM5FmbuiUG5jkSKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROOrBY+vUzqBtWYfgvNr+oWUumBLUIExI8e4KPVZAbk9jOe/mSHZz2Fx5V5D7Nq6d
         pklJZAdKBchOP3cEdCUohJtMP6vdlPWDxi7w2qyIjAnSfED+/k/lpZyflOkNQ/tZMe
         sQe7OHJdmnLnyuyeQGGUvDtQoOSzkv3Rr/K4v/1TfobP1OXOruRSMQdGYL+58m7TlC
         UC19zseO9i6aNXVKrywHqmXe4yf2meURfMOr1KEKnIMREkT4TUTMvduosiS+MAX4gT
         FsnJvFNf+PhzdpoDDtwNp2SzPGGuXugKdmVyegXerXG6TPhAa6gZZYxhd7gUD7o/3a
         pyMd7Txw0b6PQ==
Date:   Thu, 13 Jul 2023 14:14:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] attr: block mode changes of symlinks
Message-ID: <20230713-noten-umhang-c5206ce37482@brauner>
References: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
 <20230713120042.GA23709@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713120042.GA23709@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:00:42PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 08:58:49PM +0200, Christian Brauner wrote:
> > (1) Filesystems that don't implement a i_op->setattr() for symlinks.
> > 
> >     Such filesystems may or may not know that without i_op->setattr()
> >     defined, notify_change() falls back to simple_setattr() causing the
> >     inode's mode in the inode cache to be changed.
> 
> Btw, I think this fallback is pretty harmful.  At some point we should
> probably start auditing all instances and wire the ones up that should
> be using simple_setattr (probably mostly just in-memory file systems)
> and refuse attribute changes if .setattr is NULL.

Yes, I agree. For example, it is an issue or at least a potential source
for bugs for procfs files. If they don't have a i_op->setattr() handler
they still get simple_setattr() which means that they accept ATTR_MODE
changes which they were explicitly stopped from doing in 2006 in commit
6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files").

