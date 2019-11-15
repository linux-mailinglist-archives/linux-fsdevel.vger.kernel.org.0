Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19073FDEE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKON1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:27:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60600 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKON1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:27:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbdU-0000jT-R6; Fri, 15 Nov 2019 13:27:41 +0000
Date:   Fri, 15 Nov 2019 13:27:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dieti.hahn@gmail.com
Subject: Re: Kernel panic because of wrong contents in core_pattern
Message-ID: <20191115132740.GP26530@ZenIV.linux.org.uk>
References: <1856804.EHpamdVGlA@amur.mch.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1856804.EHpamdVGlA@amur.mch.fsc.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:01:55PM +0100, Dietmar Hahn wrote:

> Later a user tool dumped with SIGSEGV and the linux system crashed.
> I investigated the crash dump and found the cause.
> 
> Via format_corename() in fs/coredump.c the helper_argv[] with 3 entries is
> created and helper_argv[0] == "" (because of the ' ' after the '|')
> ispipe is set to 1.
> Later in call_usermodehelper_setup():
>   sub_info->path = path;  == helper_argv[0] == ""
> This leads in call_usermodehelper_exec() to:
>   if (strlen(sub_info->path) == 0)
>                 goto out;
> with a return value of 0.
> But no pipe is created and thus cprm.file == NULL.
> This leads in file_start_write() to the panic because of dereferencing
>  file_inode(file)->i_mode)
> 
> I'am not sure what's the best way to fix this so I've no patch.
> Thanks.

Check in the caller of format_corename() for **argv being '\0' and fail
if it is?  I mean, turn that
                if (ispipe < 0) {
                        printk(KERN_WARNING "format_corename failed\n");
                        printk(KERN_WARNING "Aborting core\n");
                        goto fail_unlock;
                }   
in there into
		if (ispipe < 0 || !**argv) {
                        printk(KERN_WARNING "format_corename failed\n");
                        printk(KERN_WARNING "Aborting core\n");
                        goto fail_unlock;
                }

