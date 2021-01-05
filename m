Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591DC2EB2B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 19:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbhAESkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 13:40:22 -0500
Received: from verein.lst.de ([213.95.11.211]:34117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbhAESkW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:40:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21ADC67373; Tue,  5 Jan 2021 19:39:39 +0100 (CET)
Date:   Tue, 5 Jan 2021 19:39:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving
 writeback bvecs allocation
Message-ID: <20210105183938.GA3878@lst.de>
References: <20210105132647.3818503-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105132647.3818503-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At least for iomap I think this is the wrong approach.  Between the
iomap and writeback_control we know the maximum size of the writeback
request and can just use that.  Take a look at what iomap_readpage_actor
does on the read size, something similar taking the wbc into account
can be done on the writeback side.
