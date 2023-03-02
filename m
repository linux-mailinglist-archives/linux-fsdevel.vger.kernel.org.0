Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13D86A897B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCBT0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBT0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:26:41 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A80F979;
        Thu,  2 Mar 2023 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyQ+env/WFzQBczlQSf7bynMeXK90337LwaiIbqlP4Q=; b=NZp9/w+BljZRYfN0HJfq/MvVZh
        JOhlD3X3UdbHu+8bCjV8AcYrDbr/2VTBF+zfODpIUQx06Tb4xbdTvSHxtTpGjddxdnNz0/lz8r4Uz
        OiOx1CK4cgyCznVYds4N6uHs1hNJyp6FKsunbyh8x3OVMy3OiQuSggtbW85gGFS+YuJ9m9Dc+yXIU
        uxveh8V3Fa82sitk5plgc46jb00TblN2vQTpKtFailc/40EVkVuZA1SJlg5RQDvEI+9Nd61RSO8+M
        AatXLmpFkbr7hHtW19M9u9fAOQFX1uclEjgi0PMYfMsjX3D9btjt2ZJCfGH2pgCML3XHH+sCSc1wF
        oPTNruZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pXoZY-00DNfL-1w;
        Thu, 02 Mar 2023 19:26:36 +0000
Date:   Thu, 2 Mar 2023 19:26:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Message-ID: <ZAD4bNDEIZf/VAnh@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV>
 <13214812.uLZWGnKmhe@suse>
 <20230301130018.yqds5yvqj7q26f7e@quack3>
 <Y/9duET0Mt5hPu2L@ZenIV>
 <20230302095931.jwyrlgtxcke7iwuu@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302095931.jwyrlgtxcke7iwuu@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:59:31AM +0100, Jan Kara wrote:
> OK, I think your changes to ext2_rename() in PATCH 1 leak a reference and
> mapping of old_page

In which case?  ext2_delete_entry() failing?

-       ext2_delete_entry(old_de, old_page, old_page_addr);
+       err = ext2_delete_entry(old_de, old_page, old_page_addr);
+       if (err)
+               goto out_dir;

and on out_dir: we have
out_dir:
        if (dir_de)
                ext2_put_page(dir_page, dir_page_addr);
out_old:
        ext2_put_page(old_page, old_page_addr);
out:
        return err;

How is the old_page leaked here?
