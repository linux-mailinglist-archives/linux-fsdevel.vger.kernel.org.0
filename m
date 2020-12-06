Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD502D072E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 21:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgLFUyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgLFUyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 15:54:15 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188CC0613D1;
        Sun,  6 Dec 2020 12:53:35 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8F6EAC009; Sun,  6 Dec 2020 21:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1607288013; bh=JjaOew6og4Ma3TgZ9+cKOV5nQwdt07PsMK9VaipXVXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kw6fVZE2HDNIfSU4yQYDOZlyGHncJmSp4+Jf44efQ5j7AT+fE6r0aQVT1r2BhqUz6
         LZQ/u8PAEbDqZmCHgAspLQz3CpX0rk/MaK3/+/O9xGR18Mno8u9JUthL3u9hmA1uZZ
         p8JfHQ/U32MAbrXSv3lycm2ZVNDUwAtZ+zL1jepJJugl15k+idutduhvMHAzfgMbZT
         ihzPwkWRiJsLja4h9QVgG4Y8OIprN+oXUqqjTttowPdV0u+6Kps3dLKvsWhSkZ3hDt
         IMP+MG98XZtfupvzwulKtCCkw4eJhnbWgHKDuXoF7gXGZxXC/LwMfEsZ2oWoyWmVn9
         ryiZIMcKj6Wng==
Date:   Sun, 6 Dec 2020 21:53:18 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [RFC PATCH] 9p: create writeback fid on shared
 mmap
Message-ID: <20201206205318.GA25257@nautica>
References: <20201205130904.518104-1-cgxu519@mykernel.net>
 <20201206091618.GA22629@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201206091618.GA22629@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet wrote on Sun, Dec 06, 2020:
> Chengguang Xu wrote on Sat, Dec 05, 2020:
> > If vma is shared and the file was opened for writing,
> > we should also create writeback fid because vma may be
> > mprotected writable even if now readonly.
> 
> Hm, I guess it makes sense.

I had a second look, and generic_file_readonly_mmap uses vma's
`vma->vm_flags & VM_MAYWRITE` instead (together with VM_SHARED),
while mapping_writably_mapped ultimately basically only seems to
validate that the mapping is shared from a look at mapping_map_writable
callers? It's not very clear to me.

OTOH, VM_MAYWRITE is set anytime we have a shared map where file has
been opened read-write, which seems to be what you want with regards to
protecting from mprotect calls.

How about simply changing check from WRITE to MAYWRITE?

 	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
 	if (!v9inode->writeback_fid &&
 	    (vma->vm_flags & VM_SHARED) &&
-	    (vma->vm_flags & VM_WRITE)) {
+	    (vma->vm_flags & VM_MAYWRITE)) {
 		/*
 		 * clone a fid and add it to writeback_fid
 		 * we do it during mmap instead of
-- 
Dominique
