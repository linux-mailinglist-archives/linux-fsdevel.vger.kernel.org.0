Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF16C7642
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCXDdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 23:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCXDdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:33:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B112F12D
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 20:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aoVoYqw2sGU3juxL566B/0c85hBiRXMIG7hy2YSbB4U=; b=nuK2qION5jOJWvYUcu10uoBodb
        v3coHW5MrPt+9lwFPo5ZfB7nEy3VBesm9+OHkk2NVzNLHec/nO6NNuxA0sO03pjfOOX0LJIC8Jnh3
        o+gIrYw8/ZZ2dj6aGVSybJ5tqfxOhExMXQGcdNtN9Qa1eKc7GycXuuNxoURhaI9PbUdB7ALjZgEkB
        kl/F9SdflZYOfbvGvPwkPlbXpex2Eo55q6YgeSoAvMV7rLP5kk/3iQDqY7sLR00BIDC9i9Pl5/s07
        ktdNbBaKu9Fb1VNHpNZomhEGmmvRDqM3+wkH+CK3MuPMrD/nUuUrq1upzkFNGw0Ak8Aq8YzFlL2Rk
        S9r8AikA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfYBD-004XIe-Fv; Fri, 24 Mar 2023 03:33:28 +0000
Date:   Fri, 24 Mar 2023 03:33:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        dan.j.williams@intel.com, jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH] fsdax: unshare: zero destination if srcmap is HOLE or
 UNWRITTEN
Message-ID: <ZB0aB7DzhzuyaM9Z@casper.infradead.org>
References: <1679483469-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230322160311.89efea3493db4c4ccad40a25@linux-foundation.org>
 <a41f0ea1-c704-7a2e-db6d-93e8bd4fcdea@fujitsu.com>
 <20230323151112.1cc3cf57b35f2dc704ff1af8@linux-foundation.org>
 <a30006e8-2896-259e-293b-2a5d873d42aa@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a30006e8-2896-259e-293b-2a5d873d42aa@fujitsu.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:50:54AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2023/3/24 6:11, Andrew Morton 写道:
> > On Thu, 23 Mar 2023 14:50:38 +0800 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> > 
> > > 
> > > 
> > > 在 2023/3/23 7:03, Andrew Morton 写道:
> > > > On Wed, 22 Mar 2023 11:11:09 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> > > > 
> > > > > unshare copies data from source to destination. But if the source is
> > > > > HOLE or UNWRITTEN extents, we should zero the destination, otherwise the
> > > > > result will be unexpectable.
> > > > 
> > > > Please provide much more detail on the user-visible effects of the bug.
> > > > For example, are we leaking kernel memory contents to userspace?
> > > 
> > > This fixes fail of generic/649.
> > 
> > OK, but this doesn't really help.  I'm trying to determine whether this
> > fix should be backported into -stable kernels and whether it should be
> > fast-tracked into Linus's current -rc tree.
> > 
> > But to determine this I (and others) need to know what effect the bug
> > has upon our users.
> 
> I didn't get any bug report form users.  I just found this by running
> xfstests.  The phenomenon of this problem is: if we funshare a reflinked
> file which contains HOLE extents, the result of the HOLE extents should be
> zero but actually not (unexpectable data).

You still aren't answering the question.  If this did happen to a user,
what would they see in the file?  Random data?  Something somebody else
wrote some time ago?  A copy of /etc/passwd, perhaps?  A copy of your
credit card number?
