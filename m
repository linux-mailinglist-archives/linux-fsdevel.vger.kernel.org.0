Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1136D20A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhD1GNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 02:13:46 -0400
Received: from verein.lst.de ([213.95.11.211]:47955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhD1GNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:13:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 638F468B05; Wed, 28 Apr 2021 08:12:59 +0200 (CEST)
Date:   Wed, 28 Apr 2021 08:12:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] proc: Use seq_read_iter where possible
Message-ID: <20210428061259.GA5084@lst.de>
References: <20210427183414.12499-1-arek_koz@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427183414.12499-1-arek_koz@o2.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:34:15PM +0200, Arkadiusz Kozdra (Arusekk) wrote:
> Since seq_read_iter looks mature enough to be used for all procfs files,
> re-allow applications to perform zero-copy data forwarding from them.
> According to the sendfile(2) man-page, it is still enough for the file
> being read to support mmap-like operations, and the proc files support
> memory mapping, so returning -EINVAL was an inconsistency.

Linus did object to blindly switching over all instances.

> Some executable-inspecting tools rely on patching entry point
> instructions with minimal machine code that uses sendfile to read
> /proc/self/maps to stdout.  The sendfile call allows them to do it
> faster and without excessive allocations.

Patching what entry point?
