Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADE1E4DE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgE0TKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0TKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 15:10:00 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEACC08C5C1;
        Wed, 27 May 2020 12:09:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1je1Qy-00GSnL-VQ; Wed, 27 May 2020 19:09:49 +0000
Date:   Wed, 27 May 2020 20:09:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: Add an explicit might_sleep() to iput
Message-ID: <20200527190948.GE23230@ZenIV.linux.org.uk>
References: <20200527141753.101163-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527141753.101163-1-kpsingh@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 04:17:53PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> It is currently mentioned in the comments to the function that iput
> might sleep when the inode is destroyed. Have it call might_sleep, as
> dput already does.
> 
> Adding an explicity might_sleep() would help in quickly realizing that
> iput is called from a place where sleeping is not allowed when
> CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:

You do realize that there are some cases where iput() *is* guaranteed
to be non-blocking, right?
