Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03F7BF5D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442728AbjJJI3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442752AbjJJI3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:29:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC997;
        Tue, 10 Oct 2023 01:29:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F3C433C8;
        Tue, 10 Oct 2023 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696926572;
        bh=7d1pzrVgBWaePffrFrHQloqudlsSNdK77SHld6pc7yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCNENh56r+Er4L033UlCmt84XhkbTUJa0O3+gIvDQPtyRTCW+GgPquxngRPIgDQ/D
         LwojG4+uK1IFIS8gAh4v2Z3vTje98Xmm2c/JfFIHYcgmbpUXdbsXhAc5Gb/1mOZn7z
         S28lL5WUebUYjS1VzAmIIHQkxY+OnJUyIjGALQXUH/bpyHg+5FGio7f+nCFmsvAatn
         dVI2+VcaMGKwKPcFsrJu4jyiubF+pSylaIKhsSvHJv3eQjYrxYR3qii5fY1di3szVZ
         oJsdtdHow+jR6KpH28zxGiTAYpFrJuxZ/DknYciTasKpVprg9adVKfHtekWpc7SKTv
         HvpCjWtJuyXuw==
Date:   Tue, 10 Oct 2023 10:29:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20231010-statik-zoomen-49dd9e81aff6@brauner>
References: <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
 <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
 <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
 <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
 <20231010030615.GO800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010030615.GO800259@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> is buried in the previous paragraph and it's not obvious that it applies to
> the last one as well.  Incidentally, I would probably turn that fragment

massaged to clarify

> (in io_uring/openclose.c:io_close()) into
> 	spin_lock(&files->file_lock);
> 	file = files_lookup_fd_locked(files, close->fd);
> 	if (!file || io_is_uring_fops(file)) {
> 		spin_unlock(&files->file_lock);
> 		goto err;
> 	}

done
