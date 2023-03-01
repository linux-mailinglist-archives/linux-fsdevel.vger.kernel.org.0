Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2226A64F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 02:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCABs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 20:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCABsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:48:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA058A25D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 17:48:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C56A60FD9
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 01:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9895C433D2;
        Wed,  1 Mar 2023 01:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677635303;
        bh=Ox0wCE8PU2UINDXVNxVBySvW0Lsrn/6aJ+nksSn9mTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn6wZuhOwUlbnkuWkn8sSPg62DzqXmNDmJf/CLalRzXqFE+L0b0YBkdYL6JbOf56x
         wDnDoR9IUXDp+gQOB0kJh/UA2qSJmfnmpniRcgGKOVxbz2TyvlxN/Xp1ANNsU+qpP6
         q2CJXqpgvy2+bfiklHx2Iiruazma/iq+OB4iYqenxgzfrP+4RodzSbZVx6EuczpATg
         5TAcQzvg6+kVSsY151+jY84ZhpyWs2Jc30BE+woWSGrQbPuUoZsiYm451sRrwlii62
         olgPtLB/FtRTM8A6+Lf9kZYgPLfH9iYXWB807a5F8IraOrX11etskH9nWlEfkw3A3z
         X6moZBzpYTJoQ==
Date:   Tue, 28 Feb 2023 17:48:23 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem backporting to stable
Message-ID: <Y/6u5ylrN2OdJm0B@magnolia>
References: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 03:46:11PM -0800, Leah Rumancik wrote:
> The current standard for backporting to stable is rather ad hoc. Not
> everyone will cc stable on bug fixes, and even if they do, if the
> patch does not apply cleanly to the stable branches, it often gets
> dropped if no one notices or cares enough to do the backporting.

I'm very glad to see you stepping forward!

> Historically, the XFS community has avoided backports via cc’ing
> stable and via AUTOSEL due to concerns of accidentally introducing new
> bugs to the stable branches. However, over the last year, XFS has
> developed a new strategy for managing stable backports. A “stable
> maintainer” role has been created for each stable branch to identify,
> apply, and test potential backports before they are sent to the stable
> mailing list. This provides better monitoring of the stable branches
> which reduces the risk of introducing new bugs to stable and lessens
> the possibility of bug fixes getting dropped on their way to stable.
> XFS has benefited from this new backporting procedure and perhaps
> other filesystems would as well.

Given the recent roaring[1] between Sasha and Eric Biggers, I think this
is a very apropos topic.  It's probably all right for robots to pick
over driver patches and fling them into the LTS kernels, but filesystems
are so complex that they really need experienced people to make
judgement calls.

Another knot that I think we need to slice through is the question of
what to do when support for LTS kernels becomes sparse.  Case in point:

Oracle produces a kernel based on 5.4 and 5.15.  We're not going to
introduce one based on 5.10.  If Amir stops supporting 5.10, what do we
do about 5.4?  If a bugfix appears that needs to be applied to 5.4-6.1,
Greg will not let Chandan backport it to 5.4 until Chandan either takes
responsibility for 5.10, or tricks someone else into do it.  That's not
fair to him, and Oracle isn't going to start supporting 5.10.  Preening
online fsck parts 1 and 2 now consumes so much time that I don't have
the bandwidth to embark on any of the iomap cleanups that are slowly
getting more urgent.

[I am very very grateful that you all came along!]

So what do we do?  Do I beg the three of you to try to do 5.10 in your
spare time, which isn't really fair to you or Amir.

Proposal:

How about we EOL the XFS code in the releases that nobody wants so that
patches can keep flowing to the ones that are still wanted?

(Hypothetically speaking, since this isn't a problem /today/.)

<rant>
Really this is a resource allocation problem stemming from the ability
of the LTS leaders to saddle the rest of the fsdevel community with
responsibilities that we weren't asked about nor agreed to.

--D

[1] https://lore.kernel.org/linux-fsdevel/Y%2F4z2NyGgwG4zvYq@sashalap/T/#maa4db2ea8187e5e047a59bbb6411d916173367b9

> - Leah
