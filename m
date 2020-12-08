Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4F2D1FA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLHAzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:55:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57046 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLHAzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:55:55 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DAF5D1F44924;
        Tue,  8 Dec 2020 00:55:12 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Organization: Collabora
References: <20201208003117.342047-1-krisman@collabora.com>
        <20201208003117.342047-6-krisman@collabora.com>
        <20201208005110.GA106255@magnolia>
Date:   Mon, 07 Dec 2020 21:55:08 -0300
In-Reply-To: <20201208005110.GA106255@magnolia> (Darrick J. Wong's message of
        "Mon, 7 Dec 2020 16:51:10 -0800")
Message-ID: <87zh2p5d77.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Mon, Dec 07, 2020 at 09:31:14PM -0300, Gabriel Krisman Bertazi wrote:
>> When reporting a filesystem error, we really need to know where the
>> error came from, therefore, include "function:line" information in the
>> notification sent to userspace.  There is no current users of notify_sb
>> in the kernel, so there are no callers to update.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  include/linux/fs.h               | 11 +++++++++--
>>  include/uapi/linux/watch_queue.h |  3 +++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index df588edc0a34..864d86fcc68c 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3514,14 +3514,17 @@ static inline void notify_sb(struct super_block *s,
>>  /**
>>   * notify_sb_error: Post superblock error notification.
>>   * @s: The superblock the notification is about.
>> + * @function: function name reported as source of the warning.
>> + * @line: source code line reported as source of the warning.
>>   * @error: The error number to be recorded.
>>   * @inode: The inode the error refers to (if available, 0 otherwise)
>>   * @block: The block the error refers to (if available, 0 otherwise)
>>   * @fmt: Formating string for extra information appended to the notification
>>   * @args: arguments for extra information string appended to the notification
>>   */
>> -static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
>> -				  u64 block, const char *fmt, va_list *args)
>> +static inline int notify_sb_error(struct super_block *s, const char *function, int line,
>> +				  int error, u64 inode, u64 block,
>> +				  const char *fmt, va_list *args)
>>  {
>>  #ifdef CONFIG_SB_NOTIFICATIONS
>>  	if (unlikely(s->s_watchers)) {
>> @@ -3534,8 +3537,12 @@ static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
>>  			.error_cookie	= 0,
>>  			.inode		= inode,
>>  			.block		= block,
>> +			.line		= line,
>>  		};
>>  
>> +		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
>> +		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
>> +
>>  		post_sb_notification(s, &n.s, fmt, args);
>>  	}
>>  #endif
>> diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
>> index 937363d9f7b3..5fa5286c5cc7 100644
>> --- a/include/uapi/linux/watch_queue.h
>> +++ b/include/uapi/linux/watch_queue.h
>> @@ -114,6 +114,7 @@ enum superblock_notification_type {
>>  
>>  #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
>>  
>> +#define SB_NOTIFICATION_FNAME_LEN 30
>>  /*
>>   * Superblock notification record.
>>   * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
>> @@ -130,6 +131,8 @@ struct superblock_error_notification {
>>  	__u32	error_cookie;
>>  	__u64	inode;
>>  	__u64	block;
>> +	char	function[SB_NOTIFICATION_FNAME_LEN];
>> +	__u16	line;
>
> Er... this is enlarging a structure in the userspace ABI, right?  Which
> will break userspace that latched on to the structure definition in the
> previous patch, and therefore isn't expecting a function name here.

Hi Darrick,

Since the structure is defined in the patch immediately before, I
thought it would be ok to split the patch to preserve authorship of the
different parts.  I will fold this into patch 4 in the next iteration.

>
> If you're gonna put a character string(?) at the end then I guess you
> have to pre-pad the notification structure so that we can add things
> later, or.... bump the type code every time you add a field?
>
> (Maybe I misread that?  But this is include/uapi/...)
>
> --D
>
>>  	char	desc[0];
>>  };
>>  
>> -- 
>> 2.29.2
>> 

-- 
Gabriel Krisman Bertazi
