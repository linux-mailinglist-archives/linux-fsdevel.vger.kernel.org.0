Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499915071D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347835AbiDSPbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiDSPbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:31:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21913F2B
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 08:29:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E880C1F42793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650382141;
        bh=rkSlUoutshtFn7WULyLopKxe+pkuypNyxiYzPULXXDo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=etypumsnGOftZGZlaZ9aPNEXT/pg2J3N26P5EnmS06+ecDayKjCXfdAERAawJOq3s
         idglqCkBzpGltCBuxSunkA+BXjtdvFSZAmLfnvcJwbD08Nr5UL9+2Ydbt5chVCTFGq
         kvypFviLwX1h5vq0bWs9YLXLFIrL8qsVzP5eAqAa94v8hFHXmiOg6fOGxIrXlpeO7l
         MXv6XYSS+0pVr+OAybcTCstRRCGViUasyW23r75A0UgU4dLSU/wUoWcCWhOkOEbn70
         EytP2qWAlKQ6mpplPR/5fJTEFP3K21I6BEdblfHZogpXkxoX+ndC1bnRgdbkHAdZxB
         k4UrkEtshEKKw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, amir73il@gmail.com, viro@zeniv.linux.org.uk,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
Organization: Collabora
References: <20220418213713.273050-1-krisman@collabora.com>
        <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
Date:   Tue, 19 Apr 2022 11:28:56 -0400
In-Reply-To: <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
        (Andrew Morton's message of "Mon, 18 Apr 2022 20:42:04 -0700")
Message-ID: <87h76pay87.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

Hi Andrew,

> On Mon, 18 Apr 2022 17:37:10 -0400 Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>
>> When provisioning containerized applications, multiple very small tmpfs
>
> "files"?

Actually, filesystems.  In cloud environments, we have several small
tmpfs associated with containerized tasks.

>> are used, for which one cannot always predict the proper file system
>> size ahead of time.  We want to be able to reliably monitor filesystems
>> for ENOSPC errors, without depending on the application being executed
>> reporting the ENOSPC after a failure.
>
> Well that sucks.  We need a kernel-side workaround for applications
> that fail to check and report storage errors?
>
> We could do this for every syscall in the kernel.  What's special about
> tmpfs in this regard?
>
> Please provide additional justification and usage examples for such an
> extraordinary thing.

For a cloud provider deploying containerized applications, they might
not control the application, so patching userspace wouldn't be a
solution.  More importantly - and why this is shmem specific -
they want to differentiate between a user getting ENOSPC due to
insufficiently provisioned fs size, vs. due to running out of memory in
a container, both of which return ENOSPC to the process.

A system administrator can then use this feature to monitor a fleet of
containerized applications in a uniform way, detect provisioning issues
caused by different reasons and address the deployment.

I originally submitted this as a new fanotify event, but given the
specificity of shmem, Amir suggested the interface I'm implementing
here.  We've raised this discussion originally here:

https://lore.kernel.org/linux-mm/CACGdZYLLCqzS4VLUHvzYG=rX3SEJaG7Vbs8_Wb_iUVSvXsqkxA@mail.gmail.com/

> Whatever that action is, I see no user-facing documentation which
> guides the user info how to take advantage of this?

I can follow up with a new version with documentation, if we agree this
feature makes sense.

Thanks,

-- 
Gabriel Krisman Bertazi
