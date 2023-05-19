Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05597709174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjESINC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjESIM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:12:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ECA12C;
        Fri, 19 May 2023 01:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uXfl52cQSZRcJnVzUsCXWUNzcDZE3EsN1WwOwGRya88=; b=bTG1MIwMskxn7o3TpI9T21HZo0
        x+2ECxKLocV3YID+i8Ap3pdpikQl1Pu3MwIFYPx9IywDmsvnxyNbIfCw5oBpP0CJwwl+AEreP8ByT
        VUUpR6srOk1ow+MMeZp1ZMfIW9RrmJ06oF9WTIEBSkZjifPAimxus5iR4eL2imIRlwSxh+h0LUyFO
        VBUUINYPvlm3IOwMN2rLgd2X3n7UjLslvRoy/MKjSTBRBFhxRIrSW4WKKHK6ZdonjpmlSUjWbg+uT
        yJayBsH0fwqibNE7Pf5RcupMcCJJYrFOyItkPhuIBQcSnYcqgLh4YBmrNo0Rr5QkdK3x9lz5RM3em
        PfZOe5Ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzvEC-00FTsc-2P;
        Fri, 19 May 2023 08:12:44 +0000
Date:   Fri, 19 May 2023 01:12:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v20 09/32] tty, proc, kernfs, random: Use
 direct_splice_read()
Message-ID: <ZGcvfLWAqmOLrnLj@infradead.org>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-10-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519074047.1739879-10-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 08:40:24AM +0100, David Howells wrote:
>  	.fasync = random_fasync,
>  	.llseek = noop_llseek,
> -	.splice_read = generic_file_splice_read,
> +	.splice_read = direct_splice_read,

Pinging Al (and maybe Linus): is there any good reason to not simply
default to direct_splice_read if ->read_iter is implemented and
->splice_read is not once you remove ITER_PIPE?  As long as we
assure direct_splice_read is simply a ->read_iter into newly
allocated pages I can't think of anything that would go wrong there.

