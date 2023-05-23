Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54670E523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjEWTMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 15:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbjEWTMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 15:12:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3AA91;
        Tue, 23 May 2023 12:12:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so134212b3a.0;
        Tue, 23 May 2023 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684869154; x=1687461154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDHOuli6LQC21PVL1jIVJHkKd4nR+BXbovWUBQJSo5E=;
        b=nnt2ZPVfDdLgMsE9DXatFeQI53mTIFlO7r2+Zrd8elz107npuksySY3Ik1QMx5QeNX
         HuOBQsQNrA/4wYyDJaFh9NPUg8lo6sK8UdVOIgh+yku9tcUmeqEKa1bmSLkHCTZpNAtZ
         phaeSMPxMN6d+QDQDOK5pKidVFhjxa9v8JZl8GD2g18uY+eHydQG8lOel3kyJgBZ2CuN
         xouiWeZ9l9EroDXJDxzAli1p9aGcoARKs2ChHGPIQKpLGakbEcGpuWxumVEiUfOrzOai
         PFDoRS2Y0B6VOAwv/BIKMqp47OYcP++4oJc4kvO3xaJx4T5OdMssVkhoz1Hwoer8UTyA
         uzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684869154; x=1687461154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDHOuli6LQC21PVL1jIVJHkKd4nR+BXbovWUBQJSo5E=;
        b=hRAd/cXMa+GHJlQCQiWGE6lpe+5zKktB5KEA3KMml7a2lnBANqvGYOnDy463WLjqff
         athMrzjAgYqlE251/XomK5F0or8hwKmmERxfHqTHtGy8mTDT/qV2ZohAa4/RCwPGAwN0
         xGC6XkxvDun9+eUTkstqQ6W/TLHUWjRpGK7QCuVZxkN4Ui5/iDEJK5ZyGz/3M8trVLSJ
         BMbHe9TRFH+fB/0uLJTKPVb8CH6CR/JDz/WmHgnHMN7hMGCH7d648gl72BHxZlMx32ZP
         SVM4C7BJ/icOjxw1zuyRQ4DS9Cd5vkzVDkzkivG7DG+fBa2WBwWxe4qw2kely62KcCLm
         LnDg==
X-Gm-Message-State: AC+VfDzq+XkK5HhB4FaxMiFj/sSBHGEQJJTvTDF+yMZA/NYSAPZRGoub
        NsjvzFc6mbvA3A8+TQyK8yY=
X-Google-Smtp-Source: ACHHUZ5MioFk87y9tahP+5F0UfZ0Z5nT1k2lXSVKi3g9FB/0Hr97Jo8X1g94AfYyFrspRxMk9j3cIA==
X-Received: by 2002:a05:6a00:2d87:b0:64d:fd0:dd1a with SMTP id fb7-20020a056a002d8700b0064d0fd0dd1amr79254pfb.16.1684869153506;
        Tue, 23 May 2023 12:12:33 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0063b89300347sm6279088pfo.142.2023.05.23.12.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:12:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 09:12:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 2/3] cgroup: Rely on namespace_sem in
 current_cgns_cgroup_from_root explicitly
Message-ID: <ZG0QH7gvKNFj0n34@slm.duckdns.org>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-3-mkoutny@suse.com>
 <20230523-radar-gleich-781fd4006057@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-radar-gleich-781fd4006057@brauner>
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

On Tue, May 23, 2023 at 12:42:46PM +0200, Christian Brauner wrote:
...
> Nope, we're not putting namespace_sem in a header. The code it protects
> is massively sensitive and it interacts with mount_lock and other locks.
> This stays private to fs/namespace.c as far as I'm concerned.

Michal, would it make sense to add a separate locking in cgroup.c? It'll add
a bit more overhead but not massively so and we should be able to get
similar gain without entangling with namespace locking.

Thanks.

-- 
tejun
