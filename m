Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D162D0EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLGLZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:25:07 -0500
Received: from nautica.notk.org ([91.121.71.147]:34635 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgLGLZH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:25:07 -0500
X-Greylist: delayed 94071 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 06:25:06 EST
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 33D1FC009; Mon,  7 Dec 2020 12:24:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1607340265; bh=7LUikZ39N6LqCKnKwHLHNUsdYXrS5aPD8YDkqwV/5yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xAns74XBbg3lA0hyCaUHKer79FiO+W0drHUGED0LfyDFk348Yrop0Pp8IQhTJB53x
         /x1nHm5FGYyDxkHwP7VshytZCs9HfhwFo/uUrNcrn1jlzvR0p3/uUPpW16wZ2bxo0r
         h8ql+uneMkPNnpNMZLcjGCkBvGnf12Eijtm1cPovvQrzeVPTGWiAeoV+xYLAxwHz8M
         PVQAHcQmFF2Ccc8b48ufDBqslAIaxkmfhDxa4OOMAf/4+fksJJY8GbkzObw5WpRFWa
         t3SgSLAE/KHiusCe0TWl6Fy02JEHHR8lOyKtPSFSPuyVg4Dz8lg+eQiIuwhZ6rph6h
         eo2+psgXL6blQ==
Date:   Mon, 7 Dec 2020 12:24:10 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     ericvh <ericvh@gmail.com>, lucho <lucho@ionkov.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        v9fs-developer <v9fs-developer@lists.sourceforge.net>
Subject: Re: [V9fs-developer] [RFC PATCH] 9p: create writeback fid on shared
 mmap
Message-ID: <20201207112410.GA26628@nautica>
References: <20201205130904.518104-1-cgxu519@mykernel.net>
 <20201206091618.GA22629@nautica>
 <20201206205318.GA25257@nautica>
 <1763bcb5b8e.da1e98e51195.9022463261101254548@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1763bcb5b8e.da1e98e51195.9022463261101254548@mykernel.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chengguang Xu wrote on Mon, Dec 07, 2020:
>  > , VM_MAYWRITE is set anytime we have a shared map where file has
>  > been opened read-write, which seems to be what you want with regards to
>  > protecting from mprotect calls.
>  > 
>  > How about simply changing check from WRITE to MAYWRITE?
> 
> It would be fine and based on the code in do_mmap(), it  seems we even don't
> need extra check here.  The condition (vma->vm_flags & VM_SHARED) will be enough.
> Am I missing something?

VM_MAYWRITE is unset if the file hasn't been open for writing (in which
case the mapping can't be mprotect()ed to writable map), so checking it
is a bit more efficient.

Anyway I'd like to obsolete the writeback fid uses now that fids have a
refcount (this usecase can be a simple refcount increase), in which case
efficiency is less of a problem, but we're not there yet...

Please resend with MAYWRITE if you want authorship and I'll try to take
some time to test incl. the mprotect usecase.

-- 
Dominique
