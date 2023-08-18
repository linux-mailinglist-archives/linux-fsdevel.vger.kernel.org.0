Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A227B780CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377204AbjHRNht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377219AbjHRNhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:37:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B74358D;
        Fri, 18 Aug 2023 06:37:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1870360174;
        Fri, 18 Aug 2023 15:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692365834; bh=9ABLKJW3znMF+2BnIavfP3lVeGPtkFRbVSJFS/sFuwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QFceNfqkxa6IrvniGKAkiEIFCCiDprfZ6RUexdlhUg+UVodUoc5t8EVtgDyAl+M63
         Ff14aJnlr9p6idlaqs+oGJeLOt8XtlCpkH0CWNBaRF2PqmG83BUIwnxQXJb8qlnpsw
         zMkj9avzFk6FpjM/G2jm525Fh+t+hxF6E3UEkszLeG76dT811M3I2UgtRz49fRdQpl
         carSUgKaq9wK/hrxcUqu4a+E1CpBzLS59Od05QXQvJWTENSiok0BlS1J1nGExrJb6O
         w4WyntMaZmM40XDJ5QTB3qjgzM1JlZhSkZpGFjIugGhkTiEli0w8xS4x1iBAYdvqn2
         d4Ash8fp73BGw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5xledPWCeM6A; Fri, 18 Aug 2023 15:37:11 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 799646015E;
        Fri, 18 Aug 2023 15:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692365831; bh=9ABLKJW3znMF+2BnIavfP3lVeGPtkFRbVSJFS/sFuwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JY+M12w0DrzenKc08++lqJyPfBRwl7mMBflod1nU9OXh4D4BuygYLgQsd9abfumXb
         s4LxvVe/Zb3DCupIxtEqauGp72PXFg53GAEumzGglOwZ7WlyWlSsDzZzOWPknC6S+S
         LMfMc0gzz//kZkuYtW/frocVvlNrSr97K919PBaOBwSzrGZGPdtOK75TAwLY836ZoD
         fxpadD15/1v4xfp4EYHFVueXXkEQBTEFy/6v21aWK6oRMitKq6uHS9UJFVXFk0/n89
         yE4+n9Mic2RUcUbxfzplHpm/SpNoo3zJzrBwjz8ptGPveGXE4Fskh26ryl1klYccj+
         pBtZJN47m2uXQ==
Message-ID: <873686fb-6e42-493d-2dcd-f0f04cbcb0c0@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 15:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
 <ZN9iPYTmV5nSK2jo@casper.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZN9iPYTmV5nSK2jo@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/18/23 14:21, Matthew Wilcox wrote:
> On Fri, Aug 18, 2023 at 10:01:32AM +0200, Mirsad Todorovac wrote:
>> [  206.510010] ==================================================================
>> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>
>> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
>> [  206.510081]  xas_clear_mark+0xd5/0x180
>> [  206.510097]  __xa_clear_mark+0xd1/0x100
>> [  206.510114]  __folio_end_writeback+0x293/0x5a0
>> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
>> [  206.520735]  xas_find_marked+0xe5/0x600
>> [  206.520750]  filemap_get_folios_tag+0xf9/0x3d0
> Also, before submitting this kind of report, you should run the
> trace through scripts/decode_stacktrace.sh to give us line numbers
> instead of hex offsets, which are useless to anyone who doesn't have
> your exact kernel build.
> 
>> [  206.510010] ==================================================================
>> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>
>> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
>> [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
>> [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
>> [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
> 
> This path is properly using xa_lock_irqsave() before calling
> __xa_clear_mark().
> 
>> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
>> [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
>> [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
> 
> This takes the RCU read lock before calling xas_find_marked() as it's
> supposed to.
> 
> What garbage do I have to write to tell KCSAN it's wrong?  The line
> that's probably triggering it is currently:
> 
>                          unsigned long data = *addr & (~0UL << offset);

Hi, Mr. Wilcox,

Thank you for your evaluation of the bug report.

I am new to KCSAN. I was not aware of KCSAN false positives thus far, so my best bet was to report them.

I thought that maybe READ_ONCE() was required, but I will trust your judgment.

I hope I can find this resolved.

Best regards,
Mirsad Todorovac
