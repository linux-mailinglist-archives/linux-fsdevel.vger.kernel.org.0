Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3711F78AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKQZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 11:25:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKQZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xpsjH3Rxk+PTzoxkOgZp7C1flZE/0kiFWtXlSW8zmmw=; b=Peyngf2bhOnRCdtwxQx45nP8t
        wAM5uTHozveypsI8OvzwXiRStp/WogTr0roVN/uKHuLazBH7c+mWXnXqQ1PKU5tSSg1e3alIDQiv3
        FoYLONj0SfEZQMbaDMmpbxCW5xcYZ9L1SnHvEHDzhRtO7O0d7aMOcu56vmmClKNhy0qMGroZpe07j
        g0d71Zzb1txtXYa9dO7Wuxk56P3CgfiqUMc+4tpfGEmKjdkM/OmNWYfloVPA/ijo8jtYfxjeSq4E8
        eeVarnc5boRMwTbtMWZ2BRbavAOznWvd4Qfnl+WCs5qe+IPj7AwPuiJsA1G1sHW4F1KsiGV/oZmhZ
        fSLdpIETw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUCUv-0001T1-CH; Mon, 11 Nov 2019 16:25:01 +0000
Date:   Mon, 11 Nov 2019 08:25:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] fs/splice: ignore flag SPLICE_F_GIFT in syscall vmsplice
Message-ID: <20191111162501.GB24952@infradead.org>
References: <157338008330.5347.7117089871769008055.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157338008330.5347.7117089871769008055.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 10, 2019 at 01:01:23PM +0300, Konstantin Khlebnikov wrote:
> Generic support of flag SPLICE_F_MOVE in syscall splice was removed in
> kernel 2.6.21 commit 485ddb4b9741 ("1/2 splice: dont steal").
> Infrastructure stay intact and this feature may came back.
> At least driver or filesystem could provide own implementation.
> 
> But stealing mapped pages from userspace never worked and is very
> unlikely that will ever make sense due to unmapping overhead.
> Also lru handling is broken if gifted anon page spliced into file.
> 
> Let's seal entry point for marking page as a gift in vmsplice.

Please kill off PIPE_BUF_FLAG_GIFT entirely, there is no need to keep
dead code around.  Anyone who cares enough can resurrect it from git
history.
