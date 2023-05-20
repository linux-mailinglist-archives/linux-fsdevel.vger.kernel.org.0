Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699D270A6B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjETJYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETJYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65650DD;
        Sat, 20 May 2023 02:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA917612CC;
        Sat, 20 May 2023 09:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5C9C433EF;
        Sat, 20 May 2023 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684574640;
        bh=FFPbZ3z2xMFOvvvYRV1x17BLaHWEDR97+KmJW37OskI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAPmH/yMHP25Gv2fr3UImPupSiMpL5tbGmUZ6VmgCogyV/6Y0dqZ5EQo0tpuW+Z6B
         Jol/bp4CLE5jweReox9fiHxD4+AT4ioE4L61izXq8+abqZbXgwVaL9bHxoQ+PA+WNB
         /hxZnHzVN+BJkJpPYJoYWaizdrisaLF/k/ZhmMO8Nuu6Wn63pnfPrdyTIO6eynkWlv
         x/ci5te4g0yBYIQ9WcNKKUP1krUgho7pND81ci9dH8ygmp4O6+HhHyohuWgfpdX5re
         R25lkOEDb/kfLWuhhs3GIRF1ld0ZptvnfrEUygTekzGa30pBP8q4v248/V0Xu6ouAx
         HtPxtNyfM0Qgw==
Date:   Sat, 20 May 2023 11:23:52 +0200
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
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v21 03/30] splice: Rename direct_splice_read() to
 copy_splice_read()
Message-ID: <20230520-sekunde-vorteil-f2d588e40b68@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-4-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-4-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:22AM +0100, David Howells wrote:
> Rename direct_splice_read() to copy_splice_read() to better reflect as to
> what it does.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Steve French <sfrench@samba.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-cifs@vger.kernel.org
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

For the future it'd be nice if exported functions would always get
proper kernel doc,
Reviewed-by: Christian Brauner <brauner@kernel.org>
