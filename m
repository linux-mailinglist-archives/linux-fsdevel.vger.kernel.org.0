Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562D766371D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjAJCMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjAJCL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:11:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF8C64E4;
        Mon,  9 Jan 2023 18:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t4isnwaPds+By8w9NjXRQ7y3UOa8uxB3kQeBLXUK4fg=; b=i/HWzLSo+D2cbKhx/8SEbEizFK
        P0TngTO1MOyuAmNe6XUl3clfb9WDJDEOCERPBUoK3qMLfPKjba7bnR3zH3V11D+coEidcj2t5CZuf
        Td16+OsETzDN4FIR2JkMy4m8SUWJ0oizUZltCDoSHlV4XKf1coEYiBGz+S20ZVhitb+pDtCldj8kX
        wIaRLHrHDaS+BcMNtllbBJJvEMnJvgrXnnbPf6pHc7pqivfdNVrvzJdUUKXhUHLj4zI+WreE2R8Ek
        myuyC+5I6+Msj4+GtipPmKgRspbOrX5PBUtxJNX4f4pOYXlzlxOeTAjCjyeC86kU5tLd7IamOlPoO
        TH0xmuYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF473-004wY4-Su; Tue, 10 Jan 2023 02:11:41 +0000
Date:   Mon, 9 Jan 2023 18:11:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <Y7zJXRw2w6c0fFzY@bombadil.infradead.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
 <20210420125903.GC3604224@infradead.org>
 <20210420184703.GN4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420184703.GN4332@42.do-not-panic.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:47:03PM +0000, Luis Chamberlain wrote:
> On Tue, Apr 20, 2021 at 01:59:03PM +0100, Christoph Hellwig wrote:
> > > This also removes all the superflous freezer calls on all filesystems
> > > as they are no longer needed as the VFS now performs filesystem
> > > freezing/thaw if the filesystem has support for it. The filesystem
> > > therefore is in charge of properly dealing with quiescing of the
> > > filesystem through its callbacks.
> > 
> > Can you split that out from the main logic change?  Maybe even into one
> > patch per file system?
> 
> The issue with this is that once you do the changes in pm to
> freeze/suspend, if you leave the other changes in for the filesystems
> freeze / resume will stall, so all this needs to be an atomic operation
> if we want bisectable kernels.

So I'm thinking one way to split this up is to add an internal sb
flag for *if* a fs has support for this, and if so then we use the
generic fs freezer solution.

I'm not however too keen on the idea of mix and matching filesystems
on top of each other with different solutions, *but* if this makes it
easier for review / integration - it may be worth it. Let me know.

  Luis
