Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42498EC4E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 15:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKAOns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 10:43:48 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35761 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAOnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:43:47 -0400
Received: by mail-il1-f193.google.com with SMTP id p8so8899517ilp.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2019 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qo1YkX5K53htT1v846eBmxvfTkH+lDKypx0tZHv9K/k=;
        b=F1mV5T+e7alskaz/TMQCqlbDe7C9X5eyBcADwQfnOGKvJoerMwk5hl8yMg5U7mHNv8
         2TZI4RMSQrIcKNqaT7Z+njAo4+vetJGRGDD12jstSf0mdfumCEuTvWLEvsp/v9KkajD/
         NUAh0seO4qPSwzyctxmdNtOM6ft+8DlPYOMcWCfWRNIqkEBdFTv258Qh5TuqlRl6IH0q
         ItGzf3QO2l+aCWiaIN8WKMuBONptYxpNU2/eOikY9yjddSxyP6IQiz4MB1+eGHKD5S/y
         RPiHxjW2UfYU3e2E46XNiRWDfou45mNveSVLcs0UTk0MAUiSssB5u5+vyJ7CBsYE1vJ5
         2Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qo1YkX5K53htT1v846eBmxvfTkH+lDKypx0tZHv9K/k=;
        b=glU2CT1SqM6nDaxTnjTHbZh8fiE2ACq27rKA6aEYx/wM1qffBDO2WBCTz02H51pkOG
         OYp/+DIw7hHhX03l5d4ShgHTYTgyWJAUXWjefijxpnbF0tkkPTjOCvGWUU1QRzigsbx/
         MKafa5MQfN7RwIW89Uia0iJ7sudiU5UpaflG2W7piZRMR6Kj7ZA/ZZT+T7B0QwpFpaP3
         M9OshNoVylIF3lzUI8pTTvVHPraRM4wbENR+MvAaibcaUoG1S06dcVzv9n0HRWWw1zcb
         fFCTPDPWb8qI7BMAVkGNkdYLoQv/wf17jt6vCIGvar9EFG2CMNwJeyRvNPJBLQMcwREF
         ho6Q==
X-Gm-Message-State: APjAAAXXqOfyW9RmrLAOpDuI6dzaZPfDAyYKv9L2Ir4fpO5LWYT1TJm8
        9MpBXau+YcP1SXgfsXPXGgc2pg==
X-Google-Smtp-Source: APXvYqypoGx2owUeN4bTKCioAqMyCDKZuIoXDSee7i++vVR9rVQPdFB2uPEXTfVYmg8yTLuqksRWIA==
X-Received: by 2002:a92:af99:: with SMTP id v25mr13239884ill.167.1572619427173;
        Fri, 01 Nov 2019 07:43:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o10sm695606iob.29.2019.11.01.07.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:43:46 -0700 (PDT)
Subject: Re: [PATCH v4] loop: fix no-unmap write-zeroes request behavior
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
References: <20191031032948.GA15212@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e7b4eed-58fb-a788-f17d-83b582b28184@kernel.dk>
Date:   Fri, 1 Nov 2019 08:43:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031032948.GA15212@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/19 9:29 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Currently, if the loop device receives a WRITE_ZEROES request, it asks
> the underlying filesystem to punch out the range.  This behavior is
> correct if unmapping is allowed.  However, a NOUNMAP request means that
> the caller doesn't want us to free the storage backing the range, so
> punching out the range is incorrect behavior.
> 
> To satisfy a NOUNMAP | WRITE_ZEROES request, loop should ask the
> underlying filesystem to FALLOC_FL_ZERO_RANGE, which is (according to
> the fallocate documentation) required to ensure that the entire range is
> backed by real storage, which suffices for our purposes.

Applied, thanks Darrick.

-- 
Jens Axboe

