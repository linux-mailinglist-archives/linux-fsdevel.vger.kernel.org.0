Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F43759CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGSSB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGSSB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:01:56 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 11:01:54 PDT
Received: from resqmta-a1p-077437.sys.comcast.net (resqmta-a1p-077437.sys.comcast.net [IPv6:2001:558:fd01:2bb4::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCA1FC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 11:01:54 -0700 (PDT)
Received: from resomta-a1p-076786.sys.comcast.net ([96.103.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-a1p-077437.sys.comcast.net with ESMTP
        id M58wqCIfWihphMBSMqowug; Wed, 19 Jul 2023 17:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1689789562;
        bh=/6lKYap9PZZRLrRmess6iU23U+m+a8OOtwMIqKZ8RIU=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=I5lL4kFYbXQNcZbp14I88EAp8TPvcrzwLD4ASOhXUiC3YNKzmFT2Vgtl32uc/bG07
         7Qur3wStIV93MD7Z8CvhOQKrD6lbt8t6aLw8Kob1O/RNptKP6o8eJsgPgmqcbkcS1b
         Tjh7DWoK6mzg5Kxa3pHCp1XVaiu+egLF9HkuH35bv7h/Jud85pw0SvRn+YLHOlpMM5
         B4LhcVTK3te0k+cS24axJUOEA6oMbrLzIWDPoOzzCkNmN4TyDbRXodg6Qbvk/cQnh+
         oY2RBXWuXXkXDn1kpB7dR4ijQeIKSsebRTnErEy7aZ3kZw8Wbiuz5tf6l/M1woJVZj
         bMCYrDf1vYn9Q==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-a1p-076786.sys.comcast.net with ESMTPSA
        id MBSEqFdsmeadOMBSEqzqUD; Wed, 19 Jul 2023 17:59:18 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@kvack.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after =?iso-8859-1?Q?splice()_returns?=
Date:   Wed, 19 Jul 2023 13:59:13 -0400
MIME-Version: 1.0
Message-ID: <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
In-Reply-To: <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote:
>>=20
>> Splicing data from, say, a file into a pipe currently leaves the source
>> pages in the pipe after splice() returns - but this means that those pages=

>> can be subsequently modified by shared-writable mmap(), write(),
>> fallocate(), etc. before they're consumed.
>
> What is this trying to fix?   The above behavior is well known, so
> it's not likely to be a problem.

Respectfully, it's not well-known, as it's not documented. If the splice(2)=20=

man page had mentioned that pages can be mutated after they're already=20
ostensibly at rest in the output pipe buffer, then my nightly backups=20
wouldn't have been incurring corruption silently for many months.
