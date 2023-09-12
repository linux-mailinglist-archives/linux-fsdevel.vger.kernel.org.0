Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09F579C7B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjILHIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 03:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjILHIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0137310C9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694502441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngjRwCUGtVn49b+a10bSdDhEKYC91j/r4ziY766Fz/Q=;
        b=Nn9RSlhVkEALsKNCenPuDiXw3qsIg2bbqpoI9zgr/rBCURM+6HCc+q+EupkmN8zRTgskLw
        FcAa4kJDrCLn/eLeKVwAq3qhU9r78I3GlVJftZlN3kcR2PUnuAP+PKFfoDwC8EhTmdZkXx
        AffZtgeCvbg4dOBZT3i4OBzr6AqeAqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-oc-pJtARO4SFKWThOD_YbQ-1; Tue, 12 Sep 2023 03:07:20 -0400
X-MC-Unique: oc-pJtARO4SFKWThOD_YbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4011f56165eso25347895e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502439; x=1695107239;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngjRwCUGtVn49b+a10bSdDhEKYC91j/r4ziY766Fz/Q=;
        b=OtpvESSaAMCvlrZKx5GlMBJHqdpNhGo1+goyeP37CidmT4/pvkdjwAW+EwV2KuuR/T
         RldWeH7508ywfI+6lMgeOtM7iSY16fk4B3VtY5lFAOy0hRPn/zvIFmSfkqNAy3giTP2v
         agdoqQQHGazXyepG8ux6QYrVNXYVKcmL731nLoaL1AsHRiMzWC3pktLk+scZrrbtXFQ/
         17k4IHEv/q5zm7/1erQbNbbh9tPD+YX17lbtstgCgdhPeKLZRiaBT2B+rhd4GAqPHhQ+
         rtIz7sH8gBalVPCVsxElT7CvRIGO0YKwVgR8Diy63V9vmgRCrJHDVciTrV1/kHIIr9QH
         +dQQ==
X-Gm-Message-State: AOJu0Yyd2UDqsxDyP130T8Qec1+3An54nE7R0BTXaYm+WHYntH/X4we2
        OTMaMD7aXxec2MORNQ6kvkAbvwBim8rsQkjSCAWQKxRQZR0mQiFh0f7pDh93eEiCr78uJoSPP3C
        2QSPaFtHRsXoDOmVhrM38FCbU6IDx7WZe/Q==
X-Received: by 2002:a05:600c:1f0f:b0:401:c717:ec6d with SMTP id bd15-20020a05600c1f0f00b00401c717ec6dmr1119947wmb.15.1694502439221;
        Tue, 12 Sep 2023 00:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5qayMUu6hFKKGXK/Y1sZoWl+xVPxZf7W2vplC+a6aJOLDOuM5ZiotTuLG/f2Sp2tx3YPNWQ==
X-Received: by 2002:a05:600c:1f0f:b0:401:c717:ec6d with SMTP id bd15-20020a05600c1f0f00b00401c717ec6dmr1119929wmb.15.1694502438860;
        Tue, 12 Sep 2023 00:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b00401d6c0505csm12028140wmr.47.2023.09.12.00.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:07:18 -0700 (PDT)
Message-ID: <550ec927-2de4-39e4-2df6-423be22c2161@redhat.com>
Date:   Tue, 12 Sep 2023 09:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [linus:master] [proc/ksm] 8b47933544:
 kernel-selftests.proc.proc-empty-vm.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Stefan Roesch <shr@devkernel.io>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel@vger.kernel.org
References: <202309121427.f3542933-oliver.sang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202309121427.f3542933-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.09.23 09:02, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.proc.proc-empty-vm.fail" on:
> 
> commit: 8b47933544a68a62a9c4e35f8d8a6d2a2c935823 ("proc/ksm: add ksm stats to /proc/pid/smaps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

https://lkml.kernel.org/r/725e041f-e9df-4f3d-b267-d4cd2774a78d@p183

-- 
Cheers,

David / dhildenb

