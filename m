Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289C423FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhJFN7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 09:59:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52176 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231384AbhJFN7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:59:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 196DvMuc023362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Oct 2021 09:57:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 409F915C34DF; Wed,  6 Oct 2021 09:57:22 -0400 (EDT)
Date:   Wed, 6 Oct 2021 09:57:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hao Sun <sunhao.th@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>
Subject: Re: WARNING in __kernel_read
Message-ID: <YV2rQnl1kJ84C1RV@mit.edu>
References: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com>
 <YV2T3HVHHmQPHVYG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV2T3HVHHmQPHVYG@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:17:32PM +0100, Matthew Wilcox wrote:
> finit_module() is not the only caller of kernel_read_file_from_fd()
> which passes it a fd that userspace passed in, for example
> kexec_file_load() doesn't validate the fd either.  We could validate
> the fd in individual syscalls, in kernel_read_file_from_fd()
> or just do what vfs_read() does and return -EBADF without warning.

My suggestion would be to do both, and keep a WARN() in
__kernel_read(), since that should never happen (and we want a stack
trace if it does).

						- Ted
