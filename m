Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7373EDC95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhHPRtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 13:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhHPRtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629136159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plJNW7Y67eXvnax8oo8FvgYyj0Iw4c1g2Thy+LmnVB4=;
        b=IVWtlu5NVqaHmoEvbNQ2sRc2Y/7IIXo9aDuZveJo7vlg+rVj3wFmZvowcISMNV5+nHKhJB
        7oZz9YyAXC/7mfpp0MYCVaPeDvFlMFY4pjp+cVXq0v1aG5Py7JaivMu6Yx+AE66Og6sFT4
        A8fZ5GMoQB+/+ANUrU7cVqW3D28wR4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-6zSW5F_mOfaVGKsyRDAv_A-1; Mon, 16 Aug 2021 13:49:17 -0400
X-MC-Unique: 6zSW5F_mOfaVGKsyRDAv_A-1
Received: by mail-wm1-f69.google.com with SMTP id m13-20020a7bcf2d000000b002e6cd9941a9so1529wmg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 10:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=plJNW7Y67eXvnax8oo8FvgYyj0Iw4c1g2Thy+LmnVB4=;
        b=K9MpTiI8aLatEW11cX5jMQbofu5T7yJnMEI3Tw+J5xzRFdD2QE2e/yuMHOHmXib69w
         mZ8dJA5v8dnCP0pu2SqHTFEjQZIQETNeS0RIUYnK3FIQ2qD2DzP1L8/7Gjoh4n+DkyOJ
         okrd/zy3PxbFT7qjUkcv3FlId7nZvSsGumW2R89nWuLjTY+G4E0HqsVNR3SiJkOtmLAp
         Rix3T/eODuZhliCYgOBglMZHrL8G+W7Opm3vAx7KYBUBG9xcX+MOrTutMw93Qx4hlUcC
         gPE67qHtksuaW6JyMsGiUswEd52vFX5lya9u4OznIOF0orGVJT///9T9OLGm5LU0CiDk
         jj5w==
X-Gm-Message-State: AOAM531Qg/LIUD22zhd7uAKp0ViGnCVc3VYUoeUEYJWNdCnSFYkzNBSb
        G570H1UZLUPQzdF8QtR8p8nSbuedcuSwxhTgvWzRGC6fI1nCYGl4McuMH9tyruia9MOCHy9vdlo
        vQ8IrX+mEkbRhQ3ZoOFxuwuqMIKcDNshmNRQ6uX7pMQW+1zPmUHv1A6+ZqVFaorEoG+/+LJzj7A
        ==
X-Received: by 2002:a5d:4852:: with SMTP id n18mr19855639wrs.10.1629136156691;
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGGjFxu2Sr4hF+9rlDSFKl2PRwrlX7LDhBhekAWq72hyPIIxvsoLI+OzsZA9j8gnxfP8E0Pg==
X-Received: by 2002:a5d:4852:: with SMTP id n18mr19855622wrs.10.1629136156447;
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id l2sm11417288wrx.2.2021.08.16.10.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
To:     Jiri Olsa <jolsa@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YRqhqz35tm3hA9CG@krava>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
Date:   Mon, 16 Aug 2021 19:49:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRqhqz35tm3hA9CG@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.08.21 19:34, Jiri Olsa wrote:
> hi,
> I'm getting fault below when running:
> 
> 	# cat /proc/kallsyms | grep ksys_read
> 	ffffffff8136d580 T ksys_read
> 	# objdump -d --start-address=0xffffffff8136d580 --stop-address=0xffffffff8136d590 /proc/kcore
> 
> 	/proc/kcore:     file format elf64-x86-64
> 
> 	Segmentation fault
> 
> any idea? config is attached

Just tried with a different config on 5.14.0-rc6+

[root@localhost ~]# cat /proc/kallsyms | grep ksys_read
ffffffff8927a800 T ksys_readahead
ffffffff89333660 T ksys_read

[root@localhost ~]# objdump -d --start-address=0xffffffff89333660 
--stop-address=0xffffffff89333670

a.out:     file format elf64-x86-64



The kern_addr_valid(start) seems to fault in your case, which is weird, 
because it merely walks the page tables. But it seems to complain about 
a non-canonical address 0xf887ffcbff000

Can you post your QEMU cmdline? Did you test this on other kernel versions?

Thanks!

-- 
Thanks,

David / dhildenb

