Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE5172C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 00:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgB0Xtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 18:49:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41216 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbgB0Xtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:49:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so684299pfa.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 15:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=voq4AFbGLoJaLwILK78n9USNIr2B9fMN776ggMuIHko=;
        b=BzdLtYFZmrbXcvLmMVD95jbyfyAzEY2NDoGBqjx7UWbhXwZfjoPtFIPx7oeWZspHu7
         mYEBjwLCg1jkXqIoOjobTJfzaocFvkLmPU3tu68hswiSJwtu3sIQBfw+mNwdeqXC0WfP
         1dc0d6QTEA08H3F0ZfHJERF/S1V9ZRyDtOc2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=voq4AFbGLoJaLwILK78n9USNIr2B9fMN776ggMuIHko=;
        b=AiGbWHY6sL14dkOCOM2rxm+CVRE0SR3VietyoimjvuVvX/4UNlFoPwnKlmxCjXGE2V
         DBun9RdI+pLEDcMswqAOLgrVEAlBwfrtzQLXUQ0SFnGAJMdEeyvbBG8H9ckVtau1E3Ub
         xcb3FX0AEh3g3X9kN0M0dphSsgHGjX1eoCtsp87t4JlRv9PsnG2ptBjVBCR5GDma4lg3
         zZwpMF2dyuZt8U8+P73o+ysFogLErTck3u0IXOOllrFfoNPcmAUcU/Gs4fWtJPqk127P
         199JaNRDeHAV3p5a2UARkS/GOk2sWQLUxSpEoxNUz4ZpCVx9MS5SM0GHGPSKvmQ6gTE8
         +HhA==
X-Gm-Message-State: APjAAAVWU5XE5FqiylNTOtOY6w3S75wcn8SBpRbIEn1FVsWOjEJbJj7J
        pJRE76EV6CAVQcI8iyJp02r7eA==
X-Google-Smtp-Source: APXvYqyOBtvgI5OkeymySdZKA1Mb7B0bYOanuRrwvcdmZeaG5Nea8oS2U7Hne4aCta6YoGOs31zJ8g==
X-Received: by 2002:a63:ed16:: with SMTP id d22mr1867585pgi.314.1582847381191;
        Thu, 27 Feb 2020 15:49:41 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x190sm8640465pfb.96.2020.02.27.15.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 15:49:40 -0800 (PST)
Subject: Re: [PATCH] exec: remove comparision of variable i_size of type
 loff_t against SIZE_MAX
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200227233133.10383-1-scott.branden@broadcom.com>
 <20200227234055.GF23230@ZenIV.linux.org.uk>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <588cad53-0099-b95a-d228-f2523774956a@broadcom.com>
Date:   Thu, 27 Feb 2020 15:49:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227234055.GF23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-02-27 3:40 p.m., Al Viro wrote:
> On Thu, Feb 27, 2020 at 03:31:33PM -0800, Scott Branden wrote:
>> Remove comparision of (i_size > SIZE_MAX).
>> i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).
> include/linux/types.h:46:typedef __kernel_loff_t                loff_t;
> include/uapi/asm-generic/posix_types.h:88:typedef long long     __kernel_loff_t;
>
> And boxen with size_t smaller than long long do exist.  Anything
> 32bit will qualify.  Pick any such and check that yourself...
Thanks for the immediate responses.  I'm glad I sent this patch out to 
understand the check is as such.
Is there some attribute we can add so such issues are not reported 
against static analysis tools such as coverity?
