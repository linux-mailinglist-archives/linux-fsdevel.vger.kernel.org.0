Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13C72DCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjFMIlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbjFMIkn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:40:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BF119AE;
        Tue, 13 Jun 2023 01:40:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3d29cfb17so15852625ad.3;
        Tue, 13 Jun 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686645629; x=1689237629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uuddb9c9VUE9xG/wODQy6qGOGm/KkteE8GYq9MCwRAo=;
        b=hHVs3qPi0Aq8cI3ZELcon2W8/5mlGpERDvjit7DNkZJGLihmbAwJbkACfzIIgkxIpc
         j4vFdsP/WWW0wIJd/+64pTHuEO5ZVFDRuI3Ji6gM8fK45NJlH0e7e/arPF6r2r2akpsM
         +P2AQH9buFVjbPQZ+tH8SrQvxbwlEmqMjiKsi3b2c61QcoDyZqrxyk3f27/fjkKTuQeH
         oJykroMIDIs7GXAhup68spefTPKSnD3abb/0MnqQMjKiiJpTM6AyYrvCdFBlKCBeyInX
         hAmGy+znv8erLXrRjh7AGDf7f3c0YH8bWp8o24v/AElZnau34Ib2Vq14+f23at78jucW
         sshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645629; x=1689237629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uuddb9c9VUE9xG/wODQy6qGOGm/KkteE8GYq9MCwRAo=;
        b=hNvSXvSjcfvqFGfnv+69AdyuoUzw1pouOFvZQmVYptdk6b2x4mAz3cu9nMuD73+xv3
         E1E/TgCLK6/yasmvb7RrkzHLpiKbFJZObj+ceVp7b9M87UC+t36g/Ln1EFxxI8HSY9Sr
         xmqosnV4w+DGNdu8JScWVMxXCZ53S+IRb02f8G10fUK17Nh2YMtHWGMI+OfIoA1A9rMf
         trdOitz0FSyRngdP1aljTkSIfyPw6dRyWaeMPoGBeSLfpFF4jITiEABtr1cXy/gBB8F4
         4fn39BJ4k1YWlp2Ht5LLB5HbH4zlCw3OF7Wt6xnEptR6oewhcxDziioLIb5zDZ8LVmmo
         BbAw==
X-Gm-Message-State: AC+VfDxby6lBz5hEV/PMz2eva4L60hiX4eiUwCZa4Xt24J2cLC1uMKNY
        fh56xOz2qgcvaHmKkmba8hA=
X-Google-Smtp-Source: ACHHUZ6QLjaq87VUQOeMerJ4xeq4L9fRl6+tzkvzr9yyN/61YJ9iz8+q0PqfsCt/f8g2UDEsLRUlOA==
X-Received: by 2002:a17:903:1105:b0:1b3:f572:397f with SMTP id n5-20020a170903110500b001b3f572397fmr389922plh.34.1686645629045;
        Tue, 13 Jun 2023 01:40:29 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b01448ba72sm9528439plf.215.2023.06.13.01.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:40:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 22:40:32 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "pilgrimtao@gmail.com" <pilgrimtao@gmail.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Message-ID: <ZIgrgGQQ-tYEQJFr@slm.duckdns.org>
References: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz>
 <66F9BB37-3BE1-4B0F-8DE1-97085AF4BED2@didiglobal.com>
 <ZFkEqhAs7FELUO3a@dhcp22.suse.cz>
 <CAJD7tkaw_7vYACsyzAtY9L0ZVC0B=XJEWgG=Ad_dOtL_pBDDvQ@mail.gmail.com>
 <ZIgodGWoC/R07eak@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIgodGWoC/R07eak@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Jun 13, 2023 at 10:27:32AM +0200, Michal Hocko wrote:
> On the other hand I can see a need to customizable OOM victim selection
> functionality. We've been through that discussion on several other
> occasions and the best thing we could come up with was to allow to plug
> BPF into the victim selection process and allow to bypass the system
> default method. No code has ever materialized from those discussions
> though. Maybe this is the time to revive that idea again?

Yeah, my 5 cent - trying to define a rigid interface for something complex
and flexible is a fool's errand.

Johannes knows a lot better than me but we (meta) are handling most OOMs
with oomd which gives more than sufficient policy flexibility. That said,
handling OOMs in userspace requires wholesale configuration changes (e.g.
working IO isolation) and being able to steer kernel OOM kills can be useful
for many folks. I haven't thought too much about it but the problem seems
pretty well fit for offloading policy decisions to a BPF program.

Thanks.

-- 
tejun
