Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0C724BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjFFS42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjFFS41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:56:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1759101;
        Tue,  6 Jun 2023 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TNU8U3MEcv3N7wCZBZ3gI1l1C49AkMXmwa8o/pNFlxI=; b=HGl+ZjY2h2aXnhelLMYheyAbT1
        40RXU03NIs3uiNpuX1SbfJoV8igDI6PNv5hjxfiE2tz7yCOeergGMeqt26CH7C8RZWcRA9a2L7/8p
        7L+kGLQWe6Rek36zP7J3QLprzOErdPVJ42xDvh+KdyMpcyHESfROKaCMc3ew/1vDiKrOwVEAnKrxU
        PFztAhNpD2hc7otlj49Ih5dZ4hwMMl7jqH3O/LKOJlIyjoxJvwqJWDxS1mYWgh9dKEf1lHuyPJtOg
        gxqm+rfun+OhJtOf1JR2vi9tooluils1H9u7TMxXI30CdcuF+IklFYf8Rdx73OZY+phdMR12bSHGw
        HkX+J5kw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6br0-002qXU-2a;
        Tue, 06 Jun 2023 18:56:26 +0000
Date:   Tue, 6 Jun 2023 11:56:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/8] Remove child from struct ctl_table
Message-ID: <ZH+BWiQOSQGNDQCv@bombadil.infradead.org>
References: <CGME20230602110640eucas1p11b79cbd7f116be6828a670f9873ed24e@eucas1p1.samsung.com>
 <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 01:06:30PM +0200, Joel Granados wrote:
> Resending as the first set got mangled with smtp error.
> 
> This is part of the effort to remove the empty element of the ctl_table
> structures (used to calculate size) and replace it with an ARRAY_SIZE call. By
> replacing the child element in struct ctl_table with a flags element we make
> sure that there are no forward recursions on child nodes and therefore set
> ourselves up for just using an ARRAY_SIZE. We also added some self tests to
> make sure that we do not break anything.
> 
> Patchset is separated in 4: parport fixes, selftests fixes, selftests additions and
> replacement of child element. Tested everything with sysctl self tests and everything
> seems "ok".
> 
> 1. parport fixes: @mcgrof: this is related to my previous series and it plugs a
>    sysct table leak in the parport driver. Please tell me if you want me to repost
>    the parport series with this one stiched in.
> 
> 2. Selftests fixes: Remove the prefixed zeros when passing a awk field to the
>    awk print command because it was causing $0009 to be interpreted as $0.
>    Replaced continue with return in sysctl.sh(test_case) so the test actually
>    gets skipped. The skip decision is now in sysctl.sh(skip_test).
> 
> 3. Selftest additions: New test to confirm that unregister actually removes
>    targets. New test to confirm that permanently empty targets are indeed
>    created and that no other targets can be created "on top".
> 
> 4. Replaced the child pointer in struct ctl_table with a u8 flag. The flag
>    is used to differentiate between permanently empty targets and non-empty ones.
> 
> Comments/feedback greatly appreciated

This all looks great, thanks so much for doing all this work! I pushed
to sysctl-next.

  Luis
