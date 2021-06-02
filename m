Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B33399484
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 22:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhFBU3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 16:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBU3k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:29:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A71D60FF0;
        Wed,  2 Jun 2021 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622665676;
        bh=XwfIpvWyrv1xGEJDa8sxLozoVR9q507e4HaLqJMC4MY=;
        h=Date:From:To:Cc:Subject:From;
        b=RiwAoV3Q50LGPAuUEN63i4Y15CLijKqAJt1WEVhVVgtBom/x/mRfIdDC4xiexpsh0
         uf106EGcwpfkekPCkOTbSLZQevBqstNJrUfh1mA6jHz1c7MRfUosaBwwVyvmiutGv4
         o9FkvnJAiY9YkDvRzUaMaed+xhjA39caA0srAPeTEtfhO+XPzuDMinN0EIZt4Pwg+t
         swGl1sgdE6VOca4tIxED9/oinwCgUA8Kb8fXEWdCgr6n8ZSDKMhch8CvCBVPWimO/0
         AkZ1WlMVn7vUV4zt3PwusywDgvP3Tgv8PbhAt+42d7j+WWQ3aFTsLWxx6imNBkBQ9S
         nnx4uuMxZKKvQ==
Date:   Wed, 2 Jun 2021 13:27:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: question about mapping_set_error when writeback fails?
Message-ID: <20210602202756.GA26333@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_finish_page_writeback,

static void
iomap_finish_page_writeback(struct inode *inode, struct page *page,
		int error, unsigned int len)
{
	struct iomap_page *iop = to_iomap_page(page);

	if (error) {
		SetPageError(page);
		mapping_set_error(inode->i_mapping, -EIO);

Why don't we pass error to mapping_set_error here?  If the writeback
completion failed due to insufficient space (e.g. extent mapping btree
expansion hit ENOSPC while trying to perform an unwritten extent
conversion) then we set AS_EIO which causes fsync to return EIO instead
of ENOSPC like you'd expect.

The line in question was lifted from XFS; is this a historical behavior
from before we had AS_ENOSPC?  Or do we always set AS_EIO because that's
the error code that everyone understands (ha) to mean that writeback
failed and now we have no idea what's on disk vs. in the pagecache?

(I tried to figure out what ext4 and btrfs do to handle this, but ...
that was a twisty code maze and I gave up.)

--D
