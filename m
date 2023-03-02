Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5C6A7CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCBIaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 03:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBIae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:30:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237323131;
        Thu,  2 Mar 2023 00:30:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5166CB811E3;
        Thu,  2 Mar 2023 08:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B9C433EF;
        Thu,  2 Mar 2023 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677745830;
        bh=y2ym4g8QIp7unPM1QF7SfPIQ5pBCr7DEHheLRtpg77o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kERi2OPvKBCQVsLLjJsSDafxrQMfKN3IRkBaL1Igg0GnPTUL5hlsmvQpmgpPDRk3K
         N9hM8zQklis0n8UOvpTwhI4XnnPYrQo0ECnaQq5m7aoxlKgv59zRcmuK18vwwn9xOi
         RRU3UxM+LL52JakP6dqrmqfTOLLKAmAXP4pPaFXiIZtTFpceTwYXuXyt3xqRU+jPr4
         ey1wswx2Qzu7ed/kfhJGsHsjs1qBVHpV+pYdooJ5OVbii/+gcfZh+racAcSLXi9ih/
         gORaZNnCRrxoSyzV0a4qLGzKWe+dp5yqg6Vw6+S8cSVJ014XiDqIkWPDYA7sNg+o54
         af9ts6AybY2Fg==
Date:   Thu, 2 Mar 2023 09:30:25 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
References: <20230125155557.37816-1-mjguzik@gmail.com>
 <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 04:44:06PM -0800, Linus Torvalds wrote:
> On Wed, Jan 25, 2023 at 7:56 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Turns out for typical consumers the resulting creds would be identical
> > and this can be checked upfront, avoiding the hard work.
> 
> I've applied this v3 of the two patches.
> 
> Normally it would go through Al, but he's clearly been under the
> weather and is drowning in email. Besides, I'm comfortable with this
> particular set of patches anyway as I was involved in the previous
> round of access() overhead avoidance with the whole RCU grace period
> thing.
> 
> So I think we're all better off having Al look at any iov_iter issues.
> 
> Anybody holler if there are issues,

Fwiw, as long as you, Al, and others are fine with it and I'm aware of
it I'm happy to pick up more stuff like this. I've done it before and
have worked in this area so I'm happy to help with some of the load.

Christian
