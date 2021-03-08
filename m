Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD333086C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhCHGt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhCHGtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:49:23 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD12C06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Mar 2021 22:49:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id e7so19346662lft.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Mar 2021 22:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoC8QNlvTR8++BIKTNy/5o3MzhxCe5WO+3UpJfEpK6c=;
        b=LGL8vyV10hWlr4AyKOFUhQb+foDReKdTXstB87PngQ/jmO1URKyMs5x5mPH6Glxxwi
         OhtezJgG5daQPD776QholBRx01BRhXwkd45SpxvtQP2Je+aquHxwr0rF1Euk8JnaT6oD
         lk8Jr/hTZQXXS3VAUsPy1Q+3oTbjSaSfG7rHWXgYob5wGa2e4seMDNlApIUHDbrq7OGh
         lkYFxTxe6QFp4WlRiOkkOV1Xbi0N4ZsGTfPu7Vie0rJ7JJ3jVibkF0H81k1CewVGhIRz
         cLKR8xFauyk+yQwHcRx5HcLegtdH+fVviAATzWl9fEqcMOAh1OLcc00BDy2QNjb2prd7
         4mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoC8QNlvTR8++BIKTNy/5o3MzhxCe5WO+3UpJfEpK6c=;
        b=q7UFMbnyfR+JjCVlKQWicnBIe6qoyN5BfXoiPE8C/E/Vr5SZoWgVTMW4znBhIKoWpm
         SLm0T6Uaw89YBkQA7eYuQofEU22ebjzIDZaxorrz5TadL/KBbsER4rdxc65xg/Diqh9N
         CTVuGE7y8qgBcmyxwMWau4Z+gfgmL9i99DWWC4D8RmpsFBi/HDGzknIxXhMvS/P5z9ME
         KFbwoOWsjfHjCo7d4vjZjfMQJccdMUwngotx6YqkaPdWYKNu/h4TEvo+/1JClFGqJuUp
         yUyHxH03GJ6iiH8RDF9VlmRF32WR8F7cEBd7f8ZrXsniUfUjlYcIuchQxRywk0rD59hz
         /1Ew==
X-Gm-Message-State: AOAM531o+Y+w9oA6HfSEHznrAogIRmus/KOCDoF5OSzKYAQURXKlB5b4
        84677tcusJIwFmvRkJIt+B3XFxEvRVDIpHkZk99CAA==
X-Google-Smtp-Source: ABdhPJwrFCP3Kf8tAv8sF2qsw0T7P32CghJc78SV62DPfTmDQGwTdXaQMAJEUDcQ0xLaRxGCHZPg76M8GxxY1dYAQwo=
X-Received: by 2002:a19:c14a:: with SMTP id r71mr13425508lff.358.1615186160205;
 Sun, 07 Mar 2021 22:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-5-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-5-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:49:06 -0800
Message-ID: <CALvZod6OMES8fE_EOFb8TR1rU3wObBb=CWvwqWs_Z46o1vnrKw@mail.gmail.com>
Subject: Re: [v8 PATCH 04/13] mm: vmscan: remove memcg_shrinker_map_size
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

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
> map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
> Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
> bit map.
>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
