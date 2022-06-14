Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BF54A9D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbiFNGw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351660AbiFNGw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:52:56 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC522E090;
        Mon, 13 Jun 2022 23:52:55 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id a15so9855148wrh.2;
        Mon, 13 Jun 2022 23:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=/ySUZjTm8UjxEDAJw2fvJmORhrykqz7zuKh8kBwSEeU=;
        b=0WcAtivn1sA7Agevxuo94VFcJL+qizFs7ivCnRHSQubIlDrmu78b5mJkJ/PmfLqcSj
         AbeltBcaH1yBUgsOldwDZ3tVbaD2k6ZPxAUMxUrAsig8I/4ZpBH28EoS6Un0h1H6SAmE
         7UHlXmI8I1ix2Kpy2YIbGIs+vSMPyBrUyMkCm7ZvhPALJoTgpUcOUNJFtVHx/o+2HyKU
         vo4sjSDbQrDqxLJxmMAGVqCpbxz4rfmTqOjGnUd4GYR1CH6ugyebW1s7sODEbqayK4Xw
         JQkEFHY+1q18SO9lFRUOhie0vWbC8nmQvJzxdy+Qm9ZCMHn8aR8iLy6edKE/IXw9pMYR
         bPQw==
X-Gm-Message-State: AJIora/wSLcEL7ATSt8JFG9rLDj9TE3y9DlfjxZLV86QaoyVA3ieEH8g
        lYZMpYM+U2K0ynsGEeWcqKw=
X-Google-Smtp-Source: AGRyM1uNSM2swQovM0d2bmA+5w2xaBUlEO2v0hdh3HwikbxlmcCxOLppetnw/YPlKu1SVWj5n2sW6Q==
X-Received: by 2002:a5d:5492:0:b0:210:2f29:b1cf with SMTP id h18-20020a5d5492000000b002102f29b1cfmr3370950wrv.468.1655189573934;
        Mon, 13 Jun 2022 23:52:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4b90000000b0020c5253d8c2sm11070061wrt.14.2022.06.13.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 23:52:53 -0700 (PDT)
Message-ID: <8c1df911-17b1-4db4-05cd-abcb4146e562@kernel.org>
Date:   Tue, 14 Jun 2022 08:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        sunjunchao2870@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <297b268a-85de-bc8c-88eb-b8d050ac1ec3@kernel.org>
In-Reply-To: <297b268a-85de-bc8c-88eb-b8d050ac1ec3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14. 06. 22, 7:15, Jiri Slaby wrote:
> On 13. 06. 22, 18:54, Alexandru Elisei wrote:
>> I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the 
>> offending
>> commit fiddles with locks, but no splat was produced that would 
>> explain the
>> hang.
> 
> It's too early for lockdep. Could you try to move lockdep_init() before 
> console_init() in start_kernel()?

Sorry, ignore this, lockdep_init() only dumps some info.

-- 
js
suse labs
