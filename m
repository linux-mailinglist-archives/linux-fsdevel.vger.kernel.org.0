Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5D21FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfEQVmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:42:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41435 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfEQVmc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:42:32 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8600:3280:e269:95ff:fe35:9f3c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4HLg1621520285
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 17 May 2019 14:42:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4HLg1621520285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558129337;
        bh=bxXMxaG3yomMejfA38U/OeM6jHqv8J+5dyCwLKAF2FU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=ZeS6bMg0hxchVF1tgoFn6yE8wCqmZlRyMrHmk8o/e+pq/KQ5I/B28qqNjzVsoOD7U
         DQYWEaBiOgbf+0gG9ks4a8NmplJ4/LiSNS7RtU0cPhv+tMObN4J8JC9is2q+fjK3JI
         2H5MtDUR3Ifj9jfSwsi87PCafjbWKoB7LTqU4iASOGQNlc8DQgB3Z41Vt+fZ7CKdi4
         MCkfffGFcvnRHug/Wn4KidawPjicjifNXBnVAZsajxOzIS5KsOQwX7fvchRAxbNb1a
         UrSu0by2ylgKXiycuvnT/BS0HdTsmsVvePniRdbIAyXbBVomg6bAOlAEpEjRZBN8k0
         fKHAeL6TgBvcg==
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Message-ID: <69ef1f55-9fc1-7ee0-371f-3dbc77551dc0@zytor.com>
Date:   Fri, 17 May 2019 14:41:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/17/19 1:18 PM, hpa@zytor.com wrote:
> 
> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> 
> A side benefit is that the format can be simpler as there is no need to encode the filename.
> 
> A technically cleaner solution still, but which would need archiver modifications, would be to encode the xattrs as an optionally nameless file (just an empty string) with a new file mode value, immediately following the original file. The advantage there is that the archiver itself could support xattrs and other extended metadata (which has been requested elsewhere); the disadvantage obviously is that that it requires new support in the archiver. However, at least it ought to be simpler since it is still a higher protocol level than the cpio archive itself.
> 
> There's already one special case in cpio, which is the "!!!TRAILER!!!" filename; although I don't think it is part of the formal spec, to the extent there is one, I would expect that in practice it is always encoded with a mode of 0, which incidentally could be used to unbreak the case where such a filename actually exists. So one way to support such extended metadata would be to set mode to 0 and use the filename to encode the type of metadata. I wonder how existing GNU or BSD cpio (the BSD one is better maintained these days) would deal with reading such a file; it would at least not be a regression if it just read it still, possibly with warnings. It could also be possible to use bits 17:16 in the mode, which are traditionally always zero (mode_t being 16 bits), but I believe are present in most or all of the cpio formats for historical reasons. It might be accepted better by existing implementations to use one of these high bits combined with S_IFREG, I dont know.
> 

Correction: it's just !!!TRAILER!!!.

I tested with GNU cpio, BSD cpio, scpio and pax.

With a mode of 0:

	- GNU cpio errors, but extracts all the other files.
	- BSD cpio extracts them as regular files.
	- scpio and pax abort.

With a mode of 0x18000 (bit 16 + S_IFREG), all of them happily extracted
the data as regular files.

	-hpa
