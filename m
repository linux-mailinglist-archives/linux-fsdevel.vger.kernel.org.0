Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75278B304
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjH1OZy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjH1OZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:25:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A02CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 07:25:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-185-RguczgZxM0OUE1HVWgEnFw-1; Mon, 28 Aug 2023 15:25:20 +0100
X-MC-Unique: RguczgZxM0OUE1HVWgEnFw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 15:25:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 15:25:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter() in
 read_write.c
Thread-Topic: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Thread-Index: AQHZ2bl28TDA+XembE2kChg2gxAby6//wy7w
Date:   Mon, 28 Aug 2023 14:25:22 +0000
Message-ID: <81ccf8f3d7294cffab754901df83b401@AcuMS.aculab.com>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
 <ZOyMZO2i3rKS/4tU@infradead.org> <20230828-alarm-entzug-923f1f8cc109@brauner>
 <20230828140934.GY3390869@ZenIV>
In-Reply-To: <20230828140934.GY3390869@ZenIV>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro
> Sent: 28 August 2023 15:10
> 
> On Mon, Aug 28, 2023 at 02:30:42PM +0200, Christian Brauner wrote:
> > On Mon, Aug 28, 2023 at 05:00:36AM -0700, Christoph Hellwig wrote:
> > > On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> > > > use helpers for calling f_op->{read,write}_iter() in read_write.c
> > > >
> > >
> > > Why?  We really should just remove the completely pointless wrappers
> > > instead.
> >
> > Especially because it means you chase this helper to figure out what's
> > actually going on. If there was more to it then it would make sense but
> > not just as a pointless wrapper.
> 
> It's borderline easier to grep for, but not dramatically so.  call_mmap()
> has a stronger argument in favour - there are several methods called
> ->mmap and telling one from another is hard without looking into context.

Which might be a justification for renaming some/all of the ->mmap()
do make them easier to find.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

