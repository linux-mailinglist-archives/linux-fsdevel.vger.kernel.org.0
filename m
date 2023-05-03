Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621306F5F94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECUCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECUCa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 16:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934583D5;
        Wed,  3 May 2023 13:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7BB362FD7;
        Wed,  3 May 2023 20:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77841C433D2;
        Wed,  3 May 2023 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683144148;
        bh=/lNAoQxWtfPR7luO8Cwj40gwEJXj4ZYIz5wP+3/mfxU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IAeAeOrFqZWwAD0qKh4PYrjpYioHsgNV59Ed6sFLFZQroD1YvFgsW3IWfQWHs0ieo
         PZGHTOQBrLQYPDT87YwDSNDR6SNtI+Pvg31HAHlw/wFgOSwgmLsQM6I/sz0TdC550n
         l7s7rnZ9CqcS9+zqOvj7uu4inUuCPq75sPPHyEz2z0lwH6zu89YZQbeEcQRNLPMQE7
         C1P4jjLFtMNkumyYi5+0YW1Ot9qKUhid+UsC4OwO1r/N8+dO19nAHaBvakPolYYyQG
         KiEJulqpruObthESNSPuYDBuXZjonYSiLUg0p0vDU8SrAfEcP8dBuSUrl+Utsou0n4
         EKDWHl5BDeTFQ==
Message-ID: <e44bb405be06fe97dbb0af3e47b4e8dd1c065f29.camel@kernel.org>
Subject: Re: LSF/MM/BPF BoF: pains / goods with automation with kdevops
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     amir73il@gmail.com, a.manzanares@samsung.com,
        chandan.babu@oracle.com, josef@toxicpanda.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Wed, 03 May 2023 16:02:26 -0400
In-Reply-To: <Y9YFgDXnB9dTZIXA@bombadil.infradead.org>
References: <Y9YFgDXnB9dTZIXA@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-01-28 at 21:34 -0800, Luis Chamberlain wrote:
> More suitable towards a BoF as I don't *think* a larger audience would be
> interested. At the last LSF during our talks about automation it was sugg=
ested
> we could share a repo and go to town as we're all adults. That's been don=
e:
>=20
> https://github.com/linux-kdevops/kdevops
>=20
> At ALPSS folks suggested maybe non-github, best we can do for now is
> gitlab:
>=20
> https://gitlab.com/linux-kdevops/kdevops
>=20
> There's been quite a bit of development from folks on the To list. But
> there's also bugs even on the upstream kernel now that can sometimes erk =
us.
> One example is 9p is now used to be able to compile Linux on the host
> instead of the guests. Well if you edit a file after boot on the host
> for Linux, the guest won't see the update, so I guess 9p doesn't update
> the guest's copy yet. Guests just have to reboot now. So we have to fix t=
hat
> and I guess add 9p to fstests. Or now that we have NFS support thanks to
> Jeff, maybe use that as an option? What's the overhead for automation Vs =
9p?
>=20
> We dicussed sharing more archive of results for fstests/blktests. Done.
> What are the other developer's pain points? What would folks like? If
> folks want demos for complex setups let me know and we can just do that
> through zoom and record them / publish online to help as documentation
> (please reply to this thread in private to me and I can set up a
> session). Let's use the time at LSF more for figuring out what is needed
> for the next year.
>=20
>   Luis

Luis mentioned that no one had replied to this expressing interest. I'm
definitely interested in discussing kdevops if the schedule's not
already full.
--=20
Jeff Layton <jlayton@kernel.org>
