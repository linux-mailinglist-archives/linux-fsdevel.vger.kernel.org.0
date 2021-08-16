Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520743EDF6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhHPVlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 17:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhHPVlg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC9960E09;
        Mon, 16 Aug 2021 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629150064;
        bh=20nFMMREAcxNH6QbkQ0N0qSyPuh5AN9LdcPTNM8PNjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHknz1j31Z6FKlzVMbHugSLYht7pulY+wT/1twvGFT18Ded8tg+SnTo7CMJbjoYeM
         mfH9BP4EG6+Z7pmD+VhVvJfaTNBRvCNJ5QPpc/yC4LedqeRuv/gqclhPza5i/Zt2vC
         f0k06hsdVmmsW0sbP6oOX49TLQEraPdhIqyecFn9L/YgHCVbnknusS56sAweuqyXza
         fJ3Qf18jaLWKuE9JYvd2pBWcbjVjS7H+NXWP2mKPFYbn/eI799doCFPDreJA4UNuBS
         0xhqozhfFiikTmjt3/6QG0aW/zC84hrOyPFNJVd9fFRGjFILCoxzjiWO9HpBRAXxtI
         pm/w/jTvq42gg==
Date:   Mon, 16 Aug 2021 14:41:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210816214103.GA12664@magnolia>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-19-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 05:40:07PM -0400, Gabriel Krisman Bertazi wrote:
> The Error info type is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v5:
>   - Move error code here
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify.h      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  4 files changed, 45 insertions(+)

<snip>

> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 16402037fc7a..80040a92e9d9 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_FID		1
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>  #define FAN_EVENT_INFO_TYPE_DFID	3
> +#define FAN_EVENT_INFO_TYPE_ERROR	4
>  
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
>  	unsigned char handle[0];
>  };
>  
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};

My apologies for not having time to review this patchset since it was
redesigned to use fanotify.  Someday it would be helpful to be able to
export more detailed error reports from XFS, but as I'm not ready to
move forward and write that today, I'll try to avoid derailling this at
the last minute.

Eventually, XFS might want to be able to report errors in file data,
file metadata, allocation group metadata, and whole-filesystem metadata.
Userspace can already gather reports from XFS about corruptions reported
by the online fsck code (see xfs_health.c).

I /think/ we could subclass the file error structure that you've
provided like so:

struct fanotify_event_info_xfs_filesystem_error {
	struct fanotify_event_info_error	base;

	__u32 magic; /* 0x58465342 to identify xfs */
	__u32 type; /* quotas, realtime bitmap, etc. */
};

struct fanotify_event_info_xfs_perag_error {
	struct fanotify_event_info_error	base;

	__u32 magic; /* 0x58465342 to identify xfs */
	__u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
	__u32 agno; /* allocation group number */
};

struct fanotify_event_info_xfs_file_error {
	struct fanotify_event_info_error	base;

	__u32 magic; /* 0x58465342 to identify xfs */
	__u32 type; /* extent map, dir, attr, etc. */
	__u64 offset; /* file data offset, if applicable */
	__u64 length; /* file data length, if applicable */
};

(A real XFS implementation might have one structure with the type code
providing for a tagged union or something; I split it into three
separate structs here to avoid confusing things.)

I have three questions at this point:

1) What's the maximum size of a fanotify event structure?  None of these
structures exceed 36 bytes, which I hope will fit in whatever size
constraints?

2) If a program written for today's notification events sees a
fanotify_event_info_header from future-XFS with a header length that is
larger than FANOTIFY_INFO_ERROR_LEN, will it be able to react
appropriately?  Which is to say, ignore it on the grounds that the
length is unexpectedly large?

It /looks/ like this is the case; really I'm just fishing around here
to make sure nothing in the design of /this/ patchset would make it Very
Difficult(tm) to add more information later.

3) Once we let filesystem implementations create their own extended
error notifications, should we have a "u32 magic" to aid in decoding?
Or even add it to fanotify_event_info_error now?

--D

> +
>  struct fanotify_response {
>  	__s32 fd;
>  	__u32 response;
> -- 
> 2.32.0
> 
