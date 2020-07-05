Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABDB2149D8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGED1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGED1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:27:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50729C061794;
        Sat,  4 Jul 2020 20:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1HVM69sv+KPc2VykHuUhGFUMm1maJllg1rLH5d0wrGI=; b=iBIPzR9Sa0ULgSA8+esCMwsd4Y
        34wYp+leVZuoUSA7vDu0P2uNvfw02uVtOcf4nBvO/9DGJ4cvnnAdjs9f8Q243z9pH591p+qVeBzTw
        OntSKXqGDTKDTMg050aSyqR7o6RybIgcGbOo5bmHiAAA1qyHsSlejlBcZAuTWkNknc+LL2eypr6BB
        S2KihTLxJ3Hf3Qll95PiUlzjSe5MoJSQzfaAkJq+11eZ+45Me+mDTAytoC270fcm0FPFtPc+1V9hZ
        fnbj6frNwxIgvNxr+IeFADhaWQLfP92jHGerXeucZlJNH+n7Q8MM91XEPc4aTEkyFvXWLkzAAzVw3
        2w3fH2YA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrvJU-0002Rw-JD; Sun, 05 Jul 2020 03:27:32 +0000
Date:   Sun, 5 Jul 2020 04:27:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705032732.GT25523@casper.infradead.org>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > You should probably take a look at io_uring.  That has the level of
> > complexity of this proposal and supports open/read/close along with many
> > other opcodes.
> 
> Then glibc can implement readfile using io_uring and there is no need
> for a new single-file readfile syscall.

It could, sure.  But there's also a value in having a simple interface
to accomplish a simple task.  Your proposed API added a very complex
interface to satisfy needs that clearly aren't part of the problem space
that Greg is looking to address.
