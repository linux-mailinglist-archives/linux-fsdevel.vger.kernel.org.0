Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8366865E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjALWHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbjALWGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:06:42 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26FEF73;
        Thu, 12 Jan 2023 13:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TflQIBHtbOtCl9ZDGmCGckLCF53giYE4nhRaQzDOaxQ=; b=CgIrh+M6NGkT6uXzBzX+fXvROx
        wuTvPtlIEUE08URn9QyBlAJmQ1Sv+TAIuo3qLS3tKEE/jc79z1WAdayFLATVY4wHp2bsM+l26TdEj
        7jvBAvnSrlnqwq/Wmu2mvIDZKTy/zfSLFq9gBLBQPjo0oMFOEyolDceoHeG1LdhVRwMNKROnZDkka
        cIucsR/1yP6ZVkH/ubLx1WCHUkeIMBfDlpIBEgrZkljcz/hznCLXdKcpEFfnwc56akJ4RUElW3Pem
        dSHXq6LMGEyYCEtVrLht64Y1BnnZHUmAMGB6km3InIHL2FAUcubwoVUrQpKXU2UkGi8ZeUFmfXuo1
        uZAZLvvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pG5Yf-001ZAk-2q;
        Thu, 12 Jan 2023 21:56:25 +0000
Date:   Thu, 12 Jan 2023 21:56:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iov_iter: Use IOCB/IOMAP_WRITE if available
 rather than iterator direction
Message-ID: <Y8CCCQLrm9vshGw0@ZenIV>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
 <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167344727810.2425628.4715663653893036683.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:27:58PM +0000, David Howells wrote:
> If a kiocb or iomap_iter is available, then use the IOCB_WRITE flag or the
> IOMAP_WRITE flag to determine whether we're writing rather than the
> iterator direction flag.
> 
> This allows all but three of the users of iov_iter_rw() to be got rid of: a
> consistency check and a warning statement in cifs and one user in the block
> layer that has neither available.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/r/167305163159.1521586.9460968250704377087.stgit@warthog.procyon.org.uk/ # v4

Incidentally, I'd suggest iocb_is_write(iocb) - just look at the amount of
places where you end up with clumsy parentheses...
