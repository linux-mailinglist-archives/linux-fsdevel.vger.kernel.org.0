Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD271D5810
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 19:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEORgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEORgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 13:36:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5FC061A0C;
        Fri, 15 May 2020 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=KPB9Sq7v2TPIcM7TwZzzPQ/MWQa+9wV74BLtgx752QQ=; b=U/8Wfjg7133SCpQIG23VFFwrAZ
        twxYvuI7OiFfpjrFh9POhb8+hW0O0twkQdQa3wWY8PoGelF3Y8KremKd+FnWEhkp4tfLweqZygl8t
        9Kj/SlpYGVg/9mUb4XUDA+qleSCXx8pf0k5tkT43mWMCStsFiOqWt5XCPGjj5UiFfmYBz9H0HJjNj
        tmt/oqSYw6oOH0wp46JZqHPaorOJF8IMCuvVtPyMVlxDlGF5asN6/RU41czRdIdVVtQBrLeZknHCa
        uQ19ijNuZOWlV4UvaDOcsGsUMQeAJyPpXVXVvz9OGL7O93uGEn4mB3cuxYBanRc0DBY75sMJbfq8c
        xI6f1kNg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZeFg-00077f-VP; Fri, 15 May 2020 17:36:05 +0000
Subject: Re: [PATCH -next] nfs: fsinfo: fix build when CONFIG_NFS_V4 is not
 enabled
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
References: <f91b8f29-271a-b5cd-410b-a43a399d34aa@infradead.org>
 <7c446f9f404135f0f4109e03646c4ce598484cae.camel@hammerspace.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e6ff78d-1c18-789b-a0ef-adf87a891a58@infradead.org>
Date:   Fri, 15 May 2020 10:36:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7c446f9f404135f0f4109e03646c4ce598484cae.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/20 10:33 AM, Trond Myklebust wrote:
> On Fri, 2020-05-15 at 10:27 -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix multiple build errors when CONFIG_NFS_V4 is not enabled.
>>
>> ../fs/nfs/fsinfo.c: In function 'nfs_fsinfo_get_supports':
>> ../fs/nfs/fsinfo.c:153:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
>>             ^~
>> ../fs/nfs/fsinfo.c:155:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
>>             ^~
>> ../fs/nfs/fsinfo.c:158:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE)
>>             ^~
>> ../fs/nfs/fsinfo.c:160:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN)
>>             ^~
>> ../fs/nfs/fsinfo.c:162:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
>>             ^~
>> ../fs/nfs/fsinfo.c: In function 'nfs_fsinfo_get_features':
>> ../fs/nfs/fsinfo.c:205:12: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
>>             ^~
>> ../fs/nfs/fsinfo.c:207:13: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>   if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
>>              ^~
>> ../fs/nfs/fsinfo.c:208:13: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>       (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
>>              ^~
>> ../fs/nfs/fsinfo.c:209:13: error: 'const struct nfs_server' has no
>> member named 'attr_bitmask'
>>       (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
>>              ^~
>>
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: linux-nfs@vger.kernel.org
>> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Cc: Anna Schumaker <anna.schumaker@netapp.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: David Howells <dhowells@redhat.com>
>> ---
>>  fs/nfs/fsinfo.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> --- linux-next-20200515.orig/fs/nfs/fsinfo.c
>> +++ linux-next-20200515/fs/nfs/fsinfo.c
>> @@ -5,6 +5,7 @@
>>   * Written by David Howells (dhowells@redhat.com)
>>   */
>>  
>> +#include <linux/kconfig.h>
>>  #include <linux/nfs_fs.h>
>>  #include <linux/windows.h>
>>  #include "internal.h"
>> @@ -150,6 +151,7 @@ static int nfs_fsinfo_get_supports(struc
>>  		sup->stx_mask |= STATX_CTIME;
>>  	if (server->caps & NFS_CAP_MTIME)
>>  		sup->stx_mask |= STATX_MTIME;
>> +#if IS_ENABLED(CONFIG_NFS_V4)
>>  	if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
>>  		sup->stx_mask |= STATX_SIZE;
>>  	if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
>> @@ -161,6 +163,7 @@ static int nfs_fsinfo_get_supports(struc
>>  		sup->win_file_attrs |= ATTR_HIDDEN;
>>  	if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
>>  		sup->win_file_attrs |= ATTR_SYSTEM;
>> +#endif
>>  
>>  	sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
>>  	return sizeof(*sup);
>> @@ -202,12 +205,14 @@ static int nfs_fsinfo_get_features(struc
>>  	if (server->caps & NFS_CAP_MTIME)
>>  		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
>>  
>> +#if IS_ENABLED(CONFIG_NFS_V4)
>>  	if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
>>  		fsinfo_set_feature(ft, FSINFO_FEAT_NAME_CASE_INDEP);
>>  	if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
>>  	    (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
>>  	    (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
>>  		fsinfo_set_feature(ft, FSINFO_FEAT_WINDOWS_ATTRS);
>> +#endif
>>  
>>  	return sizeof(*ft);
>>  }
> 
> This whole thing needs to be reviewed and acked by the NFS community,

Certainly.

> and quite frankly I'm inclined to NAK this. This is the second time
> David tries to push this unwanted rewrite of totally unrelated code.

No problem on that. I just want it to build cleanly.

thanks.
-- 
~Randy

