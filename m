Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC1378F2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhEJNeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhEJM3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:29:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0002C061347;
        Mon, 10 May 2021 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Yh4qogtudzmfgkcxgXTiGLEV+AsfBbQiX5QEdiz68g=; b=RhGQgJvpVQjX+m22dblFpLtGY0
        54cH/JGOx89AD/JHvuX3Fh/OvaeNjEsvFnT6DUIC3JBD7NjD1U9uyUnEEqqVZns3OkhG4P2yYJKyE
        g76rb1GuEqhB0tQiNs5YCZyG3m8+iZbdsJKEQvAxiydlTmjK3YRYc1hyEPt1z/eFuc80IvZPgcRzR
        DrOFtKGn3AL/VuhqFiut9GgBzugrJ03Rp5BCbpRRexNFgtmnyY0Bhr9XZK41VZAvs2GBHF63KL1Mh
        20OuRPQfzWzyF+5R9Dk0gxmGNBWr5hhc/wqPqk9auqLQ3ItxI9JUlVfSQy4Bw3itPRm8TwPr7km0J
        pOaPxJSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lg4ss-00676P-Vk; Mon, 10 May 2021 12:20:02 +0000
Date:   Mon, 10 May 2021 13:19:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rdna@fb.com" <rdna@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: cat /proc/sys/kernel/tainted => page allocation failure: order:6
Message-ID: <YJkk2qnNwj60wzSo@casper.infradead.org>
References: <04735c17a20f6edd3c97374323ba2dc15e7fd624.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04735c17a20f6edd3c97374323ba2dc15e7fd624.camel@nokia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 11:12:21AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hello,
> 
> Why is order 6 allocation required for "cat /proc/sys/kernel/tainted" ...?
> I'm seeing (occasional) failures in one VM (with 65d uptime):
> 
> [5674989.634561] cat: page allocation failure: order:6, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=user.slice,mems_allowed=0
> [5674989.645432] CPU: 0 PID: 2717524 Comm: cat Not tainted 5.10.19-200.fc33.x86_64 #1

The underlying problem is that 'cat' is asking to do a 128kB read (!)
so we allocate 256kB (!) of contiguous (!) memory.  This is already
mostly fixed upstream.  Please upgrade your kernel.
