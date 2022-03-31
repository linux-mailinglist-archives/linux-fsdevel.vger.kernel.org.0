Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C984ED969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiCaMM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiCaMMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494A1E6EB4;
        Thu, 31 Mar 2022 05:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B0A617A0;
        Thu, 31 Mar 2022 12:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C5C340F3;
        Thu, 31 Mar 2022 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648728634;
        bh=63vYKZFhfF6Rn0H9HhtdO0e/OL7FnACVb7bdzaeN0gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgutmsuPVlxE3cohcoQNq8tqmykYhio2ghJZCnOgew75Pka24NJoqYEK3mzU61QAU
         2jucZwf0kcA/jfKhYcZW+y0dpZxEiHiTd1E/7DL9WmDIk9QZbL60F0WckBDY4rzo/D
         UROWU0I+3gXUPU5HChhehVajsyHNZPLChb+lwa2gZkLQQJPGx8EK+L1FA0xnV4Dq0o
         4cQnRDXuv+cfeN4w0H8HogX6LJZEc+n0mS2Saf+r+FUAStSMeG3XVat2VM5wa23xTV
         TrAIPpUi0ehi+jr0zTDvtWyiA3BIarjWhe5pW5g0V20mjduPMyhzuWof+qQWpGJwnh
         LwN/OSz4jYY8g==
Date:   Thu, 31 Mar 2022 14:10:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Message-ID: <20220331121029.r6lcwbejdd243f5r@wittgenstein>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220331115925.5tausqdavg7xmqyv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331115925.5tausqdavg7xmqyv@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 01:59:25PM +0200, Christian Brauner wrote:
> On Thu, Mar 31, 2022 at 05:28:21PM +0800, Yang Xu wrote:
> > Since mknodat can create file, we should also check whether strip S_ISGID.
> > Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
> > depond on this cap and keep other cap(ie CAP_MKNOD) because create character device
> > needs it when using mknod.
> > 
> > Only test mknod with character device in setgid_create function because the another
> > two functions will hit EPERM error.
> 
> Fwiw, it's not allowed to create devices in userns as that would be a
> massive attack vector. But it is possible since 5.<some version> to
> create whiteouts in userns for the sake of overlayfs. So iirc that
> creating a whiteout is just passing 0 as dev_t:
> 
> mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, 0)
> 
> but you'd need to detect whether the kernel allows this and skip the
> test on EPERM when it is a userns test.

Oh, iirc Eryu usually prefers if we don't just extend existing tests but
add new tests so as not to introduce regressions. So instead of adding
this into the existings tests you _could_ add them as new separate 

struct t_idmapped_mounts t_setgid[] = {
};

set of tests and add a new command line switch:

--test-setgid

and create a new

generic/67*

for it. You can use:
d17a88e90956 ("generic: test idmapped mount circular mappings")
as a template for what I mean.
