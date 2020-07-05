Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8022149A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 04:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGECQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGECQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:16:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B0C061794;
        Sat,  4 Jul 2020 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bYbmHapE90Zxz8viJR7qML2XsV4Actl5krCuXzYUaCQ=; b=N7vgR0BFXo1XdlYqfhTORPCjqU
        hSk0D+3g0pGs6jM7MkdgUQ+es7ylNY+YzUY8aVWAcLtPmQn9HvD5AEaubwWruP9o8/V8gCIyYPS+J
        7jdzGdU8flszs+oPKiy+nVWJ3rJ6dDQ+XJfeQTj/ZMBQ1jW/V1oj421bxJQ2ApWJw6YtxFjZk9SKi
        XNdKu2zRTt0XyWqpci1vQhNYmp/5kHnW8HRk+lDrgZnUhoRITQIBVxxRXY0NAicbT+0p1xzl17JL7
        NOwoAWQ8JYKk1mJHttHmEdQMezk2aoZPU8S+ZEsHWcSxuvc7r0qpSCCYPllaeY5IjhyydD93THwFW
        ZDNkoPSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jruCl-0000IH-Gi; Sun, 05 Jul 2020 02:16:31 +0000
Date:   Sun, 5 Jul 2020 03:16:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705021631.GR25523@casper.infradead.org>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> Hello
> 
> At first, I thought that the proposed system call is capable of
> reading *multiple* small files using a single system call - which
> would help increase HDD/SSD queue utilization and increase IOPS (I/O
> operations per second) - but that isn't the case and the proposed
> system call can read just a single file.
> 
> Without the ability to read multiple small files using a single system
> call, it is impossible to increase IOPS (unless an application is
> using multiple reader threads or somehow instructs the kernel to
> prefetch multiple files into memory).

What API would you use for this?

ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);

I pretty much hate this interface, so I hope you have something better
in mind.
