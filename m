Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF697A410E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjIRG1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjIRG1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:27:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949F8F;
        Sun, 17 Sep 2023 23:27:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01DFC433C7;
        Mon, 18 Sep 2023 06:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695018446;
        bh=4QZJXtba7Bd/xM6MN6jVGiBfai/jz7oNBxLb0zxvHa8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g6mgy8yOPCAhMnALuJZemFFcsH0ah+HMpfcpLv5DCdwHXX9W2+Y2pCjE35HZIMvw6
         +IxsikCiEe2SiH9gQy+iRw7oH95vZlRGqKQKWnCXPyBWa77HpEtkiZ9e3Gc3LymGkT
         KiJPLeCtxULOuZFTy7+IBSy8nt1PUxntN2y1oHyqLRH/aPV5kXLv600J/JL67ybcej
         tKUd59T8GIdB1l+jKbM+e2A56nsfcbTKV0xRDOwTfJPL9T9GZrjHAFtG3q1mKJR/3+
         P5C5UMJfxgeFEzZmtCm3UmTfg+RNL0KOe2r1XpU/uJUhjXy3lkO4kqxiGYTDPo1EMS
         UvtTL4HVRbgvg==
Message-ID: <5573ef25-a35b-c189-874b-3cafba09b120@kernel.org>
Date:   Mon, 18 Sep 2023 16:27:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] fs: binfmt_elf_efpic: fix personality for ELF-FDPIC
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230907011808.2985083-1-gerg@kernel.org>
 <20230917122603.5466b1fc6d05ea9e9edee340@linux-foundation.org>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20230917122603.5466b1fc6d05ea9e9edee340@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

On 18/9/23 05:26, Andrew Morton wrote:
> On Thu,  7 Sep 2023 11:18:08 +1000 Greg Ungerer <gerg@kernel.org> wrote:
> 
>> The elf-fdpic loader hard sets the process personality to either
>> PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
>> normal ELF binaries (in this case they would be constant displacement
>> compiled with -pie for example). The problem with that is that it
>> will lose any other bits that may be in the ELF header personality
>> (such as the "bug emulation" bits).
>>
>> On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
>> a normal 32bit binary - as opposed to a legacy 26bit address binary.
>> This matters since start_thread() will set the ARM CPSR register as
>> required based on this flag. If the elf-fdpic loader loses this bit
>> the process will be mis-configured and crash out pretty quickly.
>>
>> Modify elf-fdpic loader personality setting so that it preserves the
>> upper three bytes by using the SET_PERSONALITY macro to set it. This
>> macro in the generic case sets PER_LINUX and preserves the upper bytes.
>> Architectures can override this for their specific use case, and ARM
>> does exactly this.
>>
>> The problem shows up quite easily running under qemu using the ARM
>> architecture, but not necessarily on all types of real ARM hardware.
>> If the underlying ARM processor does not support the legacy 26-bit
>> addressing mode then everything will work as expected.
> 
> I'm thinking
> 
> Fixes: 1bde925d23547 ("fs/binfmt_elf_fdpic.c: provide NOMMU loader for regular ELF binaries")
> Cc: <stable@vger.kernel.org>

Yes, that seems reasonable. It will apply easily, and legitimately fix this
specific issue going back to the original change.

Regards
Greg
  
