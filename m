Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A638BF482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIZNz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 09:55:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33519 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfIZNz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:55:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id c4so2137212edl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aOr0iyfBLl80umcRhExqHZHW4urAI30wkAKXPx7sd8s=;
        b=byj3666jUomIxQfVgejvo9qb9jGyy7ag0vbTbVW71SegiKooHWd3O/zR9mU4jnpKRq
         bfOavtCnWSSNGyUXeiUwmCDfS6pewUtqXrgAb29RPcOQV44Q+7nTWMvi2Qai5qKFX8gZ
         0tVLgaeBW3mCWMCnH/z/g0dZEalHgm9Gf+TA5USpCcAJqP9BGnH9Wg2kEkzlJFyhyXHN
         eR22wGokBq86OaykauTi3oZw/WmqYf7zfUyhxk3Yq8a3rw9cYcQnotYj3MWUlv9EYVB1
         MhFXn3/H+1CY66b1QwIXAt02H42lnbbT7g4p2yI8zYAXD4+Vzad797Aq01FUSoUyjeLi
         qbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOr0iyfBLl80umcRhExqHZHW4urAI30wkAKXPx7sd8s=;
        b=mBevTta52Qt378DZDv6vWVxYfpBsYkaCt3pCy/mIyq6HR/P8qSTiLhfe5SBNAd3P/z
         9QfX13Yzp1KrB5DlhofqK/aIA/QlKRNHAVYzW8gVx9JWzeqFDkqLUu+cr1w4yhtFS9yl
         itxMVgHDqQZRDtbUUkb2FkaXE0BYXYt4uMSba4Xll1bzmvAB719y5vhcrLo/smdykgBh
         ggzvLKT1BBEr7jJGctCQGxHx+4o+z9p/v9tUrgZCtgVun2JfLvpom42lDdnPaVWmC3cY
         wroNE3t948WUWPmflStRqzFgcUWTKVMgvSEeN8xws8BEzxTgxltx/9bgcwxV7kkbbHQK
         wDYQ==
X-Gm-Message-State: APjAAAWfimHNn8+t4/LGib08gtjz16Ab+Mj6do08O8K9Wnm99j1ErJBS
        rgZ5m0Wig/4Yfm/2n+bUV4l2SQ==
X-Google-Smtp-Source: APXvYqwRM3uOue8sdkJXKA0j0BlH3YC2gCanRwb3iFVBEmOi2tgQReY6Xpln4M8dnVP9lPsAWlOk+A==
X-Received: by 2002:a50:eb93:: with SMTP id y19mr3762407edr.94.1569506125053;
        Thu, 26 Sep 2019 06:55:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m18sm250017ejq.72.2019.09.26.06.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:55:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 68168101CFB; Thu, 26 Sep 2019 16:55:27 +0300 (+03)
Date:   Thu, 26 Sep 2019 16:55:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] mm: Use vm_fault error code directly
Message-ID: <20190926135527.htzehar7j5uv6nsu@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-2-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:00PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
