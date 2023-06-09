Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14E7297E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbjFILMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjFILMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FDC1;
        Fri,  9 Jun 2023 04:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D5C65704;
        Fri,  9 Jun 2023 11:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2B9C433D2;
        Fri,  9 Jun 2023 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686309159;
        bh=k/IRtFeBohjeJRyYL1MKsaOaYYziYhDqwabFnM+iWV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6s1FWZUoGqS2HNbL3AJLCtR+U74IpdHx3v9jiS+KJZT3HFtAXDUplH9CQL04FHHe
         3NXMacBFOPxNo87KW3SwQ3fQ31dUQ5TGaqDH1G2bQBlYxVdKxf3vMS/Zzd1NONa60x
         1tdDjDRjv2nzDzBcZ/xYqSiDPTmwr6yxgqBXhoN4IezCLAOwRQXsEMyUzIhKFpCiTg
         xk8dgKHwYVO7ae6I3XBNzOTSjbYxyRLHusdJFVNyYSk8i+wariNYVWd3guHN83vWeS
         ZxRJX/IWAZkW/AuP/MKZOYvzNtIuLwTLk02Mj6ieXno7dTZAMSymvMeXjDCGP9cs4d
         NGhv/uMdS9tXw==
Date:   Fri, 9 Jun 2023 13:12:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: store fake path in file_fake along with real path
Message-ID: <20230609-bannmeile-speziell-54dc72b5008c@brauner>
References: <20230609073239.957184-1-amir73il@gmail.com>
 <20230609073239.957184-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609073239.957184-4-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:32:39AM +0300, Amir Goldstein wrote:
> Instead of storing only the fake path in f_path, store the real path
> in f_path and the fake path in file_fake container.
> 
> Call sites that use the macro file_fake_path() continue to get the fake
> path from its new location.
> 
> Call sites that access f_path directly will now see the overlayfs real
> path instead of the fake overlayfs path, which is the desired bahvior
> for most users, because it makes f_path consistent with f_inode.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

If you resend, can you take the chance and refactor this into a slightly more
readable pattern, please? So something like

struct file *open_with_fake_path(const struct path *fake_path, int flags,
                                 const struct path *path,
                                 const struct cred *cred)
{
        int error;
        struct file *f;

        f = alloc_empty_file_fake(fake_path, flags, cred);
        if (IS_ERR(f))
                return f;

        f->f_path = *path;
        error = do_dentry_open(f, d_inode(path->dentry), NULL);
        if (error) {
                fput(f);
                return ERR_PTR(error);
        }

        return f;
}
