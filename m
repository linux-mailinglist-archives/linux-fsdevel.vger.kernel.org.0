Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCF17EC24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 23:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCIWeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 18:34:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41562 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:34:19 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <matthew.ruffell@canonical.com>)
        id 1jBQyW-0004jy-OX
        for linux-fsdevel@vger.kernel.org; Mon, 09 Mar 2020 22:34:16 +0000
Received: by mail-pf1-f200.google.com with SMTP id v26so7745177pfn.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2020 15:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KQcrw2yUpe9WcR5YMys+lGugYtYd9Ok8ZJgn9f16J4=;
        b=uXMjy2cCGzXilnt0oUad8GKBE00wyWd3H0TW+TMGBhGkb+785awnxsIo/taG9b1Xbf
         lIi4p+2/goRtRgE1Ul9DtBGDHyrEFY4YzjDsdphT2XGOW1I2Y/gVzXzxtH4S/lIzE0VX
         IPMSXMju/1e0TVuu1jGk7Xwt8tHQT52hXHccW8uFGeO7Pdv5/mMEZ0+QwgehIISEWhlI
         Mo7XnZKkRI303FMBI98aW1BQkJtcUBFsafvwCmjlFD59yirXrXWHljjC+pl/UlN6LpLy
         lXAStr4RkU8oMuaB5Xl6jFYWwtRqNU/A/2FAkxOwGIrqmmc6Imnu0/50sZtQ0wsn2+su
         QSWQ==
X-Gm-Message-State: ANhLgQ0L4AMPtyMCUw2xFPNlwQVuuylPamTu5cEBMT3WkAI6FBy8nygT
        OraqF1L3QbwbmWbaKCK6eNZXqZ7WnGM0K+MRPTOgtke7nFBsXrqes9myCFtyZQ2uBpVaEOTQkbQ
        gF9CegN34CANf1RHcsTQO6s+aDJ/fD8jAyBt5QK2fAAQ=
X-Received: by 2002:a17:90a:34f:: with SMTP id 15mr1519157pjf.94.1583793255495;
        Mon, 09 Mar 2020 15:34:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs9VxY4puLe/6q81FmP2tIbuWYuBZTOustWorHqidrzJwquI0Ks5GiUbA9IKsHYKfvh7tTcIQ==
X-Received: by 2002:a17:90a:34f:: with SMTP id 15mr1519132pjf.94.1583793255202;
        Mon, 09 Mar 2020 15:34:15 -0700 (PDT)
Received: from [192.168.1.107] (222-154-99-146-fibre.sparkbb.co.nz. [222.154.99.146])
        by smtp.gmail.com with ESMTPSA id t142sm36524584pgb.31.2020.03.09.15.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 15:34:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] coredump: Fix null pointer dereference when
 kernel.core_pattern is "|"
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Wilk <jwilk@jwilk.net>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
 <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Message-ID: <87a47997-3cde-bc86-423b-6154849183e9@canonical.com>
Date:   Tue, 10 Mar 2020 11:34:09 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Can I please get some feedback on this patch? Would be good to clear up the
null pointer dereference.

Thanks,
Matthew
