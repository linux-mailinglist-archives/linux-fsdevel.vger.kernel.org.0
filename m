Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448E77616A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjHINlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHINln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:41:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5C1986
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3TRNqmcaEGWcqiDRqyA2b3ib5K8DQ6i1timI+5pEw34=; b=Bd2Opyajb45fFr2wKhQzsXDLu7
        mnzwHp0JaARZ+eAmLjiv8nlwo14v4YA6lEdxQBGD6aBAjB0kflFxrzMBWTd4PGLn+1uxy4ncjbRH9
        7hnljHdlosVjZWagAs1di2LuKBAe1c/LQD8CSI8SC0KiQ2MWBtY/CKJDsdx59LO7LmqRB3ufMiUH+
        H4OtiIQUmeGBGr5lpdxbDs3+ynDbwCZb3eiaRW9pnIvDRXOWAlbEkbDp7+AwndTXtNkf38uVRifI3
        WgtTOoS3ymngTQNcQHJz7da0B4s5U+/IeRhb/pgUxKzYzcEJNj0djhFfl1Uysu1jL4qABLDjFkwIi
        qUJMRQhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qTjR7-0053pV-30;
        Wed, 09 Aug 2023 13:41:17 +0000
Date:   Wed, 9 Aug 2023 06:41:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 4/5] tmpfs: trivial support for direct IO
Message-ID: <ZNOXfanlsgTrAsny@infradead.org>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <7c12819-9b94-d56-ff88-35623aa34180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c12819-9b94-d56-ff88-35623aa34180@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please do not add a new ->direct_IO method.  I'm currently working hard
on removing it, just set FMODE_CAN_ODIRECT and handle the fallback in
your read_iter/write_iter methods.

But if we just start claiming direct I/O support for file systems that
don't actually support it, I'm starting to seriously wonder why we
bother with the flag at all and don't just allow O_DIRECT opens
to always succeed..

