Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D333B7A1D5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjIOLYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjIOLYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A67EECCF
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694776988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FgfSRx3oRdPWwtJgpHE291K7gqnxGDzcnbdYAGADtA=;
        b=HSWJQiz6G6E9hY4TLTgvXKClx+H5WQokRZn6M0FAi1h/MbOB3Ue0v6JLvMPmH7gf3dPoeB
        iq8cuZwFiD4vc3BLWVZxaqgc1n+tR/MGevFJXpf0YpwJ0dX5qrK248v9pxuROQcQ0AbsFI
        VCJeAfd0GZ7WzriGpCvp5sugC7wconY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-wzrmM9JrM0iDuLsov5_gxg-1; Fri, 15 Sep 2023 07:23:04 -0400
X-MC-Unique: wzrmM9JrM0iDuLsov5_gxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BFD9803470;
        Fri, 15 Sep 2023 11:23:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F20CB40C6EA8;
        Fri, 15 Sep 2023 11:23:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com>
References: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com> <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com> <20230914221526.3153402-1-dhowells@redhat.com> <20230914221526.3153402-10-dhowells@redhat.com> <3370515.1694772627@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3449351.1694776980.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 15 Sep 2023 12:23:00 +0100
Message-ID: <3449352.1694776980@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > > Some measurements can be made using readv() and writev()
> > > on /dev/zero and /dev/null.
> > =

> > Forget /dev/null; that doesn't actually engage any iteration code.  Th=
e same
> > for writing to /dev/zero.  Reading from /dev/zero does its own iterati=
on thing
> > rather than using iterate_and_advance(), presumably because it checks =
for
> > signals and resched.
> =

> Using /dev/null does exercise the 'copy iov from user' code.

Ummm....  Not really:

static ssize_t read_null(struct file *file, char __user *buf,
			 size_t count, loff_t *ppos)
{
	return 0;
}

static ssize_t write_null(struct file *file, const char __user *buf,
			  size_t count, loff_t *ppos)
{
	return count;
}

static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to)
{
	return 0;
}

static ssize_t write_iter_null(struct kiocb *iocb, struct iov_iter *from)
{
	size_t count =3D iov_iter_count(from);
	iov_iter_advance(from, count);
	return count;
}

David

