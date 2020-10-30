Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA52A0DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgJ3Sqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgJ3Sq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:46:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4722C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 11:46:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k6so8581722ior.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKR3nSyjdOhRFeCLOasGmXfLUPItd6VT/MZ6kYlzlTI=;
        b=ws87XD6GkkTF54VE/BqitpkVccv5nuUdtr1a4OWKvH3izPR1Dlnm8Vdllij2bllowW
         s0ntfmIP4ghwFzRWMAo18OFqKKxqjd15SpmEJXH9txb6m27Kb2eF8D5sWMlWUEzpwKgx
         oZzOQnASHz/BVD+6xNxDsBPssUrsnkrC90T0MDAXk1SNYBmMtmF1V7qgkeGC1d/1s+h1
         Iytr+wISlR254q72Q8F5ur+VPUq9T9CnmviNcY++AnKjXEpSV3vkcgFN+7KmbToRsc7W
         kjqvP+IcJoIuVDImTMuUUNxX0t2ZNlwbruQEEE/mk+R2Vt9u9tibJD9i3klGsFesGJjo
         JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKR3nSyjdOhRFeCLOasGmXfLUPItd6VT/MZ6kYlzlTI=;
        b=GblOuCaabtcq0kpS5UujBhwMlc2sONTGnlAmIW0mOOe78ZdhUTGDuSUtT+7bjllbuO
         SubHbb4L7QO63rwI/aJvfrXy1Q8XACUcd4R9/s7Bf6/tVVrrXYkd8/OpvjWkVCPwdFq7
         k7nsb/yCmRrzjBrak7O4nSwqW5m5Ligh/W8b5iWqzzyBbCHobst+qiDhqjvDJfLZJYF4
         4B3clX/xqyn8IEXNvEA3SEyKSaPym0+TcegMY9xLIepxDv2/lNuuY7klRJGj2kchOV36
         lYp7e5HTUlRblhs1xaVWAO03Lvt4frqwrom4MRLtvTFxh5qL2V/R+Q/EXWStK5up2taC
         e07Q==
X-Gm-Message-State: AOAM531DWfe0ZflDE/cjJEpBVgX5T/UW6c2WsTpZrV3Lwrmp5LHRTM4U
        Msbve0pvtSKCWj1g4kI9eSlacRGd6OvDzg==
X-Google-Smtp-Source: ABdhPJzPFbRkZgb5bbf+bDEq874LE5nnjojpANWw5M3akdwtJptMRqmVA6N5+ffeaQFVo6f0M85H9A==
X-Received: by 2002:a02:ba13:: with SMTP id z19mr3094188jan.122.1604083588943;
        Fri, 30 Oct 2020 11:46:28 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c1sm5687324ile.0.2020.10.30.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 11:46:28 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
Date:   Fri, 30 Oct 2020 12:46:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030184255.GP3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 12:42 PM, Al Viro wrote:
> On Fri, Oct 30, 2020 at 11:24:07AM -0400, Qian Cai wrote:
>> We will need to call putname() before do_renameat2() returning -EINVAL
>> to avoid memory leaks.
>>
>> Fixes: 3c5499fa56f5 ("fs: make do_renameat2() take struct filename")
>> Signed-off-by: Qian Cai <cai@redhat.com>
> 
> May I ask where has the original commit been posted for review?  And why
> the bleeding hell does io_uring touch rename-related codepaths in the
> first place?

See other reply, it's being posted soon, just haven't gotten there yet
and it wasn't ready.

It's a prep patch so we can call do_renameat2 and pass in a filename
instead. The intent is not to have any functional changes in that prep
patch. But once we can pass in filenames instead of user pointers, it's
usable from io_uring.

I'll post this as soon as I get around to it, it's been on the back
burner for the last month or so.

-- 
Jens Axboe

