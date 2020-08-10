Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17C2412D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHJWHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 18:07:02 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:43923 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgHJWHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:07:02 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 7B31E1AAC7F;
        Tue, 11 Aug 2020 08:06:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k5FwV-0007mY-7u; Tue, 11 Aug 2020 08:06:55 +1000
Date:   Tue, 11 Aug 2020 08:06:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v2 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200810220655.GC2079@dread.disaster.area>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-14-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-14-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=KqUJ7u37zmrocqc7xm4A:9 a=iL2FK-9NOCaYj0ZJ:21 a=0foCJPwPtQ_ghwrP:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:19PM -0400, Vivek Goyal wrote:
> This patch implements basic DAX support. mmap() is not implemented
> yet and will come in later patches. This patch looks into implemeting
> read/write.

....

> +static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
> +					 loff_t length, unsigned flags,
> +					 struct iomap *iomap)

please doin't use the iomap_* namespace even for static functions in
filesystem code. This really doesn't have anything to do with iomap
except that whatever fuse sets up is used to fill an iomap.
i.e. fuse_setup_new_dax_mapping() would be far more appropriate
name.

> +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> +					 loff_t length, unsigned flags,
> +					 struct iomap *iomap)

ditto: fuse_upgrade_dax_mapping().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
