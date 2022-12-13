Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB3664BD26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiLMTWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiLMTWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5847313D2E;
        Tue, 13 Dec 2022 11:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA9A2616FD;
        Tue, 13 Dec 2022 19:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57587C433D2;
        Tue, 13 Dec 2022 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670959352;
        bh=1bDObDPivrcZwqf+E8G6ugl7DpZ9/9dbg16mxSLub5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuD9kwJtHEKKvSwvnUhjA9hbv8ktYr/IIloGhMYPuC7AoDupSyqh/fho2Upeu4tu/
         UJyKZtwz6SjMxnfnQPQ9IyQYqs5MslWllh28axaD2vw7YbdSHGc0Uy+9/alO1IhvC0
         iByyyE6V8DVk9Kbr+bd8vkIU1fvSkzQ7FD2LmitIclVw7rmRHL4w1auwPsiWwPKHdt
         q63aDbQZE+j0DJ3OqskFJufX23l1bP8V4ChldUd11ftxNCjohcx3zQSDEIZOb8XOIU
         bkw+k1sbmcqeI94mGQ0K8nhBeoeibKxE1WupFedhfaslTsFT0yK4YKCPrJAfwsxRgr
         kpH4sW8yia6Yg==
Date:   Tue, 13 Dec 2022 11:22:31 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <Y5jQ9+L9u2oTc+O/@magnolia>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
 <Y5jNvXbW1cXGRPk2@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jNvXbW1cXGRPk2@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:08:45AM -0800, Eric Biggers wrote:
> On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> > 
> > Also add check that block size == PAGE_SIZE as fs-verity doesn't
> > support different sizes yet.
> 
> That's coming with
> https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u,
> which I'll be resending soon and I hope to apply for 6.3.
> Review and testing of that patchset, along with its associated xfstests update
> (https://lore.kernel.org/fstests/20221211070704.341481-1-ebiggers@kernel.org/T/#u),
> would be greatly appreciated.
> 
> Note, as proposed there will still be a limit of:
> 
> 	merkle_tree_block_size <= fs_block_size <= page_size
> 
> Hopefully you don't need fs_block_size > page_size or

Not right this second, but large folios (and the ability to demand them)
are probably the last major piece that we need to support running
64k-fsblock filesystems on x86.

> merkle_tree_block_size > fs_block_size?

Doubtful.

--D

> 
> - Eric
