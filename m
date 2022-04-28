Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88925512E38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbiD1I3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbiD1I3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FC972D6;
        Thu, 28 Apr 2022 01:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5757361F96;
        Thu, 28 Apr 2022 08:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBAFC385A0;
        Thu, 28 Apr 2022 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651134350;
        bh=7D++5Uv1MA0/29UijH6YdgqAj4cFjcElEo1390Ba2/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jzu6n7X3wtUlKGcTd/+UrSmnw4n9c1GbiQHq1k6EMOJ0s1VRDexzY6MyyRERdLZQf
         4abKNFoBPSLUVUVUrC95DK2iLqbW39pcZSf34t/kCSIK08+mX6bcEd/JwQifT2BM1t
         zSJWqSzhgVrDCaTr3HboKt0S6LPXwgrP4X6OUMa38M7NXBPfSUeNCxxzory7tDWedU
         yHPgGX93pgqsj40clqenqZR8kRA5l52HTPQeaGORleJm2KjSHS/hanTsOBFLPgi+z0
         68MpJJ1P0jDL+ac/HXXNO4lnfCeL50zCaghvZPsG4ffXf9HF7Oea2IzrInzwWvO0bW
         dUmVjOjIUGaFw==
Date:   Thu, 28 Apr 2022 10:25:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220428082544.7v5s3dfgtsda6hll@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:59:01AM +0000, Al Viro wrote:
> On Tue, Apr 26, 2022 at 07:11:27PM +0800, Yang Xu wrote:
> > Add a dedicated helper to handle the setgid bit when creating a new file
> > in a setgid directory. This is a preparatory patch for moving setgid
> > stripping into the vfs. The patch contains no functional changes.
> > 
> > Currently the setgid stripping logic is open-coded directly in
> > inode_init_owner() and the individual filesystems are responsible for
> > handling setgid inheritance. Since this has proven to be brittle as
> > evidenced by old issues we uncovered over the last months (see [1] to
> > [3] below) we will try to move this logic into the vfs.
> 
> First of all, inode_init_owner() is (and always had been) an optional helper.

The whole patch series was triggered because ever since I added setgid
inheritance tests (see [1]) as part of the idmapped mounts test suite
into xfstests we found 3 setgid inheritance bugs (The bugs are linked in
the commit messages.).
The bugs showed up whenever a filesystem didn't call inode_init_owner()
or had custom code in place that deviated from expectations.

That's what triggered this whole patch series. Yang took it on and seems
here to see it through.

I should point out that it was rather unclear what expectations are btw
because of the ordering dependency between umask and POSIX ACLs and
setgid stripping. I've describe this at length in the commit message I
gave Yang.

It took a lot of digging and over the course of me reviewing this patch
series more and more corner-cases pop up that we haven't handled.

> Filesystems are *NOT* required to call it, so putting any common functionality
> in there had always been a mistake.

See above. I pointed this out in earlier version.
I very much agree which is why we should move it into the vfs proper if
we can with reasonably minimal regression risk.

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/idmapped-mounts/idmapped-mounts.c#n7812
