Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD51770743
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjHDRgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjHDRgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE484C06;
        Fri,  4 Aug 2023 10:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F486620D6;
        Fri,  4 Aug 2023 17:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CBFC433C7;
        Fri,  4 Aug 2023 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691170578;
        bh=A7U/6JtnabxCvs2EpKPnYwrCm3XqYfEuZUCCQ5NXh9E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KSmW57I6UjMcgaghRqRhCarWDOYt9dXCsftU5VK/k14bBsoNMCtiZfhtasFo3C5Os
         dAb4q+Rq4IDG0wsdN+O0oa1syHb0JprXklO4SOD4mmf3fyCAXZ9D460ceGgQMN/DpZ
         EYPLh4ZQKVPfUjkyi4AD96i/VHXHmbcuomZwMM3j4IOqpeipNWPzrS0rxvJWIGxL4m
         rGja3FtGQcSNdrmaU8ys/cK0OpxuHQEb3XiBkxsrMQ77vLPGX7DBsRF4vGXVW8XyEb
         3ipmmRMjzE/OjoCohJ28MDIlyBgrTzhnO9KPNmRv9mHJA/fQFkMMImS9EwSZUTaW7V
         qFCGFmwQsARYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE685CE0591; Fri,  4 Aug 2023 10:36:17 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:36:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > show all kernel boot parameters, both those supplied by the boot loader
> > and those embedded in the kernel image.  This works well for those who
> > just want to see all of the kernel boot parameters, but is not helpful to
> > those who need to see only those parameters supplied by the boot loader.
> > This is especially important when these parameters are presented to the
> > boot loader by automation that might gather them from diverse sources.
> > 
> > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > boot parameters supplied by the boot loader.
> 
> > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > +{
> > +	seq_puts(m, boot_command_line);
> > +	seq_putc(m, '\n');
> > +	return 0;
> > +}
> > +
> >  static int __init proc_cmdline_init(void)
> >  {
> >  	struct proc_dir_entry *pde;
> > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> >  	pde_make_permanent(pde);
> >  	pde->size = saved_command_line_len + 1;
> > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > +		pde_make_permanent(pde);
> > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > +	}
> 
> Please add it as separate fs/proc/cmdline_load.c file so that name of
> the file matches name of the /proc file.

Thank you, will do!

> The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
> somewhere should improve things.

If we can all quickly come to agreement on a name, I can of course easily
change it.

/proc/cmdline_bootloader?  Better than /proc/cmdline_from_bootloader,
I suppose.  /proc/cmdline_bootldr?  /proc/bootloader by analogy with
/proc/bootconfig?  Something else?

							Thanx, Paul
