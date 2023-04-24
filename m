Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5983A6ED35B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjDXRRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjDXRRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:17:14 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFD10E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 10:17:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f0a2f8216fso209341cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682356631; x=1684948631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0eRdTeN7jkM57vYYN0vPrAxj3a6rnjVZ2S7PSMzkMk=;
        b=7NKiu1IiwRRKF1fJQNyjBd8av5/cqtJU9MwybHOmeJ+dADdvaJ+DHco65RXZQcn7X0
         6JM1kMAWRWTmsRwLfIIpTIne4JD5RbLum/t9IInggIEJOXFzqJ5Btg3SH2BQ/iEayg49
         khUC9L54LBJse/JTK1luGsjzv3ex8pX8qi8Z9b/yuXuX7MbPT6jx7vYp1Q5wyLKe8V/3
         9wmskz5xZmaPS3BGEJsZbf5OTzsPTkI3qyOfEJcLpS6d3lzg8PXdje6yMaIi/eb8BipH
         oZWUdcwrxh54KXDhvz4VCshlClgQWMJHDSkB0sM3NQJzWIV52NuydPQUr9SBJnA4lWmz
         MLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356631; x=1684948631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0eRdTeN7jkM57vYYN0vPrAxj3a6rnjVZ2S7PSMzkMk=;
        b=DaqSLCo1q1E6gL0v2+3uw/ze+ooIKhbD8RSXuGqNhdFGA+BwvNCUq6krJnVEgjFqtH
         q8uJ7erdULKay3x+uHfgOxobS3LHHExWBJCRDmrc2of0d8KA2lw1vzx+pDhRVNsck0SW
         TAYev1j5Otng2FgPx8MohCp8bwPG83mhWu4XHIxrkVTW1Uym6nR5z0wFTx5Eexwk6OLO
         /kgX/qjvzOrhRYFtY+5MYObZ2yR0JIB7H9tcCSshNa7vAbZFnNwabNJR+LTwlaGjTTQJ
         wbavuZGksZReYhWvzCudb+/7yVHETgqfu02LOE4wMz9XWFJGOwL3vJuSzV6NA0utR0gz
         di9w==
X-Gm-Message-State: AAQBX9flktqXm5b50E5iAPqq7lC6kMCKN5rJKIYRxhwBnXGgvlO597gC
        qjM/m0tMMlgDQvQgJhugO1KZPquym/uAC4nYp3sodg==
X-Google-Smtp-Source: AKy350YtgyMieYjr0JvEnoJpmA/ps+11jar/nzBzxWKr51AeAPA8Y30sdbhN2GD3wvfyiHUpCqNYIzx9HSDTJyE3NRk=
X-Received: by 2002:ac8:5795:0:b0:3ef:3510:7c3a with SMTP id
 v21-20020ac85795000000b003ef35107c3amr693672qta.3.1682356631715; Mon, 24 Apr
 2023 10:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com> <20230421174020.2994750-6-yosryahmed@google.com>
In-Reply-To: <20230421174020.2994750-6-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Apr 2023 10:17:01 -0700
Message-ID: <CALvZod4Ci1RamjLEk7e9zVnqSuEVKPEWjDUAwy6TWaU+X1WeVQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] cgroup: remove cgroup_rstat_flush_atomic()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Previous patches removed the only caller of cgroup_rstat_flush_atomic().
> Remove the function and simplify the code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
