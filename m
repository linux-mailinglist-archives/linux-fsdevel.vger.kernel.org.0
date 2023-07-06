Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734187499EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjGFKyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjGFKyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:54:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ACE212C;
        Thu,  6 Jul 2023 03:53:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3367E21DBF;
        Thu,  6 Jul 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjAHQzQEXBAzR1upFSNRvl8gRyeGbDUTwY9wKOloKgE=;
        b=CWhrFcjAtAdPM+hPm4NuypbzXrxFmwxY+zfESBHWW6399J6Jse2UugUhnsjaBcI/tAANYS
        2x68Pss3q/xSZClX29KcvJcR8zVVwbMZHhBVbMzOpO15n8d3xtG7iiwjC7l4ztH2pzD+KW
        SbaxcPmFejmp0j52lAJWdH94Slnofq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjAHQzQEXBAzR1upFSNRvl8gRyeGbDUTwY9wKOloKgE=;
        b=EcM5kzcX7+KL8yjZXY6iu/zZ38so+JANZAdG7FecAwBdnQE8davIS/Xz0spDkAt5AO8/kf
        yy6Xchn6z1+zURBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 254B4138EE;
        Thu,  6 Jul 2023 10:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lZ8NCTqdpmRZBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:53:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B0D58A0707; Thu,  6 Jul 2023 12:53:45 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:53:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 30/92] ceph: convert to ctime accessor functions
Message-ID: <20230706105345.cdoadx7hvb227vts@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-28-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-28-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:55, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Just one nit below:

> @@ -688,6 +688,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
>  			 struct timespec64 *mtime, struct timespec64 *atime)
>  {
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> +	struct timespec64 ictime = inode_get_ctime(inode);
>  	int warn = 0;
>  
>  	if (issued & (CEPH_CAP_FILE_EXCL|
> @@ -696,11 +697,12 @@ void ceph_fill_file_time(struct inode *inode, int issued,
>  		      CEPH_CAP_AUTH_EXCL|
>  		      CEPH_CAP_XATTR_EXCL)) {
>  		if (ci->i_version == 0 ||
> -		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
> +		    timespec64_compare(ctime, &ictime) > 0) {
>  			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
> -			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
> +			     inode_get_ctime(inode).tv_sec,
> +			     inode_get_ctime(inode).tv_nsec,

I think here you can use ictime instead of inode_get_ctime(inode).
Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>



								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
