Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA74B6DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiBONhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 08:37:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiBONhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:37:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE06E8DE;
        Tue, 15 Feb 2022 05:37:42 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJy1U-001zgX-Bx; Tue, 15 Feb 2022 13:37:40 +0000
Date:   Tue, 15 Feb 2022 13:37:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:56:29AM +0100, Miklos Szeredi wrote:

> Doing "lock_rename() + lookup last components" would fix this race.

No go - thanks to the possibility of AT_SYMLINK_FOLLOW there.
Think of it - we'd need to
	* lock parents (both at the same time)
	* look up the last component of source
	* if it turns a symlink - unlock parents and repeat the entire
thing for its body, except when asked not to.
	* when we are done with the source, look the last component of
target up

... and then there is sodding -ESTALE handling, with all the elegance
that brings in.

> If this was only done on retry, then that would prevent possible
> performance regressions, at the cost of extra complexity.

Extra compared to the above, that is.  How delightful...
