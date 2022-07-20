Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F857AE13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiGTCjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiGTCjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:39:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B446E2CB;
        Tue, 19 Jul 2022 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8bNghlUjH2CGCokL/OKTDDDt3XVnbKE+jMt3raQ6k0=; b=mbKglKGkvxsB/vUlEUSF25tjl8
        1KhlpvN9JQNEmnxfcv5kIoYN0F7hKDGf3O4RuTbkEW/ucbXix8TkApy7BK5zpAVXKD/AcwmrRo5Jg
        snkPVSgwux9LnlvGnFq7C61Ewns52XNmJSL8AHe0DNPkzxKw1cEvM6yaayhyxgJYyQXYI/RZIzBNO
        WfgE5etv6WnBwrfz1T/ClarxVC1ae+6YNyuQRBvvtHchfGG8dvQc086YbLeDmN/HeKBonTTv4MDU5
        UimFe5qXYudIpvSBjEMWFnoZNYUIdbzcoQ4xeDbhX4FEq8SRSpgLVVNxYx6G8J36yUVXwMVsrFTSp
        7P+i7RGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDzcA-00DxQL-Gp;
        Wed, 20 Jul 2022 02:39:06 +0000
Date:   Wed, 20 Jul 2022 03:39:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] vfs: add propagate_mount_tree_busy() helper
Message-ID: <YtdqyjqrUaIivGUT@ZenIV>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066658.210556.1326573473015621909.stgit@donald.themaw.net>
 <YtdgUOJlTc4aB+82@ZenIV>
 <41252c7e-674b-c110-962b-c20204dc7424@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41252c7e-674b-c110-962b-c20204dc7424@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:31:26AM +0800, Ian Kent wrote:
> 
> On 20/7/22 09:54, Al Viro wrote:
> > On Mon, Jul 11, 2022 at 11:37:46AM +0800, Ian Kent wrote:
> > 
> > > +static int do_mount_in_use_check(struct mount *mnt, int cnt)
> > > +{
> > > +	struct mount *topper;
> > > +
> > > +	/* Is there exactly one mount on the child that covers
> > > +	 * it completely?
> > > +	 */
> > > +	topper = find_topper(mnt);
> > > +	if (topper) {
> > > +		int topper_cnt = topper->mnt_mounts_cnt + 1;
> > > +
> > > +		/* Open file or pwd within singular mount? */
> > > +		if (do_refcount_check(topper, topper_cnt))
> > > +			return 1;
> > Whatever the hell for?  umount(2) will be able to slide the
> > underlying mount from under the topper, whatever the
> > refcount of topper might have been.
> 
> My thinking was that a process could have set a working
> 
> directory (or opened a descriptor) and some later change
> 
> to an autofs map resulted in it being mounted on. It's
> 
> irrelevant now with your suggested simpler approach, ;)

No, I mean why bother checking refcount of overmount in the first
place?  umount(2) will *not* consider it as -EBUSY.  On propagation
under the full overmount it will quietly remove the thing it's
overmounting.

If you have

overmount
victim
mountpoint

stacked like that, with overmount sitting directly on the root
subtree covered by the victim, the only things checked will be
	* victim itself is not busy
	* victim has nothing mounted deeper in it.
In that case it'll collapse to

overmount
mountpoint

and proceed to take the (now detached) victim out.
