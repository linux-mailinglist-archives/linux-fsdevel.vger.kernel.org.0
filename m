Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF03EA746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhHLPPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 11:15:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhHLPO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:14:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BC09C1F44053
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
Organization: Collabora
References: <20210804160612.3575505-1-krisman@collabora.com>
        <20210804160612.3575505-15-krisman@collabora.com>
        <20210805095618.GF14483@quack2.suse.cz> <87fsvf65zu.fsf@collabora.com>
        <20210812142047.GG14675@quack2.suse.cz>
Date:   Thu, 12 Aug 2021 11:14:29 -0400
In-Reply-To: <20210812142047.GG14675@quack2.suse.cz> (Jan Kara's message of
        "Thu, 12 Aug 2021 16:20:47 +0200")
Message-ID: <875ywa66ga.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
>> Jan Kara <jack@suse.cz> writes:
>> >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>> >>  		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
>> >>  	}
>> >>  
>> >> -	dwords = fh_len >> 2;
>> >> -	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
>> >> -	err = -EINVAL;
>> >> -	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
>> >> -		goto out_err;
>> >> -
>> >> -	fh->type = type;
>> >> -	fh->len = fh_len;
>> >> +	if (inode) {
>> >> +		dwords = fh_len >> 2;
>> >> +		type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
>> >> +		err = -EINVAL;
>> >> +		if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
>> >> +			goto out_err;
>> >> +		fh->type = type;
>> >> +		fh->len = fh_len;
>> >> +	} else {
>> >> +		/*
>> >> +		 * Invalid FHs are used on FAN_FS_ERROR for errors not
>> >> +		 * linked to any inode. Caller needs to guarantee the fh
>> >> +		 * has at least FANOTIFY_NULL_FH_LEN bytes of space.
>> >> +		 */
>> >> +		fh->type = FILEID_INVALID;
>> >> +		fh->len = FANOTIFY_NULL_FH_LEN;
>> >> +		memset(buf, 0, FANOTIFY_NULL_FH_LEN);
>> >> +	}
>> >
>> > Maybe it will become clearer later during the series but why do you set
>> > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
>> 
>> Jan,
>> 
>> That is how we encode a NULL file handle (i.e. superblock error).  Amir
>> suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
>> size 8.  I will improve the comment on the next iteration.
>
> Thanks for info. Then I have a question for Amir I guess :) Amir, what's
> the advantage of zeroed handle of size 8 instead of just 0 length file
> handle?

Jan,

Looking back at the email from Amir, I realize I misunderstood his
original suggestion.  Amir suggested it be FILEID_INVALID with 0-len OR
FILEID_INO32_GEN with zeroed fields.  I mixed the two suggestions.

The advantage of doing FILEID_INO32_GEN with zeroed field is to avoid
special casing the test program.  But I don't have a good reason to use
FILEID_INVALID with a len > 0.

I'm sending a v6 with everything, including this, addressed.  testcase
and man pages will be updated as well.

-- 
Gabriel Krisman Bertazi
