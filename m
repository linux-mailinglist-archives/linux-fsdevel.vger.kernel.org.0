Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722794A7993
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiBBUgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 15:36:15 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:41770 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBBUgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:36:15 -0500
Received: by mail-pj1-f51.google.com with SMTP id p12-20020a17090a2d8c00b001b833dec394so752096pjd.0;
        Wed, 02 Feb 2022 12:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YapDcpTnt0pNDjwnCsaJppc8fMq8nOcDVHLmni897fw=;
        b=g9lYHjxQBVB7bnaMaVlekVDr0pcIYnEQh3OGRhtJi8dDg0g8eDsbB4y50X6/6tAXCJ
         kslRVHYhvcasAapZvICVKRIim7lhwB305sdvqY4Q1QoqcssKhUhx8Z2pH3Z+0MVhCd3r
         VkdEhwLRMrmMgWlAouXB9rUX4kJDLrSwn1l1vZadKo0KBNdojqGz9C7Hy8ss2GrzJVdz
         ur2ULMTjJpLWCPAYNrxfWdrAk46e5735SOQXFdxH7BjqMiMJl0j+misTRPSA78z3sDOp
         aDbj3rMQsdaA7vSX8IpME1ddjnheypM+PiBQ/8cDMy6spI4qVjX2ktNIVgCWRgPwHM69
         ORLg==
X-Gm-Message-State: AOAM533RUZR1+y323ePw8KvSdRyLDnASSDZJKKuxHrqzHqqfk8ET8474
        JyOsC30MjXzvkvrFAve0t1M=
X-Google-Smtp-Source: ABdhPJztFTw+1Ka+LWZeLE261k/YPdwwB0CS/Ml4N47khvlZQwg7VL3liHHIL4Gj83KwOOgizn59Kg==
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr10008445pjb.33.1643834174683;
        Wed, 02 Feb 2022 12:36:14 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f9sm34311732pgf.94.2022.02.02.12.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 12:36:14 -0800 (PST)
Message-ID: <4de2c701-6a83-cf7f-69ba-36a921997180@acm.org>
Date:   Wed, 2 Feb 2022 12:36:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220201013329.ofxhm4qingvddqhu@garbanzo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/22 17:33, Luis Chamberlain wrote:
> It would seem we keep tacking on things with ioctls for the block
> layer and filesystems. Even for new trendy things like io_uring [0].
> For a few years I have found this odd, and have slowly started
> asking folks why we don't consider alternatives like a generic
> netlink family. I've at least been told that this is desirable
> but no one has worked on it. *If* we do want this I think we just
> not only need to commit to do this, but also provide a target. LSFMM
> seems like a good place to do this.

Do we need a new netlink family for this purpose? The RDMA subsystem 
uses netlink since considerable time for configuration purposes instead 
of ioctls, sysfs or configfs. The user space tool 'rdma' supports that 
interface. That tool is used by e.g. blktests to configure the soft-RoCE 
and soft-iWARP interfaces.

See also rdma(8), available at e.g. 
https://man7.org/linux/man-pages/man8/rdma.8.html.

Bart.
