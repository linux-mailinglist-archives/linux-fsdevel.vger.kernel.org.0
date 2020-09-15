Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B97269A71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOAb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOAbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:31:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4EC06174A;
        Mon, 14 Sep 2020 17:31:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHysw-00GEGT-1S; Tue, 15 Sep 2020 00:31:50 +0000
Date:   Tue, 15 Sep 2020 01:31:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     mateusznosek0@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: micro-optimization remove branches by adjusting
 flag values
Message-ID: <20200915003150.GJ3421308@ZenIV.linux.org.uk>
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
> 
> Introduced patch changes the value of 'LOOKUP_EMPTY' and makes it equal
> to the value of 'AT_EMPTY_PATH'. Thanks to that, few branches can be
> changed in a way showed above which improves both performance and the
> size of the code.

No.  AT_EMPTY_PATH is a part of userland ABI; to tie LOOKUP_EMPTY to it
means that we can't ever modify the sucker.  Worse, it restricts any
possible reshuffling of the LOOKUP_... bits in the future.

So unless you can show an effect on the real-world profiles, there are
fairly strong reasons to avoid that headache.
