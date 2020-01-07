Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E734A13292E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgAGOpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 09:45:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGOpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:45:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C0E2AC6F;
        Tue,  7 Jan 2020 14:45:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E37701E0B47; Tue,  7 Jan 2020 15:45:18 +0100 (CET)
Date:   Tue, 7 Jan 2020 15:45:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: udf_count_free() and UDF discs with Metadata partition
Message-ID: <20200107144518.GF25547@quack2.suse.cz>
References: <20191226113750.rcfmbs643sfnpixq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226113750.rcfmbs643sfnpixq@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Thu 26-12-19 12:37:50, Pali Rohár wrote:
> During testing of udfinfo tool (from udftools project) I found that
> udfinfo's implementation for calculating free space does not work when
> UDF filesystem has Metadata partition (according to OSTA UDF 2.50).
> 
> Year ago in udfinfo for calculating free space I used same algorithm as
> is implemented in kernel UDF driver, function udf_count_free(). So I
> suspect kernel driver could have it incorrectly implemented too, but I'm
> not sure. So I'm sending this email to let you know about it.
> 
> What is the problem? UDF Metadata partition is stored directly on UDF
> Physical partition and therefore free space calculation needs to be done
> from Physical one (same applies for Virtual partition). But Metadata
> partition contains mapping table for logical <--> physical blocks, so
> reading data needs to be done always from Metadata partition. Also in
> UDF terminology are two different things: Partition and Partition Map.
> And "partition number" is a bit misleading as sometimes it refers to
> "Partition" and sometimes to "Partition Map" what are two different
> things.

Thanks for the note! You're right that we probably misreport amount of free
space in the UDF filesystems with Metadata partition. Luckily the kernel
driver supports filesystems with Metadata partition or Virtual partition
only in read-only mode so the bug does not cause any real harm.

> Calculation problem in udfinfo I fixed in this commit:
> https://github.com/pali/udftools/commit/1763c9f899bdbdb68b1a44a8cb5edd5141107043

Thanks for the link, I'll fixup the kernel code. BTW, how did you test
this? Do you have any UDF image with Metadata partition?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
