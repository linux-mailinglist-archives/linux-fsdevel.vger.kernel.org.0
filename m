Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C461F4AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 03:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFJBIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJBIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:08:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC4C05BD1E;
        Tue,  9 Jun 2020 18:08:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 205so568925qkg.3;
        Tue, 09 Jun 2020 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vamar1imPGmNvjQrf4Z1noIseKJMzzhcgENPsA5na3U=;
        b=fJTk0h8FxJJAQwFkQza1lwcNACtdjTFZr6vhcgsFpGKBxxZjCFMDQ6XmpukrefLhN9
         KUBaakKsqTHUuuR1YwsgfxpQpmMj93G5eSTIsWDKRWmeSa4lm+G6xB2HIN2blsTuw91E
         7iK0gXHiPUChe3Luig3UTJs+4gXDXGDh4oHnJ0SRqcGnUldPL/oU1flFuKB+mbsPGa/X
         Qh8H0rzRNWxTFedfKVEa/89dvP0Zh6AFbXpYbkscc2tQbxZW9A7px3nXNNdSw3jEBrYP
         qGViUTUf9nmTXDmkySHu68f60FFzs0/F6ssGRjXzJ0pPiRirdO6KzYi1kFy4/gqg2fvr
         IuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vamar1imPGmNvjQrf4Z1noIseKJMzzhcgENPsA5na3U=;
        b=ScrMwVGJFKXT2NbY/uxNPn4XQ7F3KBYmOnw0TifKXB0mUbpSmicNQp96BYb1HieCek
         Sqde6Jcv6AI7h4N+5ZDDZL97j3R7MuV68DvZI9tZpDQCBFuslNnrhE6TEnW9TtC16VNs
         MZIla7cAPWUojstlBsoVvyushDfql78DzBBfHPJdeJOIlo5ojhNYAHO/7kYaIWZKJrwk
         mzjLvLXeAVXs5gshW7T4UoLJAxctc6K1e0MsP8cT/cug6e+Iwnb/VG3TkhLbgS7HYIrO
         kBqqnd1DuJiAWhRvUkalc97EAxyVpyP9NsbdsJA3pFPWGrGheOelaXlmYVRQnCJz2iuL
         kPIA==
X-Gm-Message-State: AOAM5328dlcSZuE/BUyG+x/OYGPCCFa/xbGTXuepnU/pAaoG0qi4zTKN
        V5LsEFYc9wGjyxF70tA20Q==
X-Google-Smtp-Source: ABdhPJxoJ/sHIknqpkWtvAQC8xpLyu6qROAktnCeMs1TtRk3G0EWq6N4jDwOJrrSSBWGqbXcpkBRqw==
X-Received: by 2002:ae9:c113:: with SMTP id z19mr676879qki.355.1591751282318;
        Tue, 09 Jun 2020 18:08:02 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id m53sm12341695qtb.64.2020.06.09.18.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 18:08:01 -0700 (PDT)
Date:   Tue, 9 Jun 2020 21:08:00 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: generic_file_buffered_read() now uses
 find_get_pages_contig
Message-ID: <20200610010800.GA4070152@moria.home.lan>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
 <20200610001036.3904844-3-kent.overstreet@gmail.com>
 <20200610004753.GE19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610004753.GE19604@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:47:53PM -0700, Matthew Wilcox wrote:
> On Tue, Jun 09, 2020 at 08:10:36PM -0400, Kent Overstreet wrote:
> > @@ -2275,83 +2287,93 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
> >  		struct iov_iter *iter, ssize_t written)
> >  {
> >  	struct file *filp = iocb->ki_filp;
> > +	struct file_ra_state *ra = &filp->f_ra;
> >  	struct address_space *mapping = filp->f_mapping;
> >  	struct inode *inode = mapping->host;
> > -	struct file_ra_state *ra = &filp->f_ra;
> >  	size_t orig_count = iov_iter_count(iter);
> > -	pgoff_t last_index;
> > -	int error = 0;
> > +	struct page *pages[64];
> 
> That's 512 bytes which seems like a lot of stack space.  Would 16 be
> enough to see a significant fraction of the benefit?

Ah right, we do call into fs code for readahead from here. I'll switch it to
kmalloc the page array if it's more than 16.
