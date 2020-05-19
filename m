Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05181D90D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 09:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgESHQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 03:16:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57933 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 03:16:55 -0400
X-Originating-IP: 78.194.159.98
Received: from clip-os.org (unknown [78.194.159.98])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DE5FF40006;
        Tue, 19 May 2020 07:16:52 +0000 (UTC)
Date:   Tue, 19 May 2020 09:16:52 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in coredump code
Message-ID: <20200519071652.GA924@clip-os.org>
References: <20200330083158.GA21845@clip-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330083158.GA21845@clip-os.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:31:59AM +0200, Thibaut Sautereau wrote:
> I hit a kernel NULL pointer dereference caused by the following call chain:
> 
> do_coredump()
>   file_start_write(cprm.file) # cprm.file is NULL
>     file_inode(file) # NULL ptr deref
> 
> The `ispipe` path is followed in do_coredump(), and:
>     # cat /proc/sys/kernel/core_pattern
>     |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> It seems that cprm.file can be NULL after the call to the usermode
> helper, especially when setting CONFIG_STATIC_USERMODEHELPER=y and
> CONFIG_STATIC_USERMODEHELPER_PATH="", which is the case for me.
> 
> One may say it's a strange combination of configuration options but I
> think it should not crash the kernel anyway. As I don't know much about
> coredumps in general and this code, I don't know what's the best way to
> fix this issue in a clean and comprehensive way.
> 
> I attached the patch I used to temporarily work around this issue, if
> that can clarify anything.
> 
> Thanks,

For the record, this had previously been reported [1] and was eventually
fixed by 3740d93e3790 ("coredump: fix crash when umh is disabled").

[1] https://bugzilla.kernel.org/show_bug.cgi?id=199795

-- 
Thibaut Sautereau
CLIP OS developer
