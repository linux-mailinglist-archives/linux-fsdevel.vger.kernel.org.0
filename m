Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D937BC69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGaI6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 04:58:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46972 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaI6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:58:24 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so21273480iol.13;
        Wed, 31 Jul 2019 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GsMyYZltyVkiUgPix6eZw4DKTyNFfETnvHB4Ds8HiVc=;
        b=gz4EhWDwl+FFka+bG6XuRSE2IyaGBW8Ek0wnAE7rVPcqqyMm9VkwrweV7mrXFgGZFx
         UMGO14B2lr7QR+QJ3Qkw83KZeXJInnnyoZT/nJmWEJSYN+GJPM8Ssn8Lo92YDFitn9t8
         aaxjgS0ZGVxjVV29XHmzYtu1x5on8Mm+EaHMNfm6dpjHsjDs3ZDJ1/sSPCnF7oZk5hwo
         5Kgo/j+dnAG6hVjaTWGjGNemZBE+eK0sVm+UKYDnEVCBERmON9sxvDm11nMwfbIAeySH
         R9VXdXpyGI3BkYZyYW3PP8oC+QryXwmY8U+X4kHJHnvjo8cTnPEeoNRtZlljs1HrxI3R
         Xnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsMyYZltyVkiUgPix6eZw4DKTyNFfETnvHB4Ds8HiVc=;
        b=EtaewPSEwWECnjNVMkyoWmJUeCdkzls7j4SxuQRGsWQleiRny/jqI0t3840QO5cuyv
         hAaLaL0GFaWS8QHRv4Cr7Az4CrdIDXaVK8cZx78gEsbzw3uFvc/FldI1bUktkTN35yxo
         9p5MsC70idHcVej79GamUqn88AS4j7BFe7LRUJhVkRb/IBAojcCVj8bvKXdhgdtCSKX2
         F9Wkqu7hW9XH00JYAiKAoYZi/vUJVgcR/u1CtP/CoqjcJGETBIvDwqQk///tYHDZxxPd
         d20m0rL+Kxf7GObaeLdR9xBsgVEazWag5E88TtaxnhiSvMaPIHEcyO9couaLjptxKoY4
         ji0Q==
X-Gm-Message-State: APjAAAU77XiFJBHBe7NIzl2AgC6z6Flc8Iyu6iLdSGo+ATWMHsfBr3El
        dSqRLx3CwG0Pcyyxuy3QsSA=
X-Google-Smtp-Source: APXvYqzm+BH7xQRpT+4ezKyy3jdxNDHBrI0ptlr0nsU0f5AZPXTwXFCEtdwxbp5e6xwz8i9BWOTuyw==
X-Received: by 2002:a5e:924d:: with SMTP id z13mr24840346iop.247.1564563503597;
        Wed, 31 Jul 2019 01:58:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:285:8200:4089:3dd3:8aa0:5345:aaa3])
        by smtp.gmail.com with ESMTPSA id a7sm54226200iok.19.2019.07.31.01.58.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 01:58:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
To:     Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <C9405E2A-4A0B-4EFD-B432-C54D2C9CFC2B@fb.com>
From:   William Kucharski <kucharsk@gmail.com>
Message-ID: <dc8d71ca-cbec-b924-386f-678ce528aff6@gmail.com>
Date:   Wed, 31 Jul 2019 02:58:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C9405E2A-4A0B-4EFD-B432-C54D2C9CFC2B@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/31/19 2:35 AM, Song Liu wrote:

> Could you please explain how to test/try this? Would it automatically map
> all executables to THPs?

Until there is filesystem support you can't actually try this, though I have 
tested it through some hacks during development and am also working on some 
other methods to be able to test this before large page filesystem read support 
is in place.

The end goal is that if enabled, when a fault occurs for an RO executable where 
the faulting address lies within a vma properly aligned/sized for the fault to 
be satisfied by mapping a THP, and the kernel can allocate a THP, the fault WILL 
be satisfied by mapping the THP.

It's not expected that all executables nor even all pages of all executables 
would be THP-mapped, just those executables and ranges where alignment and size 
permit. Future optimizations may include fine-tuning these checks to try to 
better determine whether an application would actually benefit from THP mapping.

 From some quick and dirty experiments I performed, I've seen that there are a 
surprising number of applications that may end up with THP-mapped pages, 
including Perl, Chrome and Firefox.

However I don't yet know what the actual vs. theoretical benefits would be.

     -- Bill
