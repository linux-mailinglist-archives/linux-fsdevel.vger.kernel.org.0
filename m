Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EE54F23C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378259AbiFQHxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380502AbiFQHxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:53:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1271DA62
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 00:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D24EFCE277E
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 07:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12F1C3411B;
        Fri, 17 Jun 2022 07:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655452413;
        bh=msF7BLkqYnLnOu+Q3/vtObqxNvEZEsiIeafcXFVJ2o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2F891Ipep5+JTbXXliitR2ujqRHu9IH5gqolWLjTWWyLrHhnhMn2+iN9lkcsDBo2
         9ah3dP56dhNBsQuYuBZtpJdZCKMht77iDAgHX3JeIEcrGaiW6PpAubKYAKNl+f4r65
         ETedOJ9VQ3iLZ8Yj+xhc5fF8gAznf6u3aLKVaX82rTQpbvohbFnhwjUrQoueCKngSE
         iHsnfQQPUsEZB6FekcFELt3fUo9KQjmpGSA5fRzoWOuxqlQNXISZLM5cy5jDbt1Da9
         fmYbkty/ABxERizdj8EIiUHq3BNsqJAnFPs0vHlmlX4fpqWqTKSv6PCVYmyUC1JCfk
         NJvPo9Qzk3UEg==
Date:   Fri, 17 Jun 2022 09:53:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, clm@fb.com
Subject: Re: [PATCH v3] fuse: Add module param for CAP_SYS_ADMIN access
 bypassing allow_other
Message-ID: <20220617075327.s6dbqqrjbgotioq5@wittgenstein>
References: <20220617004710.621301-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617004710.621301-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:47:10PM -0700, Dave Marchevsky wrote:
> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
> superblock's namespace or a descendant"), access to allow_other FUSE
> filesystems has been limited to users in the mounting user namespace or
> descendants. This prevents a process that is privileged in its userns -
> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
> that is accessible to processes in parent namespaces.
> 
> While this restriction makes sense overall it breaks a legitimate
> usecase: I have a tracing daemon which needs to peek into
> process' open files in order to symbolicate - similar to 'perf'. The
> daemon is a privileged process in the root userns, but is unable to peek
> into FUSE filesystems mounted by processes in child namespaces.
> 
> This patch adds a module param, allow_sys_admin_access, to act as an
> escape hatch for this descendant userns logic and for the allow_other
> mount option in general. Setting allow_sys_admin_access allows
> processes with CAP_SYS_ADMIN in the initial userns to access FUSE
> filesystems irrespective of the mounting userns or whether allow_other
> was set. A sysadmin setting this param must trust FUSEs on the host to
> not DoS processes as described in 73f03c2b4b52.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

Could you please add a patch to Documentation/filesystems/fuse.rst and
add the module option somwhere in there?
There should also be a comment added how this relates to points 2/i and
2/ii in section "How are requirements fulfilled?".
