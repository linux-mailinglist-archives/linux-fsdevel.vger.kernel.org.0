Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89A1E5B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgE1Ij5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgE1Ij4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 04:39:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169FC08C5C3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 01:39:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p18so451838eds.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XDdmB/aDu7vmw0I5lDV1Q4+gB4BypwighQ3lORBH3wc=;
        b=CAf+Dz0VmWC9ztDzhIYSQC5YVbiHg299UsxRcMebMK3XVuQcskr9cr//obYizUBr+R
         SKVtD55+vPtxiw53ri8K5USs5DFmuFlSazeRgHvcrAmaaeDFhJ+uUJtwxZQnq+7B6oyM
         zWNmnMPBYfdRFb5U/GUekJn3HfUFhIrm4XixJSRFtA4ymOC7zXxK8WJ1BHqFmaae6lXT
         5Us1elbOj6TDt69XYXExD6KadgdBL4mBFR+6Aa96MYHUMH84S/tkiyI5vphWCawc22pK
         pe1eEI8Hp4dBVsvnANDTySVLCVBzOApuuVA4YBL8FRi/ElxKqW5yqqKIUBMAI6Szc5cX
         vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XDdmB/aDu7vmw0I5lDV1Q4+gB4BypwighQ3lORBH3wc=;
        b=f3lVfr46gUo7UfEJGiu9hSioOUwQJU9eTqbkNRTQOOr43gcgj1bWYTIP8f7Za55kzr
         sTMWrVhnWN2sW29VKP6kC6HpBoeyFs7sW3Pl6AuRLL3WfNHhqc9MW3GzTDvJAquusO0o
         WSIFuG32pLRpZY+rUQ1sD5kCMWLDoFWkSZd05vnrPvDzhbmDv/OyQonB+SKNgnv5x4xX
         rwSBCMNQKXBbmHHqmuWOB5tVU3LEobRhoay5ijQhrKrY+lSeWmvb6aB8fXsAFiqjYjmw
         oTfwAEItMi51qXdx3wxP1lDhJr9k4jpUbhjzT+Mt07NQaxdWZFzRIpokj2niPB0grFhW
         GraQ==
X-Gm-Message-State: AOAM530EpCYHWLJugLqBmjIwIt5S4WjtD8nziTV9PaOwejBOygLCTEy4
        UbRIIOxV3YgYRJqQWvJU6g8zJw==
X-Google-Smtp-Source: ABdhPJzvS0PuIZ3CoJAyjzLsVMlgK6IFKiAxLwcj9LsbX/47TMdsJOcP881ALFfWIKg9AldDIGqiIA==
X-Received: by 2002:a50:d715:: with SMTP id t21mr1892086edi.194.1590655191533;
        Thu, 28 May 2020 01:39:51 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4811:7000:e80e:f5df:f780:7d57? ([2001:16b8:4811:7000:e80e:f5df:f780:7d57])
        by smtp.gmail.com with ESMTPSA id r9sm4367835edg.13.2020.05.28.01.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 01:39:50 -0700 (PDT)
Subject: Re: [PATCH 08/10] orangefs: use attach/detach_page_private
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
 <20200517214718.468-9-guoqing.jiang@cloud.ionos.com>
 <CAOg9mSQ+nGCD-k2OwWWd6Ze_PAh3mhSOwYcLugD-SQHCb0ymWw@mail.gmail.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <bd3495e7-1820-6268-1a5a-76f54421fb16@cloud.ionos.com>
Date:   Thu, 28 May 2020 10:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOg9mSQ+nGCD-k2OwWWd6Ze_PAh3mhSOwYcLugD-SQHCb0ymWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/20 11:54 PM, Mike Marshall wrote:
> I apologize for not mentioning that I ran this patch set
> through orangefs xfstests at 5.7 rc5 with no problems
> or regressions.

Glad to hear that, thanks for your effort.

Thanks,
Guoqing
