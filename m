Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E91C2E7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgECS2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 14:28:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgECS2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 14:28:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 76D392A0CEA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
Organization: Collabora
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
        <20200503032613.GE29705@bombadil.infradead.org>
        <87368hz9vm.fsf@vostro.rath.org>
        <20200503102742.GF29705@bombadil.infradead.org>
Date:   Sun, 03 May 2020 14:28:34 -0400
In-Reply-To: <20200503102742.GF29705@bombadil.infradead.org> (Matthew Wilcox's
        message of "Sun, 3 May 2020 03:27:42 -0700")
Message-ID: <85d07kkh4d.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
>> Here's what I got:
>> 
>> [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
>> [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
>> [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
>> [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
>> [  221.277272] page dumped because: fuse: trying to steal weird page
>> [  221.277273] page->mem_cgroup:ffff9aec11beb000
>
> Great!  Here's the condition:
>
>         if (page_mapcount(page) ||
>             page->mapping != NULL ||
>             page_count(page) != 1 ||
>             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
>              ~(1 << PG_locked |
>                1 << PG_referenced |
>                1 << PG_uptodate |
>                1 << PG_lru |
>                1 << PG_active |
>                1 << PG_reclaim))) {
>
> mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
> flags has 'waiters' set, which is not in the allowed list.  I don't
> know the internals of FUSE, so I don't know why that is.
>

Hi

On the first message, Nikolaus sent the following line:

>> [ 2333.009937] fuse: page=00000000dd1750e3 index=2022240 flags=17ffffc0000097, count=1,
>> mapcount=0, mapping=00000000125079ad

It should be noted that on the second run, where we got the dump_page
log, it indeed had a null mapping, which is similar to what Nikolaus
asked on the previous thread he linked to, but looks like this wasn't
the case on at least some of the reproductions of the issue.  On the
line above, the condition that triggered the warning was page->mapping
!= NULL.  I don't know what to do with this information, though.



-- 
Gabriel Krisman Bertazi
