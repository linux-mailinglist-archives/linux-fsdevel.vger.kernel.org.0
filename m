Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C976BCD42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCPKvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPKvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:51:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E507199CC;
        Thu, 16 Mar 2023 03:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11377B820D1;
        Thu, 16 Mar 2023 10:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D23C433EF;
        Thu, 16 Mar 2023 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678963873;
        bh=o5wa1JMj2zzuoLzQAkHij/fz/01C48xRb+au5j5qJNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6m+LgZxyPxAv9EF0QM2ILFfjSGfBIs2q0m7UE/ox2P47WZ0IVDQkg3dTSnGKjT+S
         df3mIO7yB5DdnIXxeKDRagCzRKy4eAceaSzGVP82Dj6INOgp1E9vUpeHCCyWwCp0Ek
         CsP1C15KG2u79hUs+oj5wp3XpOoFIfZfagjTdNjLpRbpo7w5RPTcKjanjqpw7YTIAZ
         m9c4vzCjjwPiSzdOjh4uog3ibSebCMwFEARA/HHuui3y81y0E/Vt4+58VS65hjPgPK
         VTy4dj5G35wcUcdjocnS6mYptUQP/m3CTeMatassVYe+scqaZ4yt6M80ZrXWJW9b83
         OoUzAKY/vg3Mw==
Date:   Thu, 16 Mar 2023 11:51:06 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v19 09/15] iov_iter: Kill ITER_PIPE
Message-ID: <20230316105106.cqo7equqxzw342rr@wittgenstein>
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-10-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315163549.295454-10-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:35:43PM +0000, David Howells wrote:
> The ITER_PIPE-type iterator was only used for generic_file_splice_read(),
> but that has now been switched to either pull pages directly from the
> pagecache for buffered file splice-reads or to use ITER_BVEC instead for
> O_DIRECT file splice-reads.  This leaves ITER_PIPE unused - so remove it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

That is a good simplification,
Reviewed-by: Christian Brauner <brauner@kernel.org>
