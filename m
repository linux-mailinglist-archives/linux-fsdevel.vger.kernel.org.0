Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7C7520B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjGMMAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjGMMAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:00:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0A1FC9;
        Thu, 13 Jul 2023 05:00:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84E3C6732D; Thu, 13 Jul 2023 14:00:43 +0200 (CEST)
Date:   Thu, 13 Jul 2023 14:00:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] attr: block mode changes of symlinks
Message-ID: <20230713120042.GA23709@lst.de>
References: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:58:49PM +0200, Christian Brauner wrote:
> (1) Filesystems that don't implement a i_op->setattr() for symlinks.
> 
>     Such filesystems may or may not know that without i_op->setattr()
>     defined, notify_change() falls back to simple_setattr() causing the
>     inode's mode in the inode cache to be changed.

Btw, I think this fallback is pretty harmful.  At some point we should
probably start auditing all instances and wire the ones up that should
be using simple_setattr (probably mostly just in-memory file systems)
and refuse attribute changes if .setattr is NULL.

