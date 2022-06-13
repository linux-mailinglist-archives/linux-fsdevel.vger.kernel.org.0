Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8977454A1D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiFMVzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 17:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiFMVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:55:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FDF20BDC;
        Mon, 13 Jun 2022 14:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07F8BB8160E;
        Mon, 13 Jun 2022 21:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BCAC34114;
        Mon, 13 Jun 2022 21:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655157341;
        bh=AF0PJZhUcs0mBF42nPc3xhzkjbqEMjUTmXKOM9WAw0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gp1jX8WfBHjFifwdWq/r3rM+5ff1PyLfsrvNPCjL/KEoA5z0WY0FtNdKvktKG0/H1
         OB+hODIpwiz5HZLXvMhRq56RlFjgs5LTz+/hue49mnCAYI6yqm1CSfpP6KU4dZUWQ/
         m3cc6+SIkl7LrNXdoQsOBT4vqiuz9nkbOs5BVJN8=
Date:   Mon, 13 Jun 2022 14:55:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-Id: <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
In-Reply-To: <20220601210951.3916598-3-axelrasmussen@google.com>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
        <20220601210951.3916598-3-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed,  1 Jun 2022 14:09:47 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> To achieve this, add a /dev/userfaultfd misc device. This device
> provides an alternative to the userfaultfd(2) syscall for the creation
> of new userfaultfds. The idea is, any userfaultfds created this way will
> be able to handle kernel faults, without the caller having any special
> capabilities. Access to this mechanism is instead restricted using e.g.
> standard filesystem permissions.

The use of a /dev node isn't pretty.  Why can't this be done by
tweaking sys_userfaultfd() or by adding a sys_userfaultfd2()?

Peter, will you be completing review of this patchset?
