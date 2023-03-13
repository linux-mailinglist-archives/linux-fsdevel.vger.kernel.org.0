Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893046B6D8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 03:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCMCeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 22:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCMCeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499DE36466
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Mar 2023 19:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E37F61033
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 02:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA3CC433D2;
        Mon, 13 Mar 2023 02:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678674842;
        bh=c9wfjiJpBMnTNj5NrS+9YBhI/pyatuB+cHeQLPVtMUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJDxUoWFsZecz1JpLEejf15ZAK1nyiSrIwZaM+yiiA2qTWDfWa0B352Dtnp+H1jAM
         FqFcsSkJ48BA5E/bp7+3fNILPY/Xpj+0heIzbbRTmtj2DlZYs704J2Q26vFBlq15FQ
         WvsT6LTElPTRe5+cj9SfllpO8dVOChJdRSACx8re+WBrQTusOSvANrQ6uFOuooXCIK
         EPVSCSXXMl7V2mcAlsbVw/v3d5Dzukly95Hq5sdODoMOunxfIIGqIw2ZrqpL2+ejis
         MSurfJSq1bx5UhPoF9r9xpKdijt9C8+puv8UNm1aFWx4GLNv3bBRm5LZrvi83ZGqUS
         rwgRKNUFDq4hQ==
Date:   Sun, 12 Mar 2023 22:34:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem backporting to stable
Message-ID: <ZA6LmJA/4HZMFraZ@sashalap>
References: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
 <Y/6u5ylrN2OdJm0B@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/6u5ylrN2OdJm0B@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:48:23PM -0800, Darrick J. Wong wrote:
>On Tue, Feb 28, 2023 at 03:46:11PM -0800, Leah Rumancik wrote:
>> The current standard for backporting to stable is rather ad hoc. Not
>> everyone will cc stable on bug fixes, and even if they do, if the
>> patch does not apply cleanly to the stable branches, it often gets
>> dropped if no one notices or cares enough to do the backporting.
>
>I'm very glad to see you stepping forward!
>
>> Historically, the XFS community has avoided backports via cc’ing
>> stable and via AUTOSEL due to concerns of accidentally introducing new
>> bugs to the stable branches. However, over the last year, XFS has
>> developed a new strategy for managing stable backports. A “stable
>> maintainer” role has been created for each stable branch to identify,
>> apply, and test potential backports before they are sent to the stable
>> mailing list. This provides better monitoring of the stable branches
>> which reduces the risk of introducing new bugs to stable and lessens
>> the possibility of bug fixes getting dropped on their way to stable.
>> XFS has benefited from this new backporting procedure and perhaps
>> other filesystems would as well.
>
>Given the recent roaring[1] between Sasha and Eric Biggers, I think this
>is a very apropos topic.  It's probably all right for robots to pick
>over driver patches and fling them into the LTS kernels, but filesystems
>are so complex that they really need experienced people to make
>judgement calls.

Which is fine in today's world, no? If a certain subsystem wants to do
it's own thing, it just makes our lives that much easier, and on that
note: thanks Leah & Amir!

>Another knot that I think we need to slice through is the question of
>what to do when support for LTS kernels becomes sparse.  Case in point:
>
>Oracle produces a kernel based on 5.4 and 5.15.  We're not going to
>introduce one based on 5.10.  If Amir stops supporting 5.10, what do we
>do about 5.4?  If a bugfix appears that needs to be applied to 5.4-6.1,
>Greg will not let Chandan backport it to 5.4 until Chandan either takes
>responsibility for 5.10, or tricks someone else into do it.  That's not
>fair to him, and Oracle isn't going to start supporting 5.10.  Preening
>online fsck parts 1 and 2 now consumes so much time that I don't have
>the bandwidth to embark on any of the iomap cleanups that are slowly
>getting more urgent.
>
>[I am very very grateful that you all came along!]
>
>So what do we do?  Do I beg the three of you to try to do 5.10 in your
>spare time, which isn't really fair to you or Amir.
>
>Proposal:
>
>How about we EOL the XFS code in the releases that nobody wants so that
>patches can keep flowing to the ones that are still wanted?

We're in the process of going away from 6 year kernels which will in
turn lessen the number of parallel trees we support.

OTOH, this raises the question of what Oracle plans to do after 5.4 goes
EOL?

-- 
Thanks,
Sasha
