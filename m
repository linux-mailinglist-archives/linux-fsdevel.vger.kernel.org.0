Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF10B2A3443
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgKBThi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBThh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:37:37 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:37:37 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id o205so5769395qke.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fzT0RAqiMzs39m37dX/EBLpU88lzxt1fP1ZflrRv3fo=;
        b=REv90MNn8vH/rMHILEWe1iBlBcHaHV38kkgx1WVRe+c9Q/TTxTr8MiYTJqVffqaFXY
         71T7jjlTe+wYZCabP6RtqNcdHeYIJV6DBZA+UnRuAo+9KxszzjpYRl8SN1lzh0Pjor2O
         z+kVNH+4dqSMZWFRUQaV8YSEQ5U1izXhHzw4uy0arRBuYwFM9D0UXPiSmMn/++vswnr5
         +5qhQv2Q/7TOgX3ca/3j41naLDzzxKiRLqux2iCYOZbliZTiZZN5uh3yI+7W1Ir/yYot
         LrFVHotqzALjr9hwQqHUujypCUlLYRdoNcGhkjDyHkvjuWrXBtTGDTdVAQb1xI9/6B/z
         UGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fzT0RAqiMzs39m37dX/EBLpU88lzxt1fP1ZflrRv3fo=;
        b=Y++A8FIgRiZyGkWLuPBGlVFydCG4nX9GU3vXIETdimQVc7wd7WL8GIAkHhTHjRcL8+
         nNf0GG8StXV9BeuTps6ArM79YWXSgnvCK3a8F4YwNLI8y1Re67+GmxlsYMPZ8ykpZDYZ
         GXO3MNys+bLq+4UON1qC7jhc2ExArM3Y+aV8IXf4D80W4trqVVMEhGEYRdaLxTBok4Ms
         kq5GYwTqG+bUVC9lXuOexrItQFHGPST3foM75x6Ju80E4UAfRW34CiwSfIiEQDrTi0GM
         vmCZ5mn2v8tzoRVmBXcV403fnmokUKI2POxAAALyA9iDqfChF85BaYdVb1IdKGwYcw3T
         VDpA==
X-Gm-Message-State: AOAM533UQgR1yM/gO9Crgk3WC7Gn3vtkc/Q8SyJtT9vNc1jjbgVdXZcg
        sLezUKcR8LqF+Dorsk9UCw==
X-Google-Smtp-Source: ABdhPJyxSkcg6juHn86OWdiimWTDOgXPZQ7U33NFe/CpUGJOfwcU3FNTBKK7DZLwTuvRUqR48pqwfw==
X-Received: by 2002:a37:6fc5:: with SMTP id k188mr16766947qkc.317.1604345857103;
        Mon, 02 Nov 2020 11:37:37 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g191sm4544455qke.86.2020.11.02.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:37:36 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:37:35 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 07/17] mm/filemap: Change filemap_read_page calling
 conventions
Message-ID: <20201102193735.GK2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:02PM +0000, Matthew Wilcox (Oracle) wrote:
> Make this function more generic by passing the file instead of the iocb.
> Check in the callers whether we should call readpage or not.  Also make
> it return an errno / 0 / AOP_TRUNCATED_PAGE, and make calling put_page()
> the caller's responsibility.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
