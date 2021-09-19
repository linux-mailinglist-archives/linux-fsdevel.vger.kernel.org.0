Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83109410C25
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhISP0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 11:26:11 -0400
Received: from kanga.kvack.org ([205.233.56.17]:37213 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhISP0L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:26:11 -0400
X-Greylist: delayed 1679 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 11:26:10 EDT
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id C0D346B0072; Sun, 19 Sep 2021 10:56:45 -0400 (EDT)
Date:   Sun, 19 Sep 2021 10:56:45 -0400
From:   Benjamin LaHaise <bcrl@kvack.org>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH v2] aio: convert active_reqs into a hashtable
Message-ID: <20210919145645.GE16005@kvack.org>
References: <20210919144146.19531-1-someguy@effective-light.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919144146.19531-1-someguy@effective-light.com>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 19, 2021 at 10:41:46AM -0400, Hamza Mahfooz wrote:
> Commit 833f4154ed56 ("aio: fold lookup_kiocb() into its sole caller")
> suggests that, the fact that active_reqs is a linked-list means aio_kiocb
> lookups in io_cancel() are inefficient. So, to get faster lookups (on
> average) while maintaining similar insertion and deletion characteristics,
> turn active_reqs into a hashtable.

You're doing this wrong.  If you want faster cancellations, stash an index
into iocb->aio_key to index into an array with all requests rather than
using a hash table.

		-ben
-- 
"Thought is the essence of where you are now."
