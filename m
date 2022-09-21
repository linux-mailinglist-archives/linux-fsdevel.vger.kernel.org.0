Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E75BFC3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIUKVh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUKVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:21:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401E10B
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 03:21:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-147-IxVjDi6jM8iMn47TyzyX2Q-1; Wed, 21 Sep 2022 11:21:27 +0100
X-MC-Unique: IxVjDi6jM8iMn47TyzyX2Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 21 Sep
 2022 11:21:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Wed, 21 Sep 2022 11:21:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ivan Babrou' <ivan@cloudflare.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Kalesh Singh" <kaleshsingh@google.com>
Subject: RE: [PATCH] proc: report open files as size in stat() for
 /proc/pid/fd
Thread-Topic: [PATCH] proc: report open files as size in stat() for
 /proc/pid/fd
Thread-Index: AQHYzSSDXSMkKVoMw0SOfcp9+NyhuK3prOsw
Date:   Wed, 21 Sep 2022 10:21:24 +0000
Message-ID: <b6aa0151527a4ee39ae85dfd34e71864@AcuMS.aculab.com>
References: <20220920190617.2539-1-ivan@cloudflare.com>
In-Reply-To: <20220920190617.2539-1-ivan@cloudflare.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ivan Babrou
> Sent: 20 September 2022 20:06
...
> 
> +static int proc_readfd_count(struct inode *inode)
> +{
> +	struct task_struct *p = get_proc_task(inode);
> +	struct fdtable *fdt;
> +	unsigned int i, size, open_fds = 0;
> +
> +	if (!p)
> +		return -ENOENT;
> +
> +	if (p->files) {
> +		fdt = files_fdtable(p->files);
> +		size = fdt->max_fds;
> +
> +		for (i = size / BITS_PER_LONG; i > 0;)
> +			open_fds += hweight64(fdt->open_fds[--i]);
> +	}
> +
> +	return open_fds;
> +}
> +

Doesn't that need (at least) rcu protection?
There might also be issues reading p->files twice.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

