Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545D7A6655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjISOQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjISOQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:16:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F0134;
        Tue, 19 Sep 2023 07:16:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223BFC433C7;
        Tue, 19 Sep 2023 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695132971;
        bh=DoNwzPQc2IBi/5emx9crPnkubUnAPIyHk1dmESs02BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hv5E1TRucxP27VGQhkME58Yqy1YVVc/z5xfzN6KiGj0DHTfRE5pyOGWNVzIQa3fdT
         cg3HJkvvm+EGGcAo8q375QF5T842seCem1rIto5tg8PGDP0Mgifky8K7XI9SG+kVAQ
         sde8XklcqbBhgXQX8RI1/7dNh1oxpuwK5b0gU9IC6stnHajelay0jIsae8lJPhaAb3
         l3whdrDH4t0ulR8Ugyo4Wxg3si/65IIjybxWX04mAIxZDPlTxc0+kcatY+WY8eRqqY
         kUg/G4t1s1jzcAQw8nLQgg9TcWSSulrbNAiwfg8MIufzP29Vo32emhrscXo/5R0Wq6
         7InVrjPq2UJhw==
Date:   Tue, 19 Sep 2023 16:16:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <20230919-deeskalation-hinsehen-3b6765180d71@brauner>
References: <20230919080707.1077426-1-max.kellermann@ionos.com>
 <20230919-fachkenntnis-seenotrettung-3f873c1ec8da@brauner>
 <CAKPOu+_ehctokCKHFZgqs2NksE=Kva80Y5xjA705dNCbtcDxgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_ehctokCKHFZgqs2NksE=Kva80Y5xjA705dNCbtcDxgA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:55:36PM +0200, Max Kellermann wrote:
> On Tue, Sep 19, 2023 at 3:45 PM Christian Brauner <brauner@kernel.org> wrote:
> > So pipe_buf->private may now contain garbage.
> 
> NULL is just as garbage as the other 2^64-1 possible pointer values.
> NULL isn't special here, nobody checks the field for NULL. This field

You're changing how the code currently works which is written in a way
that ensures all fields are initialized to zero. The fact that currently
nothing looks at private is irrelevant.

Following your argument below this might very easily be the cause for
another CVE when something starts looking at this.

Wouldn't it make more sense to have the pipe_buf_init() initialize the
whole thing and for the place where it leaves buf->private untouched you
can just do:

unsigned long private = buf->private
pipe_buf_init(buf, page, 0, 0, &anon_pipe_buf_ops,
	      PIPE_BUF_FLAG_CAN_MERGE, private)

So just use a compound initializer in pipe_buf_init() just like we do in
copy_clone_args_from_user()?
