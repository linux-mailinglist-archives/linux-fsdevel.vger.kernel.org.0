Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939262C5CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404988AbgKZTqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 14:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404970AbgKZTqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:46:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C14C0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 11:46:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z7so3349567wrn.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oA+p6sQRZh6K/+2/r/vzDoG47gc/rMQlygvkOGkhwFw=;
        b=aB00JKdnobOsgyuS2Ye42WpIYWno/EcfbYt+MymjWdzhfUS1RdpH+3b9ihSLo2rwuR
         gnoOvR5M8NrDTMeEl7HrAjlh1JfQ0PDx1XWf0PstYelsiiBvPtIyUyG7mTQ42WFyr65O
         yJ/5dJVPk3FGXSgNF2/mKj2a1V6uvuq5N2EFzuL8X6xHT5tEe1Zwvv8j79cFWAI0IIVX
         NHe5hPqLvn6bhhNj73yuttk3tL34D6bUzLWdajTy8ia94p+D0oq7IDq4TlDsdJe+bcJn
         XMSiN8hI8LTy35LNk7pD0TIp8vT0rBfNfhckDDSTKxddrp1Wa7bPm26OZnmU5Sor0Q9p
         wzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oA+p6sQRZh6K/+2/r/vzDoG47gc/rMQlygvkOGkhwFw=;
        b=FhZjMt/tVLVxWUPU5+iBhWK/upCasuBdsx2iZfwi5kEwBdKeP1MRtC/IXw1fwwNd+z
         KykAiWkrmlrTeHaUT84lPKl4NVf54A7SQtt0NCm+iF1oNOeqY/fl2l0ySTcpnb4+ffnv
         xxD6l8GtpbTrmbkJKI8E3nWj9JrDBiVlpoDbub28Gxo4TknK4rzq+OIUCfMinlG2q9jS
         z8lUzsJf94+xbLQ9KwVmsYnutZwd6aVDu/omfgjtfZEFDt2ySaVc/cL7K9H6Viw9VVL1
         zSpvw5OlkHAK8GSNPL9F/z07mC0QCwzH9WGItZD1nS0Lb92VvUQLs1VicEtKb0h2TuMw
         6/2g==
X-Gm-Message-State: AOAM531UGGpDMmpo5x5Ty6EHSyEdEqhuyoeaEA0DKvq3iOA16nQViMed
        iRPum3UVGgIid9jhb63SJDX+5g==
X-Google-Smtp-Source: ABdhPJx1bIwWl+pH8X8yYvQ3W1QeOmH7r+FL4p2P5x38EbIHYQgRF9EC5Aem35LNOdoK0T4pQFCkaA==
X-Received: by 2002:adf:fe82:: with SMTP id l2mr4250868wrr.232.1606420011286;
        Thu, 26 Nov 2020 11:46:51 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n10sm10316007wrv.77.2020.11.26.11.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 11:46:50 -0800 (PST)
Subject: Re: [PATCH v2 06/19] elf/vdso: Reuse arch_setup_additional_pages()
 parameters
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-fsdevel@vger.kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-7-dima@arista.com>
 <aefd633f-6dec-313f-f658-6e0b556171a4@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <0e665fc7-0e00-d193-ef78-c29059d6d4aa@arista.com>
Date:   Thu, 26 Nov 2020 19:46:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <aefd633f-6dec-313f-f658-6e0b556171a4@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/20 6:18 AM, Christophe Leroy wrote:
> "Reuse arch_setup_additional_pages() parameters"
> 
> Did you mean "remove" ? Or "Revise" ?
> 
> Maybe could be:
> 
> "Modify arch_setup_additional_pages() parameters"

Sure.

Thanks,
          Dmitry
