Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01FD45E14A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350529AbhKYUJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 15:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356720AbhKYUHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:07:08 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E46C06174A;
        Thu, 25 Nov 2021 12:03:27 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k23so14564385lje.1;
        Thu, 25 Nov 2021 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7p/0Jku+qCm+8vv6WBeeFjWQ8UEiYTDZ+FwuFwo6po0=;
        b=YRu3bS8YBSqpNQWfwxhsfN0YGZIbWkiIfCUxv1eDC9sam9AKQz/3ISYOdcikWR4prR
         9edCkBA7vvjZK9G7CSJLvPM098m3CNDwB06TOFBH4nyor3pssFXVarKQu5CmmmkKTH0r
         LJGOWfTsG+E+Wo65yL77uqreaQbrxOE5FPX5XzR/xP8jfG5lpgDexjQjPMl5gluO2lQj
         5nR+W1LCIGKVVpfOHt7GjTl76JploFGn/9GqCg3FkxvDtAqtG858uMWfgOPWNsRqS+uS
         2n8J0koPX/lAOAi2eVGbuAnIdEYFQg2juE89kT2Aif658rEl8/peutgiU7CVkbZOfvz5
         nw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7p/0Jku+qCm+8vv6WBeeFjWQ8UEiYTDZ+FwuFwo6po0=;
        b=BPalExpd7MweTtpCMgsCT4i0YZfiM7/THWGd2wWPxGdPFt59tgYaGdkZ7CtecP+PrJ
         YthYZYyK1B7DcytdzbpI2047LhkemC3rpawq55D0MXCyYEWsZsKiqk6A8cUyaKCmaDz/
         fXoOOCC7GuyHbD7y/Da6hZ+ldiqeTlhldtsSqtghC4EaxGDfZ7R75c2ocSft0K882izs
         wUbnaK/lJrogLUlmw2PUbZrYzYQokZ/XFq8aDaeSLPJ6CjfnzXYx0QdahJMpT9JD5g7D
         ybGff0jPC1zvf7ZtLAY8YxrKfTD7CtwygQy5bjOBBn6IzxG4v/viHzG8lZeABe4xZH/N
         pTxA==
X-Gm-Message-State: AOAM532KQfNW8K35ud9vsxaPpLUc5eNorzZX5aXFcdSyU5y4KGBEKgO8
        0rZ8J80QNncTQdUA5JLolvY=
X-Google-Smtp-Source: ABdhPJx4DWJw5wxZ76NVyXRts+DU62de9yu6D2DNcBUWlouwK5XqqpxGD+pcp2WEUnLB3NH0bwseMg==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr26523009ljd.184.1637870605782;
        Thu, 25 Nov 2021 12:03:25 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q13sm336566lfe.121.2021.11.25.12.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 12:03:25 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 25 Nov 2021 21:03:23 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ/sC/N+fHUREjo0@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan>
 <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
 <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
 <YZ/i1Dww6rUTyIdD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/i1Dww6rUTyIdD@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:24:04PM +0100, Michal Hocko wrote:
> On Thu 25-11-21 19:02:09, Uladzislau Rezki wrote:
> [...]
> > Therefore i root for simplification and OOM related concerns :) But
> > maybe there will be other opinions.
> 
> I have to say that I disagree with your view. I am not sure we have
> other precedence where an allocator would throw away the primary
> allocation just because a metadata allocation failure.
> 
Well, i tried to do some code review and raised some concerns and
proposals. If you do not agree, then of course i will not be arguing
here.

--
Vlad Rezki
