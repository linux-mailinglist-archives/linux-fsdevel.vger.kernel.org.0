Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6772557F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjFGHYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbjFGHYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE191FC9
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 00:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F5B633B1
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 07:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C677C433EF;
        Wed,  7 Jun 2023 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122618;
        bh=ViBmsWVp8L9NmQ2d3wnVDmt4JvxjYIAJp2CZj6DXdK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJ8XuPH4H8/JIIiE9wqowcV6WqV/GzNrbTiUBi+LHNsSVIgjICXFnx0g/LCF6wZvW
         3G8ES3Qd5wlx8flv3CzZpFSRkmRGjjJoTjgyNO9/2TafBRuy5K8N9H+FLWrq944zTm
         qv61vzLhA9xVu80TITkl8cYJVTeJ6wSVX3c5NJqCW2FBmTqGoxmVK4nFJbO60Im+EH
         EBIIOlOpVIqqnDoB6PoQDBdScQl2Tk3CEu04EByeWETwsygQW+32uRHytbimM9MJ8e
         WYBOB3H7jGFb8Yhl+1jnsmDFlV9k8uayl/6US5Ftr0XxDKgeU4Ft4mSKd+cnTGW0p0
         w/DNuxtukjl/A==
Date:   Wed, 7 Jun 2023 09:23:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [bug report] fs: Restrict lock_two_nondirectories() to
 non-directory inodes
Message-ID: <20230607-frucht-stillen-285dfd2573fe@brauner>
References: <ZH7vNQSIVurytnME@moroto>
 <20230606095625.zowqbpfi7hktfbwh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606095625.zowqbpfi7hktfbwh@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:56:25AM +0200, Jan Kara wrote:
> On Tue 06-06-23 11:32:53, Dan Carpenter wrote:
> > Hello Jan Kara,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch afb4adc7c3ef: "fs: Restrict lock_two_nondirectories() to
> > non-directory inodes" from Jun 1, 2023, leads to the following Smatch
> > complaint:
> > 
> >     fs/inode.c:1174 unlock_two_nondirectories()
> >     warn: variable dereferenced before check 'inode1' (see line 1172)
> > 
> >     fs/inode.c:1176 unlock_two_nondirectories()
> >     warn: variable dereferenced before check 'inode2' (see line 1173)
> 
> Indeed, thanks for spotting this! Luckily there are currently no in-tree
> users passing NULL. Attached patch fixes this. Christian, can you please

Thanks for the fixup!

> add this to your branch or squash it into the fixed commit? Thanks!


Of course. I've squashed the fix into the original patch.

---

Applied to the vfs.rename.locking branch of the vfs/vfs.git tree.
Patches in the vfs.rename.locking branch should appear in linux-next soon.
