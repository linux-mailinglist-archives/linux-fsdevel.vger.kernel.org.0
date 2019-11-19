Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC3102AA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKSRR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 12:17:56 -0500
Received: from verein.lst.de ([213.95.11.211]:35516 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbfKSRR4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:17:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C383968BFE; Tue, 19 Nov 2019 18:17:52 +0100 (CET)
Date:   Tue, 19 Nov 2019 18:17:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Daniel Wagner' <dwagner@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org,
        valdis.kletnieks@vt.edu, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com
Subject: Re: [PATCH v2 02/13] exfat: add super block operations
Message-ID: <20191119171752.GA20042@lst.de>
References: <20191119071107.1947-1-namjae.jeon@samsung.com> <CGME20191119071403epcas1p3f3d69faad57984fa3d079cf18f0a46dc@epcas1p3.samsung.com> <20191119071107.1947-3-namjae.jeon@samsung.com> <20191119085639.kr4esp72dix4lvok@beryllium.lan> <00d101d59eba$dcc373c0$964a5b40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d101d59eba$dcc373c0$964a5b40$@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 06:22:28PM +0900, Namjae Jeon wrote:
> > No idea what the code does. But I was just skimming over and find the
> > above pattern somehow strange. Shouldn't this be something like
> Right.
> 
> > 
> > 	if (!READ_ONCE(sbi->s_dirt)) {
> > 		WRITE_ONCE(sbi->s_dirt, true);
> 
> It should be :
> 	if (READ_ONCE(sbi->s_dirt)) {
>  		WRITE_ONCE(sbi->s_dirt, false);
> I will fix it on v3.

The other option would be to an unsigned long flags field and define
bits flags on it, then use test_and_set_bit, test_and_clear_bit etc.
Which might be closer to the pattern we use elsewhere in the kernel.
