Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5254B72B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiBOQU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 11:20:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241535AbiBOQUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:20:49 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC6E3725;
        Tue, 15 Feb 2022 08:20:40 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK0ZB-0021jl-Tk; Tue, 15 Feb 2022 16:20:38 +0000
Date:   Tue, 15 Feb 2022 16:20:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
 <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvSB6CKAhF5IXFj@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:17:11PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 15, 2022 at 04:06:06PM +0000, Al Viro wrote:
> > On Tue, Feb 15, 2022 at 01:37:40PM +0000, Al Viro wrote:
> > > On Tue, Feb 15, 2022 at 10:56:29AM +0100, Miklos Szeredi wrote:
> > > 
> > > > Doing "lock_rename() + lookup last components" would fix this race.
> >
> > "Fucking ugly" is inadequate for the likely results of that approach.
> > It's guaranteed to be a source of headache for pretty much ever after.
> > 
> > Does POSIX actually make any promises in that area?  That would affect
> > how high a cost we ought to pay for that - I agree that it would be nicer
> > to have atomicity from userland point of view, but there's a difference
> > between hard bug and QoI issue.
> 
> As I understand the original report, it relies on us hitting the nlink ==
> 0 at exactly the wrong moment.  Can't we just restart the entire path
> resolution if we find a target with nlink == 0?  Sure, it's a lot of
> extra work, but you've got to be trying hard to hit it in the first place.

touch /tmp/blah
exec 42</tmp/blah
rm /tmp/blah
... call linkat() with AT_SYMLINK_FOLLOW and /proc/self/fd/42 for source

Your variant will loop indefinitely on that...
