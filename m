Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB816E83B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 23:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDSV3R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDSV3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:29:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6914010CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 14:29:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-68-QVCktaoHOri6oPTbBSwJ8A-1; Wed, 19 Apr 2023 22:29:09 +0100
X-MC-Unique: QVCktaoHOri6oPTbBSwJ8A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Apr
 2023 22:29:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Apr 2023 22:29:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ameer Hamza' <ahamza@ixsystems.com>,
        Christian Brauner <brauner@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "slark_xiao@163.com" <slark_xiao@163.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "awalker@ixsystems.com" <awalker@ixsystems.com>
Subject: RE: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Thread-Topic: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Thread-Index: AQHZclx78K8aidFdnEuGd0zBlIXBda8zJNXg
Date:   Wed, 19 Apr 2023 21:29:08 +0000
Message-ID: <05845c12eab34567ae61466db36a0cef@AcuMS.aculab.com>
References: <20221228160249.428399-1-ahamza@ixsystems.com>
 <20230106130651.vxz7pjtu5gvchdgt@wittgenstein> <ZD9AsWMnNKJ4dpjm@hamza-pc>
In-Reply-To: <ZD9AsWMnNKJ4dpjm@hamza-pc>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ameer Hamza
> Sent: 19 April 2023 02:15
> 
> On Fri, Jan 06, 2023 at 02:06:51PM +0100, Christian Brauner wrote:
> > On Wed, Dec 28, 2022 at 09:02:49PM +0500, Ameer Hamza wrote:
> > > This patch adds a new flag O_EMPTY_PATH that allows openat and open
> > > system calls to open a file referenced by fd if the path is empty,
> > > and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
> > > beneficial in some cases since it would avoid having to grant /proc
> > > access to things like samba containers for reopening files to change
> > > flags in a race-free way.
> > >
> > > Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>
> > > ---
> >
> > In general this isn't a bad idea and Aleksa and I proposed this as part
> > of the openat2() patchset (see [1]).
> >
> > However, the reason we didn't do this right away was that we concluded
> > that it shouldn't be simply adding a flag. Reopening file descriptors
> > through procfs is indeed very useful and is often required. But it's
> > also been an endless source of subtle bugs and security holes as it
> > allows reopening file descriptors with more permissions than the
> > original file descriptor had.
> >
> > The same lax behavior should not be encoded into O_EMPTYPATH. Ideally we
> > would teach O_EMPTYPATH to adhere to magic link modes by default. This
> > would be tied to the idea of upgrade mask in openat2() (cf. [2]). They
> > allow a caller to specify the permissions that a file descriptor may be
> > reopened with at the time the fd is opened.
> >
> > [1]: https://lore.kernel.org/lkml/20190930183316.10190-4-cyphar@cyphar.com/
> > [2]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku/Kk
> 
> Thank you for the detailed explanation and sorry for getting back late
> at it. It seems like a pre-requisite for O_EMPTYPATH is to make it safe
> and that depends on a patchset that Aleksa was working on. It would be
> helpful to know the current status of that effort and if we could expect
> it in the near future.

ISTM that reopening a file READ_WRITE shouldn't be unconditionally allowed.
Checking the inode permissions of the file isn't enough to ensure
that the process is allowed to open it.
The 'x' (search) permissions on all the parent directories needs to
be checked (going back as far as some directory the process has open).

If a full pathname is generated this check is done.
But the proposed O_EMTPY_PATH won't be doing it.

This all matters if a system is using restricted directory
permissions to block a process from opening files in some
part of the filesystem, but is also being passed an open
fd (for reading) in that part of the filesystem.
I'm sure there are systems that will be doing this.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

