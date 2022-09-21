Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6F5BFA3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIUJIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIUJI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:08:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D42C672
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 02:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58055B82ECC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 09:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C23EC433D6;
        Wed, 21 Sep 2022 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663751305;
        bh=vtEpYekWJmHkDMcdv895IgPeLV5HZZezb/WUlV0jJFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOozZ1B0dYvrzX/AYV3v195svxpmKho0m0rRY+2RP6gJef15HXtB59Nw5JNdPHAN+
         9PbIrwRyiYD/P7/EsVRdPPwJhVmMjuP35IwRAMetXPPU0J9dNRe91JxyK4fFSkhPVz
         pjThhPC/5wcEw/wFyMYdK50jq0CL6RaC+lM1tKhbompiEcssuHnojOP+yPOZpoOeey
         FG+qXFA1AZzbBvLC94R8j2ZC+ew0TtapDO18+UOKuCoe/uT1loEgWCGmEye1sl312E
         7DK8HhhiVWMVp2mCB13yop5KzMyes4HpNBjI2flT+oQTIEgoW6DKfozm2OuPVe5+8W
         jEkFe5gSvAFFA==
Date:   Wed, 21 Sep 2022 11:08:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
Message-ID: <20220921090820.woijqimkphaf3qll@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-9-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920193632.2215598-9-mszeredi@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:36:31PM +0200, Miklos Szeredi wrote:
> This is in preparation for adding tmpfile support to fuse, which requires
> that the tmpfile creation and opening are done as a single operation.
> 
> Replace the 'struct dentry *' argument of i_op->tmpfile with
> 'struct file *'.
> 
> Call finish_open_simple() as the last thing in ->tmpfile() instances (may
> be omitted in the error case).
> 
> Change d_tmpfile() argument to 'struct file *' as well to make callers more
> readable.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Seems fine to me. Fwiw, it feels like all the file->f_path.dentry derefs
could be wrapped in a helper similar to file_inode(). I know we have
file_dentry() but that calls d_real() so not sure if that'll be correct
for all updated callers,
