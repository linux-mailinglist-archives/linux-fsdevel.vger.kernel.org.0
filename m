Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8675FC4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGXQin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGXQim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:38:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D43125;
        Mon, 24 Jul 2023 09:38:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B45567373; Mon, 24 Jul 2023 18:38:38 +0200 (CEST)
Date:   Mon, 24 Jul 2023 18:38:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, hch@lst.de,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/read_write: Enable copy_file_range for block device.
Message-ID: <20230724163838.GB26430@lst.de>
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com> <20230724060336.8939-1-nj.shetty@samsung.com> <ZL4cpDxr450zomJ0@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL4cpDxr450zomJ0@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
> > and inode_out. Allow block device in generic_file_rw_checks.
> 
> Why? copy_file_range() is for copying a range of a regular file to
> another regular file - why do we want to support block devices for
> somethign that is clearly intended for copying data files?

Nitesh has a series to add block layer copy offload, and uses that to
implement copy_file_range on block device nodes, which seems like a
sensible use case for copy_file_range on block device nodes, and that
series was hiding a change like this deep down in a "block" title
patch, so I asked for it to be split out.  It still really should
be in that series, as there's very little point in changing this
check without an actual implementation making use of it.

