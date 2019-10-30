Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58C7E96CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfJ3Gul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 02:50:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32928 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3Gul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:50:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id t5so1383820ljk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OG8TB5Z3OxSF2gHsUrhZBaXhf5Zgk82Z4whv67njgvw=;
        b=iLvr36c6OKkhrzfRc9P24L3/yvyhg95cNQYYiDkqVk0XocMpM/RrtgKRStDaUTD3hy
         t2Z0iDKBFn68feV/JPUoOeIYNM+dK/jviWrlQ3W7ulycbYjsHU+hCuO79lVCfrOfbTop
         cLCG/NjL2OtAkcfDNYvkxpg6oKlzy09qag8StQ1AqeV0MbViYA6fvhdaco9LZU6ImE0Y
         67+/dTZGp153XQPFxmdJtAEHsJXq+6OL+P18Khdb4abA1itzfm8Cj7nWJrF/TKDbmpY8
         BTg7htB/XoXzxNe162ot9/hSu5WFDQkQbeF/B4vzWpL57AnMPUDdq8rbY4PXirZ9wer7
         bKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OG8TB5Z3OxSF2gHsUrhZBaXhf5Zgk82Z4whv67njgvw=;
        b=NZIGT/410l9iqKNMVcNs1THsQP9p8I4p85Du9MuCUYnvQF4d2fUP2VphSLJBJj/BQX
         IdLnP2KQ7FjwE8dNNCRzxUkVrbr2mEc71Mk16SlN3bh2M3MMSqKut9f2elZeHzmeKQqh
         6TetWQ7Ak6O32lcB4zOwfhenxNsfZYH+S208QSsbFFvcpIR5pvTaiPZ7BOg5l86gnUc2
         SUWXg0Ke8IeJV97M3OwxFcG4GLHcHg3BigdE25xpMbnF423FEM53NuA3H55a0CTZXNFk
         0NUd8JXx+QEvQDb8n5Hi2upcANdnVRLu3ygrb3Oe2NxI5l+tiAnenhPv3/Y0yq9+NCnF
         xjoQ==
X-Gm-Message-State: APjAAAU3RPyfGQgoLfPAjur5NkZIezTTLV0cAvuDfgqsGb2hRlMwzQKl
        IsEFebZiYCX4OYrxXtrg6sWwYw==
X-Google-Smtp-Source: APXvYqyogKk2T+hF/rDbEusxizB/QjtNb9b5jF9FBYmoPBYmHE2zvO/6BoiLQKZ0srYAn7ZqDqdzNA==
X-Received: by 2002:a2e:151c:: with SMTP id s28mr5291987ljd.70.1572418239710;
        Tue, 29 Oct 2019 23:50:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n5sm640209ljh.54.2019.10.29.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 23:50:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D87181003C9; Wed, 30 Oct 2019 09:50:37 +0300 (+03)
Date:   Wed, 30 Oct 2019 09:50:37 +0300
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
Message-ID: <20191030065037.o3q6usc5vo3woif6@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box>
 <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box>
 <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:52:05PM +0100, Linus Torvalds wrote:
> But NFS, for example, has open/close consistency, so the metadata
> revalidation is at open() time, not at read time.

I don't know much about filesystems, but can't size of file change after
the open() under network filesystem? Revlidation on read looks like an
requirement anyway, no?

-- 
 Kirill A. Shutemov
