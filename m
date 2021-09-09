Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C2405B03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhIIQkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 12:40:18 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:42558 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232192AbhIIQkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:40:18 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1DD5A1D24;
        Thu,  9 Sep 2021 19:39:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631205546;
        bh=Ah4+46r6nDVwZfNEa9ffS5opMw0+uC0WLLzuSRXzu8A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UueLkuTdfOdie9h3/mwjNGsgiHnS4bt3wgnmhfKdmgGvyO7s5kqo1RaHOLSA+9sz7
         ZyogONE6ERN5hly94a/Cyc17c4NokwSWsrQIwfLvuHh9odXgwpW4jYcQE+E6I0TRHf
         gpVzq+LePzy6QXLrtqln9pYAC8J4n395pdB3IbK8=
Received: from [192.168.211.46] (192.168.211.46) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 9 Sep 2021 19:39:05 +0300
Message-ID: <6a4ef0b6-a855-646a-91cc-81060b63850f@paragon-software.com>
Date:   Thu, 9 Sep 2021 19:39:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v4 0/9] fs/ntfs3: Use new mount api and change some opts
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.46]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 07.09.2021 18:35, Kari Argillander wrote:
> v3 link:
> lore.kernel.org/ntfs3/20210829095614.50021-1-kari.argillander@gmail.com
> 
> This series will delete unnecessary mount options and rename some.
> Also this will convert ntfs3 to use new mount api. In my opinion we
> should get this in 5.15 because after that basically we have to have
> deprecated flag with new mount options. Let's try to avoid that if
> possible.
> 
> v4:
> 	- Rebased top of the current ntfs3/master
> 	- Rename mount option (no)acs_rules -> (no)acsrules
> 	- Fix acs commit message acl -> acs (Thank Pali)
> v3:
> 	- Add patch "Convert mount options to pointer in sbi"
> 	- Add patch "Init spi more in init_fs_context than fill_super"
> 	- Add patch "Show uid/gid always in show_options"
> 	- Patch "Use new api for mounting" has make over
> 	- NLS loading is not anymore possible when remounting
> 	- show_options() iocharset printing is fixed
> 	- Delete comment that testing should be done with other
> 	  mount options.
> 	- Add reviewed/acked-tags to 1,2,6,8 
> 	- Rewrite this cover
> v2:
> 	- Rewrite this cover leter
> 	- Reorder noatime to first patch
> 	- NLS loading with string
> 	- Delete default_options function
> 	- Remove remount flags
> 	- Rename no_acl_rules mount option
> 	- Making code cleaner
> 	- Add comment that mount options should be tested
> 
> Kari Argillander (9):
>   fs/ntfs3: Remove unnecesarry mount option noatime
>   fs/ntfs3: Remove unnecesarry remount flag handling
>   fs/ntfs3: Convert mount options to pointer in sbi
>   fs/ntfs3: Use new api for mounting
>   fs/ntfs3: Init spi more in init_fs_context than fill_super
>   fs/ntfs3: Make mount option nohidden more universal
>   fs/ntfs3: Add iocharset= mount option as alias for nls=
>   fs/ntfs3: Rename mount option no_acs_rules > (no)acsrules
>   fs/ntfs3: Show uid/gid always in show_options()
> 
>  Documentation/filesystems/ntfs3.rst |  10 +-
>  fs/ntfs3/attrib.c                   |   2 +-
>  fs/ntfs3/dir.c                      |   8 +-
>  fs/ntfs3/file.c                     |   4 +-
>  fs/ntfs3/inode.c                    |  12 +-
>  fs/ntfs3/ntfs_fs.h                  |  26 +-
>  fs/ntfs3/super.c                    | 498 +++++++++++++++-------------
>  fs/ntfs3/xattr.c                    |   2 +-
>  8 files changed, 290 insertions(+), 272 deletions(-)
> 
> 
> base-commit: 2e3a51b59ea26544303e168de8a0479915f09aa3
> 

Applied, thanks for patches and review!

Best regards,
Konstantin
