Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78DB241CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgHKPFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgHKPFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:05:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87CFC06174A;
        Tue, 11 Aug 2020 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S2wmRSHqyGoakvY5Ivw1yEzjABx7ovMcyJ1PGL50P4E=; b=bSRd1CLwW/YaUWxJ7ZkJWUfl3g
        TZq1CX+t7fmzcrlkxy4wifDSYbgWr71Ke6jBRmTtojMrtRT/pH9YPqprcOVfERYX1GnTp2ccJ9IE/
        ut0cQCPNLO9lUh3Eo8hLZSOVMLff0Mh9Zgc0IEzDje2MsVZF7jTMGA64/Exz34lWlVBQUl46gHDyh
        Nmn/sk8h3iL+eJaCwaIVjT9ay6O+bH7qp9hYCD9y02Hwjl5aK8ncBUMwy5zP8pitFnCh/jxBEsxDb
        b5l5ojKtDs3OO7qEtlOuvrMuTL0fWWq49A3+i+DZzPE5/5JJHsrYNb2iI+HQbvEqeEXkenpM/jnAj
        r0DWVysA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Vq1-0004dQ-4m; Tue, 11 Aug 2020 15:05:17 +0000
Date:   Tue, 11 Aug 2020 16:05:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Burrow, Ryan - 0553 - MITLL" <Ryan.Burrow@ll.mit.edu>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bug fix to ELF Loader which rejects valid ELFs
Message-ID: <20200811150517.GR17456@casper.infradead.org>
References: <c51feef9afbd4b82a3c718a072433a20@ll.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51feef9afbd4b82a3c718a072433a20@ll.mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 02:44:08PM +0000, Burrow, Ryan - 0553 - MITLL wrote:
>  	/* Sanity check the number of program headers... */
> -	/* ...and their total size. */
> -	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> -	if (size == 0 || size > 65536 || size > ELF_MIN_ALIGN)
> +	if (elf_ex->e_phnum == 0 || elf_ex->phnum > 65535)

umm, did you compile-test this?

assuming you meant e_phnum, it's a 16-bit quantity, so it can't be bigger
than 65535.

>  		goto out;
>  
> +	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;

use array_size() here?



