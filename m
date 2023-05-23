Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC870DCB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjEWMfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEWMfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443C118;
        Tue, 23 May 2023 05:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9621B62877;
        Tue, 23 May 2023 12:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B897CC433D2;
        Tue, 23 May 2023 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684845339;
        bh=u5mv3oHXC56HjI2PT+W2P28h07N+KAV9oli2njljAUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsJt2ZMGlEFFghj3Uk2r2mtJQ27DlaXhKf/RUJonBOkx0K8nP6Wrpcy+FtTmqI0RS
         lI87w/XrmQ1hEaK4B3nsUQqXfPz7E+ZDsUM9TtjEW0RGIU2kjLanDYtAxFH+G5x5MZ
         Rs8fB4bfJSadDYzTM/IkeJ16LcXs2C3SveGeLllZ4E3hDk1Hm+AfwTObpj8VtWNRO+
         PeLKCq6+8WSeuHz7XoTvdCsx4FEsvdJHokEVnS3x/K1h1TDcmuVijh2s1a8LJlCowo
         8qvUhGAyJ/k6spJX3i+sNA+dlkPSFVPpwb0RFIqIElPXdaHL9+1vQK/xZ8spbDPv/S
         hj99yo81V7Dvw==
Date:   Tue, 23 May 2023 14:35:26 +0200
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
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v21 1/6] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <20230523-taschen-erfinden-3bd7c39beeda@brauner>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-2-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 09:57:39PM +0100, David Howells wrote:
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
