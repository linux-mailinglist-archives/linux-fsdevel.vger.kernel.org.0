Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB747A836A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjITNai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjITNah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:30:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC2A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:30:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810CAC433C8;
        Wed, 20 Sep 2023 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216631;
        bh=HPoj2n3BhijA2y1xK0EVff6S4xSJ+u/sFRVEQn2LiJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0TYH/mdbeyQt/5ZAW+gUBGZwG5bJmqGbUqTuJIOtSE9egtHXnbiFvz16eHRll+jy
         S48Ha08XU4/FSYX6RhKmG7xnrsnw6JMNuz+uZPIJw/mm2VLyrrywVf/aovGAaHw/3b
         6lhaHqvrNvj0if7pLtEY4J6vASIxsZfHiqu5Gj9LMtlqvo0LTUqXsiL1EO2B4zwG+8
         qMd+elZ/S9v23piQjvmYu4/xtnwS/Yb7CH4cmBPgZlrpXcoBn89i+BvfuMwCCx1o0O
         6gO4sIhX34ORNjjf/hTTPRHe1RhFhV5Css1kkCZqKIWPBj0Sc8SChtumG0IJaGGIv7
         xKV2Fs0ctSfpg==
Date:   Wed, 20 Sep 2023 15:30:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: When to lock pipe->rd_wait.lock?
Message-ID: <20230920-macht-rupfen-96240ce98330@brauner>
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:34:51PM +0200, Max Kellermann wrote:
> Hi,
> 
> I'm trying to understand the code that allocates a new buffer from a
> pipe's buffer ring. I'd like to write a patch that eliminates some
> duplicate code, to make it less error prone.
> 
> In fs/pipe.c, pipe_write() locks pipe->rd_wait.lock while the pipe's
> head gets evaluated and incremented (all while pipe->mutex is locked).
> My limited understand is that holding this spinlock is important
> because it protects the head/tail accesses in pipe_readable() which is
> gets called by wait_event while the spinlock is held, but without
> pipe->mutex.
> 
> However in fs/splice.c, splice_pipe_to_pipe() contains very similar
> code; a new buffer gets allocated, head gets incremented - but without
> caring for pipe->rd_wait.lock.
> Please help me understand the point of locking pipe->rd_wait.lock, and
> why it's necessary in pipe_write() but not in splice_pipe_to_pipe().
> Is that a bug or am I missing something?

Afaict, the mutex is sufficient protection unless you're using
watchqueues which use post_one_notification() that cannot acquire the
pipe mutex. Since splice operations aren't supported on such kernel
notification pipes - see get_pipe_info() - it should be unproblematic.
