Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3690274CF0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjGJHuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGJHtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:49:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C78137;
        Mon, 10 Jul 2023 00:48:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D2CE41F88C;
        Mon, 10 Jul 2023 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688975313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRpvaHVraWSmHTGJgS9clU+E/bcwnLOg/tYUV1kAHRE=;
        b=ufZzycZCEkPD2nrQoG4+dtHe8kA8EW77H029j9Xq3LHluFcZYhXXA7ej//80aRMG8s9xKl
        NQ1upAr5rQTL8Mza6HMyNujpPhCn8pLdHposlI6TZvTMthdpcIhqAzEOOkxH61AJ+h3sNu
        Kw6b1/rjRjtmOFTogWqqzowAK3o/Ht0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688975313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRpvaHVraWSmHTGJgS9clU+E/bcwnLOg/tYUV1kAHRE=;
        b=Mwyd/jn03BMgejZI9arRq+bB0/xugZ61s1kGZVIDlAfkprKpO+1ahjdebxiVMlKSBY/WwJ
        LZWt8mKxiz9C2AAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9940B13A05;
        Mon, 10 Jul 2023 07:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J7DCJNG3q2SRegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 10 Jul 2023 07:48:33 +0000
Message-ID: <81008a82-1012-0b3e-134d-cd4a6502482c@suse.cz>
Date:   Mon, 10 Jul 2023 09:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [syzbot] [mm?] [reiserfs?] kernel panic: stack is corrupted in
 ___slab_alloc
To:     Dmitry Vyukov <dvyukov@google.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc:     David Rientjes <rientjes@google.com>,
        syzbot <syzbot+cf0693aee9ea61dda749@syzkaller.appspotmail.com>,
        42.hyeyoo@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, reiserfs-devel@vger.kernel.org,
        roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
References: <0000000000002373f005ff843b58@google.com>
 <1bb83e9d-6d7e-3c80-12f6-847bf2dc865e@google.com>
 <CACT4Y+akPvTGG0WdPdSuUFU6ZuQkRbVZByiROzqwyPVd8Pz8fQ@mail.gmail.com>
 <61032955-4200-662b-ace8-bad47d337cdc@os.amperecomputing.com>
 <CACT4Y+YAyK02ORyzS79ub+XOK6x5LV8_2k4aztwzjP=0dm--RQ@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CACT4Y+YAyK02ORyzS79ub+XOK6x5LV8_2k4aztwzjP=0dm--RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/23 09:43, Dmitry Vyukov wrote:
> On Thu, 6 Jul 2023 at 20:33, Lameter, Christopher
> <cl@os.amperecomputing.com> wrote:
>>
>> On Mon, 3 Jul 2023, Dmitry Vyukov wrote:
>>
>> >> This is happening during while mounting reiserfs, so I'm inclined to think
>> >> it's more of a reisterfs issue than a slab allocator issue :/
>>
>> Have you tried to run with the "slub_debug" kernel option to figure out
>> what got corrupted?
> 
> Can slub_debug detect anything that KASAN can't?

Probably not, KASAN will find out a bad write at the moment it happens,
while slub_debug only later from corrupted red zone/poison.

> I would assume KASAN can detect more bugs (e.g. stack/globals) and
> report way better. And it was already enabled in the config.

Anyway this is a stack corruption, not slab layout corruption. It's probably
hard to distinguish a legitimate stack write from an overrun so even KASAN
could not catch it immediately?
