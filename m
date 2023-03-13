Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA86B7317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 10:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCMJsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCMJsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88301EC41;
        Mon, 13 Mar 2023 02:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9166119F;
        Mon, 13 Mar 2023 09:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C533EC433D2;
        Mon, 13 Mar 2023 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678700882;
        bh=t+dE/sbcvvMnsmH6OJHAkbnV9Pjw9K0zP9a/gsclhXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPqqmK0d4ov1rMavJkeLO0tZVdZ+kppjp8dE7JaLMu0ANZ6D24HoqaM8ekRqTKzxv
         kXE3cDqgZsMfjp5cSTrFSh+G1jo6H+OpfFgtkst12h/QtiaIywRHzRjdoLTEMxT7IW
         5v9EwYI4mRcibAT6aYi5h0SQNfLGCUwPAB1UM9unmY3CtUHkNRvHK1UjKrTCd8kzw0
         36s1b7/E02np+4A05FQl6BrDU8/4WOex+7Ny8YYg5OZEA9DY47bzkZR8Uk2BNN40Hy
         z77Pr7p9QIYdLSS1GZ84JEK+jjwCbSWSKS4EzPElJShCrhOi7WnoZ/M8EQl8icnJxw
         Wo40qohnqXOQQ==
Date:   Mon, 13 Mar 2023 10:47:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Seth Forshee <sforshee@kernel.org>, shuah@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr
 build error
Message-ID: <20230313094752.3ytftynra5rejn6c@wittgenstein>
References: <20230213183149.231779-1-skhan@linuxfoundation.org>
 <Y+rMtlvx31w7eWCA@do-x1extreme>
 <f536ecc2-1889-6df6-43d3-1a04dc8f1b14@linuxfoundation.org>
 <Y+vzB1OTXr+zTCV7@do-x1extreme>
 <dda181d1-8a5b-adb4-6665-016f50e51487@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dda181d1-8a5b-adb4-6665-016f50e51487@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:37:05PM -0700, Shuah Khan wrote:
> On 2/14/23 13:45, Seth Forshee wrote:
> > On Tue, Feb 14, 2023 at 10:10:00AM -0700, Shuah Khan wrote:
> 
> > > > 
> > > 
> > > The header search looks up system headers followed by installed headers in
> > > the repo (both in-tree and out-of-tree builds). kselftest builds do depend
> > > on headers_install. Did you building after running headers_install?
> > 
> > I wasn't aware they depend on headers_install. Why doesn't
> > Documentation/dev-tools/kselftest.rst mention this in the section that
> > describes how to run tests?
> > 
> 
> It ahs always been a dependency. If you were to compile from the
> main (root) Makefile as below - headers_install get done before
> test compile:
> 
> make kselftest-all TARGETS=mount_setattr
> 
> > It seems what I really need to fix the build is to include
> > linux/mount.h, which works for me with or without headers_install,
> > because I have the struct in /usr/include/linux/mount.h. And I suppose
> > the makefile should use KHDR_INCLUDES. So maybe the changes below should
> > also be included.
> > 
> 
> Yes. Makefile change to use KHDR_INCLUDES is already done. Please
> take a look at linux-kselftest next - this was done as part of a
> tree-wide change.
> 
> If including linux/mount.h is thr correct solution, please send me
> the patch on top of linux-kselftest next and I will pull it in.
> > However I know Christian has said that there are challenges with
> > including the mount headers. He wrote this test, so I'd like to hear his
> > thoughts about adding the include. He's on vacation this week though.

The problem is that the linux/mount.h and sys/mount.h headers may
conflict depending on the libc version used. So if linux/mount.h is
included care needs to be taken that no headers are included that
implicitly pull in sys/mount.h and vica versa. But if that isn't a
problem in this test and it solves the issue we can just include it.
