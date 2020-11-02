Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84702A33E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKBTRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgKBTRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:17:14 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892BC0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 11:17:14 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id j62so10012796qtd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 11:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2GeINr3PUVgdupvFShw4TU1fvCx5+pXXkokM7VFTZco=;
        b=G3/YvzBP709JP/ZojwwfAJZF+k52DpVmdaDs/I8hkO4Nruw8fq7O7WC5Ca2U2MOohJ
         Tj7jWZ6RtC6BHoxAMztYv2KNE/cmxsjHxmzBBdBVAVtASD/iFMMGIoO2Mbet3gJm4DM+
         pQtZ4DucCKvI8K/3TQzDSW/TNzxsaH8nqgZAb6D7wMpthJjg7oWrILn2Wimh6inyknVF
         QM9A7Az5sYlJTQ6i5yJuSrJdb52WaVE1G81jIvLqoIOyuCQBCiHFrZj3SjjDVzVVD4/n
         ygERmx2CUBLeJNIkn4v7ch+u8rhq/v6+VgIGNVN48R+Mn5Avuj+jJ+aHrr6nhBmCVbxK
         GRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2GeINr3PUVgdupvFShw4TU1fvCx5+pXXkokM7VFTZco=;
        b=oohl6KD07RtHuBhiAfLrlE9Qv75ZnIautXz9lpdllMYZc/eLjPhnFiOa/vyTBi2Y8I
         a6W2Yzacdyu3VN2kwRGOCKMBp10Wk1NiFEebOcPWbcLRmaAFXVlFw1tTFZeVtJjGqer4
         Br8DSnkwb3mVN2wJ5Bsp3SxTpwdg/McFcUinjDNZDitg+xq6Q9cYX/o70UTd5YWje5Zz
         DTHz3V23JPs32lvB3TcKgjS583iSnr3Cn+GuoumUOQ7+OXGnLELKS34GHwCkGkIWTgBH
         wD86YVMH0ZpQ3tahpvamgbmEUVvARhXVUQsJROI5ezVBNs73TTEOqj9ytsVIEGcvgnGw
         4e+A==
X-Gm-Message-State: AOAM530DWUG92/UFaOm4yJRlc33KhjYoPEJre+BSUq38DntuGEnRnwIf
        Pkv+cfKrnn1mD0Q5+ONbJqY15Kka1K2b
X-Google-Smtp-Source: ABdhPJySu8zXlirtbToJ4+Lk8cVcoVia+6Epnj6QABoUhCkdBuTUh8jFokmAtGjfhXZZHrton4woFg==
X-Received: by 2002:ac8:728b:: with SMTP id v11mr15609504qto.373.1604344633979;
        Mon, 02 Nov 2020 11:17:13 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id i64sm8638295qtb.43.2020.11.02.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:17:13 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:17:11 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 06/17] mm/filemap: Don't call ->readpage if IOCB_WAITQ is
 set
Message-ID: <20201102191711.GJ2123636@moria.home.lan>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-7-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:01PM +0000, Matthew Wilcox (Oracle) wrote:
> The readpage operation can block in many (most?) filesystems, so we
> should punt to a work queue instead of calling it.  This was the last
> caller of lock_page_async(), so remove it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
