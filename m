Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0745123F24F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHGRxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 13:53:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38341 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgHGRxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:53:46 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 077Hr7KU003226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Aug 2020 13:53:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6DF63420263; Fri,  7 Aug 2020 13:53:07 -0400 (EDT)
Date:   Fri, 7 Aug 2020 13:53:07 -0400
From:   tytso@mit.edu
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] ext4: remove ext4_buffer_uptodate()
Message-ID: <20200807175307.GW7657@mit.edu>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
 <20200620025427.1756360-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620025427.1756360-3-yi.zhang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:54:24AM +0800, zhangyi (F) wrote:
> After we add async write error check in ext4_journal_get_write_access(),
> we can remove the partial fix for filesystem inconsistency problem
> caused by reading old data from disk, which in commit <7963e5ac9012>
> "ext4: treat buffers with write errors as containing valid data" and
> <cf2834a5ed57> "ext4: treat buffers contining write errors as valid in
> ext4_sb_bread()".
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

I think it's better to keep these checks (in commits 2 and 3) because
ext4_error() doens't guarantee that the file system will be aborted.
For better or for worse, there are a large number of file systems
which default to errors=continue.

So if we notice that the buffer is not up to date, due to a write
error, we can avoid some (although not all) damage if we keep this
workaround.

					- Ted
