Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8870A6FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjETJ47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjETJ46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FAFE4B;
        Sat, 20 May 2023 02:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12FA361216;
        Sat, 20 May 2023 09:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49690C433D2;
        Sat, 20 May 2023 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684576616;
        bh=R+IUlwfsEDigEEuSuAI8xzMd6xiNbhVZfGfTlrvqt7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeqidhNNRRUeIuHgx1VHNmuJlYffUcAUAmybhmTnBF6woRKd8lTiZ0rHCm472lApD
         +dujFnS9iRdI9+vX3+sg2zNR638y3LeBEidqPYTqHSIm+yclc8YiPZafSQOK3rB1fI
         +wh06FsQP10GRIvUpL7sT+gdsFj7G/OsZhcbOsemnIUqAY3M4jLUGMSdKcb+Ji056X
         EdZoLKWrJXHDGxaF9MT9tlwqNLZxdQVNWhChKFt3AjVQUFlo+wMuE2mS1ri7DP8EHp
         lQAvUOqnUHAXhY233Lmu7rzs9CPXZ/k/Z1Gwjw5AHhUtY7Rp50DckH2n/eaWFjE20P
         wSk56yEfFEK2g==
Date:   Sat, 20 May 2023 11:56:49 +0200
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
Subject: Re: [PATCH v21 28/30] splice: Use filemap_splice_read() instead of
 generic_file_splice_read()
Message-ID: <20230520-ortsgemeinde-rente-e7c4fb923937@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-29-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-29-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:47AM +0100, David Howells wrote:
> Replace pointers to generic_file_splice_read() with calls to
> filemap_splice_read().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
