Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B88E14B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfHNXf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 19:35:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50272 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfHNXf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:35:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hy2o8-0001eY-8P; Wed, 14 Aug 2019 23:35:56 +0000
Date:   Thu, 15 Aug 2019 00:35:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de
Subject: Re: [PATCH 04/11] fs, quota: introduce wait_super_thawed() to wait
 until a superblock is thawed
Message-ID: <20190814233556.GV1131@ZenIV.linux.org.uk>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-5-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814121834.13983-5-s.hauer@pengutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 02:18:27PM +0200, Sascha Hauer wrote:
> quota uses three different functions to get a superblock from a
> block_device. Instead, retrieve the superblock always with get_super()
> and introduce wait_super_thawed() which is then used to wait until the
> superblock is thawed. This way the code can better be shared with the
> code introduced in the next step: We want to add quota support for
> filesystems without a block_device, so here functions around a
> block_device can't be used.

> + *	wait_super_thawed - wait for a superblock being thawed
> + *	@sb: superblock to wait for
> + *	@excl: if true, get s_umount semaphore exclusively
> + *
> + * Wait until the superblock is thawed. s_umount semaphore must be released on
> + * entry and will be held when returning.
> + */

Never expose anything like that - if locking rules depend upon the flags,
it MUST NOT be anything beyond a static helper.  I'm serious - that kind
of stuff ends up with trouble again and again.  Just don't.
