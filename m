Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42F686703
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjBANf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjBANf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:35:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDB410F7;
        Wed,  1 Feb 2023 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1pmSYyxXe/Q3Nu+zS1Nws8Z9Iylo70BdepzScXv7nq0=; b=aWZu+1gyQY66506QxwHTioSh2i
        dtH0AgsXmD/X5Jy2cSpvjyJpdUVvRQVB/7ix9OahOGr9vSUd2XhWnklPU58rfIDuaL7SxzZ58oUJw
        UQq+t6COFDJGJuddfwApzOdcJ3+hkjp7A8skEesLEjmBvoVNsZCLNlfesWWs7PaoF4NGZkV6OiCf6
        0u9P5h1fnVXvJ4FPO7TsLqCntULVxZ6gVDRQRHT4nBRLh4GGfYnp8uMHaYBgYYLyM0QhQ9kD+fQQh
        vQrT9RmXvCqwiAErPgWomCf9gaWeKH9HEE5iHURnwNp8rw44tN2g+hxTR6uNfQEXJcckXlYpKzyxa
        S1i4YLDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDGc-00C60P-16; Wed, 01 Feb 2023 13:35:14 +0000
Date:   Wed, 1 Feb 2023 05:35:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 03/12] cifs: Implement splice_read to pass down ITER_BVEC
 not ITER_PIPE
Message-ID: <Y9pqke68UH9N0Qtd@infradead.org>
References: <20230131182855.4027499-1-dhowells@redhat.com>
 <20230131182855.4027499-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131182855.4027499-4-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:28:46PM +0000, David Howells wrote:
> Provide cifs_splice_read() to use a bvec rather than an pipe iterator as
> the latter cannot so easily be split and advanced,

What exactly are the issues?  If cifs is running into them others will
as well, so we might better fix them in the infrastructure.

>  (1) Bulk-allocate a bunch of pages to carry as much of the requested
>      amount of data as possible, but without overrunning the available
>      slots in the pipe and add them to an ITER_BVEC.

And that basically makes the splice_read entirely pointless and you
might as well simply not support it.
