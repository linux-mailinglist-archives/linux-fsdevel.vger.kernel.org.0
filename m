Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A536F888C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjEESRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEESRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:17:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550F13867;
        Fri,  5 May 2023 11:17:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so728448b3a.2;
        Fri, 05 May 2023 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683310632; x=1685902632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQHYPlEOPVX2QdptzuBIqeiKD9YF9ynx2rWgtCguSI8=;
        b=GATLJaLXKGT4UkAZCszdVSnAxGdXekLCDA78/LXvLjMCrf0gMpGYAkPJRHrMm0efTx
         2AM0YfRkyInaP8G4IZNRe8myyYOaXG5+TuMqRchxZEwR9sTQCmwEF4avYnvLkXRb0lXu
         ZshUyzcCLOseMwGIi5mw2rXGsskJBuqqTZRnN6UkR7zZub+q9aiBuh3FpMqLNkZUP7KI
         BTdvqQlkE1CsXOaAfreOSuXojjPs3gqE52ZkWkmQuFz8wYaw1ctggUDUAoX3BGqn+nzM
         IFKIvUYSxV1GPI2RQJ0y+DCJy+DHy7Y/zHqZ2b9RsvjJufRA8dGuYr0hlB18YDukodzy
         N2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683310632; x=1685902632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQHYPlEOPVX2QdptzuBIqeiKD9YF9ynx2rWgtCguSI8=;
        b=Y8WQ6uIupl/GCdeFck/mdveFQtwiDNAYNpagkw5IPkE5fDuGM1xiwwFpAj6r8amBBh
         rz3hiFOm6iUGJFv7HYEqkf7nFu244avmRjknWgjlc61KX0yRFcDQRCMImN6tZisMZn/c
         Q6eVtg17VZTQQ77C/hNR9JnuD+0SdEV24AFYbPuACBnypJJ+mbuSLX+5ca7vEjGs6xqP
         3VnPTEnXWpTm9le73ADYkIK3WXsfvg67J+jjMeK9etHyuCMPbXcMXorhXXVH0hC3+3Xk
         YsggXim18XIamEVxEYwECBfA1fD6mREJ58DJodgWP2QTVSyrm1Z4CGjMvZB4mydbKUMr
         i8Fw==
X-Gm-Message-State: AC+VfDxJ5Qx1e7OAkQJmGKT6QJ8IOpg4XSJVOoMUkMkB+OplybKDqBin
        USMca4BH18sepYfzFSBGtks=
X-Google-Smtp-Source: ACHHUZ7QKd0LACqSPErWFC498KThy/cj79nXPyY5L/RHExPh/Le5xmdhFDDNN/T5EkzTJQvPbKOtNw==
X-Received: by 2002:a05:6a20:d687:b0:ef:a696:993a with SMTP id it7-20020a056a20d68700b000efa696993amr2541812pzb.22.1683310632188;
        Fri, 05 May 2023 11:17:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7854e000000b0063b6cccd5dfsm1912910pfn.195.2023.05.05.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 11:17:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 08:17:10 -1000
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
Message-ID: <ZFVIJlAMyzTh3QTP@slm.duckdns.org>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
 <ZFUktg4Yxa30jRBX@slm.duckdns.org>
 <ta7bilcvc7lzt5tvs44y5wxqt6i3gdmvzwcr5h2vxhjhshmivk@3mecui76fxvy>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ta7bilcvc7lzt5tvs44y5wxqt6i3gdmvzwcr5h2vxhjhshmivk@3mecui76fxvy>
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

On Fri, May 05, 2023 at 07:32:40PM +0200, Michal Koutný wrote:
> On Fri, May 05, 2023 at 05:45:58AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > There are three relevant nodes for each cgroupfs entry:
> > > 
> > >         R ... cgroup hierarchy root
> > >         M ... mount root
> > >         C ... reader's cgroup NS root
> > > 
> > > mountinfo is supposed to show path from C to M.
> > 
> > At least for cgroup2, the path from C to M isn't gonna change once NS is
> > established, right?
> 
> Right. Although, the argument about M (when C above M or when C and M in
> different subtrees) implicitly relies on the namespace_sem.

I don't follow. Can you please elaborate a bit more?

Thanks.

-- 
tejun
