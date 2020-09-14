Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268B26945F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgINSHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgINSGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:06:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115BAC06174A;
        Mon, 14 Sep 2020 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zV4Lm/9L3zFnOTphSMX5hzkLWLxwOny/bhMtDsdszWc=; b=CnAJ8VpI4hsm8Bn1foZaUgcByp
        nvBzry/7KZH+Rw6vL9wlj5xyvgFsbxDYWzJ3Y4ZuTQ4nimUGnVBD6ONUIZk5eww74reKlCr5lPbjO
        S25CqFs/R+1E9HLNBFYgBEE4ZHxipxGOkU98nalHctkS89MYKQgQ8DfTcVz7kBhgzY/NBxbQVUkyp
        /GehE25kt6PeJ0yWQjkcB9Y9iGlSh3dHgHFl2pqma2HEVgK21J8Yom72a4azDh/RYnUSQTzXEg48+
        yxmOOQzm168Z3hIhDs/duxF5blfiJr6yuxXJABiW64N5jyqedclKg8iCYrpuf9daSgdCqHyNhcPr+
        XN/PQtlg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHss1-0006ue-2b; Mon, 14 Sep 2020 18:06:29 +0000
Date:   Mon, 14 Sep 2020 19:06:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     mateusznosek0@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] fs: micro-optimization remove branches by adjusting
 flag values
Message-ID: <20200914180629.GT6583@casper.infradead.org>
References: <20200914174338.9808-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914174338.9808-1-mateusznosek0@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:43:38PM +0200, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> When flags A and B have equal values than the following code
> 
> if(flags1 & A)
> 	flags2 |= B;
> 
> is equivalent to
> 
> flags2 |= (flags1 & A);
> 
> The latter code should generate less instructions and be faster as one
> branch is omitted in it.

[citation needed]

$ cat test.c 
int a(int x)
{
	int y = 0;

	if (x & 1)
		y |= 1;
	if (x & 2)
		y |= 2;

	return y;
}

$ objdump -d test.o
0000000000000000 <a>:
   0:   89 f8                   mov    %edi,%eax
   2:   83 e0 03                and    $0x3,%eax
   5:   c3                      retq   

Please stop submitting uglifying patches without checking they actually
improve anything.  GCC is smarter than you think it is.
