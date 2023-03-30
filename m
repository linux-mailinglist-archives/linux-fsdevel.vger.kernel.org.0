Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF076D03F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjC3Lwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjC3LwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:52:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6BBB80;
        Thu, 30 Mar 2023 04:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 799F5B81F8C;
        Thu, 30 Mar 2023 11:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C1C4339B;
        Thu, 30 Mar 2023 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680177064;
        bh=BnoKw5KS7SaKCVrfQPGiM/jICK730a3ZjfwXB5RR3CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POlSe6LxoYYMKbOiomn7vKJp1daNhA6zBC3zbpCeTB4hXDqhO0tiu7Irhbleqmyoh
         bVdkiG8ecEwGX0RJLtjhgdAUCXM88VWMlIzcgz4X1mngjoDCgum1CR5cUg/89XYeE4
         arNDkDUF76ddVJRN+kv8eJYiTYX0Bsszqn7d8ysfY+zv55o2QYUBHeurP+KIIr0pCL
         k010QikBosvJljfbjsVYAOGXHUY2bsoXfvT9f+KE5ZeqGvPxRRVt7iNfR76kPbHF43
         ff8LKFXEDxHJdXd82kaFS+8UqWPeBljy2Jf/Olkrdpv9/DGuu16BC4F1H2Zx3/2lsf
         34icUZTPUUzhQ==
Date:   Thu, 30 Mar 2023 13:50:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
Message-ID: <20230330-plunder-revert-f6b2d3199766@brauner>
References: <20230330104144.75547-1-jlayton@kernel.org>
 <ZCVpAyA__NrAOVOg@kroah.com>
 <31bd4a176344cd0746f1ec519eb8caca2ef2ba68.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31bd4a176344cd0746f1ec519eb8caca2ef2ba68.camel@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:15:36AM -0400, Jeff Layton wrote:
> On Thu, 2023-03-30 at 12:48 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Mar 30, 2023 at 06:41:43AM -0400, Jeff Layton wrote:
> > > There are three copies of the same dt_type helper sprinkled around the
> > > tree. Convert them to use the common fs_umode_to_dtype function instead,
> > > which has the added advantage of properly returning DT_UNKNOWN when
> > > given a mode that contains an unrecognized type.
> > > 
> > > Cc: Chuck Lever <chuck.lever@oracle.com>
> > > Cc: Phillip Potter <phil@philpotter.co.uk>
> > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/configfs/dir.c | 9 ++-------
> > >  fs/kernfs/dir.c   | 8 +-------
> > >  fs/libfs.c        | 9 ++-------
> > >  3 files changed, 5 insertions(+), 21 deletions(-)
> > > 
> > > v2: consolidate S_DT helper as well
> > > v3: switch existing dt_type helpers to use fs_umode_to_dtype
> > >     drop v9fs hunks since they're no longer needed
> > 
> > You forgot the "v3" in the subject line :(
> > 
> 
> Yeah, I noticed, sorry. It's the attention to detail that makes me such
> a successful kernel developer! ;)

/me hides from his own syzbot "good morning" message from earlier today...

But honestly, I don't think it's worth resending just to add v3.
