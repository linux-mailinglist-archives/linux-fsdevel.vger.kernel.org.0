Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449A456238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZGRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 02:17:30 -0400
Received: from verein.lst.de ([213.95.11.211]:40423 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGRa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:17:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BD02868B05; Wed, 26 Jun 2019 08:16:58 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:16:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        david@fromorbit.com
Subject: Re: [PATCH 3/6] iomap: Check iblocksize before transforming
 page->private
Message-ID: <20190626061658.GA23972@lst.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de> <20190621192828.28900-4-rgoldwyn@suse.de> <20190624070536.GA3675@lst.de> <20190625185659.tqaikm27onz6g3jt@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625185659.tqaikm27onz6g3jt@fiona>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:56:59PM -0500, Goldwyn Rodrigues wrote:
> Btrfs uses page->private to identify which extent_buffer it belongs to.
> So, if you read, it fills the page->private. Then you try to write to
> it, iomap will assume it to be iomap_page pointer.

Yes, and that is going to run into problems sooner or later, that is
if you want to support sub-page size block sizes in btrfs, which I
though is work in progress, or if you ever want to write through iomap.

> I don't think we can move extent_buffer out of page->private for btrfs.
> Any other ideas?

I think you'll have to.  That being said I don't see why you'd need
data in page->private for pages potentially being read in a setup
where blocksize == PAGESIZE anyway.
