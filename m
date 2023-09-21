Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76C7A9B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjIUTBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUTBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F87F83332
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0C3C32778;
        Thu, 21 Sep 2023 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287858;
        bh=gPiOoE/On+x9UFqlRIee2BPT+ywHhv1GdjezZH1s3H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wmr0WC2lqxD7X70rwi2Xp4RTcRHt+5AAKns2pA3t55KpPGYrEwjivbY2NbrIMBLh1
         ruRXDw4HpfV0q3EjabKpmMtVWJ9RwvdsPefaZIkp0z2DdetaCULxIHhsoLo9hcGxXu
         ZyiD+9mnB2m3g8HFOdjqbiLHfR5EXLk4M4zUjS74s6HkofLEg9YBA7v9fr8AlrsQ41
         SZRKqOid3v4zUKOuEbOBmqDbny5fTOZRb2HLXgatIEdy1K0f2Skk3zM55kUwtAf+rM
         mGfvwxRg7xclHhw5V5BbjI7ROaI5DZGvotDR6D4cQHDjZry1zHPcxM4nZWfkaO1nri
         EIh2sLXzVBEAw==
Date:   Thu, 21 Sep 2023 11:17:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: When to lock pipe->rd_wait.lock?
Message-ID: <20230921-nahen-ausklammern-aa91c8f49a1c@brauner>
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner>
 <CAKPOu+_Ebj6-YXPd4HWqG7TokZDvw26uM4xuJGL7k0gg+tHeyw@mail.gmail.com>
 <CAKPOu+9RC6XCKh0a0HNEFmjPCn8n=BvGwRHk13hJKWD2N_+OcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9RC6XCKh0a0HNEFmjPCn8n=BvGwRHk13hJKWD2N_+OcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:05:24AM +0200, Max Kellermann wrote:
> On Thu, Sep 21, 2023 at 9:28 AM Max Kellermann <max.kellermann@ionos.com> wrote:
> > I had another look at this, and something's fishy with the code or
> > with your explanation (or I still don't get it). If there is a
> > watch_queue, pipe_write() fails early with EXDEV - writing to such a
> > pipe is simply forbidden, the code is not reachable in the presence of
> > a watch_queue, therefore locking just because there might be a
> > wait_queue does not appear to make sense?
> 
> Meanwhile I have figured that the spinlock in pipe_write() is
> obsolete. It was added by David as preparation for the notification
> feature, but the notification was finally merged, it had the EXDEV,
> and I believe it was not initially planned to implement it that way?

It was supposed to get write support most likely but never got it.
Good catch.

> So I believe the spinlock is really not necessary (anymore) and I have

For pipe_write() it isn't we still need it for pipe_read().
