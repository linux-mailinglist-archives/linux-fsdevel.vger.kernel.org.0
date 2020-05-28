Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716BC1E69EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406095AbgE1TBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406018AbgE1TA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:00:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC5DC08C5C6;
        Thu, 28 May 2020 12:00:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeNls-00H4Qd-Rj; Thu, 28 May 2020 19:00:53 +0000
Date:   Thu, 28 May 2020 20:00:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 09/14] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200528190052.GM23230@ZenIV.linux.org.uk>
References: <20200528054043.621510-1-hch@lst.de>
 <20200528054043.621510-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528054043.621510-10-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 07:40:38AM +0200, Christoph Hellwig wrote:
> If we write to a file that implements ->write_iter there is no need
> to change the address limit if we send a kvec down.  Implement that
> case, and prefer it over using plain ->write with a changed address
> limit if available.

Umm...  It needs a comment along the lines of "weird shits like
/dev/sg that currently check for uaccess_kernel() will just
have to make sure they never switch to ->write_iter()"
