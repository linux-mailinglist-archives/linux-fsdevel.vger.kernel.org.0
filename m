Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311C4BE854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfIYW3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 18:29:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44926 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfIYW3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:29:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDFn4-0004Tu-79; Wed, 25 Sep 2019 22:29:42 +0000
Date:   Wed, 25 Sep 2019 23:29:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     dsterba@suse.cz, Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>, emamd001@umn.edu,
        kjlu@umn.edu, smccaman@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/affs: release memory if affs_init_bitmap fails
Message-ID: <20190925222942.GP26530@ZenIV.linux.org.uk>
References: <20190917041346.4802-1-navid.emamdoost@gmail.com>
 <20190917095241.GP2850@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917095241.GP2850@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:52:41AM +0200, David Sterba wrote:
> On Mon, Sep 16, 2019 at 11:13:42PM -0500, Navid Emamdoost wrote:
> > In affs_init_bitmap, on error handling path we may release the allocated
> > memory.
> 
> Yes the memory should be released but not all paths that lead to the
> label 'out' are actually errors:

... and none of them should be freeing anything here, errors or no
errors.

> The sbi->s_bitmap would be freed but at umount time it will
> be freed again.

It actually would be freed by superblock destructor, be it on umount
or on failed fill_super.
