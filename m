Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC577A437
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 01:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHLXam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 19:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHLXal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 19:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A46A1709;
        Sat, 12 Aug 2023 16:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE9BA60A5C;
        Sat, 12 Aug 2023 23:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61EDC433C7;
        Sat, 12 Aug 2023 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691883043;
        bh=KrCqW/jCgqRPD8zIczIcU75TX8B36Xq+hhaJur4o5C4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uF/COK8+QcibQLpuq2xUrbcuE5zoSo7eJdVLwLE6QxD2Sfe1u/Ex085kloXx9KpHt
         w8mghsQPy9xnKFHzBIwKrqdUWst2mPe0tJliQANneOrujGTBsJqdVvObWXXHjOe2NJ
         o3iJ2lwksVBZowl6Hbia0M3gLwiGQ6SHFxzqP4h+CRo/MBn9KS5YKyO4X2wipNqj07
         MGW27nk6JIFPqIdBrcns4LQCEj6bI82n9NlXI26MZHOE+X7xqaQQtEVD9mBErG0tKR
         t8CgJqnxI49vRQzoJhCpTGJqW9w7hWyFgLwfRgfzBrUBys7myIY7pJI0IpSOZrAxgL
         spD0nN8kjJv9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C3DECCE0AB1; Sat, 12 Aug 2023 16:30:41 -0700 (PDT)
Date:   Sat, 12 Aug 2023 16:30:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <24ec9c40-7310-4544-8c3f-81f2a756aead@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
 <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
 <20230807114455.b4bab41d771556d086e8bdf4@kernel.org>
 <7c81c63b-7097-4d28-864e-f364eaafc5a0@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c81c63b-7097-4d28-864e-f364eaafc5a0@paulmck-laptop>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 06, 2023 at 09:39:28PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 07, 2023 at 11:44:55AM +0900, Masami Hiramatsu wrote:
> > On Fri, 4 Aug 2023 10:36:17 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> > > > On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > > > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > > > show all kernel boot parameters, both those supplied by the boot loader
> > > > > and those embedded in the kernel image.  This works well for those who
> > > > > just want to see all of the kernel boot parameters, but is not helpful to
> > > > > those who need to see only those parameters supplied by the boot loader.
> > > > > This is especially important when these parameters are presented to the
> > > > > boot loader by automation that might gather them from diverse sources.
> > > > > 
> > > > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > > > boot parameters supplied by the boot loader.
> > > > 
> > > > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > > > +{
> > > > > +	seq_puts(m, boot_command_line);
> > > > > +	seq_putc(m, '\n');
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int __init proc_cmdline_init(void)
> > > > >  {
> > > > >  	struct proc_dir_entry *pde;
> > > > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > > > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > > > >  	pde_make_permanent(pde);
> > > > >  	pde->size = saved_command_line_len + 1;
> > > > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > > > +		pde_make_permanent(pde);
> > > > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > > > +	}
> > > > 
> > > > Please add it as separate fs/proc/cmdline_load.c file so that name of
> > > > the file matches name of the /proc file.
> > > 
> > > Thank you, will do!
> > > 
> > > > The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
> > > > somewhere should improve things.
> > > 
> > > If we can all quickly come to agreement on a name, I can of course easily
> > > change it.
> > > 
> > > /proc/cmdline_bootloader?  Better than /proc/cmdline_from_bootloader,
> > > I suppose.  /proc/cmdline_bootldr?  /proc/bootloader by analogy with
> > > /proc/bootconfig?  Something else?
> > 
> > What about "/proc/raw_cmdline" ?
> 
> That would work of me!
> 
> Any objections to /proc/raw_cmdline?
> 
> Going once...

Going twice...

If I don't hear otherwise, /proc/raw_cmdline is is on Monday August 14 PDT.

 							Thanx, Paul
