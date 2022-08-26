Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D165A22B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbiHZIOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiHZIOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A02D4BD5;
        Fri, 26 Aug 2022 01:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F38B0B80ABF;
        Fri, 26 Aug 2022 08:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587FEC433D6;
        Fri, 26 Aug 2022 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661501677;
        bh=9zTp80ppsLB9vgExWhFwXDV4Br64O33dqXfWGDZTXWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxPmz5WG4tVyB8VUigAC7FCJvn29IKwNw4oP9RAIN3MLTuqo8lsZRU9oguNrCTWUm
         /yaEOYleBijlkGkrkFvd1/fwfhpQOrtez/QJZk08JlDgyhcFldGfsFAx2JjFjffExC
         7lRyLPuRCVGxWFuIPmAxqAnA6OuKvbgvV//oy2hxvAgwBmqEl5O10RzK9GqxLvc9hR
         GVHY9LxTKsinFyuwwem4qh09gIbpQTgpZr0KEhk/Y0PBfeFGrK7eMVsXdtv/dPJndy
         XX/usrejBux8dWfq59mIZECbQTKyx8/l7FEUsIlYGu+Lf74uR9CQTan4+Dx4Hv9i/0
         O3bJqrINOPcGQ==
Date:   Fri, 26 Aug 2022 10:14:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCHES] struct path constification
Message-ID: <20220826081432.dwtxftki3rvo7kva@wittgenstein>
References: <YwEjnoTgi7K6iijN@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwEjnoTgi7K6iijN@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 07:10:38PM +0100, Al Viro wrote:
> 	This is mostly whack-a-mole stuff - a bunch of places
> are passing struct path pointers around, without bothering
> to mark them const, even though they are not going to try
> and modify the contents of struct path.
> 
> 	It's a bad practice, since there are invariants along
> the lines of "file->f_path stays unchanged open-to-release"
> and verifying those can get very unpleasant when you are
> forced to take detours down the long call chains that could've
> been avoided.
> 
> 	Patches in that pile are independent from each other
> and if anyone wants to grab some of them into subsystem's
> tree - just say so; I'll be happy to exclude those from the
> vfs.git branch if they go into another tree.
> 
> 	Currently they are in vfs.git#work.path; individual
> patches in followups.
> 

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
