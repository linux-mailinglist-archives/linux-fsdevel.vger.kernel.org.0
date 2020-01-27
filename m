Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED25149F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA0IE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 03:04:29 -0500
Received: from verein.lst.de ([213.95.11.211]:54608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0IE3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:04:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C552968BE1; Mon, 27 Jan 2020 09:04:25 +0100 (CET)
Date:   Mon, 27 Jan 2020 09:04:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH] exportfs: fix handling of rename race in
 reconnect_one()
Message-ID: <20200127080425.GA30513@lst.de>
References: <20200126220800.32397-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126220800.32397-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> If a disconnected dentry gets looked up and renamed between the
> call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> parent was deleted, we return an error, although dentry may be connected.
> 
> Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> warning") changes this behavior from always returning success,
> regardless if dentry was reconnected by somoe other task, to always
> returning a failure.
> 
> Change the lookup error handling to match that of exportfs_get_name()
> error handling and return success after getting -ENOENT and verifying
> that some other task has connected the dentry for us.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
