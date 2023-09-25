Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027F7AD468
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjIYJVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjIYJVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C6C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695633658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vs+s8MbEdlPjqhnrrm1uH19re0iD33TvngqTvSoravg=;
        b=Ofmj+5kHudaoG3Db4SBK+rf1qoes8QbnjAZeSD7XqkEK4lDulyZeC1yNyFD+BfiEa60YYA
        WaHcxuZbye2z+UPfIyMt40MBeb9RrDxLBhYXzwAlmwhLgTsbRd+bvgbm1Ywb88JpqG81fI
        WroLiHHt3tomBAVind+KtNLARHFGPeQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-PbCFwX7jPsm2nUuSZb31AA-1; Mon, 25 Sep 2023 05:20:56 -0400
X-MC-Unique: PbCFwX7jPsm2nUuSZb31AA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7740c0e88ffso1086465485a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 02:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633655; x=1696238455;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs+s8MbEdlPjqhnrrm1uH19re0iD33TvngqTvSoravg=;
        b=dYphkRopt9ewHaLPmiNNTDzfapgrN0tWJ6nysrdjeuzNwWxO66zlakmhhyEz/2NiIP
         +saSUnqBpPJWlYo4nOlcZzME8hKtNFz8+DZy5r2u2BmErNmr9RfUwANwRm/Mz+qdaeLR
         PVdEjhsunluEt0To7MH/JO5sK6y+YJ28u7I9Hliuya1Ao5JVvZQRorGfBY22d5hEFria
         PfaZvgWw7JiB9j8IbIUN89MG4N4VOFswu23x/U4NfyU4rSYULnybBAE+tkfvOVCX6jcA
         8zXZHz9ECg/j9gSXAHrCTE8czDer4VoyGPcG4LuLT5xIYN07Nrh1alZoaLfbqmj+X1nE
         ghZA==
X-Gm-Message-State: AOJu0YywrApBUelMsNtcBk1zV9R+0nZ8v58y/tresAiQ40amg6lVhhxk
        qtKYZGlX6jFYj2wp1xo4dHaKLaPvbCha+x84ew56XMzHLapYr7Mu94fbY2W/SvnYPoPk/lobvbv
        gZkkslRhSghL1/xE01z78UZMcVg==
X-Received: by 2002:a05:620a:2988:b0:774:2e8a:ccc6 with SMTP id r8-20020a05620a298800b007742e8accc6mr3902480qkp.32.1695633655386;
        Mon, 25 Sep 2023 02:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMfVG4q5k9ZPvMkbAHXmeCcChQBeS4lTv+/XiDIhQ/90pemlHQA/z1amKfCLJr6ZjuCedpAg==
X-Received: by 2002:a05:620a:2988:b0:774:2e8a:ccc6 with SMTP id r8-20020a05620a298800b007742e8accc6mr3902467qkp.32.1695633655100;
        Mon, 25 Sep 2023 02:20:55 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id vr10-20020a05620a55aa00b0076ef7810f27sm3633710qkn.58.2023.09.25.02.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 02:20:54 -0700 (PDT)
Date:   Mon, 25 Sep 2023 11:20:51 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
In-Reply-To: <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
Message-ID: <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net> <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com> <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Sep 2023, Eric W. Biederman wrote:
> Sebastian Ott <sebott@redhat.com> writes:
>
>> Hej,
>>
>> since we figured that the proposed patch is not going to work I've spent a
>> couple more hours looking at this (some static binaries on arm64 segfault
>> during load [0]). The segfault happens because of a failed clear_user()
>> call in load_elf_binary(). The address we try to write zeros to is mapped with
>> correct permissions.
>>
>> After some experiments I've noticed that writing to anonymous mappings work
>> fine and all the error cases happend on file backed VMAs. Debugging showed that
>> in elf_map() we call vm_mmap() with a file offset of 15 pages - for a binary
>> that's less than 1KiB in size.
>>
>> Looking at the ELF headers again that 15 pages offset originates from the offset
>> of the 2nd segment - so, I guess the loader did as instructed and that binary is
>> just too nasty?
>>
>> Program Headers:
>>   Type           Offset             VirtAddr           PhysAddr
>>                  FileSiz            MemSiz              Flags  Align
>>   LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>>                  0x0000000000000178 0x0000000000000178  R E    0x10000
>>   LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
>>                  0x0000000000000000 0x0000000000000008  RW     0x10000
>>   NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
>>                  0x0000000000000024 0x0000000000000024  R      0x4
>>   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>>                  0x0000000000000000 0x0000000000000000  RW     0x10
>>
>> As an additional test I've added a bunch of zeros at the end of that binary
>> so that the offset is within that file and it did load just fine.
>>
>> On the other hand there is this section header:
>>   [ 4] .bss              NOBITS           000000000041ffe8  0000ffe8
>>        0000000000000008  0000000000000000  WA       0     0     1
>>
>> "sh_offset
>> This member's value gives the byte offset from the beginning of the file to
>> the first byte in the section. One section type, SHT_NOBITS described
>> below, occupies no space in the file, and its sh_offset member locates
>> the conceptual placement in the file.
>> "
>>
>> So, still not sure what to do here..
>>
>> Sebastian
>>
>> [0] https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/
>
> I think that .bss section that is being generated is atrocious.
>
> At the same time I looked at what the linux elf loader is trying to do,
> and the elf loader's handling of program segments with memsz > filesz
> has serious remnants a.out of programs allocating memory with the brk
> syscall.
>
> Lots of the structure looks like it started with the assumption that
> there would only be a single program header with memsz > filesz the way
> and that was the .bss.   The way things were in the a.out days and
> handling of other cases has been debugged in later.
>
> So I have modified elf_map to always return successfully when there is
> a zero filesz in the program header for an elf segment.
>
> Then I have factored out a function clear_tail that ensures the zero
> padding for an entire elf segment is present.
>
> Please test this and see if it causes your test case to work.

Sadly, that causes issues for other programs:

[   44.164596] Run /init as init process
[   44.168763] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   44.176409] CPU: 32 PID: 1 Comm: init Not tainted 6.6.0-rc2+ #89
[   44.182404] Hardware name: GIGABYTE R181-T92-00/MT91-FS4-00, BIOS F34 08/13/2020
[   44.189786] Call trace:
[   44.192220]  dump_backtrace+0xa4/0x130
[   44.195961]  show_stack+0x20/0x38
[   44.199264]  dump_stack_lvl+0x48/0x60
[   44.202917]  dump_stack+0x18/0x28
[   44.206219]  panic+0x2e0/0x350
[   44.209264]  do_exit+0x370/0x390
[   44.212481]  do_group_exit+0x3c/0xa0
[   44.216044]  get_signal+0x800/0x808
[   44.219521]  do_signal+0xfc/0x200
[   44.222824]  do_notify_resume+0xc8/0x418
[   44.226734]  el0_da+0x114/0x120
[   44.229866]  el0t_64_sync_handler+0xb8/0x130
[   44.234124]  el0t_64_sync+0x194/0x198
[   44.237776] SMP: stopping secondary CPUs
[   44.241740] Kernel Offset: disabled
[   44.245215] CPU features: 0x03000000,14028142,10004203
[   44.250342] Memory Limit: none
[   44.253383] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

