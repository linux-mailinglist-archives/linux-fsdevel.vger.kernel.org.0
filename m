Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23A3D7A22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhG0Pru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232679AbhG0Prt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627400869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ralyV5G7XJkmcT2GXx/j2umoacDKJ2ppZ813mNupf+4=;
        b=dtYbpuTirxw7kAVCL6T7vnMVebrHTokm8g/kasznvWYXjTbQDzcX3om2+xukz7jiRvuatr
        6PxhONbuNoVF6PPZMi7M0v31Bauw9nmtjqGta77QVo/1xfxMqjau0I8icauswo8iNJfxUo
        VbjAgrxBt4El4vdW372Mc6pNNz3MYIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212--tPwhjigM7-Tm0m0FAyATw-1; Tue, 27 Jul 2021 11:47:45 -0400
X-MC-Unique: -tPwhjigM7-Tm0m0FAyATw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2DDA18C8C00;
        Tue, 27 Jul 2021 15:47:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A6965D9FC;
        Tue, 27 Jul 2021 15:47:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16RFldMM011955;
        Tue, 27 Jul 2021 11:47:39 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16RFlb1u011951;
        Tue, 27 Jul 2021 11:47:37 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 27 Jul 2021 11:47:37 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev
Subject: [RFC v4] nvfs: a filesystem for persistent memory
Message-ID: <alpine.LRH.2.02.2107270946180.876@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

I announce a new version of NVFS - a filesystem for persistent memory.
You can download it at:
	http://people.redhat.com/~mpatocka/nvfs/
	git://leontynka.twibright.com/nvfs.git
Description of the filesystem layout:
	http://people.redhat.com/~mpatocka/nvfs/INTERNALS


Changes since the last release:

* updated for the kernels 5.13 and 5.14-rc

* add the ability to export the NVFS filesystem over NFS:
	- each directory contains a pointer to its parent directory 
	- add the 'generation' field to inodes
	- the ability to open files by inode numbers

* fixed some endianity conversions

* fixed some sparse warnings

* fixed a bug in extended attributes

Mikulas

