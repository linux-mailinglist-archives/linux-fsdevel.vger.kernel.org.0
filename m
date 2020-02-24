Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7150816B0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBXUTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 15:19:01 -0500
Received: from verein.lst.de ([213.95.11.211]:40160 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgBXUTB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:19:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A13D968B05; Mon, 24 Feb 2020 21:18:58 +0100 (CET)
Date:   Mon, 24 Feb 2020 21:18:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: fix IOCB_NOWAIT handling
Message-ID: <20200224201858.GA10880@lst.de>
References: <20200221143723.482323-1-hch@lst.de> <BYAPR04MB58169F3C3A66DCCEAA35E332E7EC0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58169F3C3A66DCCEAA35E332E7EC0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:48:48PM +0000, Damien Le Moal wrote:
> 
> The main problem with allowing IOCB_NOWAIT is that for an application that sends
> multiple write AIOs with a single io_submit(), all write AIOs after one that is
> failed with -EAGAIN will be failed with -EINVAL (not -EIO !) since they will
> have an unaligned write offset. I am wondering if that is really a problem at
> all since the application can catch the -EAGAIN and -EINVAL, indicating that the
> write stream was stopped. So maybe it is reasonable to simply allow IOCB_NOWAIT ?

I don't think supporting IOCB_NOWAIT with current zonefs is very useful.
It will be very useful once Zone Append is supported.

But more importantly my patch fixes a bug in the current zonefs
implementation.  We need to fix that before 5.6 is released.  Any
additional functionaity can still come later if we think that it is
useful.
