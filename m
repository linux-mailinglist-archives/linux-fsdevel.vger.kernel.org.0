Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA026E2136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDNKqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNKq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:46:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2895;
        Fri, 14 Apr 2023 03:46:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD51E1FD95;
        Fri, 14 Apr 2023 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681469185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaDKrVzHktRGkhvNC8mOy7GLmS2NFDSAPBln7UTiz9Q=;
        b=Mi9ou96w9xvxbp6Exkd6EGylmL5lp7Mu33FedVadh7SrkmmJPYwKGBSwr9zJxRKgFsdGb7
        gHW0oGlD26djN5njEDeceOD4h9KXHxQfSrM6AgaOkZx0T9uJ+nQ3T2QvyTdd0PB26aCbvP
        X2ib6TA2fZs8xpSyoIDbx+IyyN2tXFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681469185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NaDKrVzHktRGkhvNC8mOy7GLmS2NFDSAPBln7UTiz9Q=;
        b=9vWudS8M5XsxTuY0B046MKslysKF1mrmztRo4UGnWT4XH9akLQKLv9snoIat72AImT6d6c
        CRVVTnSwo1nRYXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD957139FC;
        Fri, 14 Apr 2023 10:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zkolMgEvOWSNMgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 10:46:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4AD65A0732; Fri, 14 Apr 2023 12:46:25 +0200 (CEST)
Date:   Fri, 14 Apr 2023 12:46:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 5/5] dnotify: Pass argument of fcntl_dirnotify as int
Message-ID: <20230414104625.gyzuswldwil4jlfw@quack3>
References: <20230414100212.766118-1-Luca.Vizzarro@arm.com>
 <20230414100212.766118-6-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414100212.766118-6-Luca.Vizzarro@arm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-04-23 11:02:12, Luca Vizzarro wrote:
> The interface for fcntl expects the argument passed for the command
> F_DIRNOTIFY to be of type int. The current code wrongly treats it as
> a long. In order to avoid access to undefined bits, we should explicitly
> cast the argument to int.
> 
> Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
> Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: David Laight <David.Laight@ACULAB.com>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>

Looks good to me. Do you plan to merge this series together (perhaps
Christian could?) or should I pick up the dnotify patch? In case someone
else will merge the patch feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/dnotify/dnotify.c | 4 ++--
>  include/linux/dnotify.h     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 190aa717fa32..ebdcc25df0f7 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -199,7 +199,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
>  }
> 
>  /* this conversion is done only at watch creation */
> -static __u32 convert_arg(unsigned long arg)
> +static __u32 convert_arg(unsigned int arg)
>  {
>         __u32 new_mask = FS_EVENT_ON_CHILD;
> 
> @@ -258,7 +258,7 @@ static int attach_dn(struct dnotify_struct *dn, struct dnotify_mark *dn_mark,
>   * up here.  Allocate both a mark for fsnotify to add and a dnotify_struct to be
>   * attached to the fsnotify_mark.
>   */
> -int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
> +int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
>  {
>         struct dnotify_mark *new_dn_mark, *dn_mark;
>         struct fsnotify_mark *new_fsn_mark, *fsn_mark;
> diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
> index b1d26f9f1c9f..9f183a679277 100644
> --- a/include/linux/dnotify.h
> +++ b/include/linux/dnotify.h
> @@ -30,7 +30,7 @@ struct dnotify_struct {
>                             FS_MOVED_FROM | FS_MOVED_TO)
> 
>  extern void dnotify_flush(struct file *, fl_owner_t);
> -extern int fcntl_dirnotify(int, struct file *, unsigned long);
> +extern int fcntl_dirnotify(int, struct file *, unsigned int);
> 
>  #else
> 
> @@ -38,7 +38,7 @@ static inline void dnotify_flush(struct file *filp, fl_owner_t id)
>  {
>  }
> 
> -static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
> +static inline int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
>  {
>         return -EINVAL;
>  }
> --
> 2.34.1
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
