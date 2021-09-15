Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966F40C89E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhIOPqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 11:46:10 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35834 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhIOPqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:46:10 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 784101DFE;
        Wed, 15 Sep 2021 18:44:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631720689;
        bh=C1wc08fKU2WdcMNukQweD6oi5adNTrQv/uJCJAmSZpU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=d0W7jGHOvhYCxPZZkWKWPGflpqn3Q4cRXfgSNvyuUHJCdFLVPOMtZ54sxf6iXxQ2w
         2DtUs4gMBIBlRpYaKA3a1uYqy37jaFVTxoAJaXo1YXrapqOfjgkuw3R1czzhWYOInv
         tW2+qmBlQTI3bpkLYLaZtsuBZuluMbbBR8zp9IR8=
Received: from [192.168.211.19] (192.168.211.19) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 15 Sep 2021 18:44:49 +0300
Message-ID: <2609058c-7b2d-fc66-3589-bd0337fd0a9e@paragon-software.com>
Date:   Wed, 15 Sep 2021 18:44:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: fs/ntfs3: Runtree implementation with rbtree or others
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20210910181227.4tr3xn2aooeo2lvw@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210910181227.4tr3xn2aooeo2lvw@kari-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.19]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10.09.2021 21:12, Kari Argillander wrote:
> Hello.
> 
> Konstantin you have wrote in ntfs_fs.h in struct runs_tree:
> 
> /* TODO: Use rb tree instead of array. */
> struct runs_tree {
> 	struct rb_root root;
> 
> 	struct ntfs_run *runs;
> 	size_t count; /* Currently used size a ntfs_run storage. */
> 	size_t allocated; /* Currently allocated ntfs_run storage size. */
> };
> 
> 
> But right now it is not array. It is just memory. Probably some early
> comment, but I check that little bit and I think rb tree may not be good
> choice. Right now we allocate more memory with kvmalloc() and then make
> space for one entry with memmove. I do not quite understand why cannot
> memory be other way around. This way we do not memmove. We can just put
> new entry to other end right?
> 
> Also one thing what comes to my mind is to allocate page at the time. Is
> there any drawbacks? If we do this with rb_tree we get many small entrys
> and it also seems to problem. Ntfs-3g allocate 4kiB at the time. But
> they still reallocate which I think is avoidable.
> 
> Also one nice trick with merging two run_tree togethor would be not to
> allocate new memory for it but just use pointer to other list. This way
> we can have big run_tree but it is in multi page. No need to reallocate
> with this strategy. 
> 
> I just want some thoughts about this before starting implementation. If
> you think rb_tree would be right call then I can do that. It just seems
> to me that it might not be. But if search speed is big factor then it
> might be. I just do not yet understand enogh that I can fully understand
> benefits and drawbacks.
> 
>   Argillander
> 

Hello.

Rb tree is used in ext4 in similar use case (see extent_status in
fs/ext4/extents_status.h and fs/ext4/extents_status.c).
But ntfs3 use relatively small number of elements. 
Tests on fragmented volume showed < 64000 elements in array.
So rb tree probably won't give big benefit. It can even consume more memory.
It is difficult to predict, only comparison between current
implementation and rb tree will answer question "what is better?".
That's why it's not urgent TODO.

Konstantin
