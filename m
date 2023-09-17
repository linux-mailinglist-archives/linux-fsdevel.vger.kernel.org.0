Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB77A37DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbjIQT0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbjIQT0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:26:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E3119;
        Sun, 17 Sep 2023 12:26:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67ADC433C9;
        Sun, 17 Sep 2023 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694978765;
        bh=bZIPkQ41DTNfms13oHVUudCcifvu53l1vSPYEk6CNI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dw/Qwm4nEGzgoowEvZPGuy9vyHCeJLvQ7jF4t+RHH6VwhUcaqUj8SoZJ5yGYHVH3v
         Q3RQ5T+kHkyBA7vHBciqBmUXeNnZDdsgyxsFtUEbFqfXZRKoizTSItoyeCqoA52XE9
         lL5PwulK261xed0NKEX78vAedm4WVdHOTgOVaVo4=
Date:   Sun, 17 Sep 2023 12:26:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: binfmt_elf_efpic: fix personality for ELF-FDPIC
Message-Id: <20230917122603.5466b1fc6d05ea9e9edee340@linux-foundation.org>
In-Reply-To: <20230907011808.2985083-1-gerg@kernel.org>
References: <20230907011808.2985083-1-gerg@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  7 Sep 2023 11:18:08 +1000 Greg Ungerer <gerg@kernel.org> wrote:

> The elf-fdpic loader hard sets the process personality to either
> PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
> normal ELF binaries (in this case they would be constant displacement
> compiled with -pie for example). The problem with that is that it
> will lose any other bits that may be in the ELF header personality
> (such as the "bug emulation" bits).
> 
> On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
> a normal 32bit binary - as opposed to a legacy 26bit address binary.
> This matters since start_thread() will set the ARM CPSR register as
> required based on this flag. If the elf-fdpic loader loses this bit
> the process will be mis-configured and crash out pretty quickly.
> 
> Modify elf-fdpic loader personality setting so that it preserves the
> upper three bytes by using the SET_PERSONALITY macro to set it. This
> macro in the generic case sets PER_LINUX and preserves the upper bytes.
> Architectures can override this for their specific use case, and ARM
> does exactly this.
> 
> The problem shows up quite easily running under qemu using the ARM
> architecture, but not necessarily on all types of real ARM hardware.
> If the underlying ARM processor does not support the legacy 26-bit
> addressing mode then everything will work as expected.

I'm thinking

Fixes: 1bde925d23547 ("fs/binfmt_elf_fdpic.c: provide NOMMU loader for regular ELF binaries")
Cc: <stable@vger.kernel.org>

?
