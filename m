Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF526F8619
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjEEPqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjEEPqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 11:46:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D541490D;
        Fri,  5 May 2023 08:46:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so1431854a91.3;
        Fri, 05 May 2023 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683301560; x=1685893560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeJDF4qNyObb/6dnFVDbh66VJOaqj9OlNV5gVoC6Lw0=;
        b=ebChKD9JPNufACPPpce7Y36WdoKdtJnEgc472nYmg+3STxvplm1sSK2Xx8kf83TcqL
         BX1o46mJB9gs4k9aj9vd8GvU6FG8zcgR+80Q7iHHHzt5sSoCQxrha8ZWrAVqiGYh9kwj
         jRksz39E3pzbBJ5N2IDtOTzNvK2K/RKWSxhWND9eNT+dFhw7pRclnkyE8WeBjGW1h20k
         Soz/FUBG8C0R4v+N9JsPibT1rsEK6yyTIxOOIagO9CXo40nRo4WXSHDczqSAIKqr/lIc
         k5vhf5ImNmDMCRXfs8M/V9qzMJxpq4KH8r9EwqBZ/+zM9ZTjGXdj32TRVawJM7uQUCD8
         l/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683301560; x=1685893560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeJDF4qNyObb/6dnFVDbh66VJOaqj9OlNV5gVoC6Lw0=;
        b=DNdtjZxrQdKLF73G/LnK4bpbAS0Qnmz1loUUk1sFa3ybkHk8JljVI2UFqv7fvSh3Us
         1owpc5Gm3ESBarAdDmHYHvQ60lGXGpCIioMh9DSvKA5v0xBkGAtLbEcPYfsVDDUalmzs
         Y36fnBYZztIz7GAHZtbAzgqAXeb+qs3gCY8Ol5UAxd2sunIXezpw+X55UbOwe4mmwtDz
         m0ZLP3nAFhLQEkGg+yOPn05z+Ny+uJB6EJe0z14t3t35csqUuogH7OLGhNXF3lfiK8DK
         suByD4uVIiFYJk+2n5IMJWCwO3EZT5JLFNH63R5R8Kty0t46JS1S57xg7OWutJuZ8I15
         HtmQ==
X-Gm-Message-State: AC+VfDx8F42hYM8H7Wb7gvUhfOGYlJgXEAzq2kcm844zI3APLKFeeMsw
        PNsXX6ur/YEZx8O3lUpSCck=
X-Google-Smtp-Source: ACHHUZ7M2wd6LkEFeDGvz3O5vsG8s4it92wRRoKH04Hgq6XGzWSlObPg43+1PTuNxpYTkjmKJyq69g==
X-Received: by 2002:a17:90a:d498:b0:24e:10b3:c9cc with SMTP id s24-20020a17090ad49800b0024e10b3c9ccmr1992324pju.14.1683301560335;
        Fri, 05 May 2023 08:46:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ja18-20020a170902efd200b001a64c4023aesm1966839plb.36.2023.05.05.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:45:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 05:45:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in
 cgroup_show_path
Message-ID: <ZFUktg4Yxa30jRBX@slm.duckdns.org>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502133847.14570-4-mkoutny@suse.com>
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

On Tue, May 02, 2023 at 03:38:47PM +0200, Michal Koutný wrote:
> /proc/$pid/mountinfo may accumulate lots of entries (causing frequent
> re-reads of whole file) or lots cgroupfs entries alone.
> The cgroupfs entries rendered with cgroup_show_path() may increase/be
> subject of css_set_lock contention causing further slowdown -- not only
> mountinfo rendering but any other css_set_lock user.
> 
> We leverage the fact that mountinfo reading happens with namespace_sem
> taken and hierarchy roots thus cannot be freed concurrently.
> 
> There are three relevant nodes for each cgroupfs entry:
> 
>         R ... cgroup hierarchy root
>         M ... mount root
>         C ... reader's cgroup NS root
> 
> mountinfo is supposed to show path from C to M.

At least for cgroup2, the path from C to M isn't gonna change once NS is
established, right? Nothing can be moved or renamed while the NS root is
there. If so, can't we just cache the formatted path and return the same
thing without any locking? The proposed changes seem a bit too brittle to
me.

Thanks.

-- 
tejun
