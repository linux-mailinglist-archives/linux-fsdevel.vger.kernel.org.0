Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB26A8BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBWVT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 2 Mar 2023 17:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCBWVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:21:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879782C64E
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 14:21:16 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-p9yk02mGNJ-EvnKq43nrsA-1; Thu, 02 Mar 2023 22:21:13 +0000
X-MC-Unique: p9yk02mGNJ-EvnKq43nrsA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Thu, 2 Mar
 2023 22:21:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Thu, 2 Mar 2023 22:21:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'aloktiagi' <aloktiagi@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: RE: [RFC 2/3] file: allow callers to free the old file descriptor
 after dup2
Thread-Topic: [RFC 2/3] file: allow callers to free the old file descriptor
 after dup2
Thread-Index: AQHZTTP1xmE+kqQuQ0egihVRbIR0J67oDplw
Date:   Thu, 2 Mar 2023 22:21:11 +0000
Message-ID: <bef11c18fa234948bcab0316418f04aa@AcuMS.aculab.com>
References: <20230302182207.456311-1-aloktiagi@gmail.com>
 <20230302182207.456311-2-aloktiagi@gmail.com>
In-Reply-To: <20230302182207.456311-2-aloktiagi@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: aloktiagi
> Sent: 02 March 2023 18:22
> 
> Allow callers of do_dup2 to free the old file descriptor in case they need to
> make additional operations on it.

That doesn't read right at all.

Whether or not this is a good idea (or can be done differently)
the interface is horrid.

>  	if (tofree)
> -		filp_close(tofree, files);
> +		*fdfile = tofree;

Why not:

	if (fdfile) [
		*fdfile = tofree;
	} else {
		if (tofree)
			filp_close(tofree, files);
	}

Then existing code just passes NULL and the caller can't 'forget'
to intitalise fdfile.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

