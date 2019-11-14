Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23C7FC858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNOEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 09:04:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfKNOEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:04:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so6622746wrw.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQjXK1xogbloLUUveAtiXJL2wRqsXqxhQH4eYaiG//w=;
        b=Y3lvURg+EM1dEiklPp0ACVG0UqABNIl62Pql3E8NviRdAqCJiiWuHbEf17Qp6pQ6wS
         WPIEAa0pf83gUbX0nsvb7BH/35RjAWc4WzkmZTRtrIwspMm5D7IlukRg8JE1mC/Z11b1
         WQRmKTAwu4tfCmAUpMZDSzhh0Q2ajpXPg47XjahqpCfw6M+YlFGVLtfmykMZYcv0IAjw
         s9qWi8z1jdK3LZG+tzqAviaF4faNwUXjfqHfUV3GYmo6CY+SOal7hcpEPRi5RYDMyJ+g
         Ev418B+BPQaJBTBhXZ8q4i6diu3uMLEDgFy4OnkBibLE1dwe8+1zEju4KyXE1yEEBB+6
         rRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lQjXK1xogbloLUUveAtiXJL2wRqsXqxhQH4eYaiG//w=;
        b=ivi5Af887Ywvz/8Ac8yBGnow7Adh+iCvqyYeF2JIC29N0C7Hwl+CSz1TWbgEVzCTEy
         ip0HK8Scdb2i3zJhqbqixG7oAo2yLdqnBdMWGNC9fRTPv0lqNQUdJ+NeesxUsXdVG8wt
         5vSRPYeqanbrFl3J7O7d3TWBNjq9LUJHFHXoI+snDzG32llCRMXaVTlGr5MtpmSKDusB
         zfKcBaovDBepndUJHBXzUJ2tk/YSLyZ87gmbdi4pmHpnbRm54L8b4S2SUDycyW4PoC5d
         c44cePc9KL41HYPid5Px03Ve0pYjC1JBuCy//ZqLXJCx+jgxPcdrnHY3To3r2OD24w0n
         TVvA==
X-Gm-Message-State: APjAAAWF2JocS7JDZ0z4wfHQFbDBtdXrG6T7BX3ZjObtuePioy7TIFp/
        UM18n33NJFRlGlnnreo++MbzpFlq
X-Google-Smtp-Source: APXvYqwdbdyhrQUOwvm29Ht1tyD/2cryqiJMNG0D6ckIaDZu6rQbRNP5X9NLiF39/XwGpUuCx1xgBQ==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr8014290wrr.162.1573740269139;
        Thu, 14 Nov 2019 06:04:29 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id f24sm6051409wmb.37.2019.11.14.06.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:04:28 -0800 (PST)
Subject: Re: [PATCH 11/16] zuf: Write/Read implementation
To:     Matthew Wilcox <willy@infradead.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>,
        "boaz@plexistor.com" <boaz@plexistor.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "Manole, Sagi" <Sagi.Manole@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <20190926020725.19601-12-boazh@netapp.com>
 <db90d73233484d251755c5a0cb7ee570b3fc9d19.camel@netapp.com>
 <20191029201521.GC17669@bombadil.infradead.org>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <2d296e08-d393-7578-ce32-1efc39788c2e@gmail.com>
Date:   Thu, 14 Nov 2019 16:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029201521.GC17669@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/10/2019 22:15, Matthew Wilcox wrote:
> On Tue, Oct 29, 2019 at 08:08:16PM +0000, Schumaker, Anna wrote:
>>> +       return size ?: ret;
>>
>> It looks like you're returning "ret" if the ternary evaluates to false, but it's not clear to
>> me what is returned if it evaluates to true. It's possible it's okay, but I just don't know
>> enough about how ternaries work in this case.
> 
> It's an unloved, unwnted GNU extension.  See
> https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html
> 
> It's really no better than writing:
> 
> 	return size ? size : ret;
> 
> or even better:
> 
> 	if (size)
> 		return size;
> 	return ret;
> 

OK Cool thanks will do
Boaz
