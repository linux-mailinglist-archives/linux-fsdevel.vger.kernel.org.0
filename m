Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56DE243E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHMRcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMRcF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:32:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D164C061757;
        Thu, 13 Aug 2020 10:32:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6H51-00F8jY-9s; Thu, 13 Aug 2020 17:31:55 +0000
Date:   Thu, 13 Aug 2020 18:31:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
Message-ID: <20200813173155.GZ1236603@ZenIV.linux.org.uk>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de>
 <20200813162002.GX1236603@ZenIV.linux.org.uk>
 <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 01:19:18PM -0400, Josef Bacik wrote:

> > in sunrpc proc_dodebug() turns into
> > 		left -= snprintf(buffer, left, "0x%04x\n",
					 ^^^^
					 left + 1, that is.

> > 				 *(unsigned int *) table->data);
> > and that's not the only example.
> > 
> 
> We wouldn't even need the extra +1 part, since we're only copying in how
> much the user wants anyway, we could just go ahead and convert this to
> 
> left -= snprintf(buffer, left, "0x%04x\n", *(unsigned int *) table->data);
> 
> and be fine, right?  Or am I misunderstanding what you're looking for?  Thanks,

snprintf() always produces a NUL-terminated string.  And if you are passing 7 as
len, you want 0xf0ad\n to be copied to user.  For that you need 8 passed to
snprintf, and 8-byte buffer given to it.
