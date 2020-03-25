Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A990192ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYRBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 13:01:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCYRBo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4DDCADC8;
        Wed, 25 Mar 2020 17:01:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A91AC1E1108; Wed, 25 Mar 2020 18:01:41 +0100 (CET)
Date:   Wed, 25 Mar 2020 18:01:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] fanotify directory modify event
Message-ID: <20200325170141.GM28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200325155436.GL28951@quack2.suse.cz>
 <CAOQ4uxiBxjsyZ0ZR6OH29xCTjBEde9u00LfXu58DX9gYR6cwcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiBxjsyZ0ZR6OH29xCTjBEde9u00LfXu58DX9gYR6cwcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-03-20 18:55:46, Amir Goldstein wrote:
> On Wed, Mar 25, 2020 at 5:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi,
> >
> > On Thu 19-03-20 17:10:08, Amir Goldstein wrote:
> > > Jan,
> > >
> > > This v3 posting is a trimmed down version of v2 name info patches [1].
> > > It includes the prep/fix patches and the patches to add support for
> > > the new FAN_DIR_MODIFY event, but leaves out the FAN_REPORT_NAME
> > > patches. I will re-post those as a later time.
> > >
> > > The v3 patches are available on my github branch fanotify_dir_modify [2].
> > > Same branch names for LTP tests [3], man page draft [6] and a demo [7].
> > > The fanotify_name branches in those github trees include the additional
> > > FAN_REPORT_NAME related changes.
> > >
> > > Main changes since v2:
> > > - Split fanotify_path_event fanotify_fid_event and fanotify_name_event
> > > - Drop the FAN_REPORT_NAME patches
> >
> > So I have pushed out the result to my tree (fsnotify branch and also pulled
> > it to for_next branch).
> 
> Great!
> 
> Liked the cleanups.
> Suggest to squash the attached simplification to "record name info" patch.
> I will start try to get to finalizing man page patch next week.

Yeah, nice, I'll squash this into the series. Thanks!

								Honza

> From d42d388ed1a9f90a623552e6fabfa3418ceb40ae Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Wed, 25 Mar 2020 18:50:16 +0200
> Subject: [PATCH] fanotify: simplify record name info
> 
> ---
>  fs/notify/fanotify/fanotify.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 7a889da1ee12..4c1a4eb597d5 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -282,6 +282,9 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  	void *buf = fh->buf;
>  	int err;
>  
> +	if (!inode)
> +		goto out;
> +
>  	dwords = 0;
>  	err = -ENOENT;
>  	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> @@ -315,6 +318,7 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>  			    type, bytes, err);
>  	kfree(ext_buf);
>  	*fanotify_fh_ext_buf_ptr(fh) = NULL;
> +out:
>  	/* Report the event without a file identifier on encode error */
>  	fh->type = FILEID_INVALID;
>  	fh->len = 0;
> @@ -429,22 +433,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	if (fsid && fanotify_event_fsid(event))
>  		*fanotify_event_fsid(event) = *fsid;
>  
> -	if (fanotify_event_object_fh(event)) {
> -		struct fanotify_fh *obj_fh = fanotify_event_object_fh(event);
> +	if (fanotify_event_object_fh(event))
> +		fanotify_encode_fh(fanotify_event_object_fh(event), id, gfp);
>  
> -		if (id)
> -			fanotify_encode_fh(obj_fh, id, gfp);
> -		else
> -			obj_fh->len = 0;
> -	}
> -	if (fanotify_event_dir_fh(event)) {
> -		struct fanotify_fh *dir_fh = fanotify_event_dir_fh(event);
> +	if (fanotify_event_dir_fh(event))
> +		fanotify_encode_fh(fanotify_event_dir_fh(event), id, gfp);
>  
> -		if (id)
> -			fanotify_encode_fh(dir_fh, id, gfp);
> -		else
> -			dir_fh->len = 0;
> -	}
>  	if (fanotify_event_has_path(event)) {
>  		struct path *p = fanotify_event_path(event);
>  
> -- 
> 2.17.1
> 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
