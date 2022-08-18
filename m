Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18E1597E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 08:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiHRGZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiHRGZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDBA722F;
        Wed, 17 Aug 2022 23:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DF36B82000;
        Thu, 18 Aug 2022 06:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D2EC433C1;
        Thu, 18 Aug 2022 06:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660803915;
        bh=4gvlEkh6Gf9B8U8HDVHnkdoKBgZHMvuPetp86ALLLD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D97PB2Pg0uiwHhUpm6vOjyTtCc3AB5uMgbZP5v/aOWtKvM8eQ4Kt06DBV4NB8ARb7
         aHv4JPmtoQXzsOiclH78vLUYKc4ScxH+PsnRWJLeJ6qPMytiFonsA9ALSftUmy8SId
         HqNCpSlU6C8g8i4UHGLgIqqahFqPJLZsqIm4f8Lc=
Date:   Thu, 18 Aug 2022 08:25:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <Yv3bRwh/M8WVkQBs@kroah.com>
References: <20220817214728.489904-1-axelrasmussen@google.com>
 <20220817214728.489904-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817214728.489904-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:47:25PM -0700, Axel Rasmussen wrote:
>  static int __init userfaultfd_init(void)
>  {
> +	WARN_ON(misc_register(&userfaultfd_misc));

Please no.

Spell this out and properly error out if there is an issue:
	int ret;

	ret = misc_register(&userfaultfd_misc);
	if (ret)
		return ret;

Handle issues properly, don't paper over them with WARN_ON().

thanks,

greg k-h
