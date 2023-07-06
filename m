Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9C74A466
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 21:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGFTcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFTb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:31:59 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60219B7
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 12:31:55 -0700 (PDT)
Date:   Thu, 6 Jul 2023 15:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688671913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGCCHwwA0cqXeEKD4KLulUCgMqGwkQRRxiEeo6W/m4I=;
        b=uLSIk5UJnWZnWg1Sh4p4US2Xr0/a9bs9JhQ9SV/5kZaoyMtIMdu/mExFa/MPGbqDQack9r
        2/zSEQha87UaghKVQv2E9fW4Mzs9erE734Q2T8cjrYVRcWjpQmj6/HUq8rGWDH8EQ5dMzc
        ULREbxOP4mTmET86ulXYaWEv7X9uxwo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Josef Bacik <josef@toxicpanda.com>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706193146.f2ktfnsxhrfokasp@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <d2a06111-c8c6-cdb6-c8ac-ae7148742786@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a06111-c8c6-cdb6-c8ac-ae7148742786@sandeen.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:17:29PM -0500, Eric Sandeen wrote:
> On 7/6/23 12:38 PM, Kent Overstreet wrote:
> > Right now what I'm hearing, in particular from Redhat, is that they want
> > it upstream in order to commit more resources. Which, I know, is not
> > what kernel people want to hear, but it's the chicken-and-the-egg
> > situation I'm in.
> 
> I need to temper that a little. Folks in and around filesystems and storage
> at Red Hat find bcachefs to be quite compelling and interesting, and we've
> spent some resources in the past several months to investigate, test,
> benchmark, and even do some bugfixing.
> 
> Upstream acceptance is going to be a necessary condition for almost any
> distro to consider shipping or investing significantly in bcachefs. But it's
> not a given that once it's upstream we'll immediately commit more resources
> - I just wanted to clarify that.

Yeah, I should probably have worder that a bit better. But in the
conversations I've had with people at other companies it does sound like
the interest is there, it's just that filesystem/storage teams are not
so big these days as to support investing in something that is not yet
mainlined.

> It is a tough chicken and egg problem to be sure. That said, I think you're
> right Kent - landing it upstream will quite likely encourage more interest,
> users, and hopefully developers.

Gotta start somewhere :)
 
> Maybe it'd be reasonable to mark bcachefs as EXPERIMENTAL or similar in
> Kconfig, documentation, and printks - it'd give us options in case it
> doesn't attract developers and Kent does get hit by a bus or decide to go
> start a goat farm instead (i.e. in the worst case, it could be yanked,
> having set expectations.)

Yeah, it does need to be marked EXPERIMENTAL initially, regardless -
staged rollout please, not everyone all at once :)
