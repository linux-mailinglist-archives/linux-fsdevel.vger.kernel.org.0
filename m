Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788884EBECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiC3Kep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 06:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiC3Keo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:34:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A67260C59
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 03:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02221B81ACC
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D6C340EC;
        Wed, 30 Mar 2022 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648636376;
        bh=TYbl10pG2Kx50IOxMJqQtGvQhSgl1xLPOiZblnf07X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgzUNr643ocdkTuM1+5qrlExUlER4Vhs0f84SOyYzGa2vMtydvtOCcuIOf7sfL0QM
         TuaNw0yb2pXp2MW0IXLDhVsgQqa0GsYfW9RiN6CYKtvwaLzaYBOQamKwpHyW8cjduD
         j9pC8ZlJvqX2gHstZ3coXaRHTVeNZF49jgb9ABaYnMqAPZO1ocAK0oNL1+BVYdZp1E
         w8gtUl13v6u+Al6cSG7Fbcnq9lxZ/dpLBKFA0xzBDsZIEjXJqQ5+meYf6fdtzqAMQd
         lJdnBnK9j4mA+isXmfhZBYLLxefyvHq4wXctZ8ezyybXFnPw3fDftJJdEs0+8tJmlK
         /mxZbriNdXmOg==
Date:   Wed, 30 Mar 2022 12:32:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs/dcache: use lockdep assertion instead of warn try_lock
Message-ID: <20220330103247.dwyke4gcjpcmtsxx@wittgenstein>
References: <20220325190001.1832-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325190001.1832-1-dossche.niels@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:00:02PM +0100, Niels Dossche wrote:
> Currently, there is a fallback with a WARN that uses down_read_trylock
> as a safety measure for when there is no lock taken. The current
> callsites expect a write lock to be taken. Moreover, the s_root field
> is written to, which is not allowed under a read lock.
> This code safety fallback should not be executed unless there is an
> issue somewhere else.
> Using a lockdep assertion better communicates the intent of the code,
> and gets rid of the currently slightly wrong fallback solution.
> 
> Note:
> I am currently working on a static analyser to detect missing locks
> using type-based static analysis as my master's thesis
> in order to obtain my master's degree.
> If you would like to have more details, please let me know.
> This was a reported case. I manually verified the report by looking
> at the code, so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created
> this patch. I have both compile-tested this patch and runtime-tested
> this patch on x86_64. The effect on a running system could be a
> potential race condition in exceptional cases.
> This issue was found on Linux v5.17.
> 
> Fixes: c636ebdb186bf ("VFS: Destroy the dentries contributed by a superblock on unmounting")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
