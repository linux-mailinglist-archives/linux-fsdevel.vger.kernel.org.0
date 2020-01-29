Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887E814C8F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgA2Kut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 05:50:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38705 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2Kut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:50:49 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so16518763iog.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWJyJn0sfT0Zc5yi27vWrHQD81AWkTLfYCa1678fPLo=;
        b=Gf6CTpyTECKUTC/bnNsYZb4GH5leoYRRcnPTp/KFi5JNN2XMLYSfBihxGeTsEnp2ln
         C44X0C640MPWJZyTWqRyHbZRRHCdrh4gjmkUk63NkrWuXsI505/vERefKnBHYvNT0O3u
         n8U5fx/OyDpaZcvna3pGyEuw8SqEvSaEVn+Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWJyJn0sfT0Zc5yi27vWrHQD81AWkTLfYCa1678fPLo=;
        b=heWgcmrHC24iuM/lDjAuM11mGtYL3L5IShSodzUjvDZnv6/TIdAykneyNu9xc8E/Up
         0U4StiNK+jFdpwPHjUJ82wvekgw0nh69EELzBV8aDMv0N6fgA/e7fHHWwYRTtec8A0sF
         Q1dcSDW/xQBM7WEUGC2vhw9Td6q6AGljIjINNUyRVVhC3ku9TQx7U+of26hRR+O1bNXI
         0akckWzJO9446ftr/BYLOfYmu/Gyd4HyOsb/4/gYPUBMX7IyMQ2F/6cinpW6OEB4Y+cb
         wS14v14EDiXijHDxJjSKXMCAmv6nepHOI3q23Rl9+I+wYYjyucBSVb+utrEMqBToGjr+
         Xwxg==
X-Gm-Message-State: APjAAAWrjJNvLMqTpDc9nuLKuUZhHiemGauydiEHotzvLpqVcyKBI1gb
        SK/a+zcx4/FGylavP173TkUYZ+NFbDoeJx3hr67oig==
X-Google-Smtp-Source: APXvYqyMwMa1EZLvilOnOqucjHfFowYylcPwKRIaPLXouVwygD13i61Qx/FolEShfxCTy2yX3s8VN1aTQydpbYCRsB8=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr21031873jap.35.1580295048355;
 Wed, 29 Jan 2020 02:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20200125013553.24899-1-willy@infradead.org> <20200125013553.24899-12-willy@infradead.org>
In-Reply-To: <20200125013553.24899-12-willy@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 Jan 2020 11:50:37 +0100
Message-ID: <CAJfpegvk2ZHzZCriAjdWoKvDXLtXi_c4mh34qLfy9O89+oAwhQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 25, 2020 at 2:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in fuse.  Switching away from the
> read_cache_pages() helper gets rid of an implicit call to put_page(),
> so we can get rid of the get_page() call in fuse_readpages_fill().
> We can also get rid of the call to fuse_wait_on_page_writeback() as
> this page is newly allocated and so cannot be under writeback.

Not sure.  fuse_wait_on_page_writeback() waits not on the page but the
byte range indicated by the index.

Fuse writeback goes through some hoops to prevent reclaim related
deadlocks, which means that the byte range could still be under
writeback, yet the page belonging to that range be already reclaimed.
 This fuse_wait_on_page_writeback() is trying to serialize reads
against such writes.

Thanks,
Miklos
