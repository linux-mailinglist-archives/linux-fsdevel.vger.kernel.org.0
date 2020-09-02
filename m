Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18D525AEA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBPTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:19:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32713 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgIBPRy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:17:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhSHF0YFGz9tySq;
        Wed,  2 Sep 2020 17:17:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VNiYSj_8XU-g; Wed,  2 Sep 2020 17:17:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhSHD6TLCz9tySn;
        Wed,  2 Sep 2020 17:17:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54AFA8B7ED;
        Wed,  2 Sep 2020 17:17:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ob8p81vLm4sB; Wed,  2 Sep 2020 17:17:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FF028B7EA;
        Wed,  2 Sep 2020 17:17:45 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu>
Date:   Wed, 2 Sep 2020 17:17:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902123646.GA31184@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 02/09/2020 à 14:36, Christoph Hellwig a écrit :
> On Wed, Sep 02, 2020 at 08:15:12AM +0200, Christophe Leroy wrote:
>>> -		return 0;
>>> -	return (size == 0 || size - 1 <= seg.seg - addr);
>>> +	if (addr >= TASK_SIZE_MAX)
>>> +		return false;
>>> +	if (size == 0)
>>> +		return false;
>>
>> __access_ok() was returning true when size == 0 up to now. Any reason to
>> return false now ?
> 
> No, this is accidental and broken.  Can you re-run your benchmark with
> this fixed?
> 

With this fix, I get

root@vgoippro:~# time dd if=/dev/zero of=/dev/null count=1M
1048576+0 records in
1048576+0 records out
536870912 bytes (512.0MB) copied, 6.776327 seconds, 75.6MB/s
real    0m 6.78s
user    0m 1.64s
sys     0m 5.13s

That's still far from the 91.7MB/s I get with 5.9-rc2, but better than 
the 65.8MB/s I got yesterday with your series. Still some way to go thought.

Christophe
