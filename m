Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4443275FC7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGXQq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGXQqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309DD10C3;
        Mon, 24 Jul 2023 09:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB4F61299;
        Mon, 24 Jul 2023 16:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495FBC433C8;
        Mon, 24 Jul 2023 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690217169;
        bh=viJrJM5gS3p8Ik0p/RNEGOXpE1eow1dw+HxX06Fwphs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k65dYZsip/x/uqx7HiaLEfE8TPWOHPKf98o9D0Pdmwq61dM+687rnsJCp9+zDdoX8
         B1SNesz3mYecL/NoymCoXgMHuCZ+oJGL7kxaig082lQb7HKLvHYRRcqGF+r7pk20HP
         SvUM9yGcXFbo1ud0xoYRvp9uueQq1oS8fHhfqLuCa92/kVkBGynmGovMTRDdPRj9zG
         eh6+Jl03hVjaLF8avj1H9xL0x00f83+28snM3wQuumx9TXCQDZbAYs5oon0jmPJcgH
         +5ok2yYmjJnELTd/llhhzvwWuY6qWacfDHhxg95Bbu8RO+bzf4gO7ti5G1CTK9gT8l
         4pOiOrIDnFhTA==
Date:   Mon, 24 Jul 2023 18:46:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230724-pyjama-papier-9e4cdf5359cb@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:53:32AM -0700, Linus Torvalds wrote:
> Is it too late to just fix pidfd_getfd() to duplicate the 'struct
> file', and act like a new open, and act like /proc/<pid>/fd/<xyz>?

So thinking a little about it I think that doesn't work.
/proc/<pid>/fd/<xyz> does a reopen and for good reasons. The original
open will have gone through the module's/subsytem's ->open() method
which might stash additional refcounted data in e.g., file->private_data
if we simply copy that file or sm then we risk UAFs. If we don't skip
->open() though and effectively emulate /proc/<pid>/fd/<xyz> completely
then we break any such use-cases where a socket or something else is
shared as they cannot be reopened. So the module/subsystem really needs
to be informed that a new struct file is created and not simply refd.
