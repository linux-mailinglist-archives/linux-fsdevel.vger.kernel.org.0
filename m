Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668B482634
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jan 2022 01:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiAAAgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 19:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAAAgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 19:36:37 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251CC061574;
        Fri, 31 Dec 2021 16:36:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3SNm-00GKiS-4A; Sat, 01 Jan 2022 00:36:26 +0000
Date:   Sat, 1 Jan 2022 00:36:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Message-ID: <Yc+iCla9zjUFkBXt@zeniv-ca.linux.org.uk>
References: <20211213143927.3069508-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:39:24PM +0000, Matthew Wilcox (Oracle) wrote:
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

A couple of notes: please, use iov_iter_count(i) instead of open-coding
i->count.  And there's a preexisting nastiness in read_vmcore() -
generally, a fault halfway through the read() is treated as a short read,
rather than -EFAULT...
