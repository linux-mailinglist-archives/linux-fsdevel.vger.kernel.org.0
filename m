Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D063B122AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfLQL4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:56:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40242 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfLQL4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:56:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2802711wmi.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBfsCMjh1ETu4mPTqgM5m4FYVkLnpEWQJDTEOuEBWRw=;
        b=YsZheKiErf9J8bHuszkaTrjWxBi2UYRFDxZ4H3TD9/5eE6/R4GX1UCHBYK92bx71w0
         7ezj9+bsXTI7jgT5oRO+wKeLBbGS4y1/oyvfrkKm6qP0ANU/AOB1KbwsyK2Avj+N6c0z
         lAbs2swVAeovQCFetkkm3GWVkg8S4NnTmgfk/brEr687g4BGS24BjevRktmgUihYCQse
         GppEtHCx4v1V1Iwq2p2E6WojYd6qi5AovrSr1EtkU9X5nRkGZ9j/PmB8NsBM+rkX3B46
         2JTQWz9nKKVp8XdHXD/mpJdi6BxbEQV4nlTiJqP6b4PJdZeKKibZvQRgZFuorRyWCif1
         Ir9A==
X-Gm-Message-State: APjAAAUUOkmdcKJ9dzooIcSXlF6TTwhqema1wuNNtav3HflaERC0dWnC
        qIxKk2XYnGo07DhjhRDqtnI=
X-Google-Smtp-Source: APXvYqyYFTVfGZu2J7p0OrIg09Dwz5eFI6PsMuysdoIJMBZ0kOkQ1SsHnOZSXe51f6W7R63viLe3SA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5016121wmi.152.1576583766141;
        Tue, 17 Dec 2019 03:56:06 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n3sm2819398wmc.27.2019.12.17.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:56:05 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:56:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191217115603.GA10016@dhcp22.suse.cz>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-12-19 06:29:15, Yafang Shao wrote:
> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.

What do you mean by this exactly. Are those inodes reclaimed by the
regular memory reclaim or by other means? Because shrink_node does
exclude shrinking slab for protected memcgs.
-- 
Michal Hocko
SUSE Labs
