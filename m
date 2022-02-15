Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED94B717C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 17:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbiBOQS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 11:18:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiBOQSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:18:55 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60213FA7;
        Tue, 15 Feb 2022 08:18:46 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK0XM-0021iO-20; Tue, 15 Feb 2022 16:18:44 +0000
Date:   Tue, 15 Feb 2022 16:18:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YgvSZB9Akl7FBqPX@zeniv-ca.linux.org.uk>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
 <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:06:06PM +0000, Al Viro wrote:

> Worse, you need to deal with the corner cases.  "/" or anything ending on
> "." or ".." can be rejected (no links to directories) and thankfully we
> do not allow AT_EMPTY for linkat(2), but...  procfs symlinks are in the

That'd be AT_EMPTY_PATH, obviously, and unfortunately we do allow that.
Which brings another fun case to deal with.  Same problem with "what's the
parent of that thing and how do we make it stable?"...

Oh, and you need to cope with O_TMPFILE ones as well - both for that and
for procfs symlinks to them.  Which is fine from the vfs_link() POV (see
I_LINKABLE check in there), but the locking is outside of that, so we
need to deal with that joy.  And _there_ you have no parent at all - what
could it be, anyway?  So we'd need to decide what to lock.  *AND* we have
the possibility of another thread doing link(2) on what used to be
O_TMPFILE, which would give it a parent by the time we get to doing
the actual operation...
