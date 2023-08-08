Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C077774CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjHHVUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 17:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjHHVUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:20:02 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B114084C;
        Tue,  8 Aug 2023 12:20:11 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bb7d1f7aeaso4731067fac.1;
        Tue, 08 Aug 2023 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522408; x=1692127208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lo4mgIh/9nXIAz81CZMW5MI7/+F8GTcgLr96nVQtDgE=;
        b=csn37X32wO1Au0l6vBQx2q5u4zXc0k/TrPFkYfdNkHlqb8/drEsmOuqi2csZBahR2C
         9PWU7Qh8JQLTEXu2ZPj6v2zt8FgVz8U3iuFkJtIeFTPmgQmr5HrAdWvhh1JWDX+z9J0B
         z12PX7uPVy6AsEA5GYnbtBbjjGTmL6e1ifaJIj+i+d1s+1KUgnF4Knchq7FVtYYfudtO
         LJNQI4HdMAiwjUj0FJ3ud+Q+/zT26+u8kX8OsUuuKxVJvRqhbWTBpZ3mXqh4Yf3YBHMd
         Gx8a2ZKhUur0mbCdLm8bTYgwGqgpqFdpambtjFRCAtf0/c1rcPfXUaBrIQJhQ99lNZy5
         hHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522408; x=1692127208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lo4mgIh/9nXIAz81CZMW5MI7/+F8GTcgLr96nVQtDgE=;
        b=ktksGH12QFtnE5DMlC6U0o0KAjsoJ9RNHkXmcqcFpUhGbXKThiyVQHyNzd1hAyWyJM
         eEavoUpyZsHmbtCXF7IvUh0hLxzG3tigWVXr+r5i4AiR+AP8SSxZ5m42mmc08kq/GrfR
         QYb3le2CiVdM7HplbJFs6WbusPKPOaIqf5FalGVot+RDOcSjMOs/Ue1RGAbWBFG/uzLt
         yeqFifq7PgEjhup48gOQSpAQD+ijYM/gqThmwv8OFYclHFNh0ABhlimJIH2QMSI+M0s0
         Imlm4Rtihgb8M5SPqyfbVWotYYbrHFUCNC03GPjOBK0/33tlz84o4yAEqgRbAriynyD3
         6CBA==
X-Gm-Message-State: AOJu0Ywtsc5474bT97o3MWARenHKPI8fOxqHmtX8vqZFdaptLllKRFL1
        +iw3f2GBD6vdKUoFKT75H2g=
X-Google-Smtp-Source: AGHT+IHqOyan+5/7RWD1nJ8ax3s1SDYfKm888u41Ha2ElbdK8zMF5qKXrs1hOE5/fwe70xvMZWhCbQ==
X-Received: by 2002:a05:6870:c18c:b0:1a9:af29:46eb with SMTP id h12-20020a056870c18c00b001a9af2946ebmr529285oad.59.1691522408303;
        Tue, 08 Aug 2023 12:20:08 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n27-20020a4ad63b000000b00565d41ba4d0sm5602140oon.35.2023.08.08.12.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 12:20:07 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <20fc56ef-6240-e86e-6d38-9278592a3b25@lwfinger.net>
Date:   Tue, 8 Aug 2023 14:20:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] vboxsf: Use flexible arrays for trailing string member
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230720151458.never.673-kees@kernel.org>
 <169040854617.1782642.4557415464507636357.b4-ty@chromium.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <169040854617.1782642.4557415464507636357.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/23 16:55, Kees Cook wrote:
> 
> On Thu, 20 Jul 2023 08:15:06 -0700, Kees Cook wrote:
>> The declaration of struct shfl_string used trailing fake flexible arrays
>> for the string member. This was tripping FORTIFY_SOURCE since commit
>> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
>> utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
>> member, and retriain a 2 byte padding to keep the structure size the same.
>>
>>
>> [...]
> 
> Applied to for-linus/hardening, thanks!
> 
> [1/1] vboxsf: Use flexible arrays for trailing string member
>        https://git.kernel.org/kees/c/a8f014ec6a21

Kees,

This patch has not been applied to kernel 6.5-rc5. Is there some problem?

Larry


