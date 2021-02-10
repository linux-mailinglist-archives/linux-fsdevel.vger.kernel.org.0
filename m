Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E03168FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 15:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBJOUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 09:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhBJOU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:20:29 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69EC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 06:19:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a25so3076817ljn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Feb 2021 06:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STanyo0VxqectlsIzMPDjmIhDAwFO8ShwKQAZIMHAJ8=;
        b=JJVIO8cTw0DZ7TaBIt9ZD/qu+pTbwmSPSxu3ZJtHq1HYVFkYlnvumMMA6oQOCsCnxy
         DBWFDzx8MQqA1M1aqWSA2E94JTTCiXpkqFB/z+J6GMfHWF9rQQlyzwSjmBvp9fQGi06T
         3DfnG8GC8iCIuKLidmGvDyhrs9Fz9AHI/eAeUzpKFcsMJ5POyJT5tudlakqmdm30sBuZ
         TVfg5KqdzEozPxuVerAvCYuvBE0RUf9XzhSkm+oNX86BRPdXpNDprDI9dutzfQK1pILf
         hjDMhaGqKnI2Njmb1uT9fhTQ2kLt3Y49uNlsDdeBzeiOKYuE/ixIjrIvIj6jJKhVqJU9
         +njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STanyo0VxqectlsIzMPDjmIhDAwFO8ShwKQAZIMHAJ8=;
        b=nrg5bEyr543YMza1j8SIva+iVJEatH8FvC72xepaVwMRpo4Zt3Fc6y1QmyI1WfnQT+
         ZV4Rg5Nny3oaMTkdCXLGthBA4TWnXAfklJ22IvYjUHUZjTDp6g+j15vnyJZRm4Fqwv9x
         bv8ziDmj5CBPWwLQ+FzdCX+J8gIgxaBVgdgi9KE/IH7TLYtAXcICdDB7OAGyuO1yMtn4
         yekmi3mYKZin29gusDv9iBPG+7k6XprzKEOeTSVPsABcPr9wEjDCPC8galIZBJSJyKq1
         AVjF2iV5epsfaoemh10UDlUj6Z5wTCoYvqWlSLA2oN3UNL1gL3eAY9c3waFCyhJndkpg
         BEfA==
X-Gm-Message-State: AOAM531+gmj0Of1ReJYw4kpJ+Q7AkXgPJDrmvmeG8dPckTLyShzW1SuU
        Ewoy3JHbQ8LvxFh+DRdXCSQ9mwNnfi/aET8nPto+Iw==
X-Google-Smtp-Source: ABdhPJxMnEHrTizG5GfHfjzb+C5dLVyw57d8HYLUk3hc88l0K4uvHzlXl2BcBR+I9W7Kk6l3XwqVEzjhJe/BNkWaUmM=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr2227628ljj.122.1612966786152;
 Wed, 10 Feb 2021 06:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-3-shy828301@gmail.com>
In-Reply-To: <20210209174646.1310591-3-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Feb 2021 06:19:35 -0800
Message-ID: <CALvZod4s4_AJPxjPo+okq3XuvXa45eXTAeJOHgu3rwGVBw-Oww@mail.gmail.com>
Subject: Re: [v7 PATCH 02/12] mm: vmscan: consolidate shrinker_maps handling code
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
>
> The shrinker map management is not purely memcg specific, it is at the intersection
> between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> and the only memcg bit is the map is being stored in a memcg structure.  So move the
> shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> and remove the "memcg_" prefix.  There is no functional change.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
