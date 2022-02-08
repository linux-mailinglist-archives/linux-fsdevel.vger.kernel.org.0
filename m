Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B84AE247
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386104AbiBHTcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 14:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352499AbiBHTcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:32:10 -0500
X-Greylist: delayed 1256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 11:32:08 PST
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A160C0612C0
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Feb 2022 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xNLD+ohNcz8s+M2ZfwyQWaMV388U5TWtk0mAuxq0Jls=; b=Bxl9XAIFTDWKUHGroQRpuDasjd
        tgS8OvU0Ps+B9IqBwitqXm9eg19pxboo4/Axod6x1zS4fckWDK7q1i6YVIOE0PF3nd2Czd1T922lK
        vkgK4IOJsxJSUqHDVL1B2rKP4uXhln6//lz8dcD3fEUi7rl2Hxoo6lkjwVQzhoq7DHJdnKwDJd1Ih
        Nbm18MDVU0HRU34Lz8xy2LkOSLZb0WkZtp/cHYVyc/jtH+rYhi1v6+MMxc5N7Njv7L0nJu26GqRIJ
        rEGXZiZz0RyZId5QIeK/XcgG627jXQ0ia6lkNvhBhvMnWSO9fo/Iqj2JNkF0pxzQBEjrNtVCyc7uv
        e5NuYKIA==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nHUyS-000CHM-Ta; Tue, 08 Feb 2022 19:12:21 +0100
Message-ID: <c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com>
Date:   Tue, 8 Feb 2022 15:12:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com> <Yd/qmyz+qSuoUwbs@alley>
 <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
In-Reply-To: <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/01/2022 13:53, Guilherme G. Piccoli wrote:
> Hi Andrew, can I ask you to please remove this patch from linux-next?
> 
> It shows here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=56439cb78293
> 
> Baoquan has concerns, and we're discussing that in another thread [0],
> after I submit another change on top of this one. So, I guess it's
> simpler to just drop it.
> 
> My apologies for this, I should have definitely loop the kexec list in
> this one , but I forgot.
> 
> Cheers,
> 
> 
> Guilherme
> 
> 
> [0]
> https://lore.kernel.org/lkml/7b93afff-66a0-44ee-3bb7-3d1e12dd47c2@igalia.com/


Hi Stephen / Andrew, sorry for the annoyance, but can you please remove
this patch from linux-next?

Today it shows as commit
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d691651735f1
- this commit is subject to concern from Baoquan and we are discussing
better ways to achieve that, through a refactor.

Thanks in advance,


Guilherme
