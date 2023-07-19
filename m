Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C075A2E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGSXlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 19:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSXlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:41:19 -0400
Received: from resqmta-c1p-024060.sys.comcast.net (resqmta-c1p-024060.sys.comcast.net [IPv6:2001:558:fd00:56::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6BE1B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:41:18 -0700 (PDT)
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-c1p-024060.sys.comcast.net with ESMTP
        id M6ftqWOMGprSIMGnFqYFtS; Wed, 19 Jul 2023 23:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1689810077;
        bh=D0Zxwoc5PyVtQd58yNNXz/EasT5elbjv8i+Mv7KlxLk=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=VYYlb35lQ2Me5FxEggIh4eLd6U5nIi+pWMfonx5QvcpoEoY5W6rV3+ypSpUHH6ooT
         af9wi0mXh81xS0p4tdn9379JTX10iuilIOoCfrX0MO+T+CoL5HeI3xAR7tLaBQUBBF
         wynoad62e6N2MoqXdnzfY6CA/b0rnJy33OtgRYP8JoDrYXPPb5LtHdIasY4j26gRe0
         zNGBhA++S/99ewS/y4Ihyrd6jZZjo5ENVDUUGZbW/rpxP4TzVwTQ9417PgfIwY2n3y
         IdG8A55TtwaDGI4AHgJyXtQsIPXgSdLr2ZJfzbGokpu65Kt3IW1UX8kVjnHueKTzSG
         8PlOL9fysEBzQ==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-c1p-023269.sys.comcast.net with ESMTPSA
        id MGn6q5Mwsf3EjMGn7qAANV; Wed, 19 Jul 2023 23:41:13 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@kvack.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after =?iso-8859-1?Q?splice()_returns?=
Date:   Wed, 19 Jul 2023 19:41:07 -0400
MIME-Version: 1.0
Message-ID: <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
In-Reply-To: <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
 <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
 <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, 19 July 2023 19:20:32 EDT, Linus Torvalds wrote:
>> On Wednesday, 19 July 2023 16:16:07 EDT, Linus Torvalds wrote:
>>> The *ONLY* reason for splice() existing is for zero-copy.
>>=20
>> The very first sentence of splice(2) reads: "splice() moves data between
>> two file descriptors without copying between kernel address space and user=

>> address space." Thus, it is not unreasonable to believe that the point of
>> splice is to avoid copying between user-space and kernel-space.
>
> I'm not at all opposed to clarifying the documentation.

Then that is my request. This entire complaint/discussion/argument would=20
have been avoided if splice(2) had contained a sentence like this one from=20=

sendfile(2):

"If out_fd refers to a socket or pipe with zero-copy support, callers must=20=

ensure the transferred portions of the file referred to by in_fd remain=20
unmodified until the reader on the other end of out_fd has consumed the=20
transferred data."

That is a clear warning of the perils of the implementation under the hood,=20=

and it could/should be copied, more or less verbatim, to splice(2).
