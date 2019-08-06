Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DDB82B39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 07:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfHFFqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 01:46:09 -0400
Received: from verein.lst.de ([213.95.11.211]:53335 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFqJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:46:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBDA868B02; Tue,  6 Aug 2019 07:46:04 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:46:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190806054604.GK13409@lst.de>
References: <20190731141245.7230-1-cmaiolino@redhat.com> <20190731141245.7230-9-cmaiolino@redhat.com> <20190731232254.GW1561054@magnolia> <20190802134816.usmauocewduggrjt@pegasus.maiolino.io> <20190802152902.GI7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802152902.GI7138@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:29:02AM -0700, Darrick J. Wong wrote:
> It's harder for me to tell when I don't have a branch containing the
> final product to look at, but I'd have thought that _fill_kernel fills
> out an in-kernel fiemap extent; and then _fill_user would declare one on
> the stack, call _fill_kernel to set the fields, and then copy_to_user?

That works fine for small, fixed-sized structures.  But for large
variable sized structures it is very inefficient, as we need to do a
possibly large kernel allocation and just copy it on.  Thus I told Carlos
to follow the readdir model with the ->actor (used to be ->filldir)
callback that can fill out the actual kernel or user data directly.
Another example of this high-level model is our struct iov_iter used
in the I/O path.
