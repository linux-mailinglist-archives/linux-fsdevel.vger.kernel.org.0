Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD748A869
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHLUdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 16:33:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39666 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfHLUdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:33:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so46284089pfn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=opuTeOP019YiHjS7zgVGx1N/ZtI2m573pQ8Fm6DPedA=;
        b=Ns5tnFaXWDviA+GNTixFkO7AFl1W+l/Ald/kQO5BWa44a6ukvr1eWIfWjaWVDYUYDj
         hiAQT2HpufQzPthDGeB765CF3V6cCc9ECB9Nb9FumVOdvKyCv603isBx/5MPS6iHlrNj
         YgxsfNStteKFyfoyRgVQ7FztMMbz+A+7H9xCy4FP4N6hIP3FexB/hSxdWfnYZ5e8qxoO
         n8ijIrIRl4bVRGBQMRhePCuyMmbw7FhP1X3hyIp9VFPC+iRXtGEIKjnn3rnFwdAycubP
         1wpdkQhN3+kVMZT8ywoPlKyHLiAEMXVoKcD7/Lr1NHmQ8oLt8qXpYTHauzLeviIHKc2M
         tWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=opuTeOP019YiHjS7zgVGx1N/ZtI2m573pQ8Fm6DPedA=;
        b=C9bIu4L54wblOSORb/GCA5TPfpED4KfuHzBSgaOZfpW0kszu2bb4GJ8MJ+oo0lKEt2
         ZEQPqOrNE7OeFz85gJLSJfIpZ2GEsSObBbA0K0uQkx7wR/FdHnWWNX4khFMMdlTjGkCh
         G27Z9tgHlx3QHCP/o/jSl/JlF82PmCvnyREcwCiHrVgYkoMMFpVuaDtDL2gHAy5OcMKQ
         bDpDj1ibqpQIDd6FgMnUWa5Y1n5Qrufi9QNvrxWMy18un+7bJDH8P52HkRaj5lQ4mgWx
         UcRGHearKjaKEUn5sWQhTEC+TmncS9tX+gtCENrwKnXmGbG4dV7y7m4rbt592yrkVp6X
         jrsg==
X-Gm-Message-State: APjAAAU85/GRHkJ9xmymQe/5LZJ6zyPznEiDVVMNIQDp/ED7cWbqREHF
        7ZNHpvZscei9S4OkqVlQL4iTrA==
X-Google-Smtp-Source: APXvYqzLso2VXLAcxk2gXZWzzA185FIPfyG4h7hY0rd/zhvtbW+18JphumXy+BZjj65b5PHnBueorA==
X-Received: by 2002:a17:90a:d793:: with SMTP id z19mr1014808pju.36.1565641986978;
        Mon, 12 Aug 2019 13:33:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id b6sm93774090pgq.26.2019.08.12.13.33.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:33:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:33:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v10 2/7] filemap: check compound_head(page)->mapping in
 pagecache_get_page()
Message-ID: <20190812203304.GA15498@cmpxchg.org>
References: <20190801184244.3169074-1-songliubraving@fb.com>
 <20190801184244.3169074-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801184244.3169074-3-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:42:39AM -0700, Song Liu wrote:
> Similar to previous patch, pagecache_get_page() avoids race condition
> with truncate by checking page->mapping == mapping. This does not work
> for compound pages. This patch let it check compound_head(page)->mapping
> instead.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
