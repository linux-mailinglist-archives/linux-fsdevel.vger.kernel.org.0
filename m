Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD2211517
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGAV2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAV2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:28:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C52C08C5C1;
        Wed,  1 Jul 2020 14:28:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqkGl-003a7l-14; Wed, 01 Jul 2020 21:27:51 +0000
Date:   Wed, 1 Jul 2020 22:27:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/23] proc: add a read_iter method to proc proc_ops
Message-ID: <20200701212751.GL2786714@ZenIV.linux.org.uk>
References: <20200701200951.3603160-1-hch@lst.de>
 <20200701200951.3603160-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701200951.3603160-18-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 01, 2020 at 10:09:45PM +0200, Christoph Hellwig wrote:
> This will allow proc files to implement iter read semantics.

*UGH*

You are introducing file_operations with both ->read() and ->read_iter();
worse, in some cases they are not equivalent.  Sure, ->read() takes
precedence right now, but...  why not a separate file_operations for
->read_iter-capable files?

I really hate the fallbacks of that sort - they tend to be brittle
as hell.  And while we are at it, I'm not sure that your iter_read() 
has good cause to be non-static.
