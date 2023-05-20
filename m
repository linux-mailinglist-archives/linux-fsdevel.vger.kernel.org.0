Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B770A6B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjETJel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETJel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78B1B4;
        Sat, 20 May 2023 02:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8A9360A54;
        Sat, 20 May 2023 09:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151FEC433D2;
        Sat, 20 May 2023 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684575279;
        bh=nrrEdtmBB6Wb7o+hUn1Dip5xrGG4Byrj3iJNIPMqUEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foeDhXxI2PuHz7Q+qNEc/7IWEGb8BDWyk+PS3YX2CJWnBvwk6OXTf0aTprW0aj98l
         ZuZFHoe3kJWxosV1xt85J1vVEtNWMC4OJVyU0CpJd7LS2xSlgjprs0TJ5RLPNlkbDc
         EF8M3BomBWTqIxtocWFzE8ZDobcOmoh2J2SIYCz8oMmOd2Eg2KLTI04lVQPFOGcY60
         MT/qFNwGdxD20aXv3GXEKSq5qQCq+45ZkDb6bGZ54PQLMjLTPN6N5gpdjpKOj/cJdi
         +8B3+rfWWiSlo8Igzx9FMHAFpRBIAGG9y/tlvFEn3HwMSMqNI8PrOJEu54GWcRMQbj
         zEsed/EcHyeMQ==
Date:   Sat, 20 May 2023 11:34:31 +0200
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
Subject: Re: [PATCH v21 04/30] splice: Clean up copy_splice_read() a bit
Message-ID: <20230520-geantwortet-pflanzen-5623c1881792@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-5-dhowells@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:23AM +0100, David Howells wrote:
> Do a couple of cleanups to copy_splice_read():
> 
>  (1) Cast to struct page **, not void *.
> 
>  (2) Simplify the calculation of the number of pages to keep/reclaim in
>      copy_splice_read().
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
