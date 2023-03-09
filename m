Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD06B2E03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCIT6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCIT6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:58:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D4A7A92B;
        Thu,  9 Mar 2023 11:58:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB397B82084;
        Thu,  9 Mar 2023 19:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C5C433EF;
        Thu,  9 Mar 2023 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678391900;
        bh=/5mhEH+0jhy2TFRF2A3QBp1K1QEz/XCD8K1TWQPSe08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nkzkF3VK95mW2LePnZ6lDNSOg5uGxOS2iIFJhkOnYlWwwsFGiQXzCTQD70rerpX7I
         O6jvZg07cywqdslFUFZUeCPJ6lZWTGW8ZXDx0mcroxS5kPUkMS3QBaYucRPL6fmwdN
         jLBI4YFnm9eNZVOUb41pBaBIezxPKUPNb6apsPi4=
Date:   Thu, 9 Mar 2023 11:58:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 0/7] Implement IOCTL to get and optionally clear
 info about PTEs
Message-Id: <20230309115818.170dd5ef2cde7b58b9354ecd@linux-foundation.org>
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  9 Mar 2023 18:57:11 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> The information related to pages if the page is file mapped, present and
> swapped is required for the CRIU project [5][6]. The addition of the
> required mask, any mask, excluded mask and return masks are also required
> for the CRIU project [5].

It's a ton of new code and what I'm not seeing in here (might have
missed it?) is a clear statement of the value of this feature to our
users.

I see hints that CRIU would like it, but no description of how valuable
this is to CRIU's users.

So please spend some time preparing this info.

Also, are any other applications of this feature anticipated?  If so,
what are they?

IOW, please sell this stuff to us!
