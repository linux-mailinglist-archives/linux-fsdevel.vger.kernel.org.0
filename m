Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5D3167D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 14:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBJNUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 08:20:22 -0500
Received: from verein.lst.de ([213.95.11.211]:51090 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhBJNUN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:20:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E84686736F; Wed, 10 Feb 2021 14:19:28 +0100 (CET)
Date:   Wed, 10 Feb 2021 14:19:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210210131928.GA30109@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com> <20210208151920.GE12872@lst.de> <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com> <20210209093438.GA630@lst.de> <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:46:13PM +0800, Ruan Shiyang wrote:
>
>
> On 2021/2/9 下午5:34, Christoph Hellwig wrote:
>> On Tue, Feb 09, 2021 at 05:15:13PM +0800, Ruan Shiyang wrote:
>>> The dax dedupe comparison need the iomap_ops pointer as argument, so my
>>> understanding is that we don't modify the argument list of
>>> generic_remap_file_range_prep(), but move its code into
>>> __generic_remap_file_range_prep() whose argument list can be modified to
>>> accepts the iomap_ops pointer.  Then it looks like this:
>>
>> I'd say just add the iomap_ops pointer to
>> generic_remap_file_range_prep and do away with the extra wrappers.  We
>> only have three callers anyway.
>
> OK.

So looking at this again I think your proposal actaully is better,
given that the iomap variant is still DAX specific.  Sorry for
the noise.

Also I think dax_file_range_compare should use iomap_apply instead
of open coding it.
