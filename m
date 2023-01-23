Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF306775AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 08:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjAWHgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 02:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAWHgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:36:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D418AB8;
        Sun, 22 Jan 2023 23:36:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C2A968BEB; Mon, 23 Jan 2023 08:36:10 +0100 (CET)
Date:   Mon, 23 Jan 2023 08:36:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+c27475eb921c46bbdc62@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hch@lst.de, jack@suse.com, jack@suse.cz,
        linkinjeon@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [udf?] BUG: unable to handle kernel NULL pointer
 dereference in __writepage
Message-ID: <20230123073609.GA31134@lst.de>
References: <0000000000003198a505f0076823@google.com> <0000000000009cfc1705f2a07641@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009cfc1705f2a07641@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I looked into this and got really confused.  We should never end
up in generic_writepages if ->writepages is set, which this patch
obviously does.

Then I took a closer look at udf, and it seems to switch a_aops around
at run time, and it seems like we're hitting just that case, and the
patch just seems to narrow down that window.

I suspect the right fix is to remove this runtime switching of aops,
and just do conditionals inside the methods.
