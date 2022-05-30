Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558A5384FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiE3Pdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiE3Pdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 11:33:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDAE151FDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 07:38:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q21so21291004ejm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9XVHS3rlr74kwDPS9cPLZWGBf1IHIjmcfJWC5iwwI2Q=;
        b=MbARoEMNQrQQ5S51pge6GPzZS8oHKf3IaF+XiDUy8Ks5VCzzDxfw2dNHfzHZpEiWQC
         Lir4csByQgi8syophTh9lcO08dPkZ5b+pcyLI4xvARvyOpGO5Dz1suPagZKcrX5giq++
         tWsVlviaPGUMTu82QwfnMk/+msafi9JIPmz0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XVHS3rlr74kwDPS9cPLZWGBf1IHIjmcfJWC5iwwI2Q=;
        b=fXXPR+kfIDohTaSdwe04zPdV9KTA+CX7klvUqlKITwNcBidv1UU6znxTgFU8Vzmn6/
         CPew22ubIp9QCCNt1OIYJmRPpgr0eBN02sAI0QXHFXHDy9oTVq8QVYBytw8JCVypI+3T
         Tj/Mv+3TwJ6k5rzXRB1xL+ZLEve1xLIFDRu8ILGFEwhkSTZd5AYTJbwT18SdHwpenlJi
         laKGsh41RNM9k9wtWi3SPN1HewyQq5gVRffltHjnRs7nYBY69oWHf6lffLzU67IW0Hlb
         HayzYUEdNla2wPpKDMd+Lx3IRsAIJvQTMYCZlkEbxUK1vne2jDQbAZ/kIunO6nNGGOyw
         KE+w==
X-Gm-Message-State: AOAM532iymyu7ph9WTU32q3kcSdJQOBJfFCaBXxDc/ks1V23vEEm2Gz2
        iVJyJcJriEnqq6KpqCx1Em5zFQ==
X-Google-Smtp-Source: ABdhPJzCJc9LIiLBdHANCcQcfp+8G5VZEaFRDSMPja3qGm5Y6mFm1R/ni7P5lpa3+cR3SNJNCX9l9A==
X-Received: by 2002:a17:906:90c9:b0:6fe:9e40:5cc with SMTP id v9-20020a17090690c900b006fe9e4005ccmr46125940ejw.367.1653921508038;
        Mon, 30 May 2022 07:38:28 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id bh19-20020a170906a0d300b006ff802baf5dsm910684ejb.54.2022.05.30.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:38:27 -0700 (PDT)
Date:   Mon, 30 May 2022 16:38:24 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        ChenXiaoSong <chenxiaosong2@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyongqiang13@huawei.com, "zhangyi (F)" <yi.zhang@huawei.com>,
        zhangxiaoxu5@huawei.com, Steve French <smfrench@gmail.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH -next,v2] fuse: return the more nuanced writeback error
 on close()
Message-ID: <YpTW4LNGGzuXu/bq@miu.piliscsaba.redhat.com>
References: <20220523014838.1647498-1-chenxiaosong2@huawei.com>
 <CAJfpegt-+6oSCxx1-LHet4qm4s7p0jSoP9Vg8PJka3=1dqBXng@mail.gmail.com>
 <9915b7b556106d2a525941141755adcca9e50163.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9915b7b556106d2a525941141755adcca9e50163.camel@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 10:02:06AM -0400, Jeff Layton wrote:

> The main difference is that ->flush is called from filp_close, so it's
> called when a file descriptor (or equivalent) is being torn down out,
> whereas ->fsync is (obviously) called from the fsync codepath.
> 
> We _must_ report writeback errors on fsync, but reporting them on the
> close() syscall is less clear. The thing about close() is that it's
> going be successful no matter what is returned. The file descriptor will
> no longer work afterward regardless.
> 
> fsync also must also initiate writeback of all the buffered data, but
> it's not required for filesystems to do that on close() (and in fact,
> there are good reasons not to if you can). A successful close() tells
> you nothing about whether your data made it to the backing store. It
> might just not have been synced out yet.
> 
> Personally, I think it's probably best to _not_ return writeback errors
> on close at all. The only "legitimate" error on close is -EBADF.
> Arguably, we should make ->flush be void return. Note that most
> filp_close callers ignore the error anyway, so it's not much of a
> stretch.
> 
> In any case, if you do decide to return errors in fuse_flush, then
> advancing the cursor would also have the effect of masking writeback
> errors on dup()'ed file descriptors, and I don't think you want to do
> that.

Thanks for clarifying.

Chen, would the following patch make sense for your case?

Thanks,
Miklos

---
 fs/fuse/file.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -487,11 +487,6 @@ static int fuse_flush(struct file *file,
 	fuse_sync_writes(inode);
 	inode_unlock(inode);
 
-	err = filemap_check_errors(file->f_mapping);
-	if (err)
-		return err;
-
-	err = 0;
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
