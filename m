Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0026F50AB8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 00:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442511AbiDUWkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 18:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiDUWkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:40:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B2E443D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 15:37:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2915E1F4613A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650580633;
        bh=2uLR6lpcb3Wga8OxsHI3MxrAfCZ5deGu8mBakPVEbSo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZbnMABbPXsy/tNgW/pJ2Y9S5Ra0QtsmTs+YKfO+fNRjQrxHqmRbf0A/L7GD52PDjP
         Eu6Laii+7GLGd07qlyC44m7WsWpwOIYuj6l7ZHLjYFrAxxevqgZasXpBoYygdpq0Wp
         zyf9Ag3OQ9ZcWtMhuxrxaIWwasRbjFP96mycD4bxqALFN3D1qSOtNTshxDywIl3DDJ
         vma0kG96vZ1cCnKlvct6me+4x9PNpI+QED0yfYl4bktO2GpEfk7d5ucfGUGtiLwyuK
         kjRPBKC7IVM/YB+a4fhTML+KyHTzVeuBrTly3py1ORd0z6zDI/rOFkY7c6Gl6HCyX7
         DBzn5ClE/wA6Q==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
Organization: Collabora
References: <20220418213713.273050-1-krisman@collabora.com>
        <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
        <87h76pay87.fsf@collabora.com>
        <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
Date:   Thu, 21 Apr 2022 18:37:09 -0400
In-Reply-To: <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 21 Apr 2022 08:33:56 +0300")
Message-ID: <87levyoyga.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Apr 19, 2022 at 6:29 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>> > Well that sucks.  We need a kernel-side workaround for applications
>> > that fail to check and report storage errors?
>> >
>> > We could do this for every syscall in the kernel.  What's special about
>> > tmpfs in this regard?
>> >
>> > Please provide additional justification and usage examples for such an
>> > extraordinary thing.
>>
>> For a cloud provider deploying containerized applications, they might
>> not control the application, so patching userspace wouldn't be a
>> solution.  More importantly - and why this is shmem specific -
>> they want to differentiate between a user getting ENOSPC due to
>> insufficiently provisioned fs size, vs. due to running out of memory in
>> a container, both of which return ENOSPC to the process.
>>
>
> Isn't there already a per memcg OOM handler that could be used by
> orchestrator to detect the latter?

Hi Amir,

Thanks for the added context.  I'm actually not sure if an OOM handler
completely solves the latter case.  If shmem_inode_acct_block fails, it
happens before the allocation. The OOM won't trigger and we won't know
about it, as far as I understand.  I'm not sure it's real problem for
Google's use case.  Khazhy is the expert on their implementation and
might be able to better discuss it.

I wanna mention that, for the insufficiently-provisioned-fs-size case,
we still can't rely just on statfs.  We need a polling interface -
generic or tmpfs specific - to make sure we don't miss these events, I
think.

Thanks,

-- 
Gabriel Krisman Bertazi
