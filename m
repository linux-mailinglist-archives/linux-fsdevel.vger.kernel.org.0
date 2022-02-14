Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38DA4B5AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBNUBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:01:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBNUBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02214AC8A;
        Mon, 14 Feb 2022 12:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74396115F;
        Mon, 14 Feb 2022 19:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45256C340E9;
        Mon, 14 Feb 2022 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644867881;
        bh=jxOYiEgPWektpf5sVKihUYWrVFKV0HAUXvsI0SeCjrY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dRO6ISvNTvfNGuc219bHukN3m5ziudzHyjjyHNwbAp4XOotmfmGfAXli6ng7PYyXw
         sWFG+c35AJQTFFKLSn16Q72apFPWfzeJXWsQyTXV7GyHj8qifh+iwVgoIe7y+4bcaZ
         C4bUJcxCZOTRc7HOgbfLuXmMJPQ8OIhG/Q4nSmrwdYCMNgOtpMccwOrgM7lKNHD2iv
         6gZJt+JBJF5KoXLO6RjkRA63GJYzgtGC8cNjK8jvEhqNrd+CPsDtswo6JHWrXVfYSs
         TynDNMULeQidgTK9AYSBvvyLAz4SEcRhTUPb159geRvTv7KbG53RWrWL7vnSo4qH9K
         IlIVMKhhf+ZMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 024035C0388; Mon, 14 Feb 2022 11:44:40 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:44:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Mason <clm@fb.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220214194440.GZ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
 <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 07:26:49PM +0000, Chris Mason wrote:
> 
> 
> > On Feb 14, 2022, at 2:05 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > Experimental.  Not for inclusion.  Yet, anyway.
> > 
> > Freeing large numbers of namespaces in quick succession can result in
> > a bottleneck on the synchronize_rcu() invoked from kern_unmount().
> > This patch applies the synchronize_rcu_expedited() hammer to allow
> > further testing and fault isolation.
> > 
> > Hey, at least there was no need to change the comment!  ;-)
> > 
> 
> I don’t think this will be fast enough.  I think the problem is that commit e1eb26fa62d04ec0955432be1aa8722a97cb52e7 is putting all of the ipc namespace frees onto a list, and every free includes one call to synchronize_rcu()
> 
> The end result is that we can create new namespaces much much faster than we can free them, and eventually we run out.  I found this while debugging clone() returning ENOSPC because create_ipc_ns() was returning ENOSPC.

Moving from synchronize_rcu() to synchronize_rcu_expedited() does buy
you at least an order of magnitude.  But yes, it should be possible to
get rid of all but one call per batch, which would be better.  Maybe
a bit more complicated, but probably not that much.

Let me see what I can come up with.

If this is an emergency, I still suggest trying the patch as a short-term
workaround.

							Thanx, Paul
