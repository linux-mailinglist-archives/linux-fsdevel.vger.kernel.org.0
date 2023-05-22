Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497370B97F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjEVJzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 05:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjEVJzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 05:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E053B4;
        Mon, 22 May 2023 02:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6C96150D;
        Mon, 22 May 2023 09:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0A5C433EF;
        Mon, 22 May 2023 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684749319;
        bh=fRwiw1INuwjkt19gwSVxzGNQu629P6uL7TB/Svuxl0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5nnFLaEvkIuOiAmZC2sXAkem+n5sayQK6e3wkvMW+QVClnGsvjP3yAs33zOlcpxC
         gca8dtVm6H2e4hKME0yxlC8p3ghEymY4whcIIOc3XB1hQpfSbzUINvUm6Nz9VpVs4M
         RfnxcFI6wlaVPb+/L+ZG7re+oa1EG3vrwCSFENliJZg/yr80JgHbuQlMmST1drkgsu
         hf3RzVW9lF0O/WvmiseTM0i69VNeHa3nNSyzMGmY4vyUeT8gTjBIle3LvSpz2TxJqO
         mJIXSoGyWjrfiW3wsVHefMCen0sDDJHqUmFbm2U0wgzcFIvAU62i/SCp2+Xav7EKlK
         sxIc4Xw+70WKQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 0/9] fs: implement multigrain timestamps
Date:   Mon, 22 May 2023 11:54:53 +0200
Message-Id: <20230522-aufrollen-reimt-6e6bdda09360@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=brauner@kernel.org; h=from:subject:message-id; bh=o1aoaUPCwydX/boaI011rHyl1vi8I/0HtCFKo+iIpns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRkWx9bV9yYmLnJ6tjjosKNkp+jgyenPTDSEuBOTeHfXy+V 9yu+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIB8YwMx3W4ilbrzYty4T4ccWDzho ap3y+mlIdVLN+v7HxoYadXDMM/pcePci+mbN1hN8uvp6b665yTZ9fdZp3A+OIYm5nLdw4GFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 May 2023 07:47:33 -0400, Jeff Layton wrote:
> v4:
> - add request_mask argument to generic_fillattr
> - Drop current_ctime helper and just code functionality into current_time
> - rework i_ctime accessor functions
> 
> A few weeks ago, during one of the discussions around i_version, Dave
> Chinner wrote this:
> 
> [...]

Let's get this into -next so we can see whether this leads to any
performance or other regressions. It's moved to a vfs.unstable.* branch
for now. If nothing bad happens it'll be upgraded to a vfs.* branch.
Filesystems that prefer to carry their fs specific patch themselves can
request a stable tag for the generic changes.

---

Applied to the vfs.unstable.ctime branch of the vfs/vfs.git tree.
Patches in the vfs.unstable.ctime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.unstable.ctime

[1/9] fs: pass the request_mask to generic_fillattr
      https://git.kernel.org/vfs/vfs/c/ec1239bab5fd
[2/9] fs: add infrastructure for multigrain inode i_m/ctime
      https://git.kernel.org/vfs/vfs/c/97e9fbb03240
[3/9] overlayfs: allow it to handle multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/ada0fe43f748
[4/9] nfsd: ensure we use ctime_peek to grab the inode->i_ctime
      https://git.kernel.org/vfs/vfs/c/39493918b700
[5/9] ksmbd: use ctime_peek to grab the ctime out of the inode
      https://git.kernel.org/vfs/vfs/c/35527cdc7840
[6/9] tmpfs: add support for multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/ce1dc211dbde
[7/9] xfs: switch to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/78bbdfd2fb74
[8/9] ext4: convert to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/d2100ca52e14
[9/9] btrfs: convert to multigrain timestamps
      https://git.kernel.org/vfs/vfs/c/c725b40cfbd5
