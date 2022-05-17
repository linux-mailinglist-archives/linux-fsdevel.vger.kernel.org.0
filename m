Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF7452AE2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 00:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiEQWcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiEQWck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 18:32:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B43E5C0;
        Tue, 17 May 2022 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NkGrqohDhl0Ru/z/4CdG6vGOYGQQqFbS8Adgul9ZO6U=; b=Wiru92zKmLZwC3ibtyjcesi8uW
        r/gJ+Fyxp3+obMLld0GCOAi2ZW9Y747BjG8+A/Ak32uwni/t/u2JP+qMxfXondYIU5lPWUH9gapzC
        92BPGGXQfBre+Lz7UgKlLUQ0AU/UWZEi6wrTkzMhbfrc4SN79Z7ajKaYGFJR+3CC4+2NoDrJ6KEFK
        BstTjmYOWCmb9BOyX5AKUQvkUs3UPHOEWpL4xkpn5x9ME5S+nxEtcRbaal778TVGIAUUFlbxhpBpo
        IBUCULp06qp0Ak1+s3BkFtZHH4/gPiTvargskB89ZS0hbe14BOCbeBkczT1haQ9TaIweU6WpaqoTB
        euS/N5XQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr5k6-00Fr1x-GF; Tue, 17 May 2022 22:32:38 +0000
Date:   Tue, 17 May 2022 22:32:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        fuse-devel@lists.sourceforge.net, tytso@mit.edu, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
Message-ID: <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
References: <20220511222910.635307-1-dlunev@chromium.org>
 <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 10:20:06PM +0000, Al Viro wrote:
> On Thu, May 12, 2022 at 08:29:10AM +1000, Daniil Lunev wrote:
> > Force unmount of FUSE severes the connection with the user space, even
> > if there are still open files. Subsequent remount tries to re-use the
> > superblock held by the open files, which is meaningless in the FUSE case
> > after disconnect - reused super block doesn't have userspace counterpart
> > attached to it and is incapable of doing any IO.
> 
> 	Why not simply have those simply rejected by fuse_test_super()?
> Looks like that would be much smaller and less invasive patch...
> Confused...

... because Miklos had suggested that, apparently ;-/  I disagree -
that approach has more side effects.  "mount will skip that sucker" is,
AFAICS, the only effect of modiyfing test_super callback(s); yours, OTOH...

Note that generic_shutdown_super() is *not* called while superblock is
mounted anywhere.  And it doesn't get to eviction from the list while it still
has live dentries.  Or inodes, for that matter.

So this
        if (sb->s_bdi != &noop_backing_dev_info) {
		if (sb->s_iflags & SB_I_PERSB_BDI)
			bdi_unregister(sb->s_bdi);
		bdi_put(sb->s_bdi);
		sb->s_bdi = &noop_backing_dev_info;
	}
is almost certainly not safe to be done on a live superblock.
