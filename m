Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C1402141
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 00:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbhIFWRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIFWRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 18:17:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8CC061757;
        Mon,  6 Sep 2021 15:16:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C90E81F429DF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/11] unicode: pass a UNICODE_AGE() tripple to utf8_load
Organization: Collabora
References: <20210818140651.17181-1-hch@lst.de>
        <20210818140651.17181-6-hch@lst.de> <87h7exfj31.fsf@collabora.com>
Date:   Mon, 06 Sep 2021 18:16:24 -0400
In-Reply-To: <87h7exfj31.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Mon, 06 Sep 2021 18:13:54 -0400")
Message-ID: <87a6kpfiyv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Christoph Hellwig <hch@lst.de> writes:
>
>> Don't bother with pointless string parsing when the caller can just pass
>> the version in the format that the core expects.  Also remove the
>> fallback to the latest version that none of the callers actually uses.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/ext4/super.c            | 10 ++++----
>>  fs/f2fs/super.c            | 10 ++++----
>>  fs/unicode/utf8-core.c     | 50 ++++----------------------------------
>>  fs/unicode/utf8-norm.c     | 11 ++-------
>>  fs/unicode/utf8-selftest.c | 15 ++++++------
>>  fs/unicode/utf8n.h         | 14 ++---------
>>  include/linux/unicode.h    | 11 ++++++++-
>>  7 files changed, 37 insertions(+), 84 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index a68be582bba5..be418a30b52e 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -2016,9 +2016,9 @@ static const struct mount_opts {
>>  static const struct ext4_sb_encodings {
>>  	__u16 magic;
>>  	char *name;
>> -	char *version;
>> +	unsigned int version;
>>  } ext4_sb_encoding_map[] = {
>> -	{EXT4_ENC_UTF8_12_1, "utf8", "12.1.0"},
>> +	{EXT4_ENC_UTF8_12_1, "utf8", UNICODE_AGE(12, 1, 0)},
>>  };
>>  
>>  static const struct ext4_sb_encodings *
>> @@ -4308,15 +4308,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>>  		encoding = utf8_load(encoding_info->version);
>>  		if (IS_ERR(encoding)) {
>>  			ext4_msg(sb, KERN_ERR,
>> -				 "can't mount with superblock charset: %s-%s "
>> +				 "can't mount with superblock charset: %s-0x%x "
>>  				 "not supported by the kernel. flags: 0x%x.",
>>  				 encoding_info->name, encoding_info->version,
>>  				 encoding_flags);
>>  			goto failed_mount;
>
> "Using encoding defined by superblock: utf8-0xc0100 with flags 0x0"
>
> This is much less readable than what we previously had:
>
> "Using encoding defined by superblock: utf8-12.1.0 with flags 0x0"
>
> It is minor, but can we do instead:
>
> ext4_msg("... %u.%u.%u\n", (encoding_info->version>>12) & 0xff,
> 	 (encoding_info->version>>8) & 0xff), encoding_info->version & 0xff))
>
> The rest of the series looks good and I can pick it up for 5.15, unless
> someone has anything else to say?  It has lived on the list for a while
> now.
>

Ugh, pressed reply too quickly.  Sorry for the multiple email reply.

In the summary line: tripple -> triple.

-- 
Gabriel Krisman Bertazi
