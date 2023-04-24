Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331CD6EC49D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDXFCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDXFCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:02:09 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D732117;
        Sun, 23 Apr 2023 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CCRNvp3CAY8gnmfukGPp4LMVqx9K4u7H3dpw0TeGf30=; b=WFaGmb2mR24xf2CsX9WmF5qfKS
        8aMqBey2Wo8zoc3Ur5h4M5GGdq7NZ3bjCZF7/LFVzbqESit5ae8gwaqyFVi43bNnyRyCTy2la99q8
        46AaqLSFbvREylsO6FySfBaNqm9vAu0qLSCOZ8b181lTkM53gRqkTU78bpgWPOj9W7VYpQ4/s4s48
        6XFFiHfs4lMgE88FxQ+QJQOaYv7VPA4raYM8DVYslqiFW6rSPSPoKiqE4JR2ocZGdOJYzHdeo2RbS
        HqT1u4otwRDwmHQ1dExPRLhKqvFMCDFZxKehAlWkL9rzayI/S0PaUyHh8BLLdkHVlM3NrfbKn73BA
        rzE5OXLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqoKs-00C0hc-1E;
        Mon, 24 Apr 2023 05:01:58 +0000
Date:   Mon, 24 Apr 2023 06:01:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Ge <gehao@kylinos.cn>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH V2] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <20230424050158.GN3390869@ZenIV>
References: <20230424030005.363457-1-gehao@kylinos.cn>
 <20230424045122.370511-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424045122.370511-1-gehao@kylinos.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:51:22PM +0800, Hao Ge wrote:
> Shifting signed 32-bit value by 31 bits is undefined, so changing
> significant bit to unsigned. The UBSAN warning calltrace like below:

> UBSAN: shift-out-of-bounds in fs/nsfs.c:306:32
> left shift of 1 by 31 places cannot be represented in type 'int'
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc4+ #2
> Call trace:
> <TASK>
> dump_backtrace+0x134/0x1e0
> show_stack+0x2c/0x3c
> dump_stack_lvl+0xb0/0xd4
> dump_stack+0x14/0x1c
> ubsan_epilogue+0xc/0x3c
> __ubsan_handle_shift_out_of_bounds+0xb0/0x14c
> nsfs_init+0x4c/0xb0
> start_kernel+0x38c/0x738
> __primary_switched+0xbc/0xc4
> </TASK>
> 
> Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

*snort*

IMO something like "spotted by UBSAN" is more than enough here -
stack trace is completely pointless.

Otherwise, no problems with the patch - it's obviously safe.
