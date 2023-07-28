Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40A76773E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjG1UwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjG1UwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E730DA;
        Fri, 28 Jul 2023 13:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F9A621F7;
        Fri, 28 Jul 2023 20:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775CC433C7;
        Fri, 28 Jul 2023 20:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690577526;
        bh=aZhhtX7mq6u+YsbVL7eMx92xigfULW3GL12bxfMNvUg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hTqdRgLJdvl10i70ugNWqPOatYwahgttyiiZuvouP1oIty5LsZ1HbqRs8aKWmQZYd
         YtufZLBiy/4qyxnQebzH3s/XeUL6v5iSLRH5f2W9cLCZRkgtvHfbGD6jeCSWUw0mZn
         82TR4vimbLVpcLuqqIwy2LdG3pK3KVCl7Xl/Cb58W2zLVLVvbGhRfmiwtlYhJY5JM4
         SnVqi8dCMyv+zBc3HUFZ+uw59DNyRmnsxnjQq1WV2TZU3WIQxnfGtSxmSaYb039bIA
         JogaSK1tXvHxsvfCiVG5i0p/hRwSMOod4WdLD43Dw8FF17ojysOeKrsJPrtFmqdMNT
         m26uI1jPoFPrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E1DECCE0A13; Fri, 28 Jul 2023 13:52:05 -0700 (PDT)
Date:   Fri, 28 Jul 2023 13:52:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        mhiramat@kernel.org, arnd@kernel.org, ndesaulniers@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <91ea62ce-f452-40cd-82f3-a26d2ce866ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <20230728140635.2ea3e82d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728140635.2ea3e82d@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:06:35PM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> Just a couple of nits:
> 
> On Thu, 27 Jul 2023 20:37:00 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > [ sfr: Apply kernel test robot feedback. ]
> 
> This was a fix for my own build testing (I am not a bot (yet) :-)).

Ah!

This says "Stephen Rothwell made a change in response to kernel test robot
feedback".  I saw your change and saw the kernel test robot complaint,
and gave the robot the benefit of the doubt.

But if you saw this build bug yourself and object to crediting kernel
test robot for also spotting it, please let me know and I will remove
this line.

> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 266c3e1640d4..29e75bbe7984 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -112,6 +112,7 @@
> >  #define __REFCONST       .section       ".ref.rodata", "a"
> >  
> >  #ifndef __ASSEMBLY__
> > +
> 
> Please remove this added blank line.

Good eyes, done!

I should also split out the modifications to include/linux/init.h,
which are now whitespace-only, shouldn't I?

							Thanx, Paul
