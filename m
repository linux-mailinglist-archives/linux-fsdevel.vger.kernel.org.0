Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4204C401F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 09:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiBYI3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 03:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiBYI3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F9722399C4
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 00:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645777761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GT8z9LqO+66soqATOFmkROoS1wym6AvUApI1SnunQHw=;
        b=EKMYdrg3TsRL8F+pp1nqT+dO6AJj0WZ2nEBW10LxYVMZsSdYFtQHbjRcUpKi27v0MWIc2t
        tuoLnhklTHC2B77Z60gTevSHUomxzWOJWFiCjfX1Go8oB50xh3xoVfQQK0SCdR6nkdiJK+
        CROmcRuuVupcL6D/fsnIniyGA7sXBXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-b3QYUbt4NtGUkZCAWjNe0w-1; Fri, 25 Feb 2022 03:29:16 -0500
X-MC-Unique: b3QYUbt4NtGUkZCAWjNe0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41E9501E0;
        Fri, 25 Feb 2022 08:29:12 +0000 (UTC)
Received: from localhost (ovpn-13-4.pek2.redhat.com [10.72.13.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 886E183172;
        Fri, 25 Feb 2022 08:28:42 +0000 (UTC)
Date:   Fri, 25 Feb 2022 16:28:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Message-ID: <YhiTN0MORoQmFFkO@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
 <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/01/22 at 12:36am, Al Viro wrote:
> On Mon, Dec 13, 2021 at 02:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> A couple of notes: please, use iov_iter_count(i) instead of open-coding
> i->count.  And there's a preexisting nastiness in read_vmcore() -
> generally, a fault halfway through the read() is treated as a short read,
> rather than -EFAULT...

Sorry for being late to work on this.

While checking it, I noticed it's generic to return -EFAULT in kernel.
E.g in kernfs_file_read_iter(). Even though 'man 3 read' does give the
same words as you noted.

However, the manpage says the less then nbyte case happened just in case
the number of bytes left in the file is less than nbyte. The returning
-EFAULT in read_vmcore() seems to be a little different and not
satisfying the condition, because the left bytes should be greater than
the nbyte when reading out the elf note, or the middle of the vmcore. So
we should leave it as is?

Abstract from man page of read:
====
Upon successful completion, where nbyte is greater than 0, read() shall mark for update the last data access timestamp of the
file, and shall return the number of bytes read.  This number shall never be greater than nbyte.  The value returned  may  be
less  than  nbyte if the number of bytes left in the file is less than nbyte, if the read() request was interrupted by a sig‐
nal, or if the file is a pipe or FIFO or special file and has fewer than nbyte bytes immediately available for  reading.  For
example, a read() from a file associated with a terminal may return one typed line of data.
====

