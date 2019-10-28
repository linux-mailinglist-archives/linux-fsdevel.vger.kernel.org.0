Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6855E722C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfJ1M5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:57:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42629 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfJ1M5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:57:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so11207351ljh.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0z8rcnJQ2Ztw3XS+4jmpXqQHR2gbd+xnEDMVQdJ2PKg=;
        b=srML+4c4W5XX21msxWpc4UTlLGRvocfhX+m8lvWZmTqWJ5JCiI2mfWZTnHxVqaYfjb
         RZj0UT8eW/naYqmghTosmknDZj7Xpio4LxUzGrGSO3//giGKDQmYVrnZ/paCFuFAQcsB
         V7znTFFwZzkN0gTbaEAl9TrDNfH1cG7W0wF73Ynd7rAmULk2w/g74sEdzHqe4AhDJ+3H
         vPLMBrEepytPqjx0ZwiWK8rMJ4d7YqC1t7Ci1xJs9k1l4TphNVHkdFQ5/Xx3FdjDjY1D
         qJp1PdMkWXv1nkI0LJwRV0l4SfjCylX+qDHekhf7ufySNb4+QR/AwOoYHWdrxpSqs3Sq
         uUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0z8rcnJQ2Ztw3XS+4jmpXqQHR2gbd+xnEDMVQdJ2PKg=;
        b=Xi+AVdMwg6VHS4viZHz6C9knWy/BmG3oYmjBiR9fIp8r/++C8fbviO9njVFAIWkdPP
         +n7LXzx8m9Ih99ElV6squIaw5fcwzDYd+XYnWXBwBK9GfeCrc78qOW09L9mr7DqS2s3J
         azbHFvGJkCQK8CepDNSV40/IwOosD2SWXr2AP3oNwCEbJPtZDCBav7xYJVDEMe+MJa03
         8N13GmvIHuTIsYgIZhpjHvyvZFHOrjQrid98UUVlSegImdpf405bzF3imfhpZuyk11o0
         b9GRe8rBRNWpW1jKEcIKf19aKuoR9awRm9Pi0fK7GtRzpiIGD9DbkSroUxAxctNoayN/
         jULQ==
X-Gm-Message-State: APjAAAXeqsS4hUR2aRxvlG0D4PPNhomMpeEisSzGmtlY0+dlS0Pvk4E3
        YoPsZFcP4ghENz9AyY5H56eijA==
X-Google-Smtp-Source: APXvYqxnZmY+iQCpMLmbeFZh5dem+tdNcGHC4iY1KE4BMNoGuCBgfBV/T08SYVaI0ko2KXi+altLhA==
X-Received: by 2002:a2e:9759:: with SMTP id f25mr175210ljj.173.1572267421409;
        Mon, 28 Oct 2019 05:57:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a11sm5241245ljp.97.2019.10.28.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:57:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C0662100242; Mon, 28 Oct 2019 15:57:02 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:57:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
Message-ID: <20191028125702.xdfbs7rqhm3wer5t@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:47:16PM +0100, Linus Torvalds wrote:
> On Mon, Oct 28, 2019 at 1:42 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > I've tried something of this sort back in 2013:
> >
> > http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com
> >
> > and I've got push back.
> >
> > Apparently, some filesystems may not have valid i_size before >readpage().
> > Not sure if it's still the case...
> 
> Well, I agree that there might be some network filesystem that might
> have inode sizes that are stale, but if that's the case then I don't
> think your previous patch works either.
> 
> It too will avoid the readpage() if the read position is beyond i_size.
> 
> No?

Yes. That's the reason the patch was rejected back then.

My point is that we need to make sure that this patch not break anything.

-- 
 Kirill A. Shutemov
