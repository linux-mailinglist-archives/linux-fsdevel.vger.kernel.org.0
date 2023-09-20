Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239427A77CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjITJnn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjITJnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:43:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3889E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 02:43:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-126-4uoMlHilNA-pwi2ct8LJgQ-1; Wed, 20 Sep 2023 10:43:18 +0100
X-MC-Unique: 4uoMlHilNA-pwi2ct8LJgQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Sep
 2023 10:43:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Sep 2023 10:43:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jeff Layton' <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, "Ian Kent" <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Amir Goldstein" <amir73il@gmail.com>
Subject: RE: [RFC PATCH 2/3] add statmnt(2) syscall
Thread-Topic: [RFC PATCH 2/3] add statmnt(2) syscall
Thread-Index: AQHZ6lITJ6lmDHl4dUW3VQsauHaorbAjeA4A
Date:   Wed, 20 Sep 2023 09:43:13 +0000
Message-ID: <ac0f42e8ace2474a941b702fb4fa85a3@AcuMS.aculab.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
         <20230913152238.905247-3-mszeredi@redhat.com>
         <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
         <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
         <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <3183d8b21e78dce2c1d5cbc8a1304f2937110621.camel@kernel.org>
In-Reply-To: <3183d8b21e78dce2c1d5cbc8a1304f2937110621.camel@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton
> Sent: 18 September 2023 15:30
....
> A bit tangential to this discussion, but one thing we could consider is
> adding something like a mnt_change_cookie field that increments on any
> significant changes on the mount: i.e. remounts with new options,
> changes to parentage or propagation, etc.
> 
> That might make it more palatable to do something with separate syscalls
> for the string-based fields. You could do:
> 
> statmnt(...);
> getmntattr(mnt, "mnt.fstype", ...);
> statmnt(...);
> 
> ...and then if the mnt_change_cookie hasn't changed, you know that the
> string option was stable during that window.

That would also help with the problem of the mount options
being changed while processing a page fault on the user buffer.

Of, with a call to just get the cookie, could find that nothing
has changed so there is no point looking again.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

