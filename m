Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6251613C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgBQNoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:44:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:37520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBQNoW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:44:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF191AF6A;
        Mon, 17 Feb 2020 13:44:20 +0000 (UTC)
Date:   Mon, 17 Feb 2020 07:44:17 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH] iomap: return partial I/O count on error in direct I/O
Message-ID: <20200217134417.bxdw4yex5ky44p57@fiona>
References: <20200213192503.17267-1-rgoldwyn@suse.de>
 <20200217131752.GA14490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131752.GA14490@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  5:17 17/02, Christoph Hellwig wrote:
> On Thu, Feb 13, 2020 at 01:25:03PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > In case of a block device error, iomap code returns 0 as opposed to
> > the amount of submitted I/O, which may have completed before the
> > error occurred. Return the count of submitted I/O for correct
> > accounting.
> 
> Haven't we traditionally failed direct I/O syscalls that don't fully
> complete and never supported short writes (or reads)?

Yes, but I think that decision should be with the filesystem what to do
with it and not the iomap layer.

The reason we need this patch for btrfs is that we need to account for
updating the allocations. iomap_end() returns written as zero while
iomap_dio_rw loop has submitted part of the I/O. So btrfs has no idea
as to how much has been submitted before the failure and how much of
the allocation to update.

This was exhibited by generic/250 in some of the runs where it fails the
underlying storage.

-- 
Goldwyn
