Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E005F71D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJFXfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiJFXfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:35:05 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5AA71BFE;
        Thu,  6 Oct 2022 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9/Kzs5EWDHcfdnB7QsEyGoGhVmKbR9KDuwkUE1J1en4=; b=n9bxje7iF84Y7YrDmLJ44z11dz
        4qshJB8AfnMUK9gGUoDX0O/YBEfeg5j/au9n4inHHkr6glvS+bu/CgJ+KaDZnwB741d5vH9IwrpQK
        SYEDS3WUfeF9EMzWxRoe3h4rVbnoi5SdafeMQx5gJnd4JA5/DeeLgvDlFK/YH2Zfb1cDiqqMxfYP0
        Fj8NvjbyHiqVd6qBaJCvqPUxEy33s0cN3Pf+HTDn1okgp3k6Bl+Rf27rDoJs0Z8WPfhzIwan6zlk2
        X5gp8p3PK4OkB2WImNwEJd9CfVFjCNy4Jv84tcgqdRH7H5nkxO0eDIMkruzonJoyJ6HMFV1n1tUja
        j7QJgghQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogaOJ-00C7ML-N9; Fri, 07 Oct 2022 01:35:00 +0200
Message-ID: <55cceaf8-acd4-22e2-61b5-99fff4ad5d75@igalia.com>
Date:   Thu, 6 Oct 2022 20:34:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/8] pstore: Alert on backend write error
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-5-gpiccoli@igalia.com>
 <202210061625.950B43C119@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210061625.950B43C119@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/10/2022 20:27, Kees Cook wrote:
> [...]
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -463,6 +463,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>>  		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
>>  			pstore_new_entry = 1;
>>  			pstore_timer_kick();
>> +		} else {
>> +			pr_err_once("backend (%s) writing error (%d)\n",
>> +				    psinfo->name, ret);
> 
> We're holding a spinlock here, so doing a pr_*() call isn't a great
> idea. It's kind of not a great idea to try to write to the log in the
> middle of a dump either, but we do attempt it at the start.
> 
> Perhaps keep a saved_ret or something and send it after the spin lock is
> released?
> 

Hi Kees, thanks a lot for the very quick review!!

Agree with you, I'll rework this one.
Do you agree with showing only a single error? For me makes sense since
we just wanna hint advanced users (+ people-debugging-pstore heh) that
something went wrong.

Cheers,


Guilherme
