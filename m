Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8852C5A3E58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiH1PW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiH1PWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:22:54 -0400
Received: from mail.stoffel.org (li1843-175.members.linode.com [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0C32BBD;
        Sun, 28 Aug 2022 08:22:51 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 4B0BE1E853;
        Sun, 28 Aug 2022 11:22:50 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id DEAAEA7E25; Sun, 28 Aug 2022 11:22:49 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25355.34889.890961.350510@quad.stoffel.home>
Date:   Sun, 28 Aug 2022 11:22:49 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages PATCH] statx, inode: document the new STATX_INO_VERSION field
In-Reply-To: <20220826214747.134964-1-jlayton@kernel.org>
References: <20220826214747.134964-1-jlayton@kernel.org>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "Jeff" == Jeff Layton <jlayton@kernel.org> writes:

Jeff> We're planning to expose the inode change attribute via statx. Document
Jeff> what this value means and what an observer can infer from a change in
Jeff> its value.

It might be nice to put in some more example verbiage of how this
would be used by userland.  For example, if you do a statx() call and
notice that the ino_version has changed... what would you do next to
find out what changed?  

Would you have to keep around an old copy of the statx() results and
then compare them to find the changes?  When talking to userland
people, don't assume they know anything about the kernel internals
here.  


Jeff> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Jeff> ---
Jeff>  man2/statx.2 | 13 +++++++++++++
Jeff>  man7/inode.7 | 10 ++++++++++
Jeff>  2 files changed, 23 insertions(+)

Jeff> diff --git a/man2/statx.2 b/man2/statx.2
Jeff> index 0d1b4591f74c..644fb251f114 100644
Jeff> --- a/man2/statx.2
Jeff> +++ b/man2/statx.2
Jeff> @@ -62,6 +62,7 @@ struct statx {
Jeff>      __u32 stx_dev_major;   /* Major ID */
Jeff>      __u32 stx_dev_minor;   /* Minor ID */
Jeff>      __u64 stx_mnt_id;      /* Mount ID */
Jeff> +    __u64 stx_ino_version; /* Inode change attribute */
Jeff>  };
Jeff>  .EE
Jeff>  .in
Jeff> @@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
Jeff>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
Jeff>  	It is deprecated and should not be used.
Jeff>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
Jeff> +STATX_INO_VERSION	Want stx_ino_version (since Linux 6.1)
Jeff>  .TE
Jeff>  .in
Jeff>  .PP
Jeff> @@ -411,6 +413,17 @@ and corresponds to the number in the first field in one of the records in
Jeff>  For further information on the above fields, see
Jeff>  .BR inode (7).
Jeff>  .\"
Jeff> +.TP
Jeff> +.I stx_ino_version
Jeff> +The inode version, also known as the inode change attribute. This
Jeff> +value is intended to change any time there is an inode status change. Any
Jeff> +operation that would cause the stx_ctime to change should also cause
Jeff> +stx_ino_version to change, even when there is no apparent change to the
Jeff> +stx_ctime due to timestamp granularity.
Jeff> +.IP
Jeff> +Note that an observer cannot infer anything about the nature or
Jeff> +magnitude of the change from the value of this field. A change in this value
Jeff> +only indicates that there may have been an explicit change in the inode.
Jeff>  .SS File attributes
Jeff>  The
Jeff>  .I stx_attributes
Jeff> diff --git a/man7/inode.7 b/man7/inode.7
Jeff> index 9b255a890720..d296bb6df70c 100644
Jeff> --- a/man7/inode.7
Jeff> +++ b/man7/inode.7
Jeff> @@ -184,6 +184,16 @@ Last status change timestamp (ctime)
Jeff>  This is the file's last status change timestamp.
Jeff>  It is changed by writing or by setting inode information
Jeff>  (i.e., owner, group, link count, mode, etc.).
Jeff> +.TP
Jeff> +Inode version (i_version)
Jeff> +(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
Jeff> +.IP
Jeff> +This is the inode change attribute. Any operation that would result in a ctime
Jeff> +change should also result in a change to this value. The value must change even
Jeff> +in the case where the ctime change is not evident due to timestamp granularity.
Jeff> +An observer cannot infer anything from the actual value about the nature or
Jeff> +magnitude of the change. If it is different from the last time it was checked,
Jeff> +then something may have made an explicit change to the inode.
Jeff>  .PP
Jeff>  The timestamp fields report time measured with a zero point at the
Jeff>  .IR Epoch ,
Jeff> -- 
Jeff> 2.37.2

