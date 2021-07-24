Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D754B3D4382
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhGWXRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhGWXRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:17:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A75C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 16:57:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso5870793pjs.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zYO9jI96skhwqdG4nkEO20r+wSQP58qy0XBzRXVg6w=;
        b=kK5AsqAxdrzIIjCnebsiRu0vohUqYHqBCc/kIX1hYjC59MheX7ijzJrpVaDhrZyT8u
         yDZjiH9lp2XgLqeTlFu4cVbIUuMOsew0UHYZ2UNatTVWfNPOGx7BFzvHaw8iHzfO7AKt
         r8hsg15xYbYTJN2W1ohEvtfXtNxtWY83usOyhBRnYWA5L8gD4YIGuCTAYY5w7kXSnXjD
         Vk9yi+z1nTTzIXIv+ub/P5S/ezBLz3MXn3Gi1AXiR8w3eBm1rWe2v/omvbFm0kvsr3WP
         axvNU1XoxCwrWMbBiM+sKTjI+/74EPS/M/R+pAZeWDyhOwrdjmAmwfmfklTT4oBNuO0P
         uzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zYO9jI96skhwqdG4nkEO20r+wSQP58qy0XBzRXVg6w=;
        b=UMIEwFVBxoTOFzQ4mHrW/SAwKgrfrbc1msBMPXOTY7RVI8dShDApRzPg9Yqal3NtUt
         XGX4xHOiQralrl/Btve0l1RuvwOH4rSvusW0IwJil5bxp2Q2+Ryffaf/iVRqwXGTsoAW
         M6KBvXWXwzAzZds6Btn9cBI018sxyLXk3CEdmFmLdNSMr//9wTMU+yeGgMndE1GfcwvQ
         A2X1nfM7dPaIeKLeWl9zLtfQ72IZcEdITAOYET0DyuwEFpJoYXSlnOdbUKdPCODJBPAt
         4NUAqQ+k9UJRDPevv6BKW/118NmSlQ7LB+GdqlT7OFd2wFbdaEVzqV3c4NvNt+OmOtqp
         A8jQ==
X-Gm-Message-State: AOAM530qJx6UJy4wocbfXjMHl1lKFkD2WJTZyDrB39HwvrDLxoPOBMTB
        +CYeV2jtP7XqZVwGTJZItx/wfA==
X-Google-Smtp-Source: ABdhPJwap0a9tUogqxNE9/e7HvCqQXf5NjJbvhj179cnjPCSvtpsc46JRRH9H1bm+KpW3YIqwnsJxg==
X-Received: by 2002:a05:6a00:2:b029:32e:3ef0:770a with SMTP id h2-20020a056a000002b029032e3ef0770amr6925482pfk.8.1627084664210;
        Fri, 23 Jul 2021 16:57:44 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id k37sm9788143pgm.84.2021.07.23.16.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 16:57:42 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: refactor io_sq_offload_create()
To:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YPn/m56w86xAlbIm@zeniv-ca.linux.org.uk>
 <a85df247-137f-721c-6056-a5c340eed90e@kernel.dk>
 <YPoI+GYrgZgWN/dW@zeniv-ca.linux.org.uk>
 <8fb39022-ba21-2c1f-3df5-29be002014d8@kernel.dk>
 <YPr4OaHv0iv0KTOc@zeniv-ca.linux.org.uk>
 <c09589ed-4ae9-c3c5-ec91-ba28b8f01424@kernel.dk>
 <591b4a1e-606a-898c-7470-b5a1be621047@kernel.dk>
 <640bdb4e-f4d9-a5b8-5b7f-5265b39c8044@kernel.dk>
 <YPsR2FgShiiYA2do@zeniv-ca.linux.org.uk>
 <YPskZS1uLctRWz/f@zeniv-ca.linux.org.uk>
 <YPtUiLg7n8I+dpCT@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e43a1f88-67ae-284b-81b3-60d990263b14@kernel.dk>
Date:   Fri, 23 Jul 2021 17:57:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPtUiLg7n8I+dpCT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/23/21 5:45 PM, Matthew Wilcox wrote:
> On Fri, Jul 23, 2021 at 08:19:49PM +0000, Al Viro wrote:
>> To elaborate: ->release() instance may not assume anything about current->mm,
>> or assume anything about current, for that matter.  It is entirely possible
>> to arrange its execution in context of a process that is not yours and had not
>> consent to doing that.  In particular, it's a hard bug to have _any_ visible
>> effects depending upon the memory mappings, memory contents or the contents of
>> descriptor table of the process in question.
> 
> Hmm.  Could we add a poison_current() function?  Something like ...
> 
> static inline void call_release(struct file *file, struct inode *inode)
> {
> 	void *tmp = poison_current();
> 	if (file->f_op->release)
> 		file->f_op->release(inode, file);
> 	restore_current(tmp);
> }
> 
> Should be straightforward for asm-generic/current.h and for x86 too.
> Probably have to disable preemption?  Maybe interrupts too?  Not sure
> what's kept in current these days that an interrupt handler might
> rely on being able to access temporarily.

->release() would probably be unhappy with preempt and/or interrupts
disabled for a lot of legit cases...

-- 
Jens Axboe

