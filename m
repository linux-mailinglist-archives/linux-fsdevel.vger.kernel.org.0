Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4358122B49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 13:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLQMTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 07:19:45 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35333 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfLQMTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:19:45 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so8223255ild.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 04:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhMulIHbA6yrCBtl34rzmfSnJIKkct6s3ATbb92kwkQ=;
        b=nW1RqOqJej7U+Gi30b8Ebxo6jxeuuzLDFF5t6AtAzKamch6VCwh6hAr1TRxq3d8NTk
         F77nfO0x/MSql4fCo94/LZolCBOdwa0K5XIq040kwNRhzXVpJ2StKHkl/TUB6TAJbmQp
         t9mpS/Smt1rzSiXtczb64PXcIJtuzWYAD4Rw7/uRDcViJ9jwqAMte4by94Zbk7tV7+yj
         +jplzDGi7e5pamfrJcJxBOef5GbzAqLQb9EvAcS28TkxdESxKMVKLN7sCWWfvspbUPrR
         qlcjdC44PQn0Y2feX3nHDNxyY9lezTVjdXtQTUP8eCh6uY3qotdUrIv+UTMMteVIoVbQ
         oQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhMulIHbA6yrCBtl34rzmfSnJIKkct6s3ATbb92kwkQ=;
        b=tSAorDFCLM3D+9fJBhZHzF8BqeJjDwiQLfxpknVvvcDjL6n4dX0JFlefEbsaE5Y9QM
         +UX6hCq1wxFv/wCtTbDP/1Oz12O685diEjrT0MmCvph9il9QLXGD2DOXPz7Lz0X77AHc
         oyX5SM2In2rTz1f5VsfOsKi6JHkDYRhamzL1wTnnw306kRSBj8hUkwBXOp03yuNznnww
         S4aaFRf595oCcSdFy1h4D29NFu9aHIp5Ey1o12oplgqSdFa2DOMLNiHUVRLVjdLovXts
         09UqdosLVR9yANS1oT/OhWJGA1fuiqKUfGzkxXLUSqdNXqJbgMhBbpzlWOC64uEzXCVS
         t3NA==
X-Gm-Message-State: APjAAAXM0FTJxFcEotfgYEMeAHSdRPtti4nLmHa55isqG939eIfxbG+T
        aHLT3NL9w30ke9vmt/Gu15IGw7vd/Hypezcsd9s=
X-Google-Smtp-Source: APXvYqzd1b6Nq7mjJEU+0QW65IlPVvFtP8uLP80Myzpt1VyVBGVcCm2LFT+aFiqiyyB9OVpYguUejmyeugtAWLj+lZw=
X-Received: by 2002:a92:84ce:: with SMTP id y75mr16532399ilk.93.1576585184869;
 Tue, 17 Dec 2019 04:19:44 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com> <20191217115603.GA10016@dhcp22.suse.cz>
In-Reply-To: <20191217115603.GA10016@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 17 Dec 2019 20:19:08 +0800
Message-ID: <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 17-12-19 06:29:15, Yafang Shao wrote:
> > On my server there're some running MEMCGs protected by memory.{min, low},
> > but I found the usage of these MEMCGs abruptly became very small, which
> > were far less than the protect limit. It confused me and finally I
> > found that was because of inode stealing.
>
> What do you mean by this exactly. Are those inodes reclaimed by the
> regular memory reclaim or by other means? Because shrink_node does
> exclude shrinking slab for protected memcgs.

By the regular memory reclaim, kswapd, direct reclaimer or memcg reclaimer.
IOW, the current->reclaim_state it set.

Take an example for you.

kswapd
    balance_pgdat
        shrink_node_memcgs
            switch (mem_cgroup_protected)  <<<< memory.current= 1024M
memory.min = 512M a file has 800M page caches
                case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
                      beak;
            shrink_lruvec
            shrink_slab <<< it may free the inode and the free all its
page caches (800M)


Hope it could clarify.

Thanks
Yafang
