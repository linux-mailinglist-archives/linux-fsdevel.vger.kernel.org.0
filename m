Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EEF1F3831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgFIKhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgFIKhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:37:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139B2C05BD1E;
        Tue,  9 Jun 2020 03:37:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so1226600pjs.3;
        Tue, 09 Jun 2020 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=50KfskdRn64Hc1/lSl8hTGQPAB6Anp68wAajsIMysbk=;
        b=N8yRfI3QLCXPUF2rD/bRYJEM+Mh17WVxAzkN9J6sENYz4rZ1DgqPRxQdWfx0clPQ0E
         0OdkIHJIrHWTidgGAUePIhQN9gshC4ZlccHVr/ha0SVY0wfVXZszdyS7OLVVBgWvx7S4
         sdyi1qrbKtxurlQKRKserA3VnQZhpq11IwKHmcYWdTbBFECHyuYRZ0Vw2q6sk16LcFMb
         2fa73W2wGQVGweEBI18m0KGT6qipMysQ8avwlQlSAiKPy1xfrOwtpY6VwWdxr3jBRKD5
         SuEr65t/9p2U4Mplfe5ZdFffIVniBzYED99XENuY2wETeHLmo6A1TjUb9+o9kDYDC/uA
         EhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=50KfskdRn64Hc1/lSl8hTGQPAB6Anp68wAajsIMysbk=;
        b=gtxsi78qfHRbmNslXmHTyVO3yruuiAhKRXoq6+wUi4xOvfV8/HVkrWdUDEA6oiEqzt
         QCE7w1Vv0Vsbvy9tHWNArwfqxdJak9srtMotKSa7zBpuXr7WUugLJjADTQM6z7KdN2KD
         XEuFExl3rYVLXoq065jzaXDdHKbiyc2m8/qAkFssZZOMPMU4EHGoCV/8miRp1K3sWUae
         FZOu4OAAYJ8JfRWTGYxlEoU52bkQRZ88s6haktibP/A5JkHOdMWPOYSDnKSZjROVpAGZ
         fzMPD98T/aSbp7azfnfIpLuKlDc/SK0TsyHqlpTE+v4HZngQ7Ii7FXCSfmKiMNMcb46k
         wgsA==
X-Gm-Message-State: AOAM531MT7dCorNG+L7XOBZ0f2upKaIhfh0SeZ/zYA5/qmJLM8aoTnHk
        5pt0XNVfO+jT+I1RguXn5oi3xA0M
X-Google-Smtp-Source: ABdhPJxcGvVpDoZ5vTEidDhY3bM1eiX3cgin3LoExbype/8h0KCFNr+CRNByYU/bBIhWp4MH9ijD1w==
X-Received: by 2002:a17:902:7088:: with SMTP id z8mr2597419plk.71.1591699066167;
        Tue, 09 Jun 2020 03:37:46 -0700 (PDT)
Received: from localhost.localdomain ([124.123.82.91])
        by smtp.gmail.com with ESMTPSA id n4sm2273258pjt.48.2020.06.09.03.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:37:45 -0700 (PDT)
Subject: Re: [PATCHv5 3/5] ext4: mballoc: Introduce pcpu seqcnt for freeing PA
 to improve ENOSPC handling
To:     Borislav Petkov <bp@alien8.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1589955723.git.riteshh@linux.ibm.com>
 <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
 <CGME20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b@eucas1p2.samsung.com>
 <aa4f7629-02ff-e49b-e9c0-5ef4a1deee90@samsung.com>
 <2940d744-3f6f-d0b5-ad8d-e80128c495d0@gmail.com>
 <20200609102015.GA7696@zn.tnic>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <69a26eb8-e439-6574-6f46-e557d6c852d5@gmail.com>
Date:   Tue, 9 Jun 2020 16:07:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609102015.GA7696@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/9/20 3:50 PM, Borislav Petkov wrote:
> On Wed, Jun 03, 2020 at 03:40:16PM +0530, Ritesh Harjani wrote:
>> Yes, this is being discussed in the community.
>> I have submitted a patch which should help fix this warning msg.
>> Feel free to give this a try on your setup.
>>
>> https://marc.info/?l=linux-ext4&m=159110574414645&w=2
> 
> I just triggered the same thing here too. Looking at your fix and not
> even pretending to know what's going on with that percpu sequence
> counting, I can't help but wonder why do you wanna do:
> 
> 	seq = *raw_cpu_ptr(&discard_pa_seq);
> 
> instead of simply doing:
> 
> 	seq = this_cpu_read(discard_pa_seq);
> 

That's correct. Thanks for pointing that out.
I guess in my development version of code I had seq as a u64 pointer
variable which later I had changed to u64 variable but I guess I
continued using pcpu ptr APIs for that.

Let me re-submit that patch with your Suggested-by tag and corresponding
changes.

-riteshh
