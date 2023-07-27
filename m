Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534577658D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjG0Qfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 12:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjG0Qfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593663582;
        Thu, 27 Jul 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFDE661ED0;
        Thu, 27 Jul 2023 16:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F2DC433C8;
        Thu, 27 Jul 2023 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690475730;
        bh=xxSAimQXBy8LTexe+HxsAaFK570YSxyX6ulLt13STYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OMOPTeOJM3E8IsDW0ELqoK6LluFeGCmacBrLYfqXHj09OdTl9QniJ7ztd9rd3G908
         Pya4jart2BSNg2KlkuDLGmCRZMOeWuF9/jnBJhzD0yFn/GxMxIwoprXinjDatR7RFt
         aCSsi9YxGQ4TPKv4EhtDN/VqBmVj/sZhTzhWeJxU=
Date:   Thu, 27 Jul 2023 09:35:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] shmem: Fix splice of a missing page
Message-Id: <20230727093529.f235377fabec606e16c20679@linux-foundation.org>
In-Reply-To: <20230727161016.169066-2-dhowells@redhat.com>
References: <20230727161016.169066-1-dhowells@redhat.com>
        <20230727161016.169066-2-dhowells@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 17:10:15 +0100 David Howells <dhowells@redhat.com> wrote:

> Fix shmem_splice_read() to splice only part of the partial page at the end
> of a splice and not all of it.
> 
> This can be seen by splicing from a tmpfs file that's not a multiple of
> PAGE_SIZE in size.  Without this fix, it splices extra data to round up to
> PAGE_SIZE.

This is already in mm-unstable (and hence linux-next) via Hugh's
"shmem: minor fixes to splice-read implementation"
(https://lkml.kernel.org/r/32c72c9c-72a8-115f-407d-f0148f368@google.com)
