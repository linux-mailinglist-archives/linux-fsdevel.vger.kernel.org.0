Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A724E2D36CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 00:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgLHXQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 18:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:16:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47CC0613D6;
        Tue,  8 Dec 2020 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=E+S79NxXtXZvWU7yR5R96CB53fdCfSscjaREn60hxaQ=; b=jt4QRfprixCRm3FoESEGq24COb
        r3si0Q+hvoW6LRVid49gwZaLRwodTWEoF75Brevquncqim/vh2WVVE1pozmXKaDLgh+ZmejTUCgFk
        VnDKTMvtTIMIEwGfCGBWrk9raiARMW8amoBrTXhSwG1C5obfEW5DR1DkV0MXbeKNefsGZq5zoB82m
        UsG7/BX0VR3sOtwbWRqBV4mdJ6acWIWpydIFrXIOUiss8OC80spOmvpdtmr0MbKe1LfYdUgZ2ehQC
        BUqVX6g/tyxy9xcpYcJb7Vo2mBN+ijqwamn/BGpHtixVcEGXWA0MzQtwOsJ2r8FoiUsf8MyFMubIi
        zlN6JsVg==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmmCy-0000dW-1m; Tue, 08 Dec 2020 23:15:48 +0000
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org>
 <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org>
 <0000000000002a530d05b400349b@google.com>
 <928043.1607416561@warthog.procyon.org.uk>
 <1030308.1607468099@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e6d9fd7e-ea43-25a6-9f1e-16a605de0f2d@infradead.org>
Date:   Tue, 8 Dec 2020 15:15:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1030308.1607468099@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/8/20 2:54 PM, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>> Now the backtrace only shows what the state was when the string was allocated;
>>> it doesn't show what happened to it after that, so another possibility is that
>>> the filesystem being mounted nicked what vfs_parse_fs_param() had rightfully
>>> stolen, transferring fc->source somewhere else and then failed to release it -
>>> most likely on mount failure (ie. it's an error handling bug in the
>>> filesystem).
>>>
>>> Do we know what filesystem it was?
>>
>> Yes, it's call AFS (or kAFS).
> 
> Hmmm...  afs parses the string in afs_parse_source() without modifying it,
> then moves the pointer to fc->source (parallelling vfs_parse_fs_param()) and
> doesn't touch it again.  fc->source should be cleaned up by do_new_mount()
> calling put_fs_context() at the end of the function.
> 
> As far as I can tell with the attached print-insertion patch, it works, called
> by the following commands, some of which are correct and some which aren't:
> 
> # mount -t afs none /xfstest.test/ -o dyn
> # umount /xfstest.test 
> # mount -t afs "" /xfstest.test/ -o foo
> mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
> # umount /xfstest.test 
> umount: /xfstest.test: not mounted.
> # mount -t afs %xfstest.test20 /xfstest.test/ -o foo
> mount: /xfstest.test: bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
> # umount /xfstest.test 
> umount: /xfstest.test: not mounted.
> # mount -t afs %xfstest.test20 /xfstest.test/ 
> # umount /xfstest.test 
> 
> Do you know if the mount was successful and what the mount parameters were?

Here's the syzbot reproducer:
https://syzkaller.appspot.com/x/repro.c?x=129ca3d6500000

The "interesting" mount params are:
	source=%^]$[+%](${:\017k[)-:,source=%^]$[+.](%{:\017\200[)-:,\000

There is no other AFS activity: nothing mounted, no cells known (or
whatever that is), etc.

I don't recall if the mount was successful and I can't test it just now.
My laptop is mucked up.


Be aware that this report could just be a false positive: it waits
for 5 seconds then looks for a memleak. AFAIK, it's possible that the "leaked"
memory is still in valid use and will be freed some day.


> David
> ---
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 6c5900df6aa5..4c44ec0196c9 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -299,7 +299,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->cell = cell;
>  	}
>  
> -	_debug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
> +	kdebug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
>  	       ctx->cell->name, ctx->cell,
>  	       ctx->volnamesz, ctx->volnamesz, ctx->volname,
>  	       suffix ?: "-", ctx->type, ctx->force ? " FORCE" : "");
> @@ -318,6 +318,8 @@ static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	struct afs_fs_context *ctx = fc->fs_private;
>  	int opt;
>  
> +	kenter("%s,%p '%s'", param->key, param->string, param->string);
> +
>  	opt = fs_parse(fc, afs_fs_parameters, param, &result);
>  	if (opt < 0)
>  		return opt;
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa6e8..f530a33876ce 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -450,6 +450,8 @@ void put_fs_context(struct fs_context *fc)
>  	put_user_ns(fc->user_ns);
>  	put_cred(fc->cred);
>  	put_fc_log(fc);
> +	if (strcmp(fc->fs_type->name, "afs") == 0)
> +		printk("PUT %p '%s'\n", fc->source, fc->source);
>  	put_filesystem(fc->fs_type);
>  	kfree(fc->source);
>  	kfree(fc);
> @@ -671,6 +673,8 @@ void vfs_clean_context(struct fs_context *fc)
>  	fc->s_fs_info = NULL;
>  	fc->sb_flags = 0;
>  	security_free_mnt_opts(&fc->security);
> +	if (strcmp(fc->fs_type->name, "afs") == 0)
> +		printk("CLEAN %p '%s'\n", fc->source, fc->source);
>  	kfree(fc->source);
>  	fc->source = NULL;
>  
> 

I'll check more after my test machine is working again.

thanks.
-- 
~Randy

