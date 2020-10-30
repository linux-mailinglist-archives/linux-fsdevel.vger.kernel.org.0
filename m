Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39429F96B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 01:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJ3AFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJ3AFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:05:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE8C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:05:38 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y17so4978525ilg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NWXJurSDAUdvVulUBS08ycCbDD8zDtUY/wRER/Pl6w=;
        b=DuLV5SSd8IBfdgg0JIjsJeXUQtNhy2jTDNdmjG4MhkPpGlibrast3VKlviEg3Its/o
         bYUj5gmPFXkvDw6oGJPr8PG0BvCsf4oSaqIe65I30Yo5pVvHSijzGEWaKjL+MpmVsgs6
         va6QV1rsD+q6Rx3vFFQquOVAFG9wYAl2pjgU3K+RaHOlow4qUIqNrpgMjO1rgIfvX/rw
         bGcJvf/9edofTvPa5aWYMOIdVK1nZkYGZas/Z/66NFmR8Xl8Pw+99QtrHIlUP8eTLZOq
         9YzwnBN+nO+N2v/nq5ByuaWP6oxwFA4z3E6C9aYTYPrByxEIMzk144hD6a445WnlYYy8
         p16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NWXJurSDAUdvVulUBS08ycCbDD8zDtUY/wRER/Pl6w=;
        b=OPnW2YIF2aRWESnkTf2foD5UkuWa4smAfPWGUmkAnCiVdW/dcJZsZCx7BCqDJ0PgY8
         u6i7vuUjQc/9COO2S1yOI1jc/nODCMFBEME3aNF4wzbpGD5+y0RfQSoo1EvRX4VOEJY9
         6sC8FUBEwrHDg1XheK7/tjxwrztBvW/itSYDhe5zssxR8bhGrSdda6hbjD2k3hRekHMI
         OMamVNozxiBbKC0e4wMwq8YQV4uO/leGHj0Ol3y9PfqBnp80X4YwGUpKoM7WXZvVxeS8
         Bg/SqH2BecJGsVsgIJKR6UNK8N1OPPWsVeLBvdtpcTvDmweVLC1Dqjdqk8dgAPgJGwrX
         jMGg==
X-Gm-Message-State: AOAM532sPIwhfY2Hl4WYyswtq0WwQUet4wFr0kTSX2bGo05UiUXflQ9b
        9ZnberbQ5wJYseYDxbTxFg==
X-Google-Smtp-Source: ABdhPJzUxcYp+6xyOi2e7drSpHb7Nwl1WMo0auV/RLkHOg8N6uSfnnb/EZIhx25RGvjSmNB5t4L01A==
X-Received: by 2002:a92:ddd1:: with SMTP id d17mr5271897ilr.275.1604016337618;
        Thu, 29 Oct 2020 17:05:37 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p18sm3457596ile.72.2020.10.29.17.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:05:37 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:05:35 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/19] mm/filemap: Change calling convention for gfbr_
 functions
Message-ID: <20201030000535.GB2123636@moria.home.lan>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-7-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:33:52PM +0000, Matthew Wilcox (Oracle) wrote:
> gfbr_update_page() would prefer to have mapping passed to it than filp,
> as would gfbr_create_page().  That makes gfbr_read_page() retrieve
> the file pointer from the iocb.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
