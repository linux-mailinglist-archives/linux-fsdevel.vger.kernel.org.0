Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB214CEA0A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 09:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiCFIbO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 6 Mar 2022 03:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiCFIbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 03:31:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF19745793
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 00:30:20 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-108-tUwZomUWMYSiN451TxRaKw-1; Sun, 06 Mar 2022 08:30:17 +0000
X-MC-Unique: tUwZomUWMYSiN451TxRaKw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 6 Mar 2022 08:30:15 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 6 Mar 2022 08:30:14 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jarkko Sakkinen' <jarkko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Michal Hocko" <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFC 0/3] MAP_POPULATE for device memory
Thread-Topic: [PATCH RFC 0/3] MAP_POPULATE for device memory
Thread-Index: AQHYMRun9YUfQRgF3USRgOtqAakL96yyAc1Q
Date:   Sun, 6 Mar 2022 08:30:14 +0000
Message-ID: <7f46ef3c80734f478501d21cef0182c5@AcuMS.aculab.com>
References: <20220306053211.135762-1-jarkko@kernel.org>
In-Reply-To: <20220306053211.135762-1-jarkko@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jarkko Sakkinen
> Sent: 06 March 2022 05:32
> 
> For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
> to use that for initializing the device memory by providing a new callback
> f_ops->populate() for the purpose.
> 
> SGX patches are provided to show the callback in context.
> 
> An obvious alternative is a ioctl but it is less elegant and requires
> two syscalls (mmap + ioctl) per memory range, instead of just one
> (mmap).

Is this all about trying to stop the vm_operations_struct.fault()
function being called?

It is pretty easy to ensure the mappings are setup in the driver's
mmap() function.
Then the fault() function can just return -VM_FAULT_SIGBUS;

If it is actually device memory you just need to call vm_iomap_memory()
That quite nicely mmap()s PCIe memory space into a user process.

Mapping driver memory is slightly more difficult.
For buffers allocated with dma_alloc_coherent() you can
probably use dma_mmap_coherent().
But I have a loop calling remap_pfn_range() because the
buffer area is made of multiple 16kB kernel buffers that
need to be mapped to contiguous user pages.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

