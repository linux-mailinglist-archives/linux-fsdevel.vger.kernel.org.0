Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6A37EE95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbhELVxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392620AbhELViE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:38:04 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A7C061761;
        Wed, 12 May 2021 14:24:32 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 70BC5C009; Wed, 12 May 2021 23:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620854671; bh=iu3EAcBcCCyh2dvMo7i/UfETwu/cAjPrs9y/9IF/rzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqFP10EOCURuFkF2xT3PfYLIY2J/Vt5P+TKC+LR86EYnDVWOiW1p0DaJC80tMytf1
         5gN1vjC8t9tFEqHpcBzo3MjbeWnOyCsh8VwxR5wFwId+U1nHFIRPH6eGU0XnRQ4jGI
         /SsgIMi1W6qyOOjrlalZ0AkA2TawlTgrts/qqk1u1tjlJlAt9rRxfyrsKFQdSmvLLf
         60gftBiNyOvw241iDw7Ixc/ONci3OhTq0SqB2Hha0ZnGEU8kohnF+cJ0zDC9kYAG5Q
         lc4JRWj/hSOa3rKODk9l9X+dxBTJt4b/LxGbsKWpas3N+o/AEZ0xIdPNB8szmgh/1g
         RaInV+L3PfTbA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 63EE0C009;
        Wed, 12 May 2021 23:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620854671; bh=iu3EAcBcCCyh2dvMo7i/UfETwu/cAjPrs9y/9IF/rzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqFP10EOCURuFkF2xT3PfYLIY2J/Vt5P+TKC+LR86EYnDVWOiW1p0DaJC80tMytf1
         5gN1vjC8t9tFEqHpcBzo3MjbeWnOyCsh8VwxR5wFwId+U1nHFIRPH6eGU0XnRQ4jGI
         /SsgIMi1W6qyOOjrlalZ0AkA2TawlTgrts/qqk1u1tjlJlAt9rRxfyrsKFQdSmvLLf
         60gftBiNyOvw241iDw7Ixc/ONci3OhTq0SqB2Hha0ZnGEU8kohnF+cJ0zDC9kYAG5Q
         lc4JRWj/hSOa3rKODk9l9X+dxBTJt4b/LxGbsKWpas3N+o/AEZ0xIdPNB8szmgh/1g
         RaInV+L3PfTbA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id af7d1893;
        Wed, 12 May 2021 21:24:26 +0000 (UTC)
Date:   Thu, 13 May 2021 06:24:11 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [V9fs-developer] Removing readpages aop
Message-ID: <YJxHe+8qn6yYLld3@codewreck.org>
References: <YJvwVq3Gl35RQrIe@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJvwVq3Gl35RQrIe@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote on Wed, May 12, 2021 at 04:12:22PM +0100:
> In Linus' current tree, there are just three filesystems left using the
> readpages address_space_operation:
> 
> $ git grep '\.readpages'
> fs/9p/vfs_addr.c:       .readpages = v9fs_vfs_readpages,
> fs/cifs/file.c: .readpages = cifs_readpages,
> fs/nfs/file.c:  .readpages = nfs_readpages,
> 
> I'd love to finish getting rid of ->readpages as it would simplify
> the VFS.  AFS and Ceph were both converted since 5.12 to use
> netfs_readahead().  Is there any chance we might get the remaining three
> filesystems converted in the next merge window?

David sent me a mostly-working implementation for netfs and it does get
rid of readpages, so it's just a matter of finding time for thorough
tests and cleanups...
I'd also like to let it sit in -next for a while (let's say at least one
month), so realistically I need to look at it within the next few weeks
and I honestly probably won't have time with my current schedule... But
it'll definitely be done for 5.15 (next's next merge window), and
probably in -next in ~2ish months if that's good enough for you.


If you can convince me both cifs and nfs will get it done before then I
might reconsider priorities :-D

-- 
Dominique
