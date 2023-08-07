Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA677190B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 06:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHGEjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 00:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHGEjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104010F3;
        Sun,  6 Aug 2023 21:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5230D613EF;
        Mon,  7 Aug 2023 04:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF39C433C7;
        Mon,  7 Aug 2023 04:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691383168;
        bh=kaWg1WYQfTBpsM157yv/RZZY4HnHHaN48l3NfDkH/QI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cYqoEUMmLadnviWvN5QB2CgDi0u+4yv+E2+/ftWgxAbDRaBMWqtwOSDsnGfrB2tRG
         ZkccaWo8U2pwSEJMfOVmCEPQxyjx6qFwiEjGsHdEGnDcWRFVuJf7Xs2Xg+W0YqIUlt
         mo6k1KhXJIT5aS0RGzDzo2D/srZgYIDAPAEZV9pQqShhV8T9wKRcM2M8XU/xAR87vd
         xPO1V/9xyrd91oBUokBC+rntuC/9Oc3Dm0VWDg5Xp4vX1IZH3Lc9UyS9hKDdXbVgtB
         u2zK/ud0s8I9LFG2sq7DBbxXPeGpFj9YV/XG8+Dn1qRvmrPnqB32k4crfoZi2hB6vn
         O+0DuQxCOSpJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78DB7CE075B; Sun,  6 Aug 2023 21:39:28 -0700 (PDT)
Date:   Sun, 6 Aug 2023 21:39:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <7c81c63b-7097-4d28-864e-f364eaafc5a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
 <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
 <20230807114455.b4bab41d771556d086e8bdf4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807114455.b4bab41d771556d086e8bdf4@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:44:55AM +0900, Masami Hiramatsu wrote:
> On Fri, 4 Aug 2023 10:36:17 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> > > On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > > show all kernel boot parameters, both those supplied by the boot loader
> > > > and those embedded in the kernel image.  This works well for those who
> > > > just want to see all of the kernel boot parameters, but is not helpful to
> > > > those who need to see only those parameters supplied by the boot loader.
> > > > This is especially important when these parameters are presented to the
> > > > boot loader by automation that might gather them from diverse sources.
> > > > 
> > > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > > boot parameters supplied by the boot loader.
> > > 
> > > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > > +{
> > > > +	seq_puts(m, boot_command_line);
> > > > +	seq_putc(m, '\n');
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int __init proc_cmdline_init(void)
> > > >  {
> > > >  	struct proc_dir_entry *pde;
> > > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > > >  	pde_make_permanent(pde);
> > > >  	pde->size = saved_command_line_len + 1;
> > > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > > +		pde_make_permanent(pde);
> > > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > > +	}
> > > 
> > > Please add it as separate fs/proc/cmdline_load.c file so that name of
> > > the file matches name of the /proc file.
> > 
> > Thank you, will do!
> > 
> > > The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
> > > somewhere should improve things.
> > 
> > If we can all quickly come to agreement on a name, I can of course easily
> > change it.
> > 
> > /proc/cmdline_bootloader?  Better than /proc/cmdline_from_bootloader,
> > I suppose.  /proc/cmdline_bootldr?  /proc/bootloader by analogy with
> > /proc/bootconfig?  Something else?
> 
> What about "/proc/raw_cmdline" ?

That would work of me!

Any objections to /proc/raw_cmdline?

Going once...

							Thanx, Paul
