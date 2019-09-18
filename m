Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC0B644E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfIRNYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 09:24:40 -0400
Received: from verein.lst.de ([213.95.11.211]:33291 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfIRNYk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:24:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 887EB68BFE; Wed, 18 Sep 2019 15:24:36 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:24:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190918132436.GA16210@lst.de>
References: <20190911134315.27380-1-cmaiolino@redhat.com> <20190911134315.27380-10-cmaiolino@redhat.com> <20190916175049.GD2229799@magnolia> <20190918081303.zwnxr7pvtotr7cnt@pegasus.maiolino.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918081303.zwnxr7pvtotr7cnt@pegasus.maiolino.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:13:04AM +0200, Carlos Maiolino wrote:
> All checks are now made in the caller, bmap_fiemap() based on the filesystem's
> returned flags in the fiemap structure. So, it will decide to pass the result
> back, or just return -EINVAL.
> 
> Well, there is no way for iomap (or bmap_fiemap now) detect the block is in a
> realtime device, since we have no flags for that.
> 
> Following Christoph's line of thought here, maybe we can add a new IOMAP_F_* so
> the filesystem can notify iomap the extent is in a different device? I don't
> know, just a thought.
> 
> This would still keep the consistency of leaving bmap_fiemap() with the decision
> of passing or not.

I think this actually is a problem with FIEMAP as well, as it
doesn't report that things are on a different device.  So I guess for
now we should fail FIEMAP on the RT device as well.
