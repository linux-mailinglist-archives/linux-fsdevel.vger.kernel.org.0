Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE455737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbfFYS3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 14:29:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34074 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbfFYS3U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:29:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 773BA1F461;
        Tue, 25 Jun 2019 18:29:20 +0000 (UTC)
Date:   Tue, 25 Jun 2019 18:29:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/14] epoll: implement epoll_create2() syscall
Message-ID: <20190625182920.abpecnwxdjdg7sjl@dcvr>
References: <20190624144151.22688-1-rpenyaev@suse.de>
 <20190624144151.22688-14-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624144151.22688-14-rpenyaev@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Roman Penyaev <rpenyaev@suse.de> wrote:
> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> and size, i.e. this patch wires up polling from userspace.

Instead of adding a new syscall, is setting size (and/or even
the EPOLL_USEREPOLL flag) something that could be done via
ioctl?

There's no race like CLOEXEC to worry about and it's not
going to be in a hot path where the extra syscall matters.

glibc won't need to increase in .so size, either.
