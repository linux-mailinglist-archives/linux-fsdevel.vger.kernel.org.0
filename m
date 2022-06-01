Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCA253A2B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiFAKgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiFAKgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:36:00 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2317CB42
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 03:35:59 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 79C522119;
        Wed,  1 Jun 2022 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654079725;
        bh=YgDrvBgUvJh+6P8NwSrR5bjM/P2LEZxHnR5wsl3bbgc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lZtPL+DPqCp0Lwph2fhLeBLc1i4OhthAWfTVBX5Fjg1POTOIWQI9jKqob+ve3TcYm
         7pDPZrhRjZMk2XvzM/VhnlRDEHW/zg/2bMu64/fH0hO1qv1rO13nyLffNv7+S609eu
         k1KD1wQax4Jre/Gm/peHtd4yuLC3PsHzadTdoW1Y=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4D1FF217C;
        Wed,  1 Jun 2022 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654079757;
        bh=YgDrvBgUvJh+6P8NwSrR5bjM/P2LEZxHnR5wsl3bbgc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CixO/VlaTepOKGHFXQpU5ACzd6Lj9bs/i8ah/l84OsUs6FvvH/WB4Wy2dkktn7WL9
         UonSKnSMd5+9lOzGIFZOpJFdrQMQwpPUGpPJWqs21cHumAgqF4MQZvc+/Ejx15o6H4
         jRE8ip3BTxNAATxulBnLOjdbdUbhWcE8KTddWnYM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 1 Jun 2022 13:35:57 +0300
Message-ID: <8e0646b8-0572-fd3e-580c-b19d738aba93@paragon-software.com>
Date:   Wed, 1 Jun 2022 13:35:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ntfs3: provide block_invalidate_folio to fix memory leak
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>, <manualinux@yahoo.es>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
References: <20220524075112.5438df32.ref@yahoo.es>
 <20220524075112.5438df32@yahoo.es>
 <alpine.LRH.2.02.2205240501130.17784@file01.intranet.prod.int.rdu2.redhat.com>
 <20220524113314.71fe17f0@yahoo.es> <20220525130538.38fd3d35@yahoo.es>
 <20220527072629.332b078d@yahoo.es> <20220527080211.15d631be@yahoo.es>
 <alpine.LRH.2.02.2205271338250.20527@file01.intranet.prod.int.rdu2.redhat.com>
 <20220528061836.22230f86@yahoo.es> <20220530131524.7fb5640d@yahoo.es>
 <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/30/22 15:00, Mikulas Patocka wrote:
> 
> 
> On Mon, 30 May 2022, manualinux@yahoo.es wrote:
> 
>>
>> Hello again,
>>
>> When you have time, try moving a large file from a SpadFS partition to
>> an NTFS partition mounted with the NTFS3 driver and with a 5.18 kernel,
>> and then, move the same file back again, to the SpadFS partition. At
>> that very moment is when the size of the file remains permanently in
>> the system memory (in my particular case). This does not happen if we
>> do it to another Linux file system, nor does it happen if we do it from
>> a NTFS partition to another XFS or Ext4 partition.
>>
>> So no ccache or anything, I swap files quite often between the SpadFS
>> partition and an external hard disk with an NTFS partition. Anyway,
>> this problem is really unusual, and it must have some technical
>> explanation, because with the ntfs-3g driver this doesn't happen.
>>
>> If this information is of any use to you I will be satisfied.
>>
>> Regards,
>>       
>> José Luis Lara Carrascal - Webmaster de Manualinux - GNU/Linux en
>> Español (https://manualinux.es)
> 
> Hi
> 
> SpadFS is innocent here :)
> 
> The NTFS3 driver in the kernel 5.18 contains the same bug as SpadFS did -
> missing the invalidate_folio method. This patch adds this method and fixes
> the bug.
> 
> Mikulas
> 
> 
> 
> Author: Mikulas Patocka <mpatocka@redhat.com>
> 
> The ntfs3 filesystem lacks the 'invalidate_folio' method and it causes
> memory leak. If you write to the filesystem and then unmount it, the
> cached written data are not freed and they are permanently leaked.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: José Luis Lara Carrascal <manualinux@yahoo.es>
> Fixes: 7ba13abbd31e ("fs: Turn block_invalidatepage into block_invalidate_folio")
> Cc: stable@vger.kernel.org	# v5.18
> 
> ---
>   fs/ntfs3/inode.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/fs/ntfs3/inode.c
> ===================================================================
> --- linux-2.6.orig/fs/ntfs3/inode.c	2022-05-16 16:57:24.000000000 +0200
> +++ linux-2.6/fs/ntfs3/inode.c	2022-05-30 13:36:45.000000000 +0200
> @@ -1951,6 +1951,7 @@ const struct address_space_operations nt
>   	.direct_IO	= ntfs_direct_IO,
>   	.bmap		= ntfs_bmap,
>   	.dirty_folio	= block_dirty_folio,
> +	.invalidate_folio = block_invalidate_folio,
>   };
>   
>   const struct address_space_operations ntfs_aops_cmpr = {


Thanks for patch, applied!
