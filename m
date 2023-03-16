Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251216BCD0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCPKoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCPKn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:43:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C190ADC3A;
        Thu, 16 Mar 2023 03:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8FA4CE1C90;
        Thu, 16 Mar 2023 10:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7B2C433EF;
        Thu, 16 Mar 2023 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678963427;
        bh=ivnRtF0Om5eiH05K2UCaWLsj37t/Ps4vxjDE7lmPdVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRu/lN3rrdr0jwR4HeZLvBm5trwz130o230jB/iSGYgR9L0ucM8d062SfHyGNV7kD
         gcQbh3aKnPbmEmTWU7Fv9Xl9IFbr/N+AaVGR313Tunu5+PE3Q9QdefBjjiz/kggBVJ
         HvxxXFbTekZCZPfI4pnxwbDYAh46aDTghGZ7gLixsJSEs+Yh94oLRGGZu0/vH7ZpI0
         8sbQxfqd4d/V/PKUit+Nj47r/MDl3PvvzM675hBoNVbptp+ovSo9zsSdwIr6R9693e
         KKTU7wvoIopClpK1X6j38aAlAovuGoqutJjo7Djfwu314JAkoiZwsIk7mNe5ATNVwc
         RyThUK7axbBGg==
Date:   Thu, 16 Mar 2023 11:43:35 +0100
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
Subject: Re: [PATCH v19 07/15] splice: Do splice read from a file without
 using ITER_PIPE
Message-ID: <20230316104335.gpgfeigrnvdipj52@wittgenstein>
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230315163549.295454-8-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:35:41PM +0000, David Howells wrote:
> Make generic_file_splice_read() use filemap_splice_read() and
> direct_splice_read() rather than using an ITER_PIPE and call_read_iter().
> 
> With this, ITER_PIPE is no longer used.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
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

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
