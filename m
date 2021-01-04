Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F12E921E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 09:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbhADIpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 03:45:00 -0500
Received: from verein.lst.de ([213.95.11.211]:56898 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbhADIo7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:44:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB49C6736F; Mon,  4 Jan 2021 09:44:15 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:44:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs/buffer: try to submit writeback bio in unit of page
Message-ID: <20210104084415.GA28741@lst.de>
References: <20201230000815.3448707-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230000815.3448707-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 30, 2020 at 08:08:15AM +0800, Ming Lei wrote:
> It is observed that __block_write_full_page() always submit bio with size of block size,
> which is often 512 bytes.
> 
> In case of sequential IO, or >=4k BS random/seq writeback IO, most of times IO
> represented by all buffer_head in each page can be done in single bio. It is actually
> done in single request IO by block layer's plug merge too.
> 
> So check if IO represented by buffer_head can be merged to single page
> IO, if yes, just submit single bio instead of submitting one bio for each buffer_head.

There is some very weird formatting in here.  From a very quick look
the changes look sensible, but I wonder if we should spend so much
time optimizing the legacy buffer_head I/O path, rather than switching
callers to saner helpers.
