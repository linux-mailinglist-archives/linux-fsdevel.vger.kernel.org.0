Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC91AFF81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 03:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDTBbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgDTBbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:31:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125BC061A0C;
        Sun, 19 Apr 2020 18:31:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t9so1722031pjw.0;
        Sun, 19 Apr 2020 18:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qntJfTQVW2R5B/BZXP8n8jq5XEP710G+Kb7QjDlEEQ=;
        b=k5AmKImn7KnzGnT/lWSdv8VX3CIj8spL4RyLMQd8HGJxiXy77oPkqozWBzp5ILJKoB
         WW0eEcH2eIiOxwIC5DOVe5gCzW89E3KUq9R0MbsASNOePmn6tIhsvExsdGOU94kEaeK1
         goV0DiyfVW98J/N1PvBAnIa9mH7PBqXEELyQNpJGXRJthAE4ECVzLJl8FOS0IvTno1vh
         LLy9qv4lygAnjf8zzpJiExCmq+M3b6CsQPgtQrzfXp60lOqnIgZk/wwp2xry5l86ntfE
         MjwVvT8eANo059zfDXoyxrUEBjcXMOMuFFgnCorTEzWUHXC7H0D7LePh12VsuUvqyUxa
         8GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qntJfTQVW2R5B/BZXP8n8jq5XEP710G+Kb7QjDlEEQ=;
        b=ifw2FGZ3DRLA9OkQLEnKcKiDfy18yKvL93F5aBIJM77fm8oW+lSFZNGykYSZq56syr
         mbphCPAtTnuI5VRH6Qm4vOmnZhxLYzZUa38MOcLPUUm6cw6pnzS9auNfahjzBOJ6JP1H
         AEqzqJJi8gxVYGL2bh9AA7u5xcBzV/dB4KWCgR6lxGQ91Y19d6/dPt/rGTNeUA64jcW4
         m7aar6dTlSK00PeQ+kSpdR6O1vafz/eePJiuwAlGy0U2zNOVGWKLqbV0cX1ck4mEOXZP
         PfUU1qMD5I2f0h6jfOCdh2GHsFUjWoZS6L+YQiyQTZnn54y6GWqdorbJ8mpH6X6TJMsE
         D9RA==
X-Gm-Message-State: AGi0PuZxVO1ZwEfSlBvTU0WuCKxinqm4p12E9JpAIQAvq6il4dfPFwNt
        hN14UnhHiAZHlA03J5dL/yPvrF+VAMu9AQ==
X-Google-Smtp-Source: APiQypJtGX6ti+FmScXgNNGNQDgAbN5PeCH/OOo+A6WHAH0Gh4hrHTS9FyZXO+Ifmjp6k+NAz7Jhaw==
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr9508017pjb.181.1587346262714;
        Sun, 19 Apr 2020 18:31:02 -0700 (PDT)
Received: from ?IPv6:::1? ([2404:7a87:83e0:f800:d9be:3496:1edd:1106])
        by smtp.gmail.com with ESMTPSA id a22sm20373159pfg.169.2020.04.19.18.31.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 18:31:02 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Subject: Re: [PATCH v3] exfat: replace 'time_ms' with 'time_cs'
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Tetsuhiro Kohada' <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200416085144epcas1p1527b8df86453c7566b1a4d5a85689e69@epcas1p1.samsung.com>
 <20200416085121.57495-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <003601d61461$7140be60$53c23b20$@samsung.com>
Message-ID: <b250254c-3b88-9457-652d-f96c4c15e454@gmail.com>
Date:   Mon, 20 Apr 2020 10:31:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <003601d61461$7140be60$53c23b20$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 200419-0, 2020/04/19), Outbound message
X-Antivirus-Status: Clean
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/17 11:39, Namjae Jeon wrote:
>> Replace "time_ms"  with "time_cs" in the file directory entry structure
>> and related functions.
>>
>> The unit of create_time_ms/modify_time_ms in File Directory Entry are not
>> 'milli-second', but 'centi-second'.
>> The exfat specification uses the term '10ms', but instead use 'cs' as in
>> "msdos_fs.h".
>>
>> Signed-off-by: Tetsuhiro Kohada
>> <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
>> ---
> I have run checkpatch.pl on your patch.
> It give a following warning.
> 
> WARNING: Missing Signed-off-by: line by nominal patch author 'Tetsuhiro
> Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>'
> total: 0 errors, 1 warnings, 127 lines checked
> 
> Please fix it.

I want to fix it, but I'm not sure what's wrong.
The my patch has the following line:

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>

Both my real name and email address are correct.
Can you give me some advice?

*** Currently I can't use office email, so I'm sending it from private email instead.


-- 
このEメールはアバスト アンチウイルスによりウイルススキャンされています。
https://www.avast.com/antivirus

