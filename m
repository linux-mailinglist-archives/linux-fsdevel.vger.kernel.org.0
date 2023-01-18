Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA40672C34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjARXEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARXEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:04:07 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2853A305FB;
        Wed, 18 Jan 2023 15:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6dWUI5icFFmxxhB3zoj79O8xUzc1bN/i/tm3I5lQXJU=; b=WNX9/lZWP0n5ceC+COxrRxCY4i
        LIqiQjw7YxNsyy1dUOy+TIz40RbUuU8Qpm7ExiMRbW9kMprvytFCmxy1qCSdRVQiEbZe/JQulm4Mx
        Fndvm/lYebesmLUJQyC3icibaC2llpY1Eclokrn2LYyw8X7P6jVqnZNdYchgJSDPVvtBVfEKyfSJA
        Z6IKyctzuqiXpiJ1JrKvG3ZYmxxxdlPNdCNGm+oku9+2OKQ9TiA6kgQv5zVnqR1H5o0yFce5bx9On
        jbiD7OjO6mehbLyuuNYzA8V9nQlLJLAmAPD6YehSe6lYAvUlK3BBS0ptGZDE2vMhulB7C2K+Zkr5P
        kA6Qw52Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pIHTE-002dMI-1h;
        Wed, 18 Jan 2023 23:03:52 +0000
Date:   Wed, 18 Jan 2023 23:03:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Message-ID: <Y8h62KsnI8g/xaRz@ZenIV>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <Y8ZU1Jjx5VSetvOn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZU1Jjx5VSetvOn@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:57:08PM -0800, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 11:08:24PM +0000, David Howells wrote:
> > Define FOLL_SOURCE_BUF and FOLL_DEST_BUF to indicate to get_user_pages*()
> > and iov_iter_get_pages*() how the buffer is intended to be used in an I/O
> > operation.  Don't use READ and WRITE as a read I/O writes to memory and
> > vice versa - which causes confusion.
> > 
> > The direction is checked against the iterator's data_source.
> 
> Why can't we use the existing FOLL_WRITE?

	I'm really not fond of passing FOLL_... stuff into iov_iter
primitives.  That space contains things like FOLL_PIN, which makes
no sense whatsoever for non-user-backed iterators; having the
callers pass it in makes them automatically dependent upon the
iov_iter flavour.
