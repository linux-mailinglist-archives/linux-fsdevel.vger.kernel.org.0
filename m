Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16F239AE26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 00:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCWjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 18:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCWjT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 383EC613FF;
        Thu,  3 Jun 2021 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622759854;
        bh=Q7AfV/pFWoppLJ7RBW4CDh3xUENOSj+9wxs4Ekg70Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6lmdhTmAOwe1A+Cq5SsLmxCrBGgXbdHlYkMm3YzL3+698KCYhoBnKYjGxZilzbb2
         zMMuOhF+EYQUu+TnpDTtdHqhTgK/oWXrbkmA/0dyV2Rl9+62bk4kd2+J0VmsUJE+Vy
         0UANhxnqSm401KUJYlH033zb9/7xF1YwuZvA5GVHYkdR88s5N2OW0Top3Y/Z+Hcw2i
         +HuSkUjbRxDjL6bZKvq2hPR5d8DpLO2/x2DpucQMjzfzPAVa/5JXF+hjPvM+ADXGju
         NmB/zgvIs8NYy0lHBfQ07qsCKq0ijx6hwpSWat+MkQxbqjinHQUan0gLQx1rDQ2/DO
         oLLorWUQ/52cQ==
Date:   Thu, 3 Jun 2021 15:37:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Message-ID: <20210603223733.GF26380@locust>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB29205D645B33F4721E890660F4569@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29201A0E8100416023E77F80F4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB29201A0E8100416023E77F80F4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 10:23:25AM +0000, ruansy.fnst@fujitsu.com wrote:
> > 
> > Hi, Dan
> > 
> > Do you have any comments on this?
> 
> Ping

This patchset has acquired multiple RVB tags but (AFAIK) Dan still
hasn't responded.  To get this moving again, it might be time to send
this direct to Al with a note that the maintainer hasn't been
responsive.

--D

> > 
> > 
> > --
> > Thanks,
> > Ruan Shiyang.
> > 
> > > -----Original Message-----
> > > From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Sent: Thursday, April 22, 2021 9:45 PM
> > > Subject: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
> > > code
> > >
> > > From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > >
> > > The page fault part of fsdax code is little complex. In order to add
> > > CoW feature and make it easy to understand, I was suggested to factor
> > > some helper functions to simplify the current dax code.
> > >
> > > This is separated from the previous patchset called "V3 fsdax,xfs: Add
> > > reflink&dedupe support for fsdax", and the previous comments are here[1].
> > >
> > > [1]:
> > > https://patchwork.kernel.org/project/linux-nvdimm/patch/20210319015237
> > > .99
> > > 3880-3-ruansy.fnst@fujitsu.com/
> > >
> > > Changes from V2:
> > >  - fix the type of 'major' in patch 2
> > >  - Rebased on v5.12-rc8
> > >
> > > Changes from V1:
> > >  - fix Ritesh's email address
> > >  - simplify return logic in dax_fault_cow_page()
> > >
> > > (Rebased on v5.12-rc8)
> > > ==
> > >
> > > Shiyang Ruan (3):
> > >   fsdax: Factor helpers to simplify dax fault code
> > >   fsdax: Factor helper: dax_fault_actor()
> > >   fsdax: Output address in dax_iomap_pfn() and rename it
> > >
> > >  fs/dax.c | 443
> > > +++++++++++++++++++++++++++++--------------------------
> > >  1 file changed, 234 insertions(+), 209 deletions(-)
> > >
> > > --
> > > 2.31.1
> > 
> > 
> 
