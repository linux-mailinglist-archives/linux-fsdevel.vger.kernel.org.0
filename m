Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441724F16AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbiDDOEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355979AbiDDOEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:04:41 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC2A3335E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwMhEknRMkAk/hwgaifPpZf3WDZJdkc/1FgL6FEHGlQ=; b=ROSopLXhlrp+f3UqkL7cYPHfAA
        XcF4IdHLWggOzVjtsvJhvLSA7wZ+gXuklrkYC35xu8G473oP11nN2PBcMOo9Ccnoqc8o3it2S3Vp7
        OfhDUWQ78MBjQtgDKi8DM/staji/UuTgtP8D2c4yCWKTcTGF/oZJ4jp1ddsZ4YFs1eRhCDLR/9Aa3
        YtsSXLuvsC5e2Q/stU9fPW+TSvOQwyfh8a2tHh42cxU3wU1bSSk88RdqBErlUPOp9bwhdESp561Wf
        sBXfwA0gcENjcRXXIxgFTqm56r2YvRQ2SZ28XKKgftvdsLGuYezdRvlJNNQdjSoIqBLdf5GAejNtU
        nyhXhJGw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbNHy-002T3a-CW; Mon, 04 Apr 2022 14:02:38 +0000
Date:   Mon, 4 Apr 2022 14:02:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RESEND 2/3] shmem: Introduce /sys/fs/tmpfs support
Message-ID: <Ykr6fmRjMwEhIjtk@zeniv-ca.linux.org.uk>
References: <20220404134137.26284-1-krisman@collabora.com>
 <20220404134137.26284-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404134137.26284-3-krisman@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:41:36AM -0400, Gabriel Krisman Bertazi wrote:
> In order to expose tmpfs statistics on sysfs, add the boilerplate code
> to create the /sys/fs/tmpfs structure.  As suggested on a previous
> review, this uses the minor as the volume directory in /sys/fs/.
> 
> This takes care of not exposing SB_NOUSER mounts.  I don't think we have
> a usecase for showing them and, since they don't appear elsewhere, they
> might be confusing to users.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> +static void shmem_unregister_sysfs(struct super_block *sb)
> +{
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> +
> +	kobject_del(&sbinfo->s_kobj);
> +	kobject_put(&sbinfo->s_kobj);
> +	wait_for_completion(&sbinfo->s_kobj_unregister);
> +}

If you embed kobject into something, you basically commit to
having the lifetime rules maintained by that kobject...
