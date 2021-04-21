Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DDD367470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 22:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbhDUUu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 16:50:28 -0400
Received: from mail.tuxforce.de ([84.38.66.179]:39576 "EHLO mail.tuxforce.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245698AbhDUUu2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:50:28 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2021 16:50:27 EDT
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id 0421052007D;
        Wed, 21 Apr 2021 22:42:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de 0421052007D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1619037757;
        bh=eeldZ43v9kOcNhynOalmpLgFTzFOymh3pImWlM/X8Q8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EnzW78doaicFyEjhlvnSCVRWqYVS7b48MpoJj8P/vRPfVy/kJhF1df1QHkSduUXrZ
         4TeDUL9RWu/0r2lcOotvd4nPhpptQsRjINLHlanqvQAAxzU4EMiwtqXHq4Thqhd+Gk
         JOonAxqYML+RdCqM/N1R6BtBnq9gdzSKKcLjawx9xPAWGBQizW85NaW7MWfXkk+FJI
         4SXcIHDdpZddUWYb0d0CrrH896egRYeCHp8AlFEZS4v/uU4BaPCCku31GsybTmpSq0
         BFt0SeSPWXMd5diPY7CCk5JvFLGl4ge0dPR3x1918W47NLrYUJJmQvA1PzIDHd9w6w
         T/cW39CUwwMcQ==
Subject: Re: [PATCH 2/2] fs/kernel_read_file: use
 usermodehelper_read_trylock() as a stop gap
To:     Luis Chamberlain <mcgrof@kernel.org>, rafael@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-3-mcgrof@kernel.org>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <35ff02c7-8a76-730e-ddb9-f91634f5098b@tuxforce.de>
Date:   Wed, 21 Apr 2021 22:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416235850.23690-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 17/04/2021 01:58, Luis Chamberlain wrote:
> The VFS lacks support to do automatic freeze / thaw of filesystems
> on the suspend / resume cycle. This can cause some issues, namely
> stalls when we have reads/writes during the suspend / resume cycle.
> 
> Although for module loading / kexec the probability of this happening
> is extremely low, maybe even impossible, its a known real issue with
> the request_firmare() API which it does direct fs read. For this reason
> only be chatty about the issue on the call used by the firmware API.
> 
> Lukas Middendorf has reported an easy situation to reproduce, which can
> be caused by questionably buggy drivers which call the request_firmware()
> API on resume.
> 
[snip]
> 
> The VFS fs freeze work fixes this issue, however it requires a bit
> more work, which may take a while to land upstream, and so for now
> this provides a simple stop-gap solution.
> 
> We can remove this stop-gap solution once the kernel gets VFS
> fs freeze / thaw support.
> 
> Reported-by: Lukas Middendorf <kernel@tuxforce.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Tested-by: Lukas Middendorf <kernel@tuxforce.de>


Works as advertised.

This prevents stalls on resume with buggy drivers (e.g. si2168) by 
totally blocking uncached request_firmware() on resume. Uncached 
request_firmware() will fail reliably (also in situations where it by 
accident worked previously without stalling).
If firmware caching has been set up properly before suspend (either 
through firmware_request_cache() or through request_firmware() outside 
of a suspend/resume situation), the call to request_firmware() will 
still work as expected on resume. This should not break properly 
behaving drivers.

A failing firmware load is definitely preferable (and easier to debug 
and fix in the respective drivers) compared to a stall on resume.

Lukas
