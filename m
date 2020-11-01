Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121532A21ED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 22:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgKAVir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 16:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgKAVir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 16:38:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67533C0617A6;
        Sun,  1 Nov 2020 13:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=N8U69Fkns2aacXFMjU5LbnRDU6omWtduEw3QqaCzJ7I=; b=NsXG1Pd1E2RNfZHYZEY9zWoy7U
        rWab3Q5Idr/+91CH7s3oFWPvQQWvNf9Sap4dwTTRcvRwCdarpg7fHE50I0QiHiQNiwZUm9Re7kpwG
        5JWc3MrZJ4G+OURuf74ONCWIfwSMfSxvNnwnnr9H7IU4oD4pwSWGqr7+Qp3mAUk8GIgeJwSBsk1xs
        45dMvR4df9eSQYYsOQxZN4848XTpTM/5hen0ATgFFhtPoU4WJqf6g4g4X8y8EbtDTHpoVPhSIBdhR
        cqoue6yC0iKPMRcWv28j7xM0PoniwocVveBcO4G2kY00s90Mgd9rsCAIqBqa8g5bH0s7cbr3xClr8
        3fTcyaCA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZL3l-00063a-FH; Sun, 01 Nov 2020 21:38:45 +0000
Date:   Sun, 1 Nov 2020 21:38:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201101213845.GH27442@casper.infradead.org>
References: <20201101212738.GA16924@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201101212738.GA16924@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 10:27:38PM +0100, Paweł Jasiak wrote:
> I am trying to run examples from man fanotify.7 but fanotify_mark always
> fail with errno = EFAULT.
> 
> fanotify_mark declaration is
> 
> SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
> 			      __u64, mask, int, dfd,
> 			      const char  __user *, pathname)

Don't worry about that.  You aren't calling the SYSCALL, you're calling
glibc and glibc is turning it into a syscall.

extern int fanotify_mark (int __fanotify_fd, unsigned int __flags,
                          uint64_t __mask, int __dfd, const char *__pathname)

> When 
> 
> fanotify_mark(4, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
>               FAN_CREATE | FAN_ONDIR, AT_FDCWD, 0xdeadc0de)

The last argument is supposed to be a pointer to a string.  I'm guessing
there's no string at 0xdeadc0de.

