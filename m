Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2930B3077D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhA1OT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhA1OTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:19:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2606C061573;
        Thu, 28 Jan 2021 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TYnEXyENdTL08yox8Q0iM91WtAIddM3z/GprLWi6j/8=; b=NybUTpjDIDFiQ8bmQH+RKxrQ6+
        a9oYLHp006ug9/xmc00rUss8VzNjwlQ0jCku4Bs+fqKdQBM+YTO8CaOXlaXieo4jh7UMw4nYc+0FJ
        rI1UPhM8N8noKBrGjkzXShRoS1VO/o+1BuI02Ot0UxnVB4EMSAaW5o36U2D/ehH2Spsu9oUkKCNsw
        rx7h/DysVNUq16MExTCyLSOqbb4z9x6cy4F0R+kA2+XWGeJ9Md/X1Z3L86CzoLhVLtWWfRqbriuQk
        TKmU94ELrv3l2PPpJE6TxIiSnyXReyrpeiz9pW8c8HMUpDxF3zaVG/j2Kxz/zGyEwMGdU9UkNoWG+
        /XV9OBng==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l588O-008YTw-Hd; Thu, 28 Jan 2021 14:18:57 +0000
Date:   Thu, 28 Jan 2021 14:18:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     bingjingc <bingjingc@synology.com>, viro@zeniv.linux.org.uk,
        jack@suse.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com, rdunlap@infradead.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 0/3] handle large user and group ID for isofs and udf
Message-ID: <20210128141856.GX308988@casper.infradead.org>
References: <1611817947-2839-1-git-send-email-bingjingc@synology.com>
 <20210128105501.GC3324@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128105501.GC3324@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:55:01AM +0100, Jan Kara wrote:
> On Thu 28-01-21 15:12:27, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> > 
> > The uid/gid (unsigned int) of a domain user may be larger than INT_MAX.
> > The parse_options of isofs and udf will return 0, and mount will fail
> > with -EINVAL. These patches try to handle large user and group ID.
> > 
> > BingJing Chang (3):
> >   parser: add unsigned int parser
> >   isofs: handle large user and group ID
> >   udf: handle large user and group ID
> 
> Thanks for your patches! Just two notes:
> 
> 1) I don't think Matthew Wilcox gave you his Reviewed-by tag (at least I
> didn't see such email). Generally the rule is that the developer has to
> explicitely write in his email that you can attach his Reviewed-by tag for
> it to be valid.

Right, I didn't.

Looking at fuse, they deleted their copy of match_uint
in favour of switching to the fs_parameter_spec (commit
c30da2e981a703c6b1d49911511f7ade8dac20be) and I wonder if isofs & udf
shouldn't receive the same attention.
