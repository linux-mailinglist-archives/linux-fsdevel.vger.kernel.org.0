Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB16A3397
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBZTYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:24:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6834BDC2;
        Sun, 26 Feb 2023 11:24:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E1760C2E;
        Sun, 26 Feb 2023 19:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F56C433D2;
        Sun, 26 Feb 2023 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677439478;
        bh=DvhJHcnQg5b3D6o4WSuhZGJ4vMGsFhwAjTFGFXetlFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UswRLnk654isemwy1KrzCnEQKuxtOkNdSwGsddCNrRcigsvX7OHlNaHTw7DYJTLAH
         n8JsYV5ffuyvNLcVWWRaUhD44t+xrWsRB6eFY/irX9S0XhDMxSGtLhwzYJApXewQ9I
         TtIC71EoQwvOAfEq9Fi/qm1zT7DtAK8GF1jxRD4CEo5tnv9aONu0CiRJX2aoVL7mvP
         xNUYanxibycGHo0QaQNnLl2A3EoClHzkwfIhjeRs+sABamWDkv5D4pYa1/rDZD2x6M
         3OtJ7oJDcnb4SDWJc7gTxtEzQg6X+TFkXEOdESjHaOZX43DdfuQWrhwruaHQIoQ3z+
         vEUIzUYPmwBpA==
Date:   Sun, 26 Feb 2023 11:24:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 12/21] fs/super.c: stop calling
 fscrypt_destroy_keyring() from __put_super()
Message-ID: <Y/ux9JLHQKDOzWHJ@sol.localdomain>
References: <20230226034256.771769-1-sashal@kernel.org>
 <20230226034256.771769-12-sashal@kernel.org>
 <Y/rbGxq8oAEsW28j@sol.localdomain>
 <Y/rufenGRpoJVXZr@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rufenGRpoJVXZr@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 09:30:37PM -0800, Eric Biggers wrote:
> On Sat, Feb 25, 2023 at 08:07:55PM -0800, Eric Biggers wrote:
> > On Sat, Feb 25, 2023 at 10:42:47PM -0500, Sasha Levin wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > [ Upstream commit ec64036e68634231f5891faa2b7a81cdc5dcd001 ]
> > > 
> > > Now that the key associated with the "test_dummy_operation" mount option
> > > is added on-demand when it's needed, rather than immediately when the
> > > filesystem is mounted, fscrypt_destroy_keyring() no longer needs to be
> > > called from __put_super() to avoid a memory leak on mount failure.
> > > 
> > > Remove this call, which was causing confusion because it appeared to be
> > > a sleep-in-atomic bug (though it wasn't, for a somewhat-subtle reason).
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > Link: https://lore.kernel.org/r/20230208062107.199831-5-ebiggers@kernel.org
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > Why is this being backported?
> > 
> > - Eric
> 
> BTW, can you please permanently exclude all commits authored by me from AUTOSEL
> so that I don't have to repeatedly complain about every commit individually?
> Especially when these mails often come on weekends and holidays.
> 
> I know how to use Cc stable, and how to ask explicitly for a stable backport if
> I find out after the fact that one is needed.  (And other real people can always
> ask too... not counting AUTOSEL, even though you are sending the AUTOSEL emails,
> since clearly they go through no or very little human review.)
> 
> Of course, it's not just me that AUTOSEL isn't working for.  So, you'll still
> continue backporting random commits that I have to spend hours bisecting, e.g.
> https://lore.kernel.org/stable/20220921155332.234913-7-sashal@kernel.org.
> 
> But at least I won't have to deal with this garbage for my own commits.
> 
> Now, I'm not sure I'll get a response to this --- I received no response to my
> last AUTOSEL question at
> https://lore.kernel.org/stable/Y1DTFiP12ws04eOM@sol.localdomain.  So to
> hopefully entice you to actually do something, I'm also letting you know that I
> won't be reviewing any AUTOSEL mails for my commits anymore.
> 

The really annoying thing is that someone even replied to your AUTOSEL email for
that broken patch and told you it is broken
(https://lore.kernel.org/stable/d91aaff1-470f-cfdf-41cf-031eea9d6aca@mailbox.org),
and ***you ignored it and applied the patch anyway***.

Why are you even sending these emails if you are ignoring feedback anyway?

How do I even get you to not apply a patch?  Is it even possible?

I guess I might as well just add an email filter that auto-deletes all AUTOSEL
emails, as apparently there's no point in responding anyway?

- Eric
