Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8272B9CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFLIIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFLIIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F292718;
        Mon, 12 Jun 2023 01:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C66E61620;
        Mon, 12 Jun 2023 08:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CECC433EF;
        Mon, 12 Jun 2023 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686557265;
        bh=ZLQr6AFtHgoqhChD6MVYZ7X0otJfdG9q9nqDRtOcO9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OB9lMoH8HWRs7gwIH7Fwn0Ur2a3Cf2qW8CItzdv0FlcDT6foMMPhU7osLJhNzgERD
         xNyXWmJnUZOuTsiDuL860YzW5n+OmMoz9ZH3FJhhGrMBZ1W/xX/88RtUQd4KKtHR1E
         MpScAaYEghlneUgAyOiqZuqA2Nd6PP97WtguNDbEzwIKlhPRQIjtFb0X5zLSbfsxO2
         M78rw/IeuRH+W67HhM/Pk9v6/o2HUbdqjnCGXYNlASAhnpU3RChsbUQeGUBuhrtP6b
         /fRgE7P4AeGuREbkP69TU1odt4kyP6QX/MUoQgN6eLgZMWJ7xZyI4pMGZXPqMi8pYI
         UIcmVX0hi95kw==
Date:   Mon, 12 Jun 2023 10:07:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: use fake_file container for internal files
 with fake f_path
Message-ID: <20230612-erwarben-pflaumen-1916e266edf7@brauner>
References: <20230611194706.1583818-1-amir73il@gmail.com>
 <20230611194706.1583818-2-amir73il@gmail.com>
 <ZIai+UWrU9o2UVcJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIai+UWrU9o2UVcJ@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 09:45:45PM -0700, Christoph Hellwig wrote:
> On Sun, Jun 11, 2023 at 10:47:05PM +0300, Amir Goldstein wrote:
> > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > files, where overlayfs also puts a "fake" path in f_path - a path which
> > is not on the same fs as f_inode.
> 
> But cachefs doesn't, so this needs a better explanation / documentation.
> 
> > Allocate a container struct file_fake for those internal files, that
> > is used to hold the fake path along with an optional real path.
> 
> The idea looks sensible, but fake a is a really weird term here.
> I know open_with_fake_path also uses it, but we really need to
> come up with a better name, and also good documentation of the
> concept here.

It's basically a stack so I'd either use struct file_stack or
struct file_proxy; with a preference for the latter.
