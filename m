Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270833A8D18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFPAAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 20:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhFPAAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:00:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F65C061574;
        Tue, 15 Jun 2021 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ql83LcvTl1dmYyiiDpq5vOZPP/K43XvgGPAif1phT98=; b=P+vl3r2U7Ci4grk1NTj5lyylIL
        tBM4aTOxbnvYXs9MOD+SxkVpBx5yFGts3MNHRzzyQzFWhTPh0TZADTTO7aTvy5+FEx/FjArEEwo+f
        l4BuuAu8bJS6EJ2U4t2tjznGOtmH2B6a0fFZMvVi8G4vN3xfDpJatxdwI4ihB08WT+7oENbolgksr
        hSyi1XF+gYHx0JUr2R+3Ic7brc2+uutM7nELF1Wt40aC31PY5Nw5u/ZoopO4oaLMfYQnfHdXxx7C2
        hU1YLq4/7EfioKUfn8SpJWrFHvoO4vBmFcO5qxglZ63ttsP74K5fOQgEl/T5YiJK8giv8eeyyEbUZ
        +ZdxqwPw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltIwa-00429X-OH; Tue, 15 Jun 2021 23:58:08 +0000
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
Date:   Tue, 15 Jun 2021 16:58:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/21 7:49 AM, Linus Torvalds wrote:
> On Tue, Jun 15, 2021 at 4:55 AM David Howells <dhowells@redhat.com> wrote:
>>
>> From: Zheng Zengkai <zhengzengkai@huawei.com>
>>
>> Add missing return to fix following compilation issue:
>>
>> fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
>> fs/afs/dir.c:51:1: error: no return statement in function
>> returning non-void [-Werror=return-type]
> 
> This warning is actively wrong, and the patch is the wrong thing to do.
> 
> What compiler / architecture / config?
> 
> Because BUG() should have an "unreachable()", and the compiler should
> know that a return statement isn't needed (and adding it shouldn't
> make any difference).
> 
> And it's not warning for me when I build that code. So I really think
> the real bug is entirely somewhere else, and this patch is papering
> over the real problem.

Hi,

Some implementations of BUG() are macros, not functions, so "unreachable"
is not applicable AFAIK.


-- 
~Randy

