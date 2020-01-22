Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274D314587C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVPMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 10:12:55 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:44229 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVPMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:12:54 -0500
Received: by mail-io1-f47.google.com with SMTP id e7so2290391iof.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rdkEhUHMXVV4uMlw6eSjH7IdEMBOKL36dN/RS3uVdVw=;
        b=0BiBfmf/zzqW+wrXuf0+LW17/QUqOfDpfTA7tHCn2W0DFE8rOP5jQczViPkU3FU84f
         /QOPrE273+e78m+9iWgWWrwMTDMClNtGcIwZBklILgTI0ZOM11lUb+6SoGXDN/1VvxTX
         UHQ6NKQl6B8o4K2CN45TJhUoTxkZHs80ajEguUsIVCtLv8itUD0O6dx8YB/0eJaAvJMC
         /iwawKEfoms3tMtQ5Aj6t0UIAyHp61PJJbPwWBxENWpFt9s5uIm4CJ4eC09y8zI/3HVZ
         lyUJb4SKY+wvSpBfJ2hcBIPKIxBG1OaEu2nbnNaRjAk5Dt4vy6KpIWYkwrL0lX5CB5/N
         UHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rdkEhUHMXVV4uMlw6eSjH7IdEMBOKL36dN/RS3uVdVw=;
        b=QbIw9uaWi6oJSRG1hpoCsI+S6UB9FTSEQMIOH9gaacINIINJHn3JJ28dab8Z+swGXW
         uZZjT7Xe4KS2ALaqlW/gMuJbVYb8jOKRaFu0SIDWEYe03gq0mVff401/E88uEILlW6cM
         Uhd6gpctGo9UHB/eB+TuUZ3nmw6yJyxDDXxheqim45brYNC3q6J0na7TNtIUJqXDHhKZ
         KeKzerv9vj9Helobb0M3U5Uniz7mIk5oJ9kLblBWgbfASWuOdZpTqI670baX+6ZBNqac
         2EanGbtz/BvzlW79lEC2AS6M01LbMooRDNGeG8yQGg+ZwL3INKqRh3Oky3N1H9NcY5AL
         BLWw==
X-Gm-Message-State: APjAAAViTfpyhw2ew/iWq7TbTJn6rq20JeGr7EvmtE0XAbU7nn6vGlGF
        sq7u9utHBm10wjRqGNTZOJVF9Q==
X-Google-Smtp-Source: APXvYqxVmB1KS10FdBSJoV91Nr0VcOYKOZim6vIUbNnIFWnKsjB7OdIJ9GOshLGPoK3wn713Gy1UAA==
X-Received: by 2002:a6b:e90b:: with SMTP id u11mr7028106iof.14.1579705974024;
        Wed, 22 Jan 2020 07:12:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t16sm14462195ilh.75.2020.01.22.07.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 07:12:53 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
To:     Michal Hocko <mhocko@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
 <20200122045723.GC76712@redhat.com> <20200122115926.GW29276@dhcp22.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <015647b0-360c-c9ac-ac20-405ae0ec4512@kernel.dk>
Date:   Wed, 22 Jan 2020 08:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122115926.GW29276@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/20 4:59 AM, Michal Hocko wrote:
> On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
>> We can also discuss what kind of knobs we want to expose so that
>> people can decide to choose the tradeof themself (ie from i want low
>> latency io-uring and i don't care wether mm can not do its business; to
>> i want mm to never be impeded in its business and i accept the extra
>> latency burst i might face in io operations).
> 
> I do not think it is a good idea to make this configurable. How can
> people sensibly choose between the two without deep understanding of
> internals?

Fully agree, we can't just punt this to a knob and call it good, that's
a typical fallacy of core changes. And there is only one mode for
io_uring, and that's consistent low latency. If this change introduces
weird reclaim, compaction or migration latencies, then that's a
non-starter as far as I'm concerned.

And what do those two settings even mean? I don't even know, and a user
sure as hell doesn't either.

io_uring pins two types of pages - registered buffers, these are used
for actual IO, and the rings themselves. The rings are not used for IO,
just used to communicate between the application and the kernel.

-- 
Jens Axboe

