Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E62A3459
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKBTj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgKBTj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:39:29 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D689C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:39:29 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so12614497qkf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SYt9eLe6kDHJvHhZEgOGUSPfKixxA4TldLkyG0uENoI=;
        b=Ie/OZ1ppp9HN7X3xOmtCBypjyoURthicshY6mxFUKu4jKfwQnj0M5zpz7wEEMiHgTQ
         El4DQlWC5E/iZ/Ml7eXutHHsngDMCJXljT5Q1h29f7sW8CZBphQ1Dy0E1L3TYCtXnckH
         X4kcSPztdTzU/l6BqNX12PxPZCeOUYMfiaGyQqbeAdT/vGlSY4YGA9wYxzK/awol5k61
         4nrQy2YkLW9+TxepoM6BYnX0kccDyYzdF1ralyFzGga3kmiE03/nwsuyFzly8FvIoHXs
         wbsviguSLFlKSha4MhyJwmbRM0mJH2wRAhc8PzLHp7PM/vG4FJqoyfGt7eE8UU/SaESG
         aPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SYt9eLe6kDHJvHhZEgOGUSPfKixxA4TldLkyG0uENoI=;
        b=Am+5XZa33C0hk6bTa7iU5HiotqLPRDn0U24IcyN4pswLnTvA9N2Hd3s9PqhjgJbNTQ
         3xA9wJNZ9dwEQ38zcUGgctomoNdLXZ9CpdOEO7alkQjLPMcFPwaN6NzLT+tpskwFlGb2
         sUEGAHZEpRisuZ8f4crRwMLblBVBug4ezKRZ8Q3cE6+WnqJ7aQ6cbrVFqzxSHx75V5UX
         6ZuC0RLaxu95KWNSWy2l68o+nnQw35M2AOmfPEx0Nd0rh3ld5lLDBcEMSkBDf6IAK16y
         tT4iSBN4C2mSusZb4BOaV+DWuunYLdGz0D7IbnXVBCF853umuvx9Ghq/z5PMw0QZYj6T
         zMuQ==
X-Gm-Message-State: AOAM533dz/TXRsLRj2OS0ENAUBiPZGlBXRpHE0QKijzaWz5O1FDCtVer
        c0BTykB7A07SrFno56CvsA==
X-Google-Smtp-Source: ABdhPJywgZmrHmp/TyMdww1dVH09W/6cY62S8E8IcWaQGBuWX9c6WHX293Ato7qfnhf6nzu11v4TZQ==
X-Received: by 2002:a37:7c4:: with SMTP id 187mr16130487qkh.342.1604345968396;
        Mon, 02 Nov 2020 11:39:28 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 198sm8779539qki.117.2020.11.02.11.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:39:27 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:39:26 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 09/17] mm/filemap: Convert filemap_update_page to return
 an errno
Message-ID: <20201102193926.GM2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-10-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:04PM +0000, Matthew Wilcox (Oracle) wrote:
> Use AOP_TRUNCATED_PAGE to indicate that no error occurred, but the
> page we looked up is no longer valid.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
