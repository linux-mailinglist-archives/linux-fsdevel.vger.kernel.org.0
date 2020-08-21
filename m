Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD424D806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgHUPIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:08:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E8C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:08:21 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r13so1686508iln.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cATovcDF6EIIZdeZ6DTsdMSJEoMk6qL5T5u7Q6ei1rg=;
        b=jP8jPmAII5A/BaqiPZZXBQ/0nb55IKsHNPaIJCOCI9t3wpmalgbB3xtv+ZoD/sHlfF
         P+2P1a6l/tNo3CGG6rHSJOb2IyuNmPFeHlVWbqMcSNj1CfYxBRCcIrHXmxjgYLGee9X+
         U8S1nzS4XZPZ/BE4wN0ErVYadwOoNpmLpOool5rbLR3DdGUsHEPU4tGcNEpum1JuZxOz
         m+02WpKlWQtfgjk6LTzXRBBSat40NNh3PIKAvsnsTHx+V6B91HpRAinkxOylKxG+3bCN
         anLuNaN4N8xemHqYfRg4R+bxjkc6kGr5zSL4J420RagQmWnaJQ9IPgk4EFIg6Qw4I3lE
         eM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cATovcDF6EIIZdeZ6DTsdMSJEoMk6qL5T5u7Q6ei1rg=;
        b=T/l5TlbMQEqJ+qDGRY8YSGezh/F7b124IAvWgokWQsoKelyKctW9AZb6MlwQ5+jvUB
         Mk/xU0UwKyi5WQFCSnjC3MqP9gKWnoHyI72zU4Wj11OLiRRiJrgrZ7Ww6E9A/wdthauX
         AFVoGnSYttJVsQny8e6E/tZUtijpFAyNGQyEp0sVLGx6vz4HVfnM+jMC0pCCaR/ureuB
         daN7K54ttK3XWy6oUMnQk27v5KT5JaZ3XeX2w/62GauFOL6vipYzYrXSaeymS6hkLBgd
         0VH+8uPCAMvGs2wNXRLCHFEg8wKvaqeCKW6YpV2IEkWa4qs0jLww9j/JC9gQoy7aMNdM
         bB/A==
X-Gm-Message-State: AOAM533+v2PXHXM5k71DzI+tiLU1Z3mTUOhj/EFyzh2misjKj5SmAiuZ
        xyI16ZFMFQAlSPBeZ6NT/4cc1w==
X-Google-Smtp-Source: ABdhPJz7MRRaC85bkv/XmtISHRlp+BhEJvWp0fMl+7/CE/SMYUH37t/Cy8RTJG/mux9jGrmgdXSbsw==
X-Received: by 2002:a05:6e02:1352:: with SMTP id k18mr2826675ilr.276.1598022499002;
        Fri, 21 Aug 2020 08:08:19 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 187sm1388945ile.52.2020.08.21.08.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:08:18 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
 <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
 <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b55ca3d-cca5-50ae-4085-5a1866f77308@kernel.dk>
Date:   Fri, 21 Aug 2020 09:08:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821150405.GA4137@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 9:04 AM, Dan Schatzberg wrote:
> On Thu, Aug 20, 2020 at 10:06:44AM -0700, Shakeel Butt wrote:
>> On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>>>
>>> Much of the discussion about this has died down. There's been a
>>> concern raised that we could generalize infrastructure across loop,
>>> md, etc. This may be possible, in the future, but it isn't clear to me
>>> how this would look like. I'm inclined to fix the existing issue with
>>> loop devices now (this is a problem we hit at FB) and address
>>> consolidation with other cases if and when those need to be addressed.
>>>
>>
>> What's the status of this series?
> 
> Thanks for reminding me about this. I haven't got any further
> feedback. I'll bug Jens to take a look and see if he has any concerns
> and if not send a rebased version.

No immediate concerns, I think rebasing and sending one against the
current tree is probably a good idea. Then we can hopefully get it
queued up for 5.10.

-- 
Jens Axboe

