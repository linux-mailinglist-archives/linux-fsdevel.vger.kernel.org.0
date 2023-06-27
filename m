Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508873FF32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjF0PDt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjF0PDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155A97;
        Tue, 27 Jun 2023 08:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2468611CE;
        Tue, 27 Jun 2023 15:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63675C433C8;
        Tue, 27 Jun 2023 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687878227;
        bh=/C1fZDnnMpZsWKtdfU01u7/urVo63tsPikiXYwC+OGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyr/NkFH+tqFWvjRYnD8YVs94YmXJtr/PD3e8etu94d+vmofJHczkNPRifrAyiu3m
         5QJ0kZGBrbZv0mmvGg8g2vxw3ZCOv4TXn7PBulNTcf9h6IoqVw+uackYUea3Or3xWD
         877h45kEOhST1XvIf7+ee2FS5IwEQTSzpN2Di9Vca+f4QBxz4ggdDi+2rwbseihcfS
         7VPYWbVfEM068O+oz0rYrDl4WOMQmhNrdNMRZK2WKlhfLOMp6zemMJsFu3bL5AfMeP
         xMbCpxZ3lIA7vKLcMMTx1z3uzJWZu/T2PCn4XlYZXR2hWAo9qQmkOHp46Hm351cQyc
         /yxA3Fd71umkg==
Date:   Tue, 27 Jun 2023 17:03:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: port to new mount api
Message-ID: <20230627-wahlunterlagen-zappeln-df12371cad14@brauner>
References: <20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org>
 <b9028f9d-d947-3813-9677-c49bd2b72d53@wdc.com>
 <20230627140809.GA16168@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627140809.GA16168@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:08:09PM +0200, David Sterba wrote:
> On Tue, Jun 27, 2023 at 11:51:01AM +0000, Johannes Thumshirn wrote:
> > On 26.06.23 16:19, Christian Brauner wrote:
> > > This whole thing ends up being close to a rewrite in some places. I
> > > haven't found a really elegant way to split this into smaller chunks.
> > 
> > You'll probably hate me for this, but you could split it up a bit by 
> > first doing the move of the old mount code into params.c and then do the
> > rewrite for the new mount API.
> 
> The patch needs more finer split than just that. Replacing the entire
> mount code like that will introduce bugs that users will hit for sure.
> We have some weird mount option combinations or constraints, and we
> don't have a 100% testsuite coverage.
> 
> The switch to the new API needs to be done in one patch, that's obvious,
> however all the code does not need to be in one patch. I suggest to
> split generic preparatory changes, add basic framework for the new API,
> then add the easy options, then by one the complicated ones, then do the
> switch, then do the cleanup and removal of the old code. Yes it's more

You can't support both apis. You either do a full switch or you have to
have a lot of dead and duplicatd code around that isn't used until the
switch is done. I might just miss what you mean though. So please
provide more details how you envision this to be done.

> work but if we have to debug anything in the future it'll be narrowed
> down to a few short patches.

I don't think you'll end up with a few short patches. That just not how
that works but again, I might just not see what you're seeing.

> 
> Previsous work (https://lore.kernel.org/linux-btrfs/20200812163654.17080-1-marcos@mpdesouza.com/)
> has patches split but it's not following the suggestions.
