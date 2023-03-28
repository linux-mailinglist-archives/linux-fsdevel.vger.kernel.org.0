Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3036CCDD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC1XEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC1XEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC42698;
        Tue, 28 Mar 2023 16:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA4F9B81D7A;
        Tue, 28 Mar 2023 23:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1AAC433D2;
        Tue, 28 Mar 2023 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680044674;
        bh=TwGyF4PkvxDzlLA402hHK1eLtIEBIL4SI/0qxIqDczQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zfFnOoP5liF9W0eIaPQY3fWY/x2c3YWeGxGG9Z+XtwTt6PdxvwTaVSJPl/wX9oHFa
         TN2zANmUIncV7Rx4/qsCq0LcMp4Wfg+6vxHO5Wt5VS0mnQryEzrkXU+ZLmL5qTwZbk
         NlIZmoUl864XszmR/3+xPQzAT+mE9qlCDRlYe16A=
Date:   Tue, 28 Mar 2023 16:04:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: return an ERR_PTR from __filemap_get_folio v2
Message-Id: <20230328160433.4f3dc32b480239bce9e2f9ef@linux-foundation.org>
In-Reply-To: <20230121065755.1140136-1-hch@lst.de>
References: <20230121065755.1140136-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 21 Jan 2023 07:57:48 +0100 Christoph Hellwig <hch@lst.de> wrote:

> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.
> 
> Note that the shmem patches in here are non-trivial and need some
> careful review and testing.

How are we going with the review and testing.  I assume that
we're now OK on the runtime testing front, but do you feel that
review has been adequate?

Thanks.
