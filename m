Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DF22E434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 05:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgG0DFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgG0DFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:05:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE1CC0619D2;
        Sun, 26 Jul 2020 20:05:37 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jztSI-003Nid-Qc; Mon, 27 Jul 2020 03:05:35 +0000
Date:   Mon, 27 Jul 2020 04:05:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Message-ID: <20200727030534.GD795125@ZenIV.linux.org.uk>
References: <20200714190427.4332-1-hch@lst.de>
 <20200714190427.4332-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714190427.4332-19-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:04:22PM +0200, Christoph Hellwig wrote:
> Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work, but
> instead open a struct file for /dev/console and then install it as FD
> 0/1/2 manually.

I really hate that one.  Every time we exposed the internal details to
the fucking early init code, we paid for that afterwards.  And this
goes over the top wrt the level of details being exposed.

_IF_ you want to keep that thing, move it to fs/file.c, with dire comment
re that being very special shite for init and likely cause of subsequent
trouble whenever anything gets changed, a gnat farts somewhere, etc.

	Do not leave that kind of crap sitting around init/*.c; KERNEL_DS
may be a source of occasional PITA, but here you are trading it for a lot
worse one in the future.
