Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F21AF914
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSJrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 05:47:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20269 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDSJrH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:47:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 494lNP3gtMz9tyDp;
        Sun, 19 Apr 2020 11:47:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VOe4N8r5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WZtesNUcJGZq; Sun, 19 Apr 2020 11:47:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 494lNP2TXsz9tyDn;
        Sun, 19 Apr 2020 11:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587289621; bh=RaXJ481mUi0DrviGOH+SkNVnZ2LQzKruVx+D2GV8ZOM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VOe4N8r5t969r8fxlMuXcUxzMYzBUsuFSfUW2XhIzUu7MpXItbVhlqB095uOkgU/l
         lioa8xJ0ZOzk1wkoG81P1woBSK39GM50P4XzCZHwfqClIvrU37btIjyDPPuhbLnXVM
         otq6qm9vH2HX20sBV+snNzhRspQiy4NnvEXEK5XA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 620498B76F;
        Sun, 19 Apr 2020 11:47:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jYx07x_1XUos; Sun, 19 Apr 2020 11:47:04 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 244FD8B752;
        Sun, 19 Apr 2020 11:47:01 +0200 (CEST)
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
To:     Christoph Hellwig <hch@lst.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org>
 <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
 <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
 <87v9lx3t4j.fsf@x220.int.ebiederm.org> <20200419081353.GF12222@lst.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5f0bbdc-8b31-fc4c-a5b9-b63cba4ebffe@c-s.fr>
Date:   Sun, 19 Apr 2020 11:46:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200419081353.GF12222@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 19/04/2020 à 10:13, Christoph Hellwig a écrit :
> On Sat, Apr 18, 2020 at 06:55:56AM -0500, Eric W. Biederman wrote:
>>> Is that really an issue to use that set_fs() in the coredump code ?
>>
>> Using set_fs() is pretty bad and something that we would like to remove
>> from the kernel entirely.  The fewer instances of set_fs() we have the
>> better.
>>
>> I forget all of the details but set_fs() is both a type violation and an
>> attack point when people are attacking the kernel.  The existence of
>> set_fs() requires somethings that should be constants to be variables.
>> Something about that means that our current code is difficult to protect
>> from spectre style vulnerabilities.
> 
> Yes, set_fs requires variable based address checking in the uaccess
> routines for architectures with a shared address space, or even entirely
> different code for architectures with separate kernel and user address
> spaces.  My plan is to hopefully kill set_fs in its current form a few
> merge windows down the road.  We'll probably still need some form of
> it to e.g. mark a thread as kernel thread vs also being able to execute
> user code, but it will be much ore limited than before, called from very
> few places and actually be a no-op for many architectures.
> 

Oh nice. Some time ago I proposed a patch to change set_fs() to a 
flip/flop flag based logic, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/dd2876b808ea38eb7b7f760ecd6ce06096c61fb5.1580295551.git.christophe.leroy@c-s.fr/

But if we manage to get rid of it completely, that's even better.
