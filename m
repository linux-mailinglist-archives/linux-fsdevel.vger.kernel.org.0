Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339F689F0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 17:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjBCQXk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 3 Feb 2023 11:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBCQXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:23:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA1A6B88
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 08:23:36 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-_ITs-rZGN66msvzu-eXIpg-1; Fri, 03 Feb 2023 16:23:33 +0000
X-MC-Unique: _ITs-rZGN66msvzu-eXIpg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Fri, 3 Feb
 2023 16:23:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Fri, 3 Feb 2023 16:23:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Andreas Dilger <adilger@dilger.ca>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH 0/5] Fix a minor POSIX conformance problem
Thread-Topic: [PATCH 0/5] Fix a minor POSIX conformance problem
Thread-Index: AQHZN9J6uHKWfdvyUUW8SEkwX3xBiK69ZXmQ
Date:   Fri, 3 Feb 2023 16:23:32 +0000
Message-ID: <c16be18cb68a4adbbcd73cf9be9472df@AcuMS.aculab.com>
References: <20230202204428.3267832-1-willy@infradead.org>
 <DCEDB8BB-8D10-4E17-9C27-AE48718CB82F@dilger.ca>
 <Y90KTSXCKGd8Gaqc@casper.infradead.org>
In-Reply-To: <Y90KTSXCKGd8Gaqc@casper.infradead.org>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox
> Sent: 03 February 2023 13:21
> 
> On Thu, Feb 02, 2023 at 04:08:49PM -0700, Andreas Dilger wrote:
> > On Feb 2, 2023, at 1:44 PM, Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> > >
> > > POSIX requires that on ftruncate() expansion, the new bytes must read
> > > as zeroes.  If someone's mmap()ed the file and stored past EOF, for
> > > most filesystems the bytes in that page will be not-zero.  It's a
> > > pretty minor violation; someone could race you and write to the file
> > > between the ftruncate() call and you reading from it, but it's a bit
> > > of a QOI violation.
> >
> > Is it possible to have mmap return SIGBUS for the writes beyond EOF?
> 
> Well, no.  The hardware only tells us about accesses on a per-page
> basis.  We could SIGBUS on writes that _start_ after EOF, but this
> test doesn't do that (it starts before EOF and extends past EOF).
> And once the page is mapped writable, there's no page fault taken
> for subsequent writes.
> 
> > On the one hand, that might indicate incorrect behavior of the application,
> > and on the other hand, it seems possible that the application doesn't
> > know it is writing beyond EOF and expects that data to be read back OK?
> 
> POSIX says:
> 
> "The system shall always zero-fill any partial page at the end of an
> object. Further, the system shall never write out any modified portions
> of the last page of an object which are beyond its end. References
> within the address range starting at pa and continuing for len bytes to
> whole pages following the end of an object shall result in delivery of
> a SIGBUS signal."
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html

It also says (down at the bottom of the rational):

"The mmap() function can be used to map a region of memory that is larger
than the current size of the object. Memory access within the mapping but
beyond the current end of the underlying objects may result in SIGBUS
signals being sent to the process. The reason for this is that the size
of the object can be manipulated by other processes and can change at any
moment. The implementation should tell the application that a memory
reference is outside the object where this can be detected; otherwise,
written data may be lost and read data may not reflect actual data in the
object."

There are a lot of 'may' in that sentence.
Note that it only says that 'data written beyond the current eof may be
lost'.
I think that could be taken to take precedence over the zeroing clause
in ftruncate().
I'd bet a lot of beer that the original SYSV implementation (on with the
description is based) didn't zero the page buffer when ftruncate()
increased the file size.
Whether anything (important) actually relies on that is an interesting
question!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

