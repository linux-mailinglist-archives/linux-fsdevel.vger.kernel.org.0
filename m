Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81B7786FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHKF3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 01:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHKF3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:29:32 -0400
Received: from out-117.mta0.migadu.com (out-117.mta0.migadu.com [IPv6:2001:41d0:1004:224b::75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12754272D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 22:29:30 -0700 (PDT)
Date:   Fri, 11 Aug 2023 01:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691731768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUltBQir8Hs3eTpQn6eiWA0svoGidtlz0BvlqfE0u+U=;
        b=rm0llfruHXietWWFbBcDsM4vllKCXbkV0PpRUeP6xIwmzgutuiyc07k3X97z9sV69/YCJU
        IBkG1UzRMm+nTkE2Qzsi+eOB9hssHb6AoD+0HZQuLhbR5HkfdnSImhN4oMK3hX1rEB6wGH
        DG6UIroDDeib/udnTYNeIWs6zdfsjGk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811052922.h74x6m5xinil6kxa@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
 <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
 <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:20:22PM -0700, Linus Torvalds wrote:
> If it's purely "umount doesnt' succeed because the filesystem is still
> busy with cleanups", then things are much better.

That's exactly it. We have various tests that kill -9 fio and then
umount, and umount spuriously fails. 
