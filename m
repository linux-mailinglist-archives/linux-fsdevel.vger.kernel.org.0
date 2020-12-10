Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31FF2D5456
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 08:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgLJHHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 02:07:45 -0500
Received: from verein.lst.de ([213.95.11.211]:52841 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgLJHHd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:07:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64BC968B02; Thu, 10 Dec 2020 08:06:47 +0100 (CET)
Date:   Thu, 10 Dec 2020 08:06:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: fix page reference and BIO leak
Message-ID: <20201210070647.GA12511@lst.de>
References: <20201210013828.417576-1-damien.lemoal@wdc.com> <SN4PR0401MB3598F92D83760E2A2D8749E59BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598F92D83760E2A2D8749E59BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 07:03:08AM +0000, Johannes Thumshirn wrote:
> Aren't we loosing bio->bi_status = BLK_STS_IOERR in case bio_iov_iter_get_pages() fails now?

We do, but it does not matter because nothing actually looks at
->bi_status in this failure path.
