Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243226869B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBAPOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 10:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAPOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:14:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8104C23120
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 07:13:58 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v17so7294848qto.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lXpoIfaZTxbS2QRN9RfCIEN9vyUFx7ZzXfKlV5Axnk=;
        b=iYXpIQVaHQlPkpAMqJXgYZfCJQ1gmnhE6jrB3IiSpNufx9W6xRkA2RdIJkLkonJRAQ
         KkGfPqfkX8Xkbr7rT5XpDvMknFBlvGrC+uVtjxb/cBYYIaWcc7JvHSDC4WPTYmZdrjQY
         +BGPmDJhn4jDzchWKzajw4d0gJogwxzlXUDYzNwOyw3Hmy17JyRb/ldGUBVMUhI2eV7O
         YZXUQBKepuWpcKO2FY4Tg3FLcTsU3SS5uE6lb9GgOlKyC5gFjGEpv9YdYi6WQoKND+2Q
         BzVaQqBzfel1P+J4hbHI0tF6IHzkHPUvCkTM0sM0yoigoDSDhIEx6HCc1vM2j28/QpUy
         XoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lXpoIfaZTxbS2QRN9RfCIEN9vyUFx7ZzXfKlV5Axnk=;
        b=W3YGypWrqPhjwShHOZs+pl1bCu95B9H4bvPwRs2hjFN17IZ3HbPmpo+vLN0AQ/qDWB
         8CHjiGR3pUU/Hb/8E2svY4jbqJnyyG+0q+WUEeTkzEPHMHeBQdLA+u6X6lB6XEfL3F13
         xtda8PfDXFhB0yErGRDJxbNPrThKeCejNrKC+aAbj8nmAqL3GnA6SiAqihK9uCObaro7
         8QuipZ0ny3JN4f64Wco64gcDrvhlKW3SM5ziPSdSQ8Vt1dVlZm77xs50zHopXdSN/XgT
         6icQmR75MAifx/CtYBukLWBphn2qh5Vsf0/8SIJZNi4rLwzQbEJAv+5yyo2rgZuoWZt6
         mWMg==
X-Gm-Message-State: AO0yUKV8Jzjq4M040d5g5eNKHmRqP3DEJIUMDK208dEeIU3m6e7VYCG/
        tQyCXCak8zompz2iNYj30sd+Pw==
X-Google-Smtp-Source: AK7set/zFya0Va33f0ElfIcm+RrAjMwtt46oPH8ks+Fmt8Iec5Zg25tyCtAQV/Y+pvzvO/62vQw/Ww==
X-Received: by 2002:a05:622a:134c:b0:3b9:ba79:80d7 with SMTP id w12-20020a05622a134c00b003b9ba7980d7mr3284848qtk.12.1675264437407;
        Wed, 01 Feb 2023 07:13:57 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c8-20020ac81e88000000b003b9bca1e093sm788065qtm.27.2023.02.01.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:13:56 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:13:55 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     lsf-pc@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2023: Call for Proposals
Message-ID: <Y9qBs82f94aV4/78@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2023 will be held from May 8 to May 10 at the
Vancouver Convention Center in Vancouver, British Columbia, Canada.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

LSF/MM/BPF 2023 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

	https://events.linuxfoundation.org/lsfmm/

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

We're asking that you please let us know you want to be invited by March
1, 2023.  We realize that travel is an ever changing target, but it
helps us get an idea of possible attendance numbers.  Clearly things can
and will change, so consider the request to attend deadline more about
planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/VKVXjWGBHZbnsz226

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

3) This year we would like to try and make sure we are including new
members in the community that the program committee may not be familiar
with.  The Google form has an area for people to add required/optional
attendees.  Please encourage new members of the community to submit a
request for an invite as well, but additionally if maintainers or long
term community members could add nominees to the form it would help us
make sure that new members get the proper consideration.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

The COVID related restrictions can be found here, however at this time
there are no protocols defined.

	https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/

We are still looking into the virtual component.  We will likely run
something similar to what we did in 2022, but details on that will be
forthcoming.

2022: https://lwn.net/Articles/lsfmm2022/

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Javier González (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Martin KaFai Lau (BPF)
        Daniel Borkmann (BPF)
