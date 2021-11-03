Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3812444128
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKCMR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhKCMRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:17:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9937C061714;
        Wed,  3 Nov 2021 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uISvFElwAMaPZK+Lx7OyigFXQNR6wrUZM5dH9oFOj38=; b=pu9N443A2iBwqNYuGWTYuMHLlz
        hNuN93oM7RiM1o6jf8FS2HC7wldejyx1dozGgYYp6/CJFiTNW/6vjAH3aSNdhqzoSHrZNeBwWLJke
        oAv/Ud/GC9xFAaxqJqevAgyvYYPW2K8QDJpI8fWDMBt+h0+XrHnIUvzZDVMLae+P0qxg7TYlFPhOb
        QXSgta2mNRdCKLai16qdvw6D90QOeUf11fB6V4J+MOOZJ2LagOxERAoGcC4u1r0574TOEt2h/aN+V
        upY3cNYWYd9zfK6oqJxeTSUI7mwOmAI1ySm5+tFARqn+7Zm4ok6c/LdKNzkqgUAGoZPCtIiDdBKc1
        p5AZCYIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miFAF-0055jM-Ns; Wed, 03 Nov 2021 12:14:47 +0000
Date:   Wed, 3 Nov 2021 05:14:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/super.c: defer more work after super_block is off of
 the super_blocks list
Message-ID: <YYJ9NxENlOHAjKW4@bombadil.infradead.org>
References: <20211022232846.2890326-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022232846.2890326-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:28:46PM -0700, Luis Chamberlain wrote:
> Once it is off the super_blocks list we don't really need to hold the
> sb_lock anymore, we can defer the rest of the work. This reduces a few
> uneeded operations from contention from the sb_lock.
> 
> This is a minor optimization found through code inspection. If the
> sb_lock is not needed, no need for contention to wait while we free
> items. While at it, add a bit of documentation about the extent to
> which the sb_lock is used.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

*poke*

  Luis
