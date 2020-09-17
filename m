Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4626E3D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIQRQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgIQRQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:16:23 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C1C06174A;
        Thu, 17 Sep 2020 10:16:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxVs-000WY1-Kr; Thu, 17 Sep 2020 17:16:04 +0000
Date:   Thu, 17 Sep 2020 18:16:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into
 the nfs code
Message-ID: <20200917171604.GW3421308@ZenIV.linux.org.uk>
References: <20200917082236.2518236-1-hch@lst.de>
 <20200917082236.2518236-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917082236.2518236-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:22:33AM +0200, Christoph Hellwig wrote:
> There is no reason the generic fs code should bother with NFS specific
> binary mount data - lift the conversion into nfs4_parse_monolithic
> instead.

Considering the size of struct compat_nfs4_mount_data_v1...  Do we really
need to bother with that "copy in place, so we go through the fields
backwards" logics?  Just make that

> +static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
> +{
	struct compat_nfs4_mount_data_v1 compat;
	compat = *(struct compat_nfs4_mount_data_v1 *)data;
and copy the damnt thing without worrying about the field order...
