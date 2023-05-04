Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D756F69B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEDLTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEDLTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 07:19:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31138358A;
        Thu,  4 May 2023 04:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B51AB63351;
        Thu,  4 May 2023 11:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA37C433EF;
        Thu,  4 May 2023 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683199152;
        bh=HDWeeiD6b9TOwYY85iPJ6EMKm03YYjllu+bpWXbIPwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgMWXBTKo2ViNRBCp12/oVETYV+T4nqNVyVgpSAExX+wlD6jlargnQLsl8ql8xK2n
         wYhbG0BUY18jadO7xXtl5uKSpvN6a2/E61P9HJcofrHqaxVqUT0rHSVQGNEv0Nar+Z
         XC3EkUjClSTcmYDkpplU4LGzYBcCH66S5asrLMETmTZY9Z4OhtZunmji+4Z83oxtlM
         pGr0nwtGuo2mnz4Dmq/I5AfnoN5aifO3mJpgQ3z9rDVzqu1bis+LQ2huiUIvh3IEu2
         lCCLQjlfbshaSboYwvjYOrk7PCY+AU8kuM+PztTvqW296MWmirIBIo+4HQU2xBpSjx
         1HcQpmqBUqCBA==
Date:   Thu, 4 May 2023 13:19:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 3/4] exportfs: allow exporting non-decodeable file
 handles to userspace
Message-ID: <20230504-unruhen-lauftraining-d676c7702fea@brauner>
References: <20230502124817.3070545-1-amir73il@gmail.com>
 <20230502124817.3070545-4-amir73il@gmail.com>
 <20230503172314.kptbcaluwd6xiamz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503172314.kptbcaluwd6xiamz@quack3>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 07:23:14PM +0200, Jan Kara wrote:
> On Tue 02-05-23 15:48:16, Amir Goldstein wrote:
> > Some userspace programs use st_ino as a unique object identifier, even
> > though inode numbers may be recycable.
> > 
> > This issue has been addressed for NFS export long ago using the exportfs
> > file handle API and the unique file handle identifiers are also exported
> > to userspace via name_to_handle_at(2).
> > 
> > fanotify also uses file handles to identify objects in events, but only
> > for filesystems that support NFS export.
> > 
> > Relax the requirement for NFS export support and allow more filesystems
> > to export a unique object identifier via name_to_handle_at(2) with the
> > flag AT_HANDLE_FID.
> > 
> > A file handle requested with the AT_HANDLE_FID flag, may or may not be
> > usable as an argument to open_by_handle_at(2).
> > 
> > To allow filesystems to opt-in to supporting AT_HANDLE_FID, a struct
> > export_operations is required, but even an empty struct is sufficient
> > for encoding FIDs.
> 
> Christian (or Al), are you OK with sparing one AT_ flag for this
> functionality? Otherwise the patch series looks fine to me so I'd like to
> queue it into my tree. Thanks!

At first it looked like there are reasons to complain about this on the
grounds that this seems like a flag only for a single system call. But
another look at include/uapi/linux/fcntl.h reveals that oh well, the
AT_* flag namespace already contains system call specific flags.

The overloading of AT_EACCESS and AT_REMOVEDIR as 0x200 is especially
creative since it doesn't even use an infix like the statx specific
flags.

Long story short, since there's already overloading of the flag
namespace happening it wouldn't be unprecedent or in any way wrong if
this patch just reused the 0x200 value as well.

In fact, it might come in handy since it would mean that we have the bit
you're using right now free for a flag that is meaningful for multiple
system calls. So something to consider but you can just change that
in-tree as far as I'm concerned.

All this amounts to a long-winded,

Acked-by: Christian Brauner <brauner@kernel.org> 
