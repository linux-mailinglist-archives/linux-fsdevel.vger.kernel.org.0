Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26EB2FF643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbhAUUre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAUUrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:47:31 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161A8C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:46:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v126so3064700qkd.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGUNk7vhkO0IoLRkb7NZj4Pj5vz/6dqRquEfQAmHYUo=;
        b=UGkBP8zne2UEhx8nSu1JlsPoUjs0tG8DW1Qr4aSAP8Lzp0Qec6gE9yxpwYFJ2UIiFX
         C4/UC02W6/1ffmpRc2gsRvjxRvRsCZ1vVNQiIjuoR3yDs1sdoMe5SovJE67eHZYlHKmc
         c9+OAxsgsWofKUqz1i0LU0oiIlQFrNPuClaTcONcH5gD5WowAOzVdvDAe7ZYjDYkyATp
         kMSlMAjaAjVnCPqiqKZDuVPZtvq7/O06Wd6bzbr6rqqJLkPK0VTHHe2i56umZeYXGelD
         fh0wrueli+xxzXNKU9irVOOT4BC/7xo3n8GtYxPTNhlb63NzsNJFNQtNa8OXT6CZRiKS
         Yj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGUNk7vhkO0IoLRkb7NZj4Pj5vz/6dqRquEfQAmHYUo=;
        b=nijZQcvpjHRD+ovOg4tK3kQmjRHKSvT1azQRoXRIXHPOuPlaXbwBSyelz1/3e7MgNi
         KjLppXQWmUaGVKnVPWdaHoDzG0XfOsEye+WhdDyjtByUfk4LzqszdrK0r695r3n+VDYS
         hPBTq0bF900LfJvflLZgfQvbrQy8JfnVM59MPmxGXyuhoe9H+uFz1CVZ4ZrjSsR9C1yn
         uC18fMK/QdGmYlasNW9IxfXHbfZ2N4tYKsZJHP4+ck7prVAaF+mkxNEOH34nfNBdMVpE
         PT8Tu1PLCRGFpsBQTIiIMkIlt59sb4Rm1nSEUCljpXO3/5cagFXBI6H9wwjmjhj1hOLj
         P/pQ==
X-Gm-Message-State: AOAM533n/mg4KAxRxNtO/6l+10hlcP944HbFYE4gxRJtrpGTy27dgD1y
        /l/RIc4OnRxxe24hy5ILTy+q8A==
X-Google-Smtp-Source: ABdhPJwApGK4RaZq2SOhZ3wOfS6eZhO8xnmttG6vEStqJ7SwbpY/ZTeImS7T3AoCQ4VJUOSUngTuJw==
X-Received: by 2002:a05:620a:805:: with SMTP id s5mr1761345qks.80.1611262010398;
        Thu, 21 Jan 2021 12:46:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id 16sm4648862qkf.112.2021.01.21.12.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:46:49 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:46:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 3/4] dax: Account DAX entries as nrpages
Message-ID: <YAnoOHMMsc/q+lH+@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:18:48PM +0000, Matthew Wilcox (Oracle) wrote:
> Simplify mapping_needs_writeback() by accounting DAX entries as
> pages instead of exceptional entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
