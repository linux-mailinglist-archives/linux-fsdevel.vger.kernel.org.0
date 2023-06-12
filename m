Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA89B72C384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 13:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjFLLyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 07:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFLLx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD9D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686570647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5wUlRIN/HwO1xdhYncu3uXAkl7B7mbUxrP89n8g32/0=;
        b=XeXsRo2T3m9d/z3uIx8nXvu9Gx1ev7coqefJTq8cHmTe59tij/wWrCvQbdRxktJ9o1OKH6
        j2i5BZ5c2SmnbE05WZHXRbKtdAL2GCsVbr3NINI6Khyyqu/U/yMB3N/RwfEkgqQWvJnAVV
        ltIV3ulwEg43YTkE3rPB9nGi818hoZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-1HOjYs9mNxGJ0xZgOYRgng-1; Mon, 12 Jun 2023 07:50:42 -0400
X-MC-Unique: 1HOjYs9mNxGJ0xZgOYRgng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B695980027F;
        Mon, 12 Jun 2023 11:50:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAC382166B25;
        Mon, 12 Jun 2023 11:50:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <63868def-9a92-3b0f-4369-160a18b447ee@redhat.com>
References: <63868def-9a92-3b0f-4369-160a18b447ee@redhat.com> <202306120931.a9606b88-oliver.sang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [axboe-block:for-6.5/block] [block] 1ccf164ec8: WARNING:at_mm/gup.c:#try_get_folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <104416.1686570637.1@warthog.procyon.org.uk>
Date:   Mon, 12 Jun 2023 12:50:37 +0100
Message-ID: <104417.1686570637@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reproduces the problem.  It can probably be simplified still further.

Make a UDF filesystem and mount it:

	fallocate /mnt2/udf_scratch -l 1G
	mount -o loop /mnt2/udf_scratch /xfstests.scratch
	./the_program_below /xfstests.scratch/foo

David
---
#define __USE_GNU
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>
# define O_DIRECT      040000

static char buf[256 * 1024] __attribute__((aligned(512)));
static char *filename;

static void cleanup(void)
{
	if (unlink(filename) == -1)
		err(1, "unlink");
}

int main(int argc, char **argv)
{
	size_t page = 4096, big = 2 * page;
	int fd;

	if (argc != 2) {
		fprintf(stderr, "Format: %s <file>\n", argv[1]);
		exit(2);
	}

	filename = argv[1];

	fd = open(filename, O_RDWR | O_CREAT | O_EXCL, 0666);
	if (fd == -1)
		err(1, "%s", filename);

	atexit(cleanup);

	if (pwrite(fd, buf, page, 0) != page)
		err(1, "pwrite/1");

	if (pwrite(fd, buf, big, big) != big)
		err(1, "pwrite/2");

	if (close(fd) == -1)
		err(1, "close");

	fd = open(filename, O_RDWR | O_DIRECT);
	if (fd == -1)
		err(1, "%s", filename);

	if (pread(fd, buf, big, big) != big)
		err(1, "pread/1");

	if (pread(fd, buf, big, 0) != big)
		err(1, "pread/2");

	if (pwrite(fd, buf, big, 0) != big)
		err(1, "pwrite/3");

	if (close(fd) == -1)
		err(1, "close");

	return 0;
}

