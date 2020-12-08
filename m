Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83572D3000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 17:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLHQmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgLHQmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:42:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A6C0613D6;
        Tue,  8 Dec 2020 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=AtL8wx9VklKxBINtSQ3AopQN3khwzpEuE4AVdNvGdcY=; b=l+QQOGJJnRgpYOU9qHYVK8RBzH
        SXZQUa+bN3VfnU1BkiZlzQ1SF4Q2dMPSA0ozil0UZNz3xIlB2LPbxZ7WMxnBP/HThV6BlBv7+VRlx
        OhzsQ3xqNQt4ft6HluPpCugMs/9EhEjhCyTSCfOc8nvh+8z6K/RvimOqJpp37Qooxng7j9ixI6Y/y
        1qaDYh+q3gz17FVkZMbLnn6Ae1niTz55MEXUUra/sSUcjd3iex0400g1IrxKLDdlnzvhCbBad6Ibg
        EF2tlMu50B7Cp0WobPMVJgtZBEcDqeqbe0r8TW3/69aWnL6PhFHPLEnVoln7TvMmk+rak6fvEEzVU
        PC6yoIqg==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmg3p-0004f3-9B; Tue, 08 Dec 2020 16:41:57 +0000
Subject: Re: memory leak in generic_parse_monolithic [+PATCH]
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <6db2af99-e6e3-7f28-231e-2bdba05ca5fa@infradead.org>
 <0000000000002a530d05b400349b@google.com>
 <928043.1607416561@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c752ffe-8118-f9ea-e928-d92783a5c516@infradead.org>
Date:   Tue, 8 Dec 2020 08:41:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <928043.1607416561@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/8/20 12:36 AM, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Otherwise please look at the patch below.
> 
> The patch won't help, since it's not going through sys_fsconfig() - worse, it
> introduces two new errors.
> 
>>  		fc->source = param->string;
>> -		param->string = NULL;
> 
> This will cause the string now attached to fc->source to be freed by the
> caller.  No, the original is doing the correct thing here.  The point is to
> steal the string.
> 
>> @@ -262,7 +262,9 @@ static int vfs_fsconfig_locked(struct fs
>>
>> -		return vfs_parse_fs_param(fc, param);
>> +		ret = vfs_parse_fs_param(fc, param);
>> +		kfree(param->string);
>> +		return ret;
> 
> But your stack trace shows you aren't going through sys_fsconfig(), so this
> function isn't involved.  Further, this introduces a double free, since
> sys_fsconfig() frees param.string after it drops uapi_mutex.
> 
> Looking at the backtrace:
> 
>>      kmemdup_nul+0x2d/0x70 mm/util.c:151
>>      vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:155
>>      generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:201
>>      do_new_mount fs/namespace.c:2871 [inline]
>>      path_mount+0xbbb/0x1170 fs/namespace.c:3205
>>      do_mount fs/namespace.c:3218 [inline]
>>      __do_sys_mount fs/namespace.c:3426 [inline]
>>      __se_sys_mount fs/namespace.c:3403 [inline]
>>      __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403
> 
> A couple of possibilities spring to mind from that: maybe
> vfs_parse_fs_string() is not releasing the param.string - but that's not the
> problem since we stole the string and the free is definitely there at the
> bottom of the function:
> 
> 	int vfs_parse_fs_string(struct fs_context *fc, const char *key,
> 				const char *value, size_t v_size)
> 	{
> 	...
> 		kfree(param.string);
> 		return ret;
> 	}
> 
> or fc->source is not being cleaned up in vfs_clean_context() - but that's
> there as well:
> 
> 	void vfs_clean_context(struct fs_context *fc)
> 	{
> 	...
> 		kfree(fc->source);
> 		fc->source = NULL;
> 
> In either of these cases, I would expect this to have already become evident
> from other filesystem mounts as there would be a lot of leaking going on,
> particularly with the first.
> 
> Now the backtrace only shows what the state was when the string was allocated;
> it doesn't show what happened to it after that, so another possibility is that
> the filesystem being mounted nicked what vfs_parse_fs_param() had rightfully
> stolen, transferring fc->source somewhere else and then failed to release it -
> most likely on mount failure (ie. it's an error handling bug in the
> filesystem).
> 
> Do we know what filesystem it was?

Yes, it's call AFS (or kAFS).

Thanks for your comments & help.

-- 
~Randy

