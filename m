Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC677186C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 04:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHGCpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 22:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjHGCpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D4E6A;
        Sun,  6 Aug 2023 19:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 609DE61305;
        Mon,  7 Aug 2023 02:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BECFC433C8;
        Mon,  7 Aug 2023 02:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691376300;
        bh=USJIDDP4kE+cHkQpFsYQKXS4O9YsCyYriaif+zRMHog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GsGnow7ie8LxtIeC6X2zkGz1iQ19g51CjlUZ/q4wN2GfgP9HTXdWWd9tY+69L1JKh
         TAGeYVROKtU0OWlnUEZ8IYDv6w6fIEHL4Jj63cl4FF2QgWNflWt98pSSdLDAS8svDC
         dGmdgRh4iL3XoGrBSrkFZZJz6+aBRqgLNsAO2JiVM5CxDJxljcSPzEvFiNsbmdtNOJ
         rFq1xFyJNtopVS2TMwb36r/4/dKrcT3Nus4unJw5wO44n6oHykN3ZVwHKMiN4uBgHO
         JuKGJH0FeN2H+1YKq1GmGcLmSAODdk3zcKDHlb3ZMF/xsEqYjcDMuRioEE9D3bmz1k
         PO7Ytcz2Ws0GQ==
Date:   Mon, 7 Aug 2023 11:44:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        mhiramat@kernel.org, arnd@kernel.org, ndesaulniers@google.com,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-Id: <20230807114455.b4bab41d771556d086e8bdf4@kernel.org>
In-Reply-To: <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
        <20230728033701.817094-1-paulmck@kernel.org>
        <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
        <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Aug 2023 10:36:17 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> > On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > show all kernel boot parameters, both those supplied by the boot loader
> > > and those embedded in the kernel image.  This works well for those who
> > > just want to see all of the kernel boot parameters, but is not helpful to
> > > those who need to see only those parameters supplied by the boot loader.
> > > This is especially important when these parameters are presented to the
> > > boot loader by automation that might gather them from diverse sources.
> > > 
> > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > boot parameters supplied by the boot loader.
> > 
> > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > +{
> > > +	seq_puts(m, boot_command_line);
> > > +	seq_putc(m, '\n');
> > > +	return 0;
> > > +}
> > > +
> > >  static int __init proc_cmdline_init(void)
> > >  {
> > >  	struct proc_dir_entry *pde;
> > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > >  	pde_make_permanent(pde);
> > >  	pde->size = saved_command_line_len + 1;
> > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > +		pde_make_permanent(pde);
> > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > +	}
> > 
> > Please add it as separate fs/proc/cmdline_load.c file so that name of
> > the file matches name of the /proc file.
> 
> Thank you, will do!
> 
> > The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
> > somewhere should improve things.
> 
> If we can all quickly come to agreement on a name, I can of course easily
> change it.
> 
> /proc/cmdline_bootloader?  Better than /proc/cmdline_from_bootloader,
> I suppose.  /proc/cmdline_bootldr?  /proc/bootloader by analogy with
> /proc/bootconfig?  Something else?

What about "/proc/raw_cmdline" ?

Thank you,


> 
> 							Thanx, Paul


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
