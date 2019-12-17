Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738231232B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfLQQmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 11:42:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38235 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQQl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:41:59 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so11746678ioj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ch4pT9eAXuOnt9aCH34myvOKU14iVJ51Ia+nfld+XYo=;
        b=1YyNrajDUI2YIJxfCBALtwSAK2gvsMNAuP0i91YlCmUz62ouZ6WF1tT0fHhFeP/6Ja
         EHZRByZL6AsLF/yq7ZXwddBIxpOtC834HnFFkhzOIjYLlj44wlN+t+zxwxW7uK1NWN6X
         EP8j+6iX9riGl8ah/2GW3uiI5Xo+n51YlZ9VhoJp5FV3NPliTgjfmJ9VUN+0qr6I+Ho+
         YDcLmboVyDfRbYuvkgX8u9opGEQnwa8kyVxmmJyKXJq5H15fJiXxU0wiDyKZ8F2o3BAP
         adbhsTtK31AwYA+23QClWWweac1izfxeW2Ls+kOpiOQz3ScW5Su3tycEnWNzSWjmzan2
         mwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ch4pT9eAXuOnt9aCH34myvOKU14iVJ51Ia+nfld+XYo=;
        b=heDASkxfQXCzB6yxRQCo7dJ/oN86Upp08q5g9m7q9rL2WH2+gFY9PYggAD/vkfk7aR
         uTuINr58yoZu4MC432zcMZaTJ/CArIIYEI//oEHWREHEeEhsqNBvN0qHP1zN0Eh0F8ts
         QrBTSdAsNbdNHeuaWDYhFSrDebUqlE2yXyOj1jvdv6U9e91C6XOpQIeFWMUbh9CnQczv
         /wF4uXS8R6TXtlXgp8gi9etI+Ysr0oVoG1gY7IoB2Qmim6Z07WFwzys7wfD1tI7MrQ7a
         +XgGctrHOWx8spfJKPs7iXLp0k1A7exFslQ3KqtwU7FdujTkJxCsjGZi7SjKB68doqfD
         14cQ==
X-Gm-Message-State: APjAAAVoc0i/00brpRaRb+zOYaFWSoKHDSUk6Fe1lhvLzwubvgbhO5iy
        jK3jCCjDSTK6DuVj7yW/8shriQ==
X-Google-Smtp-Source: APXvYqxh5lsU9Ndk/BeMGn/zyvX+NgyYy2mh8ckeftTI6DIJt9pRgxZcg+f8Hepjj4yJa16wHgtlKA==
X-Received: by 2002:a5d:9a17:: with SMTP id s23mr4524073iol.293.1576600918943;
        Tue, 17 Dec 2019 08:41:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s64sm6948214ili.56.2019.12.17.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:41:58 -0800 (PST)
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
 <20191217155749.GC32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65992df0-1ccf-a51a-9ae0-43a0c268b1f4@kernel.dk>
Date:   Tue, 17 Dec 2019 09:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217155749.GC32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/19 8:57 AM, Matthew Wilcox wrote:
> On Tue, Dec 17, 2019 at 07:39:43AM -0700, Jens Axboe wrote:
>> +static void buffered_put_page(struct page *page, bool clear_mapping)
>> +{
>> +	if (clear_mapping)
>> +		page->mapping = NULL;
>> +	put_page(page);
>> +}
> 
> I'm not a huge fan of the variable name 'clear_mapping'.  It describes
> what it does rather than why it does it.  So maybe 'drop_immediate'?
> Or 'uncached'?

I do like 'uncached' a lot better, I've made that change.

> I think this needs to be:
> 
> 				if (!did_dio_begin)
> 					inode_dio_begin(inode);
> 				did_dio_begin = true;
> 
> otherwise inode->i_dio_count is going to be increased once per uncached
> page.  Do you have a test in your test-suite that does I/O to more than
> one page at a time?

Good catch! Yes it does, I have fixed that up. Thanks.

-- 
Jens Axboe

