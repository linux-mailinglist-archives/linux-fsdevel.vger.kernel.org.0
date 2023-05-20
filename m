Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3570A6FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjETJ5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjETJ5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD0BB;
        Sat, 20 May 2023 02:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC1A611B8;
        Sat, 20 May 2023 09:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9CDC433D2;
        Sat, 20 May 2023 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684576665;
        bh=YvXeoMKq4ZVW3MziaMkUxoxN1SUN+BwdFspqOtJTJ8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7ha6/ALvRNRnuV1C3UErypWKHp8AOth9aQFHVEPoloYb0ryYH1SWUh9dUN3Qp67k
         DvGve3yy5poyjDDXNiFCJNhLbZVabMzsBWQv+aOuVeNFVpsvK60bMeiGsQUctPX0kn
         yL+uuhIfI4lrr3vqrtl2q7tFj/PAMpIlgNqhPzQUFnYh5/0Cb0z4wbL1X7TYP1oHkY
         lAhbNV1whjjmxdJnVUEq1RPOFWdcMmC6vQr8jsV1JajEPlGqiTkxAPrACXVqmr/JRu
         c7NMu7Ib/RlKlBb+uEtHFO/Xh54f1vvM8JabfK+9Iug4C0XUhg0UNZAL51hSIyp9eZ
         c3oJNCn0vUMRQ==
Date:   Sat, 20 May 2023 11:57:37 +0200
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
        Steve French <smfrench@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v21 29/30] splice: Remove generic_file_splice_read()
Message-ID: <20230520-unfassbar-mathematik-d3b8753762ba@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-30-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-30-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:48AM +0100, David Howells wrote:
> Remove generic_file_splice_read() as it has been replaced with calls to
> filemap_splice_read() and copy_splice_read().
> 
> With this, ITER_PIPE is no longer used.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Steve French <smfrench@gmail.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
