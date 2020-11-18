Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC92B76AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 08:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKRHJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:09:57 -0500
Received: from verein.lst.de ([213.95.11.211]:34250 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgKRHJ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:09:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9279967373; Wed, 18 Nov 2020 08:09:54 +0100 (CET)
Date:   Wed, 18 Nov 2020 08:09:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118070954.GA17326@lst.de>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
> If we've successfully transferred some data in __iomap_dio_rw(),
> don't mark an error for a latter segment in the dio.

For normal direct I/O we never return short reads/writes, and IIRC that
has been inherited from the old direct I/O code.  I think we'll need
to make this conditional on your nowait case rather than changing the
user visible behavior.
