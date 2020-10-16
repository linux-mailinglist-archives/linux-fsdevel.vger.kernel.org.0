Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2550B290A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410924AbgJPQ4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410921AbgJPQ4L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:56:11 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E158320848;
        Fri, 16 Oct 2020 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602867371;
        bh=9U+8Baf6DXu/tV5OyMNV9nKYYBT1kOh1QcLFG+xP3ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrrzactTxXG9PMRy18HAyx7fSYW48KdossGtkw3cBS2gAZHMGYaTGm4neFHNV76ra
         WMrfVXLJ2iCoMQ3hWm4omhRA0qRtCY9x3R7EWElVFkKuDHdji0VESFpO9KZvCRYZFT
         vpU4YLC84V+FVA9iYBeqU+r3RNUZA2aR/7KCK63Q=
Date:   Fri, 16 Oct 2020 09:56:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: Make mpage_readpage synchronous
Message-ID: <20201016165608.GB1426921@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201016161426.21715-1-willy@infradead.org>
 <20201016161426.21715-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016161426.21715-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:14:26PM +0100, Matthew Wilcox (Oracle) wrote:
> +	err = submit_bio_killable(args.bio, mpage_end_io);
> +	if (unlikely(err))
> +		goto err;
> +
> +	SetPageUptodate(page);

On success, isn't the page already set up to date through the
mpage_end_io() callback?
