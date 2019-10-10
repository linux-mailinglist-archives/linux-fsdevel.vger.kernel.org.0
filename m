Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36709D2865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfJJLvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 07:51:02 -0400
Received: from verein.lst.de ([213.95.11.211]:57812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfJJLvC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:51:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15CB568C65; Thu, 10 Oct 2019 13:50:55 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:50:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 04/12] nvmet: make nvmet_copy_ns_identifier()
 non-static
Message-ID: <20191010115053.GB28921@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-5-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:21PM -0600, Logan Gunthorpe wrote:
> This function will be needed by the upcoming passthru code.
> 
> Passthru will need an emulated version of identify_desclist which
> copies the eui64, uuid and nguid from the passed-thru controller into
> the request SGL.

I don't like the way this is handled.  We should avoid faking up
behavior not supported if this really is a passthrough interface.

For this particular case this means:

 1) report the vs field that the actual controller reports
 2) if that is below 1.2.1 bump it to that, but no further
    (and maybe print a warning)
 3) don't emulate the namespace descriptor CNS ever
