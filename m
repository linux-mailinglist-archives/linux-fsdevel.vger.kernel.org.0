Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE104DE68E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiCSGlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiCSGli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:41:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D612E8CEB;
        Fri, 18 Mar 2022 23:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B47DDB80189;
        Sat, 19 Mar 2022 06:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1FBC340EC;
        Sat, 19 Mar 2022 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647672013;
        bh=+tQGt//lSRZPhJkXDicQ1ZieebIlhDK1GC3VS9QAKnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjqGm2aWvDgEjFjvc8Q+X7VcPYxEazBs1Rpem1s7sI/erbbBBO9EF+tzljIdvNi8Y
         VXlo+iYKJ4plAdAQer0E7khHcBkJCFjsrJ45v43z30ehOA6jJ73VLOTVws72QvpYrQ
         Dnt00239Xs+B+0y6i8+8SfvuKPw2h5IZUv1UhCp4=
Date:   Sat, 19 Mar 2022 07:40:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
Message-ID: <YjV6w6UITwidXzNw@kroah.com>
References: <20220318171405.2728855-1-cmllamas@google.com>
 <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:24:55PM +0100, Miklos Szeredi wrote:
> On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
> >
> > Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> > <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> > all the definitions in this header to use the correct type. Previous
> > discussion of this topic can be found here:
> >
> >   https://lkml.org/lkml/2019/6/5/18
> 
> This is effectively a revert of these two commits:
> 
> 4c82456eeb4d ("fuse: fix type definitions in uapi header")

That's a really odd commit, and should not have been recommended.  uapi
headers have to use __u32 and friends, otherwise things can be wrong.

> 7e98d53086d1 ("Synchronize fuse header with one used in library")
> 
> And so we've gone full circle and back to having to modify the header
> to be usable in the cross platform library...
> 
> And also made lots of churn for what reason exactly?

I think the original change above was wrong.

thanks,

greg k-h
