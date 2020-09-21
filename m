Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99DC271B16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUGsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 02:48:17 -0400
Received: from verein.lst.de ([213.95.11.211]:38665 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIUGsQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:48:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4772268AFE; Mon, 21 Sep 2020 08:48:14 +0200 (CEST)
Date:   Mon, 21 Sep 2020 08:48:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into
 the nfs code
Message-ID: <20200921064813.GB18559@lst.de>
References: <20200917082236.2518236-1-hch@lst.de> <20200917082236.2518236-3-hch@lst.de> <20200917171604.GW3421308@ZenIV.linux.org.uk> <20200917171826.GA8198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917171826.GA8198@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:18:26PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 17, 2020 at 06:16:04PM +0100, Al Viro wrote:
> > On Thu, Sep 17, 2020 at 10:22:33AM +0200, Christoph Hellwig wrote:
> > > There is no reason the generic fs code should bother with NFS specific
> > > binary mount data - lift the conversion into nfs4_parse_monolithic
> > > instead.
> > 
> > Considering the size of struct compat_nfs4_mount_data_v1...  Do we really
> > need to bother with that "copy in place, so we go through the fields
> > backwards" logics?  Just make that
> > 
> > > +static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
> > > +{
> > 	struct compat_nfs4_mount_data_v1 compat;
> > 	compat = *(struct compat_nfs4_mount_data_v1 *)data;
> > and copy the damnt thing without worrying about the field order...
> 
> Maybe.  But then again why bother?  I just sticked to the existing
> code as much as possible.

Trond, Anna: what is your preference?
