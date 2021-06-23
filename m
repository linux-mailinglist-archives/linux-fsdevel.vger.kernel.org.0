Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BFD3B220D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWUyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 16:54:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWUyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:54:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AB7441FD36;
        Wed, 23 Jun 2021 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624481522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pno0iBvl7Og2VotN4ME97iSVGJU1tjWCZ12ImwNbcgE=;
        b=EkY1PsG1IeylG0v9sboqUVwbuZoIvaM37W1N+lUf8tRWjg12fi/kGPy6sGODdFXyt+kJn6
        baHE/CQ5UtxsrFgvUHgPfyeijvIV/EcArD9/v5/y7M+haLsdDaOKhQPg/qPXKztCn78Fm0
        m0ZVVQnlt7jZgfTUSmQKEgYtVrqOo4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624481522;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pno0iBvl7Og2VotN4ME97iSVGJU1tjWCZ12ImwNbcgE=;
        b=PKjwJAt7LWLIuzGGrtYJktRR8vM+jXOXKIb89mMGdvpeXSi5rIBRVnGp6RDsMYUowVwe0J
        Hy/sQOyzieDHHTBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9C0CDA3BB1;
        Wed, 23 Jun 2021 20:52:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F302ADA908; Wed, 23 Jun 2021 22:49:10 +0200 (CEST)
Date:   Wed, 23 Jun 2021 22:49:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: the major/minor value of statx(kernel samples/vfs/test-statx.c)
 does not match /usr/bin/stat
Message-ID: <20210623204910.GO28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dhowells@redhat.com
References: <20210617181256.63EB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617181256.63EB.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:12:56PM +0800, Wang Yugui wrote:
> the major/minor value of statx(kernel samples/vfs/test-statx.c) does not
> match /usr/bin/stat. 
> 
> major/minor of statx result seems be truncated by something like
> old_decode_dev()?

I've checked the code first, both stat/statx seem to be doing the same
thing.

> [root@T640 vfs]# ./test-statx /ssd/
> statx(/ssd/) = 0
> results=1fff
>   Size: 200             Blocks: 0          IO Block: 4096    directory
> Device: 00:31           Inode: 256         Links: 1

So Device is 00:31, printed as two fields in hex.

> Access: (0755/drwxr-xr-x)  Uid:     0   Gid:     0
> Access: 2021-06-16 19:16:56.644344956+0800
> Modify: 2021-05-06 16:14:33.676248229+0800
> Change: 2021-05-06 16:14:33.676248229+0800
>  Birth: 2020-11-18 14:03:35.324915316+0800
> Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... .---.-..)
> [root@T640 vfs]# stat /ssd/
>   File: ‘/ssd/’
>   Size: 200             Blocks: 0          IO Block: 4096   directory
> Device: 31h/49d Inode: 256         Links: 1

And here it's also 31, the 'h' suffix means it's hexadecimal and "49d"
si the same value in decimal.

> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2021-06-16 19:16:56.644344956 +0800
> Modify: 2021-05-06 16:14:33.676248229 +0800
> Change: 2021-05-06 16:14:33.676248229 +0800
>  Birth: -
> 
> vfat output sample:
> [root@T640 vfs]# ./test-statx /boot/efi/
> statx(/boot/efi/) = 0
> results=17ff
>   Size: 4096            Blocks: 8          IO Block: 4096    directory
> Device: 08:01           Inode: 1           Links: 3

08:01

> Access: (0700/drwx------)  Uid:     0   Gid:     0
> Access: 1970-01-01 08:00:00.000000000+0800
> Modify: 1970-01-01 08:00:00.000000000+0800
> Change: 1970-01-01 08:00:00.000000000+0800
> Attributes: 0000000000002000 (........ ........ ........ ........ ........ ..-..... ..?-.... ........)
> [root@T640 vfs]# stat /boot/efi/
>   File: ‘/boot/efi/’
>   Size: 4096            Blocks: 8          IO Block: 4096   directory
> Device: 801h/2049d      Inode: 1           Links: 3

801h == 0801h the same value, so it's just a matter of formatting the
output and the values are indeed the same.

If you change the format in test-statx.c to  "%2xh/%2dd" and the value
to "(stx->stx_dev_major << 8) + stx->stx_dev_minor", the output is
exactly the same.
