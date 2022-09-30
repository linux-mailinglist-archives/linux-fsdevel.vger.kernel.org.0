Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6B5F022B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiI3BX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 21:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI3BX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:23:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C01F34B5;
        Thu, 29 Sep 2022 18:23:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U1MqlG010966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 21:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664500982; bh=MMajPwAjURWxTvOvdJLhItRHH+a8PB3KnPvtMrFA1PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VAEiiP6yp/EwZmY81q7oozZTyov097KW2IVId7q2lCYOL6QZ/Us/YOR8XwnK8pEk9
         MgC92A9NgKDlHDSmlAGk6tbFY0ppzFjOEadWRC8nOyRm0Om2lrvQ5VeYRmm5bi6pGR
         S77dg7CwxZq1isPXxGr3jidqtvJgqP3usRT9jw9MdwzHajemHIJ+8thAQKnuZZ3Vsn
         XLc7EcFGydDYzfrLFAcTLGBzNDfOm+I1FdicJuemqaUjRNgiD930DJ7DTp6q2cHSRZ
         6NArrV6FhjX6RvF6sCKwOjuQC896+AiJHJ7j5i87kXSnhx7Ow88VSW7/b30wpizIhD
         kOr8m0zsUp6yw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 103E915C00C9; Thu, 29 Sep 2022 21:22:52 -0400 (EDT)
Date:   Thu, 29 Sep 2022 21:22:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 2/8] ext4: fix i_version handling in ext4
Message-ID: <YzZE7PUB13cqSw1x@mit.edu>
References: <20220908172448.208585-1-jlayton@kernel.org>
 <20220908172448.208585-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908172448.208585-3-jlayton@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:24:42PM -0400, Jeff Layton wrote:
> ext4 currently updates the i_version counter when the atime is updated
> during a read. This is less than ideal as it can cause unnecessary cache
> invalidations with NFSv4 and unnecessary remeasurements for IMA.
> 
> The increment in ext4_mark_iloc_dirty is also problematic since it can
> corrupt the i_version counter for ea_inodes. We aren't bumping the file
> times in ext4_mark_iloc_dirty, so changing the i_version there seems
> wrong, and is the cause of both problems.
> 
> Remove that callsite and add increments to the setattr, setxattr and
> ioctl codepaths, at the same times that we update the ctime. The
> i_version bump that already happens during timestamp updates should take
> care of the rest.
> 
> In ext4_move_extents, increment the i_version on both inodes, and also
> add in missing ctime updates.
> 
> Cc: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, I've applied just this patch from this patch series.  I made
some minor adjustments since we've already enabled the i_version
counter unconditionally via another patch series from Lukas.

			    	    	  - Ted
