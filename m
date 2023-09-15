Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A257A22C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjIOPpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbjIOPoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:44:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6910E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:44:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41243a67b62so13424431cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1694792684; x=1695397484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad1gGutAVP5/Tgl+c7iRZuNausX9kqPfW/rFp80jjCw=;
        b=uncMKVYFg6E+IO0/LthlqxYKHvF/Lt6BnSataDD12U0PjFjNRKjHufTyChsXVSqAC0
         FOqZnzKWo2iCKOwoeubNc17ZiP1D4sbizCo/P3aal8KrXGWKNYXjCPOlNShHj3VjRpgr
         Q+Pc7iw6shrlmQszD6UxkczHCx9AR0b34ozywWVEAhkdXB3v7BKed5a1XrhMNSv8r/5a
         x/ctnC1k2bJ0qh6XeZdiX5rK7/ilnmesrLYkBc0/YRBObhrvt/102kfwooQOrzkGo6iN
         3KTFW3L6N3R6uqzhaPL5/6LoYe0UTT4ZoKmas5noOF5kJ3drrkXBxzxsqH7x6ak7cu+y
         p6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792684; x=1695397484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad1gGutAVP5/Tgl+c7iRZuNausX9kqPfW/rFp80jjCw=;
        b=dszWnIz9b11MzZwbGyQKSkVFm6Wq1MbC/mOPBRX/8atB+8ZzJiXA4HdpHlIGLyFC3T
         vOR/biYzdXXN7/wcIBBaLJjdilIo6atsGqxS95S2dWPLTPqQEtn+aXYppgb2zT3IRdUw
         Zs+dsVuf9DS3JkZ7wqgpe4ecLJqmwXd3f7A+HXmRGYhGJ1G59jumoBEBUoXmv6y6WbRm
         C91o3Tl8KWmhz1a2dr5ttuy34ST+JfGlYLfpZGHLVEkc/ErlTnvLSBo7aIiKjzKpdfcS
         KVeaoVlOTo7OjYJ/BZFBQj2E1JZkrGbFwkMLB3K2B3CIssf+xER0XfVWhQ+7dCydvxrL
         mmeQ==
X-Gm-Message-State: AOJu0Yx7VPtzUvJtVbZvlg9NTnlel8eauo1zo76gjC8v8lyYzBXsQHA9
        zh0sHC3inFuNDbL4C25cS1zpxg==
X-Google-Smtp-Source: AGHT+IFCCAFQe2QKdmHmHF9P0nc3PPnFxwxNjA+I3SGdpiNMgEx9ZYpDNLvzY1Q1/ZD232OHwktajw==
X-Received: by 2002:ac8:5d0b:0:b0:403:b395:b450 with SMTP id f11-20020ac85d0b000000b00403b395b450mr2764065qtx.2.1694792684693;
        Fri, 15 Sep 2023 08:44:44 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id ih17-20020a05622a6a9100b004100c132990sm1225549qtb.44.2023.09.15.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:44:43 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:44:40 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Ungerer <gerg@uclinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: Re: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Message-ID: <ZQR76GSNEmG6w2oe@dell-precision-5540>
References: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
 <20230915121514.GA2768@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915121514.GA2768@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:15:15PM +0200, Oleg Nesterov wrote:
> Sorry for the offtopic question. I know NOTHING about nommu and when I tried to
> review this patch I was puzzled by
> 
> 	/* See m_next(). Zero at the start or after lseek. */
> 	if (addr == -1UL)
> 		return NULL;
> 
> at the start of m_start(). OK, lets look at
> 
> 	static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
> 	{
> 		struct vm_area_struct *vma = _p;
> 
> 		*pos = vma->vm_end;
> 		return find_vma(vma->vm_mm, vma->vm_end);
> 	}
> 
> where does this -1UL come from? Does this mean that on nommu
> 
> 	last_vma->vm_end == -1UL
> 
> or what?
> 
> fs/proc/task_mmu.c has the same check at the start, but in this case
> the "See m_next()" comment actually helps.

Yes, this is another copying mistake from the MMU implementation. In
fact, it turns out that no-MMU /proc/<pid>/maps is completely broken
after 0c563f148043 ("proc: remove VMA rbtree use from nommu"). It just
returns an empty file.

This happens because find_vma() doesn't do what we want here. It "look[s]
up the first VMA in which addr resides, NULL if none", and the address
will be zero in in m_start(), which makes find_vma() return NULL (unless
presumably the zero address is actually part of the process's address
space).

I didn't run into this because I developed my patch against an older
kernel, and didn't test the latest version until today.

I'm preparing a second patch to fix this bug.

> 
> Just curious, thanks.
> 
> Oleg.
> 

Thanks, Ben
