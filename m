Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29026A0A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIOIQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 04:16:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgIOIQD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B1A8AC6E;
        Tue, 15 Sep 2020 08:16:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5957DA818; Tue, 15 Sep 2020 10:14:48 +0200 (CEST)
Date:   Tue, 15 Sep 2020 10:14:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: send: avoid copying file data
Message-ID: <20200915081448.GG1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1597994106.git.osandov@osandov.com>
 <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
 <20200911141339.GR18399@twin.jikos.cz>
 <20200914220448.GC148663@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914220448.GC148663@relinquished.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:04:48PM -0700, Omar Sandoval wrote:
> On Fri, Sep 11, 2020 at 04:13:39PM +0200, David Sterba wrote:
> > On Fri, Aug 21, 2020 at 12:39:52AM -0700, Omar Sandoval wrote:
> > > +static int put_data_header(struct send_ctx *sctx, u32 len)
> > > +{
> > > +	struct btrfs_tlv_header *hdr;
> > > +
> > > +	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> > > +		return -EOVERFLOW;
> > > +	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
> > > +	hdr->tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
> > > +	hdr->tlv_len = cpu_to_le16(len);
> > 
> > I think we need put_unaligned_le16 here, it's mapping a random buffer to
> > a pointer, this is not alignment safe in general.
> 
> I think you're right, although tlv_put() seems to have this same
> problem.

Indeed and there's more: tlv_put, TLV_PUT_DEFINE_INT, begin_cmd,
send_cmd. Other direct assignments are in local structs so the alignment
is fine.
