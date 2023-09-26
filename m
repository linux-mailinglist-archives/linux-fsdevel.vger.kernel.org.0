Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559697AECBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjIZM0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 08:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIZM0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA410E;
        Tue, 26 Sep 2023 05:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041DBC433C7;
        Tue, 26 Sep 2023 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695731176;
        bh=TffweluRYbRpL5vhqrw+fjUyUMqGnjaG+j0AsmmrgD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDTLRJ2okVDacA/KYHaAcsFKP9M5VMmGXe2Zl38P3pQ9UXTLub13itqelvjI9TtWU
         DY1GhDtMhH5fK+7StAmBE5c2izHl60+i8GygNK5963Ke09xOmQ1rsj1pmlqihouCou
         SpQ3Am6y+r/nGybo236JwLCiNyTnsC7gZu0Nke+ZWscunvB+EJkU1S15Sp14LCnqK7
         boumuDst0Pv3D9xj7e6NsSxoaN9AatiZ69HHZSWxb43XWXqSDlamISEUP/h4UO17Ob
         R+AK/fRUHGs06i1SwQK1bjZWRp8GSuZ6cJ3DQ1ECBVfHfOxKMuDd8XMXyWPWqf2eRk
         j5bgGOOy5aJow==
Date:   Tue, 26 Sep 2023 14:26:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20230926-planlos-decken-09929871d43a@brauner>
References: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
 <20230926063609.2451260-1-max.kellermann@ionos.com>
 <20230926-achtlos-ungeschehen-ee0e5f2c7666@brauner>
 <CAKPOu+9VYJeZbc6xLJzJY=mtmDm+Of9DEKk0kQwnn0nvVzN_4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9VYJeZbc6xLJzJY=mtmDm+Of9DEKk0kQwnn0nvVzN_4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 12:41:42PM +0200, Max Kellermann wrote:
> On Tue, Sep 26, 2023 at 12:21 PM Christian Brauner <brauner@kernel.org> wrote:
> > Hm, so the thing that is worrysome about this change is that this may
> > cause regressions afaict as this is a pretty significant change from
> > current behavior.
> 
> Would you prefer a new flag for explicitly selecting "wait until at
> least one byte was transferred, but don't wait further"? Because many

I had thought about it but afaict it'd be rather annoying as one can get
into that code from copy_file_range() as well so we'd need a new flag
for that system call as well afaict.

> applications need this behavior, and some (like nginx) have already
> worked around the problem by limiting the maximum transaction size,
> which I consider a bad workaround, because it leads to unnecessary
> system calls and still doesn't really solve the latency problem.
> 
> On the other hand, what exactly would the absence of this flag mean...
> the old behavior, without my patch, can lead to partial transfers, and
> the absence of the flag doesn't mean it can't happen; my patch tackles
> just one corner case, but one that is important for me.
> 
> We have been running this patch in production for nearly a year (and
> will continue to do so until upstream kernels have a proper solution)
> and never observed a problem, and I consider it safe, but I
> acknowledge the risk that this may reveal obscure application bugs if
> applied globally to all Linux kernels, so I understand your worries.

I think hanging for an insane amount of time is indeed a problem and
tweaking the code in this way might actually be useful but we'd need to
let this soak for quite a while to see whether this causes any issues.

@Jens, what do you think? Is this worth it?
