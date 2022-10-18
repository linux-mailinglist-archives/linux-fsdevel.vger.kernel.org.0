Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69F6020A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJRBz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJRBz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FC3887;
        Mon, 17 Oct 2022 18:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C7B612F4;
        Tue, 18 Oct 2022 01:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB2EC433C1;
        Tue, 18 Oct 2022 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666058125;
        bh=igcQugxTzwIP0PYHpWw1TgW9tEWJhVuc8WaXwlkC/Ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pWk9ZE6ZgxOhyz8+YbsYxk4DbRYG+eJfnTSaDfEw5L0oHwDlqnFhF7X2RKWCJ3xiw
         a+l7VKQAFH39/1QkFwV03tTCE/RYQwQVtIbVzFGePGML7pBVzLaEqfc9f313SRqAsB
         D4yiNzfpDPFoNp0yTNeFlOkoC6RaDOp0CNwC+NP4=
Date:   Mon, 17 Oct 2022 18:55:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH v3 2/2] vfs: parse: deal with zero length string
 value
Message-Id: <20221017185523.22f43b5d7f9fee1e1e3d872f@linux-foundation.org>
In-Reply-To: <166365878918.39016.12757946948158123324.stgit@donald.themaw.net>
References: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
        <166365878918.39016.12757946948158123324.stgit@donald.themaw.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Sep 2022 15:26:29 +0800 Ian Kent <raven@themaw.net> wrote:

> Parsing an fs string that has zero length should result in the parameter
> being set to NULL so that downstream processing handles it correctly.
> For example, the proc mount table processing should print "(none)" in
> this case to preserve mount record field count, but if the value points
> to the NULL string this doesn't happen.
> 
> ...
>
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -197,6 +197,8 @@ int fs_param_is_bool(struct p_log *log, const struct fs_parameter_spec *p,
>  		     struct fs_parameter *param, struct fs_parse_result *result)
>  {
>  	int b;
> +	if (param->type == fs_value_is_empty)
> +		return 0;
>  	if (param->type != fs_value_is_string)
>  		return fs_param_bad_value(log, param);
>  	if (!*param->string && (p->flags & fs_param_can_be_empty))
> @@ -213,6 +215,8 @@ int fs_param_is_u32(struct p_log *log, const struct fs_parameter_spec *p,
>  		    struct fs_parameter *param, struct fs_parse_result *result)
>  {
>  	int base = (unsigned long)p->data;
> +	if (param->type == fs_value_is_empty)
> +		return 0;
>  	if (param->type != fs_value_is_string)
>  		return fs_param_bad_value(log, param);
>  	if (!*param->string && (p->flags & fs_param_can_be_empty))
>
> [etcetera]

This feels wrong.  Having to check for fs_value_is_empty in so many
places makes me think "we just shouldn't have got this far".  Am I
right for once?
